From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Thu, 07 Aug 2014 18:30:23 -0700
Subject: Oops: 17 SMP ARM (v3.16-rc2)
In-Reply-To: <CAOMZO5BZdnzOuD9CcMv3bXsryT-j1A_bAjF6EAj_=BQTuxn45A@mail.gmail.com>
References: <C4A61A5CA4AD2246942F4BA6F20ACB80435655E9@ALVA-EXMB04.alv.autoliv.int>	<20140626151424.GT32514@n2100.arm.linux.org.uk>	<20140627112151.GF32514@n2100.arm.linux.org.uk>	<3FFB61A7A8473C49831AF20FA193534A43CADFA7@ALVA-EXMB01.alv.autoliv.int>	<20140627163108.GP32514@n2100.arm.linux.org.uk>	<C4A61A5CA4AD2246942F4BA6F20ACB8043575072@ALVA-EXMB04.alv.autoliv.int>	<20140806095012.GN30282@n2100.arm.linux.org.uk>	<C4A61A5CA4AD2246942F4BA6F20ACB8043575172@ALVA-EXMB04.alv.autoliv.int>	<20140806125550.GO30282@n2100.arm.linux.org.uk>	<C4A61A5CA4AD2246942F4BA6F20ACB804357526C@ALVA-EXMB04.alv.autoliv.int>	<20140807121248.GY30282@n2100.arm.linux.org.uk>	<CAOMZO5ACj6ER3tUMS8XsnigT=-zs4TZFmobbtmTN-+LWJFLt4Q@mail.gmail.com>
 <CAOMZO5BZdnzOuD9CcMv3bXsryT-j1A_bAjF6EAj_=BQTuxn45A@mail.gmail.com>
Message-ID: <53E4282F.7000403@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/7/2014 7:38 AM, Fabio Estevam wrote:
> On Thu, Aug 7, 2014 at 11:20 AM, Fabio Estevam <festevam@gmail.com> wrote:
> 
> ,but I am wondering if we should also do:
> 
> --- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> @@ -66,6 +66,7 @@
>         pinctrl-0 = <&pinctrl_enet>;
>         phy-mode = "rgmii";
>         interrupts-extended = <&gpio1 6 IRQ_TYPE_LEVEL_HIGH>,
> +                             <&intc 0 118 IRQ_TYPE_LEVEL_HIGH>,
>                               <&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;
>         status = "okay";
>  };
> @@ -226,7 +227,7 @@
>                                 MX6QDL_PAD_RGMII_RD2__RGMII_RD2         0x1b0b0
>                                 MX6QDL_PAD_RGMII_RD3__RGMII_RD3         0x1b0b0
>                                 MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL   0x1b0b0
> -                               MX6QDL_PAD_GPIO_6__ENET_IRQ             0x000b1
> +                               MX6QDL_PAD_GPIO_6__ENET_IRQ
>  0x400000b1
> 
> Since the Workaround for erratum ERR006687 states that the SION bit
> needs to be used:
> 
> "All of the interrupts can be selected by MUX and output to pad GPIO6.
> If GPIO6 is selected to
> output ENET interrupts and GPIO6 SION is set, the resulting GPIO
> interrupt will wake the system
> from Wait mode."
> 
arch/arm/boot/dts/imx6q-pinfunc.h:#define MX6QDL_PAD_GPIO_6__ENET_IRQ               0x230 0x600
0x03c 0x11 0xff000609

So, the ion bit should already be set(0x11). But the other way works too.


Troy
