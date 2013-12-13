From: marex@denx.de (Marek Vasut)
Date: Fri, 13 Dec 2013 22:51:41 +0100
Subject: [PATCH V1 01/11] ARM: dts: imx: sabrelite: add Dual Lite/Solo
 support
In-Reply-To: <52AB5729.9010603@boundarydevices.com>
References: <1386899355-17379-1-git-send-email-troy.kisky@boundarydevices.com>
 <201312131246.00944.marex@denx.de> <52AB5729.9010603@boundarydevices.com>
Message-ID: <201312132251.41342.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, December 13, 2013 at 07:51:21 PM, Troy Kisky wrote:
> On 12/13/2013 4:46 AM, Marek Vasut wrote:
> > On Friday, December 13, 2013 at 02:49:05 AM, Troy Kisky wrote:
> >> This makes the structure of Sabre Lite board files the same
> >> as Sabre SD board files so that they are easier to compare.
> >> 
> >> By this, I mean that the majority of the file imx6q-sabrelite.dts
> >> is moved to imx6qdl-sabrelite.dtsi so that both imx6q-sabrelite.dts
> >> and imx6dl-sabrelite.dts can include it.
> >> 
> >> Now Sabre Lite has support for Dual Lite/Solo
> >> processors.
> >> 
> >> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> >> ---
> >> 
> >>   arch/arm/boot/dts/Makefile                         |   1 +
> >>   arch/arm/boot/dts/imx6dl-sabrelite.dts             |  20 ++
> >>   arch/arm/boot/dts/imx6q-sabrelite.dts              | 214
> >> 
> >> +-------------------- ...{imx6q-sabrelite.dts => imx6qdl-sabrelite.dtsi}
> >> |
> >> 
> >>   10 -
> >>   4 files changed, 22 insertions(+), 223 deletions(-)
> >>   create mode 100644 arch/arm/boot/dts/imx6dl-sabrelite.dts
> >>   copy arch/arm/boot/dts/{imx6q-sabrelite.dts => imx6qdl-sabrelite.dtsi}
> >> 
> >> (96%)
> >> 
> >> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> >> index 342d16d..3c6f456 100644
> >> --- a/arch/arm/boot/dts/Makefile
> >> +++ b/arch/arm/boot/dts/Makefile
> >> @@ -149,6 +149,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
> >> 
> >>   	imx6dl-gw53xx.dtb \
> >>   	imx6dl-gw54xx.dtb \
> >>   	imx6dl-sabreauto.dtb \
> >> 
> >> +	imx6dl-sabrelite.dtb \
> >> 
> >>   	imx6dl-sabresd.dtb \
> >>   	imx6dl-wandboard.dtb \
> >>   	imx6q-arm2.dtb \
> >> 
> >> diff --git a/arch/arm/boot/dts/imx6dl-sabrelite.dts
> >> b/arch/arm/boot/dts/imx6dl-sabrelite.dts new file mode 100644
> >> index 0000000..2de0447
> >> --- /dev/null
> >> +++ b/arch/arm/boot/dts/imx6dl-sabrelite.dts
> >> @@ -0,0 +1,20 @@
> >> +/*
> >> + * Copyright 2011 Freescale Semiconductor, Inc.
> >> + * Copyright 2011 Linaro Ltd.
> > 
> > Are you sure about this copyright message ? Isn't this copyright BD ?
> > 
> > Otherwise,
> > 
> > Reviewed-by: Marek Vasut <marex@denx.de>
> > 
> > Best regards,
> > Marek Vasut
> 
> Maybe, but the following change doesn't seem worthy of a copyright
> 
> linux-imx6/arch/arm/boot/dts$ diff -u imx6q-sabrelite.dts
> imx6dl-sabrelite.dts
> --- imx6q-sabrelite.dts 2013-12-12 11:22:10.156010652 -0700
> +++ imx6dl-sabrelite.dts        2013-12-12 11:22:10.156010652 -0700
> @@ -11,14 +11,10 @@
>    */
> 
>   /dts-v1/;
> -#include "imx6q.dtsi"
> +#include "imx6dl.dtsi"
>   #include "imx6qdl-sabrelite.dtsi"
> 
>   / {
> -       model = "Freescale i.MX6 Quad SABRE Lite Board";
> -       compatible = "fsl,imx6q-sabrelite", "fsl,imx6q";
> -};
> -
> -&sata {
> -       status = "okay";
> +       model = "Freescale i.MX6 DualLite SABRE Lite Board";
> +       compatible = "fsl,imx6dl-sabrelite", "fsl,imx6dl";
>   };
> _______
> 
> Perhaps I should add a copyright to both?

I'm no lawyer, I cannot give you an authoritative advice in this, sorry.
