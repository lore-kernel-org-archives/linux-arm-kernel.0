From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 9 Dec 2011 13:17:20 +0100
Subject: imx_v4_v5_defconfig: Need to specify LOADADDR
In-Reply-To: <CAOMZO5CkFx_kFJxDtyNsUVOfN9f-3X6daNvVD5BqUGLPnSvi7A@mail.gmail.com>
References: <CAOMZO5CkFx_kFJxDtyNsUVOfN9f-3X6daNvVD5BqUGLPnSvi7A@mail.gmail.com>
Message-ID: <20111209121720.GJ27267@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2011 at 09:55:30AM -0200, Fabio Estevam wrote:
> Hi,
> 
> On top of head mainline kernel I get:
> 
> make imx_v4_v5_defconfig
> make uImage
> 
> ....
>   Kernel: arch/arm/boot/zImage is ready
> multiple load addresses: 0x08008000 0xC0008000 0x80008000 0xA0008000
> This is incompatible with uImages
> Specify LOADADDR on the commandline to build an uImage
> make[1]: *** [arch/arm/boot/uImage] Error 1
> make: *** [uImage] Error 2
> fabio at fabio-Latitude-E6410:~/linus/linux-2.6$
> 
> Is there a patch for this already?

You mean a patch for fixing the uImage format?

I've seen that the U-Boot mkimage now has a

#define IH_TYPE_KERNEL_NOLOAD	14	/* OS Kernel Image, can run from any load address */

This means that we could change the generated uImage type to this
one, but it would also mean that you need a very recent version
of the mkimage tool.

Also 'any load address' is not quite correct, instead for Arm zImages
with CONFIG_AUTO_ZRELADDR it's the first 128MB of SDRAM.

Use zImages...

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
