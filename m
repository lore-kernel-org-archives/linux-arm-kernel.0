From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 25 Oct 2012 10:57:21 +0200
Subject: [PATCH 2/5] ARM: Kirkwood: Allow use of MVEBU GPIO driver.
In-Reply-To: <1351088724-11142-3-git-send-email-andrew@lunn.ch>
References: <1351088724-11142-1-git-send-email-andrew@lunn.ch>
 <1351088724-11142-3-git-send-email-andrew@lunn.ch>
Message-ID: <20121025105721.67bf20a2@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Wed, 24 Oct 2012 16:25:21 +0200, Andrew Lunn wrote:

>  config GPIO_MVEBU
>  	def_bool y
> -	depends on ARCH_MVEBU
> +	depends on ARCH_MVEBU || ARCH_KIRKWOOD
>  	select GPIO_GENERIC
>  	select GENERIC_IRQ_CHIP

Should we turn the depends on ARCH_MVEBU into a depends on PLAT_ORION,
like I did for the pinctrl driver (patch accepted by Linus Walleij
yesterday) ? I think the dependency on ARCH_MVEBU was making too much
of a shortcut, by assuming that we would very quickly move everybody
into mach-mvebu. As we rather decided to move gradually
mach-{kirkwood,dove,orion5x,mv78xx0} to those infrastructure while
keeping them in their respective directories, I think a dependency on
PLAT_ORION is more appropriate here.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
