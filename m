From: mirqus@gmail.com (=?ISO-8859-2?Q?Micha=B3_Miros=B3aw?=)
Date: Fri, 24 Sep 2010 18:11:28 +0200
Subject: [PATCH] [OMAP] HTCHERALD: MMC, I2C, HTCPLD, SPI, TSC2046
In-Reply-To: <AANLkTinh=oRnuf1RQ3_=UEuke4PHaPB-172peMca7Ya7@mail.gmail.com>
References: <1282106047-7619-1-git-send-email-darkstar6262@gmail.com>
	<1282106146-7727-1-git-send-email-darkstar6262@gmail.com>
	<AANLkTik83Q8wdZdv=oG86Yp3Lgbxezp-mFtHMcQpKd8c@mail.gmail.com>
	<AANLkTinh=oRnuf1RQ3_=UEuke4PHaPB-172peMca7Ya7@mail.gmail.com>
Message-ID: <AANLkTikNLn-VuCQb2q7wZVbYORxV6uhia_oOBsQg3ZiJ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 24 wrze?nia 2010 17:38 u?ytkownik Cory Maccarrone
<darkstar6262@gmail.com> napisa?:
> 2010/9/24 Micha? Miros?aw <mirqus@gmail.com>:
>> 2010/8/18 Cory Maccarrone <darkstar6262@gmail.com>:
>>> This change adds in MMC and I2C support to the HTC Herald board, as well
>>> as adding the HTCPLD driver for the PLD used on this phone. ?It also
>>> adds in the gpio-keys entries for the front directional keys and
>>> selector and the cursor keys on the slide-out keyboard, and gpio-leds
>>> support for the LEDs attached to the htcpld.
>>>
>>> Additionally, SPI bus support (using the spi100k driver) and
>>> touchscreen support (using the ads7846 driver) were added.
>>>
>>> Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
>>> ---
>> [...]
>>> +/* MMC Card */
>>> +#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
>>> +static struct omap_mmc_platform_data htc_mmc1_data = {
>>> + ? ? ? .nr_slots ? ? ? ? ? ? ? ? ? ? ? = 1,
>>> + ? ? ? .switch_slot ? ? ? ? ? ? ? ? ? ?= NULL,
>>> + ? ? ? .slots[0] ? ? ? = {
>>> + ? ? ? ? ? ? ? .ocr_mask ? ? ? ? ? ? ? = MMC_VDD_28_29 | MMC_VDD_30_31 |
>>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? MMC_VDD_32_33 | MMC_VDD_33_34,
>>> + ? ? ? ? ? ? ? .name ? ? ? ? ? ? ? ? ? = "mmcblk",
>>> + ? ? ? ? ? ? ? .nomux ? ? ? ? ? ? ? ? ?= 1,
>>> + ? ? ? ? ? ? ? .wires ? ? ? ? ? ? ? ? ?= 4,
>>> + ? ? ? ? ? ? ? .switch_pin ? ? ? ? ? ? = -1,
>>> + ? ? ? },
>>> +};
>> [...]
>> What voltages can this MMC controller provide? That's a rather unusual OCR mask.
> Not really sure, I wasn't the one who first came up with that mask.
> All I know is that it seems to work, and not just for my device, but
> lots of other HTC OMAP850 devices we've tried it on too.
>
> I'm interested though, what in particular makes it unusual?

It specifies, that device supports voltage ranges:
2.8V - 2.9V, 3.0V - 3.1V, 3.2V - 3.4V
(so: 2.9V - 3.0V and 3.1V - 3.2V are not available).
Are there really 2.8V, 3.0V, 3.3V VDDs settable?

If the host supports only VDD = 3.3V for example, then correct OCR
mask would be: MMC_VDD_32_33 | MMC_VDD_33_34 (or just one flag).

Best Regards,
Micha? Miros?aw
