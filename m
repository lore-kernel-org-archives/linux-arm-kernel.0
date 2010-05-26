From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 May 2010 10:27:56 +0100
Subject: vpack270 and sleep mode
In-Reply-To: <4BFCE794.9000306@papillon.ru>
References: <1272311167-576-1-git-send-email-marek.vasut@gmail.com>
	<4BFBD01E.8010101@papillon.ru>
	<20100525202447.GD16204@n2100.arm.linux.org.uk>
	<201005252247.57688.marek.vasut@gmail.com>
	<4BFC99CB.2090902@papillon.ru>
	<20100526090748.GB25435@n2100.arm.linux.org.uk>
	<4BFCE794.9000306@papillon.ru>
Message-ID: <20100526092756.GA6232@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 26, 2010 at 03:19:16PM +0600, 237 Rumjantsev Egor (PROG) wrote:
> no they doesn't, but here is a part of pxa2xx-flash.c and driver  
> structure registered by driver_register call. Is it problem ?
>
>
> static struct device_driver pxa2xx_flash_driver = {
>         .name           = "pxa2xx-flash",
>         .bus            = &platform_bus_type,
>         .probe          = pxa2xx_flash_probe,
>         .remove         = __exit_p(pxa2xx_flash_remove),
>         .suspend        = pxa2xx_flash_suspend,
>         .resume         = pxa2xx_flash_resume,

The suspend and resume callbacks are removed in later kernels - could you
try commenting these two out and seeing what the effect is please?
