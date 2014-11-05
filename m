From: stefan@agner.ch (Stefan Agner)
Date: Wed, 05 Nov 2014 09:40:54 +0100
Subject: [PATCH] ARM: dts: vf610: add SD node to cosmic dts
In-Reply-To: <1415170765-3343-1-git-send-email-olof@lixom.net>
References: <1415170765-3343-1-git-send-email-olof@lixom.net>
Message-ID: <566a5b330f05c69ad27902ca8ce24463@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 2014-11-05 07:59, schrieb Olof Johansson:
> Driver has been there since a while back, but the dts never seems to
> have been updated with the node (nor pinctrl). Do so now.
> 
> Cc: Matt Porter <mporter@linaro.org>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
> 
> Shawn, Stefan: This probably has some small conflicts with Stefan's
> patchsets that refactors some of the dts contents for 3.19. I'd like to
> pick this patch up as a fix for 3.18 though, since it makes my Cosmic+
> board usable for the boot farm.
> 
> If that'd be OK (i.e. to apply Stefan's patches on top of this), please
> ack so I can include it with the next set of fixes. :)
> 
> Thanks,
> 
> -Olof

Same reordering complains as Shawn.

Also note that starting with 3.19, it would be possible to use card
detect GPIO. However, SD-card works also fairly well without card
detection.

Acked-by: Stefan Agner <stefan@agner.ch>


> 
>  arch/arm/boot/dts/vf610-cosmic.dts |   20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vf610-cosmic.dts
> b/arch/arm/boot/dts/vf610-cosmic.dts
> index 3fd1b74..c1b8355 100644
> --- a/arch/arm/boot/dts/vf610-cosmic.dts
> +++ b/arch/arm/boot/dts/vf610-cosmic.dts
> @@ -56,6 +56,19 @@
>  			>;
>  		};
>  
> +		pinctrl_esdhc1: esdhc1grp {
> +			fsl,pins = <
> +				VF610_PAD_PTA24__ESDHC1_CLK	0x31ef
> +				VF610_PAD_PTA25__ESDHC1_CMD	0x31ef
> +				VF610_PAD_PTA26__ESDHC1_DAT0	0x31ef
> +				VF610_PAD_PTA27__ESDHC1_DAT1	0x31ef
> +				VF610_PAD_PTA28__ESDHC1_DATA2	0x31ef
> +				VF610_PAD_PTA29__ESDHC1_DAT3	0x31ef
> +				VF610_PAD_PTB28__GPIO_98	0x219d
> +			>;
> +		};
> +
> +
>  		pinctrl_uart1: uart1grp {
>  			fsl,pins = <
>  				VF610_PAD_PTB4__UART1_TX		0x21a2
> @@ -70,3 +83,10 @@
>  	pinctrl-0 = <&pinctrl_uart1>;
>  	status = "okay";
>  };
> +
> +&esdhc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_esdhc1>;
> +	bus-width = <4>;
> +	status = "okay";
> +};
