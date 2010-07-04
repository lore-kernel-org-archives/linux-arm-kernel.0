From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Sun, 04 Jul 2010 11:22:59 +0200
Subject: [PATCH v2 1/2] ARM: SAMSUNG: Add device definition for HSMMC3
In-Reply-To: <009501cb1a4e$04f57ec0$0ee07c40$%kim@samsung.com>
References: <1278115660-20969-1-git-send-email-kgene.kim@samsung.com>
	<1278115660-20969-2-git-send-email-kgene.kim@samsung.com>
	<4C2E81AC.3090707@gmail.com>
	<009501cb1a4e$04f57ec0$0ee07c40$%kim@samsung.com>
Message-ID: <4C3052F3.4080208@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Op 03-07-10 03:21, Kukjin Kim schreef:
> Maurus Cuelenaere wrote:
>>  Op 03-07-10 02:07, Kukjin Kim schreef:
>>
>>>  /* S3C6400 SDHCI setup */
>>>
>>> @@ -264,10 +267,22 @@ static inline void s5pv210_default_sdhci2(void)
>>>  static inline void s5pv210_default_sdhci2(void) { }
>>>  #endif /* CONFIG_S3C_DEV_HSMMC2 */
>>>
>>> +#ifdef CONFIG_S3C_DEV_HSMMC3
>>> +static inline void s5pv210_default_sdhci3(void)
>>> +{
>>> +	s3c_hsmmc3_def_platdata.clocks = s5pv210_hsmmc_clksrcs;
>>> +	s3c_hsmmc3_def_platdata.cfg_gpio = s5pv210_setup_sdhci3_cfg_gpio;
>>> +	s3c_hsmmc3_def_platdata.cfg_card = s5pv210_setup_sdhci_cfg_card;
>>> +}
>>> +#else
>>> +static inline void s5pv210_default_sdhci3(void) { }
>>> +#endif /* CONFIG_S3C_DEV_HSMMC3 */
>> This could be simplified by putting the #ifdef inside the function.
> Yeah, you're right..but used same style with others in this file.
> ...so will modify it as your comment with others soon.

Hmm yes, I guess it's just a matter of personal taste.

-- 
Maurus Cuelenaere
