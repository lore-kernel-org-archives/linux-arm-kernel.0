From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 30 Jun 2011 10:30:24 +0100
Subject: [PATCH 3/7] ARM: SAMSUNG: Add SPI clock definitions for
	SAMSUNG SoCs
In-Reply-To: <1309436723-662-4-git-send-email-padma.v@samsung.com>
References: <1309436723-662-1-git-send-email-padma.v@samsung.com>
	<1309436723-662-4-git-send-email-padma.v@samsung.com>
Message-ID: <20110630093024.GT21898@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2011 at 08:25:19AM -0400, Padmavathi Venna wrote:
> SPI Clocks were defined in dev-spi.c of machine specific folder.
> To make SPI devices common across all SoCs,dev-spi.c is moved
> from machine specific folder to plat-samsung. So SPI clock
> definitions has been moved from dev-spi.c to SoC specific machine
> folder for S3C64XX,S5P64X0,S5PC100 and S5PV210

This just shows how sick the Samsung code is by abusing the clk API.
If it stopped that abuse and switched over to clkdev none of this would
be necessary.

So I'm going to NAK this until the Samsung clk code moves over to clkdev.
Sorry, I've made enough requests of Samsung people to do this, and its
time for more effective persuasion by standing in the way of other patches
to make it happen.
