From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Nov 2012 19:00:24 +0000
Subject: [PATCH v2] clk: move IM-PD1 clocks to drivers/clk
In-Reply-To: <1353437696-23285-1-git-send-email-linus.walleij@linaro.org>
References: <1353437696-23285-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20121120190024.GV3290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 07:54:56PM +0100, Linus Walleij wrote:
> The ARM IM-PD1 add-on module has a few clock of its own, let's
> move also these down to the drivers/clk/versatile driver dir
> and get rid of any remaining oldschool Integrator clocks.

Where's the cleanup paths?

You do realise it's possible to unbind and rebind the whole impd1 board
via sysfs, which means if you don't do the cleanup you'll end up
re-registering the same clocks again.

Until that's fixed, NAK.
