From: darkstar6262@gmail.com (Cory Maccarrone)
Date: Fri, 24 Sep 2010 08:38:37 -0700
Subject: [PATCH] [OMAP] HTCHERALD: MMC, I2C, HTCPLD, SPI, TSC2046
In-Reply-To: <AANLkTik83Q8wdZdv=oG86Yp3Lgbxezp-mFtHMcQpKd8c@mail.gmail.com>
References: <1282106047-7619-1-git-send-email-darkstar6262@gmail.com>
	<1282106146-7727-1-git-send-email-darkstar6262@gmail.com>
	<AANLkTik83Q8wdZdv=oG86Yp3Lgbxezp-mFtHMcQpKd8c@mail.gmail.com>
Message-ID: <AANLkTinh=oRnuf1RQ3_=UEuke4PHaPB-172peMca7Ya7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/9/24 Micha? Miros?aw <mirqus@gmail.com>:
> 2010/8/18 Cory Maccarrone <darkstar6262@gmail.com>:
>> This change adds in MMC and I2C support to the HTC Herald board, as well
>> as adding the HTCPLD driver for the PLD used on this phone. ?It also
>> adds in the gpio-keys entries for the front directional keys and
>> selector and the cursor keys on the slide-out keyboard, and gpio-leds
>> support for the LEDs attached to the htcpld.
>>
>> Additionally, SPI bus support (using the spi100k driver) and
>> touchscreen support (using the ads7846 driver) were added.
>>
>> Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
>> ---
> [...]
>> +/* MMC Card */
>> +#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
>> +static struct omap_mmc_platform_data htc_mmc1_data = {
>> + ? ? ? .nr_slots ? ? ? ? ? ? ? ? ? ? ? = 1,
>> + ? ? ? .switch_slot ? ? ? ? ? ? ? ? ? ?= NULL,
>> + ? ? ? .slots[0] ? ? ? = {
>> + ? ? ? ? ? ? ? .ocr_mask ? ? ? ? ? ? ? = MMC_VDD_28_29 | MMC_VDD_30_31 |
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? MMC_VDD_32_33 | MMC_VDD_33_34,
>> + ? ? ? ? ? ? ? .name ? ? ? ? ? ? ? ? ? = "mmcblk",
>> + ? ? ? ? ? ? ? .nomux ? ? ? ? ? ? ? ? ?= 1,
>> + ? ? ? ? ? ? ? .wires ? ? ? ? ? ? ? ? ?= 4,
>> + ? ? ? ? ? ? ? .switch_pin ? ? ? ? ? ? = -1,
>> + ? ? ? },
>> +};
> [...]
>
> What voltages can this MMC controller provide? That's a rather unusual OCR mask.
>
> Best Regards,
> Micha? Miros?aw
>

Not really sure, I wasn't the one who first came up with that mask.
All I know is that it seems to work, and not just for my device, but
lots of other HTC OMAP850 devices we've tried it on too.

I'm interested though, what in particular makes it unusual?

- Cory
