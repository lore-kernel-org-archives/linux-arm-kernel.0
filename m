From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Jan 2014 13:37:00 +0000
Subject: [PATCH 5/5] ARM: integrator: select AMBA bus and GPIO block
In-Reply-To: <1390397471-6802-6-git-send-email-linus.walleij@linaro.org>
References: <1390397471-6802-1-git-send-email-linus.walleij@linaro.org>
 <1390397471-6802-6-git-send-email-linus.walleij@linaro.org>
Message-ID: <20140122133700.GC15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 22, 2014 at 02:31:11PM +0100, Linus Walleij wrote:
> The Integrator/AP can be used with a logical module called

	logic module

> IM-PD1, which contains a few AMBA PrimeCell devices, one of which
> is the PL061 GPIO controller. As the lines from this GPIO
> controller are looped back to devices on the board itself and
> provides resources back to it, we need to always have GPIO
> and the PL061 driver available for other devices to work.

>  config INTEGRATOR_IMPD1
>  	tristate "Include support for Integrator/IM-PD1"
>  	depends on ARCH_INTEGRATOR_AP
> +	select ARCH_REQUIRE_GPIOLIB
> +	select ARM_AMBA

Doesn't ARCH_INTEGRATOR already select ARM_AMBA, which this option already
depends on?

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
