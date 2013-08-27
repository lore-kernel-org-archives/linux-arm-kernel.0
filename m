From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 27 Aug 2013 16:39:39 +0200
Subject: [PATCH 01/15] watchdog: orion: Remove unneeded BRIDGE_CAUSE clear
In-Reply-To: <1377614079-10000-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377614079-10000-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1377614079-10000-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130827163939.24636d80@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ezequiel Garcia,

On Tue, 27 Aug 2013 11:34:25 -0300, Ezequiel Garcia wrote:
> With the introduction of the orion irqchip driver, now the BRIDGE_CAUSE
> bit is cleared by it. There's no longer a need to do it in the watchdog
> driver, so we can simply remove it.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Is this going to work with the platforms that use the orion_wdt driver
but are not using the orion irqchip driver? Take for example
mach-orion5x, it still uses the plat-orion/irq.c code and not the
irqchip orion driver, as far as I can see.

The orion irqchip driver is DT only, so all of the Orion platforms that
have not been converted to DT are still using the old irq code.

Any thoughts on the consequences of this in relation with your patch?

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
