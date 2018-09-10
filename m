From: sed@free.fr (Cedric Roux)
Date: Mon, 10 Sep 2018 18:55:09 +0200
Subject: [PATCH v3 2/2] ARM: s3c24xx: Correct SD card write protect
 detection on Mini2440
In-Reply-To: <CAJKOXPeYO3VR5LABP3zKYnKckqUBahKPt7MCjzuo3j6oe+d87w@mail.gmail.com>
References: <20180907215446.15160-1-sed@free.fr>
 <20180907215446.15160-2-sed@free.fr>
 <CAJKOXPeYO3VR5LABP3zKYnKckqUBahKPt7MCjzuo3j6oe+d87w@mail.gmail.com>
Message-ID: <ba9d81bf-f000-f6ae-30b1-3e922985f655@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/2018 12:23 PM, Krzysztof Kozlowski wrote:
>>  static struct s3c24xx_mci_pdata mini2440_mmc_cfg __initdata = {
>> -       .gpio_detect   = S3C2410_GPG(8),
>> -       .gpio_wprotect = S3C2410_GPH(8),
>> -       .set_power     = NULL,
>> -       .ocr_avail     = MMC_VDD_32_33|MMC_VDD_33_34,
>> +       .gpio_detect     = S3C2410_GPG(8),
>> +       .gpio_wprotect   = S3C2410_GPH(8),
>> +       .wprotect_invert = 1,
>> +       .set_power       = NULL,
>> +       .ocr_avail       = MMC_VDD_32_33|MMC_VDD_33_34,
> 
> This looks unexpected... after patch 1 there should be only one change
> - one new line added. What happened here?

This is to align all the '='.

These were spaces before the '=' so I also used spaces.
Should I put TABs instead? I looked in the coding style
and didn't find anything about this specific thing
(maybe I read too fast though).

And if this ends up unaligned because 'wprotect_invert'
requires a second TAB for the others, should I do a separate
commit?

Thanks.

Regards,
C?dric.
