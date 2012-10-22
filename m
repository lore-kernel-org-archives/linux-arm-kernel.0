From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 22 Oct 2012 14:05:57 +0100
Subject: [PATCH] clk: Make the generic clock API available by default
In-Reply-To: <1350910970-9095-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1350910970-9095-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <20121022130556.GM21164@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 22, 2012 at 02:02:50PM +0100, Mark Brown wrote:
> @@ -327,6 +328,7 @@ config ARCH_AT91
>  	select ARCH_REQUIRE_GPIOLIB
>  	select CLKDEV_LOOKUP
>  	select HAVE_CLK
> +	select HAVE_CUSTOM_CLK

This is silly.  If you select "HAVE_CUSTOM_CLK" then isn't it true that
"HAVE_CLK" should also be selected?  If so, why not have "HAVE_CUSTOM_CLK"
do that selection and remove it from all these entries?
