From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 08 Jun 2013 12:49:10 +0200
Subject: [PATCH 2/3] ARM: dts: Add FIMD node to Origen4210 board
In-Reply-To: <1370603235-11193-3-git-send-email-tushar.behera@linaro.org>
References: <1370603235-11193-1-git-send-email-tushar.behera@linaro.org>
 <1370603235-11193-3-git-send-email-tushar.behera@linaro.org>
Message-ID: <5527415.fcM1OgADxD@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 of June 2013 16:37:14 Tushar Behera wrote:
> From: Sachin Kamat <sachin.kamat@linaro.org>
> 
> Added FIMD and display timing node to Origen4210 board.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
> ---
>  arch/arm/boot/dts/exynos4210-origen.dts |   21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos4210-origen.dts
> b/arch/arm/boot/dts/exynos4210-origen.dts index bcf8079..4c6c3cd 100644
> --- a/arch/arm/boot/dts/exynos4210-origen.dts
> +++ b/arch/arm/boot/dts/exynos4210-origen.dts
> @@ -290,4 +290,25 @@
>  			clock-frequency = <24000000>;
>  		};
>  	};
> +
> +	fimd at 11c00000 {
> +		pinctrl-0 = <&lcd_en &lcd_clk &lcd_data24 &pwm0_out>;

Ahh, this would explain the two pwm pin groups from previous patch.

This seems somehow incorrect, though. AFAIK PWM outputs are not managed by 
FIMD in any way.

> +		pinctrl-names = "default";
> +		status = "okay";
> +	};
> +
> +	display-timings {
> +		native-mode = <&timing0>;
> +		timing0: timing {
> +			clock-frequency = <50000>;

Hmm, 50 KHz for pixel clock? Isn't it a bit too low? Or am I missing 
something?

Best regards,
Tomasz

> +			hactive = <1024>;
> +			vactive = <600>;
> +			hfront-porch = <64>;
> +			hback-porch = <16>;
> +			hsync-len = <48>;
> +			vback-porch = <64>;
> +			vfront-porch = <16>;
> +			vsync-len = <3>;
> +		};
> +	};
>  };
