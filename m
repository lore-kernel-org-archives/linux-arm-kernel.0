From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 1 Apr 2013 20:51:16 +0800
Subject: ARM: dts: MicroSys sbc6x support (i.MX6)
In-Reply-To: <20130401122422.GA13982@amd.pavel.ucw.cz>
References: <20130329185500.GB30029@amd.pavel.ucw.cz>
 <20130330113703.GA21042@amd.pavel.ucw.cz>
 <5156D69E.3050600@gmail.com>
 <20130331201614.GC25751@amd.pavel.ucw.cz>
 <20130401064224.GD1693@S2101-09.ap.freescale.net>
 <20130401122422.GA13982@amd.pavel.ucw.cz>
Message-ID: <20130401125114.GA24039@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 01, 2013 at 02:24:22PM +0200, Pavel Machek wrote:
> >   git://git.linaro.org/people/shawnguo/linux-2.6.git imx/dt
> 
> I took a look, and it should apply cleanly to that branch.
> 
It can apply cleanly, but it does not work, because all imx dts files
got renamed to support macros.

> Updated patch is below, please apply,

I applied it with some fixup.  Please use git send-email in the future,
so that git am can just work out everything for me.

Shawn

> 								Pavel
> 
> ---
> 
> Add support for MicroSys sbc6x board.
> 
> Signed-off-by: Pavel Machek <pavel@denx.de> 
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 9c62558..1590ae9 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -99,7 +99,8 @@ dtb-$(CONFIG_ARCH_MXC) += \
>  	imx6q-arm2.dtb \
>  	imx6q-sabreauto.dtb \
>  	imx6q-sabrelite.dtb \
> -	imx6q-sabresd.dtb
> +	imx6q-sabresd.dtb \
> +	imx6q-sbc6x.dtb
>  dtb-$(CONFIG_ARCH_MXS) += imx23-evk.dtb \
>  	imx23-olinuxino.dtb \
>  	imx23-stmp378x_devb.dtb \
> diff --git a/arch/arm/boot/dts/imx6q-sbc6x.dts b/arch/arm/boot/dts/imx6q-sbc6x.dts
> new file mode 100644
> index 0000000..0b2ef5f
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-sbc6x.dts
> @@ -0,0 +1,44 @@
> +/*
> + * Copyright 2013 Pavel Machek <pavel@denx.de>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License V2.
> + */
> +
> +/dts-v1/;
> +/include/ "imx6q.dtsi"
> +
> +/ {
> +	model = "MicroSys sbc6x board";
> +	compatible = "microsys,sbc6x", "fsl,imx6q";
> +
> +	memory {
> +		reg = <0x10000000 0x80000000>;
> +	};
> +};
> +
> +&fec {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_enet_1>;
> +	phy-mode = "rgmii";
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1_1>;
> +	status = "okay";
> +};
> +
> +&usbotg {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usbotg_1>;
> +	disable-over-current;
> +	status = "okay";
> +};
> +
> +&usdhc3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc3_2>;
> +	status = "okay";
> +};
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
