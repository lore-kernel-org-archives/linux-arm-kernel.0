From: edubezval@gmail.com (Eduardo Valentin)
Date: Fri, 6 Nov 2015 11:16:11 -0800
Subject: [PATCH v2 9/9] arm64: dts: Enable the Thermal on R88 board
In-Reply-To: <1446700685-18017-10-git-send-email-wxt@rock-chips.com>
References: <1446700685-18017-1-git-send-email-wxt@rock-chips.com>
 <1446700685-18017-10-git-send-email-wxt@rock-chips.com>
Message-ID: <20151106191611.GF8202@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 05, 2015 at 01:18:05PM +0800, Caesar Wang wrote:
> This patch enable the TS-ADC.
> 
> When a thermal temperature is invoked use the CRU to reset the chip
> on R88 board. TSHUT is low active on this board.
> 

Acked-by: Eduardo Valentin <edubezval@gmail.com>

> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> 
> ---
> 
> Changes in v2: None
> Changes in v1: None
> 
>  arch/arm64/boot/dts/rockchip/rk3368-r88.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3368-r88.dts b/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
> index 401a812..7684426a 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
> @@ -336,6 +336,12 @@
>  	status = "okay";
>  };
>  
> +&tsadc {
> +	rockchip,hw-tshut-mode = <0>; /* tshut mode 0:CRU 1:GPIO */
> +	rockchip,hw-tshut-polarity = <0>; /* tshut polarity 0:LOW 1:HIGH */
> +	status = "okay";
> +}
> +
>  &uart2 {
>  	status = "okay";
>  };
> -- 
> 1.9.1
> 
