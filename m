From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 May 2011 23:57:08 +0100
Subject: [PATCH 0/4] Pinmux subsystem
In-Reply-To: <1304363768-30338-1-git-send-email-linus.walleij@stericsson.com>
References: <1304363768-30338-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110502225708.GD28001@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 02, 2011 at 09:16:08PM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This patchset creates a pinmux subsystem and switches U300 to use that new
> subsystem as an example. The problem is not that fantastically hard to
> solve in a general way, nobody got around to it because it requires some
> upfront code I believe, and this is my stab at it.

While I like the idea of consolidating the pinmuxing stuff, I'm not sure
about having a struct pin_mux pointer in each bus types device structure.
It'd mean this would have to be added to platform devices as well...

Then there's SA1100 (and PXA?) to consider with its IrDA setup, where its
necessary to switch the pin muxing during driver operation, when switching
between SIR and FIR modes (SIR uses the UART, FIR uses a separate hardware
block.)

So any per-device pinmuxing subsystem also needs a way that a driver can
change the pinmuxing of its associated pins on the fly too.
