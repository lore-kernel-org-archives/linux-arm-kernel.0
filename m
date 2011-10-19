From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Wed, 19 Oct 2011 16:27:21 +0400
Subject: [patch 1/1] iMX: Fix module build
In-Reply-To: <20111018131353.663173305@rtp-net.org>
References: <20111018131353.663173305@rtp-net.org>
Message-ID: <4E9EC229.4080704@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 18-10-2011 17:13, Arnaud Patard (Rtp) wrote:

> When trying to build some modules with the "hint" branch of imx tree,
> they're now failing to build at modpost with an error like this :

>   OBJCOPY arch/arm/boot/zImage
>   Kernel: arch/arm/boot/zImage is ready
>   Building modules, stage 2.
>   MODPOST 69 modules
> ERROR: "imx_ioremap" [sound/soc/imx/snd-soc-imx.ko] undefined!
> ERROR: "imx_ioremap" [drivers/usb/gadget/fsl_usb2_udc.ko] undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2

> It seems to be caused by commit f548897ffc0510885af27e22a11f449fe5e0cbbd,

    Please specify that commit's summary in parens.

> which introduced imx_ioremap without EXPORT_SYMBOL.

> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>

WBR, Sergei
