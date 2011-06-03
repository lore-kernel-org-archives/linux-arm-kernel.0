From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Jun 2011 08:52:01 +0100
Subject: [PATCH v2 0/4] Move plat-mxc gpio driver into drivers/gpio
In-Reply-To: <1306985632-18820-1-git-send-email-shawn.guo@linaro.org>
References: <1306985632-18820-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110603075201.GE10532@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 02, 2011 at 11:33:48AM +0800, Shawn Guo wrote:
>  arch/arm/plat-mxc/gpio.c                        |  361 -------------------
>  drivers/gpio/gpio-mxc.c                         |  433 +++++++++++++++++++++++

I'm wondering why just moving this driver into drivers/gpio has
resulted in it growing by 72 lines - and it's not clear from the
diffs why that is because of the way they're broken up.

Would it not be better to have the first patch to merely move
arch/arm/plat-mxc/gpio.c to drivers/gpio/gpio-mxc.c, making whatever
config changes are necessary.  Then subsequent patches should change
drivers/gpio/gpio-mxc.c as required - which means we can see what
changes are being made.

As the series currently stands, from the review point of view it's
effectively adding an entirely new driver, converting everything over
to it, and then deleting the old.
