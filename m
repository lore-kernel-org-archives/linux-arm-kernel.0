From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Thu, 09 Feb 2012 11:57:17 +0100
Subject: [PATCH 1/2] ARM: ixp4xx: fix compilation, add gpiolib support
In-Reply-To: <20275.35898.120590.54388@pilspetsen.it.uu.se> (Mikael
 Pettersson's message of "Thu, 9 Feb 2012 10:04:58 +0100")
References: <1328729069-21308-1-git-send-email-mkl@blackshift.org>
 <1328729069-21308-2-git-send-email-mkl@blackshift.org>
 <20275.35898.120590.54388@pilspetsen.it.uu.se>
Message-ID: <87fweki8aa.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mikael Pettersson <mikpe@it.uu.se> writes:

> Marc Kleine-Budde writes:
>  > From: Imre Kaloz <kaloz@openwrt.org>
>  > 
>  > The problem was introduced with commit:
>  > "eb9ae7f gpio: fix build error in include/asm-generic/gpio.h"
>  > 
>  > This patch adds gpiolib support for the IXP4xx platform, which fixes the
>  > compilation of several ixp4xx platforms, e.g.:
>  > 
>  > In file included from arch/arm/mach-ixp4xx/include/mach/gpio.h:72,
>  >                  from /home/frogger/projects/server/linux/arch/arm/include/asm/gpio.h:9,
>  >                  from include/linux/gpio.h:30,
>  >                  from arch/arm/mach-ixp4xx/nslu2-setup.c:19:
>  > include/asm-generic/gpio.h: In function 'gpio_get_value_cansleep':
>  > include/asm-generic/gpio.h:218: error: implicit declaration of function '__gpio_get_value'
>  > include/asm-generic/gpio.h: In function 'gpio_set_value_cansleep':
>  > include/asm-generic/gpio.h:224: error: implicit declaration of function '__gpio_set_value'
>
> This fix is needed for 3.2 too, right?  I got the same errors when
> updating my (out-of-tree) ixp4xx/ds101 platform support to the 3.2 kernel
> a few days ago.

fwiw, it's even needed for 3.1. We've added it in the debian kernel when it
was sent to the linux-arm-kernel ml and it was for 3.1.

Arnaud
