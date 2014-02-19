From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 19 Feb 2014 15:06:32 +0800
Subject: [PATCH 2/4] ARM: dts: Enable SAI ALSA SoC DAI device for Vybrid
 VF610 TOWER board.
In-Reply-To: <1392788323-6092-3-git-send-email-Li.Xiubo@freescale.com>
References: <1392788323-6092-1-git-send-email-Li.Xiubo@freescale.com>
 <1392788323-6092-3-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <20140219070630.GE3010@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 19, 2014 at 01:38:41PM +0800, Xiubo Li wrote:
> This patch adds and enables the SAI device.
> 
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> ---
>  arch/arm/boot/dts/vf610-twr.dts | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
> index e3a3805..8217854 100644
> --- a/arch/arm/boot/dts/vf610-twr.dts
> +++ b/arch/arm/boot/dts/vf610-twr.dts
> @@ -127,9 +127,27 @@
>  				VF610_PAD_PTB5__UART1_RX		0x21a1
>  			>;
>  		};
> +
> +		pinctrl_sai2: sai2grp {

To sort it alphabetically, the entry should be added before
pinctrl_uart1.

> +		      fsl,pins = <
> +			      VF610_PAD_PTA16__SAI2_TX_BCLK   0x02ed
> +			      VF610_PAD_PTA18__SAI2_TX_DATA   0x02ee
> +			      VF610_PAD_PTA19__SAI2_TX_SYNC   0x02ed
> +			      VF610_PAD_PTA21__SAI2_RX_BCLK   0x02ed
> +			      VF610_PAD_PTA22__SAI2_RX_DATA   0x02ed
> +			      VF610_PAD_PTA23__SAI2_RX_SYNC   0x02ed
> +			      VF610_PAD_PTB18__EXT_AUDIO_MCLK 0x02ed

Use tabs instead of spaces.

Shawn

> +			>;
> +		};
>  	};
>  };
>  
> +&sai2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai2>;
> +	status = "okay";
> +};
> +
>  &uart1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_uart1>;
> -- 
> 1.8.4
> 
> 
