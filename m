From: yong.shen@linaro.org (Yong Shen)
Date: Thu, 6 Jan 2011 17:45:11 +0800
Subject: [PATCH] ARM i.MX53: enable fec driver on EVK board
In-Reply-To: <20110106061647.GB30232@jasper.tkos.co.il>
References: <1294292731-2896-1-git-send-email-yong.shen@freescale.com>
	<20110106061647.GB30232@jasper.tkos.co.il>
Message-ID: <AANLkTi=Bh7yrE-n0egTMPzhhfXNPrz11jJrnXd7h2J+e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

Thanks for comments.

>>
>> +static inline void fec_reset(void)
>
> For the sake of clearer stack traces I prefer a less generic name for this
> routine, something like mx53_evk_fec_reset().
>
Acked.
>> +{
>> + ? ? int ret;
>> +
>> + ? ? /* reset FEC PHY */
>> + ? ? ret = gpio_request(SMD_FEC_PHY_RST, "fec-phy-reset");
>> + ? ? if (ret) {
>> + ? ? ? ? ? ? printk(KERN_ERR"failed to get GPIO_FEC_PHY_RESET: %d\n", ret);
>> + ? ? ? ? ? ? return;
>> + ? ? }
>> + ? ? gpio_direction_output(SMD_FEC_PHY_RST, 0);
>> + ? ? gpio_set_value(SMD_FEC_PHY_RST, 0);
>
> This seems to be redundant. gpio_direction_output() has already set the value
> to 0.

You are right. But, gpio_set_value is meant to be here to show the
process of fec reset: first pull low and then pull high. And
gpio_direction_output here is for direction configuration although it
has the ability of configure output value.

cheers
Yong
