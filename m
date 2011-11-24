From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 24 Nov 2011 15:37:33 +0100
Subject: [PATCH] mfd: Fixed unconditional reset of the ADC reading enable
 bits
In-Reply-To: <1322132160-7451-1-git-send-email-robin@protonic.nl>
References: <1322132160-7451-1-git-send-email-robin@protonic.nl>
Message-ID: <20111124143733.GZ19986@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2011 at 11:56:00AM +0100, Robin van der Gracht wrote:
> When the ADC is being prepared for a single or multiple channel reading,
> the adc0 register is reconfigured without taking the lithium cell, charge
> current and battery current reading enable bits into account. Which results
> in clearing the bits.
> 
> Signed-off-by: Robin van der Gracht <robin@protonic.nl>
> ---
> [...]
>  	case MC13XXX_ADC_MODE_SINGLE_CHAN:
> -		adc0 |= old_adc0 & MC13XXX_ADC0_TSMOD_MASK;
> +		adc0 |= old_adc0 & (MC13XXX_ADC0_TSMOD_MASK |
> +			MC13XXX_ADC0_EN_READING_MASK);
Maybe also put MC13XXX_ADC0_TSMOD_MASK into MC13XXX_ADC0_EN_READING_MASK
and only use the latter here?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
