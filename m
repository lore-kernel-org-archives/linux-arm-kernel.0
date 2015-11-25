From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 24 Nov 2015 16:08:04 -0800
Subject: [PATCH 3/3] ARM: dts: enable pinctrl for Broadcom NSP
In-Reply-To: <1448042309-46445-1-git-send-email-yrdreddy@broadcom.com>
References: <1448042309-46445-1-git-send-email-yrdreddy@broadcom.com>
Message-ID: <5654FBE4.5010802@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/11/15 09:58, Yendapally Reddy Dhananjaya Reddy wrote:
> This enables the pinctrl support for Broadcom NSP SoC
> 
> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yrdreddy@broadcom.com>

Looks like a sane pinctrl node here, unless there are objections, I
would like to go ahead and apply this for v4.5, thanks!

> ---
>  arch/arm/boot/dts/bcm-nsp.dtsi   | 7 +++++++
>  arch/arm/boot/dts/bcm958625k.dts | 9 +++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
> index b74438c..a16d743 100644
> --- a/arch/arm/boot/dts/bcm-nsp.dtsi
> +++ b/arch/arm/boot/dts/bcm-nsp.dtsi
> @@ -226,5 +226,12 @@
>  			interrupts = <GIC_SPI 89 IRQ_TYPE_NONE>;
>  			clock-frequency = <100000>;
>  		};
> +
> +		pinctrl: pinctrl at 3f1c0 {
> +			compatible = "brcm,nsp-pinmux";
> +			reg = <0x3f1c0 0x04>,
> +			      <0x30028 0x04>,
> +			      <0x3f408 0x04>;
> +		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/bcm958625k.dts b/arch/arm/boot/dts/bcm958625k.dts
> index b966955..e298450 100644
> --- a/arch/arm/boot/dts/bcm958625k.dts
> +++ b/arch/arm/boot/dts/bcm958625k.dts
> @@ -105,3 +105,12 @@
>  		};
>  	};
>  };
> +
> +&pinctrl {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&nand_sel>;
> +	nand_sel: nand_sel {
> +		function = "nand";
> +		groups = "nand_grp";
> +	};
> +};
> 


-- 
Florian
