From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 17 May 2013 13:01:49 -0400
Subject: [PATCH] ARM: mvebu: select ARCH_REQUIRE_GPIOLIB for mvebu platform
In-Reply-To: <1368793503-8883-2-git-send-email-gregory.clement@free-electrons.com>
References: <1368793503-8883-1-git-send-email-gregory.clement@free-electrons.com>
 <1368793503-8883-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130517170149.GF11137@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 17, 2013 at 02:25:03PM +0200, Gregory CLEMENT wrote:
> Initially ARCH_REQUIRE_GPIOLIB was part of Thomas Petazzoni series
> when he introduced the gpiolib support for mvebu:
> 93a59cf arm: mvebu: use GPIO support now that a driver is available
> 
> This commit was written to be applied for the ARCH_MVEBU which was
> located in arch/arm/KConfig and was merged in 3.7.
> 
> In the same time Rob Herring moved the ARCH_MVEBU block to
> arch/arm/mach-mvebu/Kconfig with this commit and also merged in 3.7:
> 387798b ARM: initial multiplatform support
> 
> Unfortunately the ARCH_REQUIRE_GPIOLIB have been lost during this
> migration. This was not noticed until the v3.10-rc1, because mvebu as
> part of ARCH_MULTIPLATFORM was always selected with ARCH_VEXPRESS, and
> this architect selected ARCH_REQUIRE_GPIOLIB.
> 
> Since the following commit from Arnd: "883a106 ARM: default machine
> descriptor for multiplatform", ARCH_VEXPRESS was then no more selected
> by default with ARCH_MVEBU and it made appeared the lack of
> ARCH_REQUIRE_GPIOLIB for mvebu. This commit added back the selection
> of ARCH_REQUIRE_GPIOLIB for ARCH_MVEBU.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Applied to mvebu/fixes

thx,

Jason.
