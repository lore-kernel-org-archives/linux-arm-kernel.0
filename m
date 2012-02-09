From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 09 Feb 2012 10:08:09 +0100
Subject: [PATCH 1/2] ARM: ixp4xx: fix compilation, add gpiolib support
In-Reply-To: <20275.35898.120590.54388@pilspetsen.it.uu.se>
References: <1328729069-21308-1-git-send-email-mkl@blackshift.org>
 <1328729069-21308-2-git-send-email-mkl@blackshift.org>
 <20275.35898.120590.54388@pilspetsen.it.uu.se>
Message-ID: <4F338CF9.6050803@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/2012 10:04 AM, Mikael Pettersson wrote:
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

Yes, it's needed for 3.2, too. I'll put stable on Cc.

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 262 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120209/171cb308/attachment.sig>
