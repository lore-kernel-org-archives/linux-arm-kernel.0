From: kernel@martin.sperl.org (Martin Sperl)
Date: Thu, 14 Jan 2016 16:16:46 +0100
Subject: [PATCH V3 4/6] clk: bcm2835: remove use of BCM2835_CLOCK_COUNT in
 driver
In-Reply-To: <1452779142-20615-5-git-send-email-kernel@martin.sperl.org>
References: <1452779142-20615-1-git-send-email-kernel@martin.sperl.org>
 <1452779142-20615-5-git-send-email-kernel@martin.sperl.org>
Message-ID: <6E590181-FFFB-4396-8B8A-61F277ED27B7@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 14.01.2016, at 14:45, kernel at martin.sperl.org wrote:
> 
> -
> -	clks[BCM2835_CLOCK_PWM] =
> -		bcm2835_register_clock(cprman, &bcm2835_clock_pwm_data);
> +	for (i = 0; i < asize; i++) {
> +		desc = &clk_desc_array[i];
> +		if (desc)
		if (desc->data && desc->clk_register)
> +			clks[i] = desc->clk_register(cprman, desc->data);
> +	}

I will wait for other feedback before sending V4, which would fix this...
