From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 19 Jun 2014 09:38:35 +0100
Subject: [STLinux Kernel] [PATCH 1/7] ARM: stih407: Add DT nodes for for
 PWM
In-Reply-To: <1403103172-19856-1-git-send-email-lee.jones@linaro.org>
References: <1403103172-19856-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20140619083835.GA2131@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

> +		/* SBC PWM Module */
> +		pwm1: pwm at 9510000 {
> +			compatible	= "st,sti-pwm";
> +			status		= "disabled";
> +			#pwm-cells	= <2>;
> +			reg		= <0x9510000 0x68>;
> +			pinctrl-names	= "default";
> +		        pinctrl-0	= <&pinctrl_pwm1_chan0_default
> +					&pinctrl_pwm1_chan1_default
> +					&pinctrl_pwm1_chan2_default
> +					&pinctrl_pwm1_chan3_default>;

If you're passing pin config for 4 channels, I think you should also be using the 
'st,pwm-num-chan = <4>' property like the doc example in patch 7.

After that: 
Acked-by: Peter Griffin <peter.griffin@linaro.org>

regards,

Peter. 
