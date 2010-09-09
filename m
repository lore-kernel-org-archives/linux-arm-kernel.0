From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 9 Sep 2010 09:03:17 +0200
Subject: [PATCH] MMC: move regulator handling closer to core v3
In-Reply-To: <20100908155114.880463fc.akpm@linux-foundation.org>
References: <1283677538-31121-1-git-send-email-linus.walleij@stericsson.com>
	<20100908155114.880463fc.akpm@linux-foundation.org>
Message-ID: <AANLkTinADjBaOcfdtGRZK0WdMs0xt+PLWGE7NUBndRr_@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/9/9 Andrew Morton <akpm@linux-foundation.org>:
> On Sun, ?5 Sep 2010 11:05:38 +0200
> Linus Walleij <linus.walleij@stericsson.com> wrote:
>> + ? ? if (host->vcc) {
>> + ? ? ? ? ? ? int ret;
>> +
>> + ? ? ? ? ? ? if (power_mode == MMC_POWER_UP)
>> + ? ? ? ? ? ? ? ? ? ? ret = mmc_regulator_set_ocr(host->mmc, host->vcc, vdd);
>> + ? ? ? ? ? ? else if (power_mode == MMC_POWER_OFF)
>> + ? ? ? ? ? ? ? ? ? ? ret = mmc_regulator_set_ocr(host->mmc, host->vcc, 0);
>> + ? ? }
>
> There's no point in copying the return value into a local then ignoring
> it. ?mmc_regulator_set_ocr() can return a negative errno so we should
> test for that, clean up and propagate the error.

OK I'll fix.

> The same comments apply to mmci_set_ios().

OK.

Yours,
Linus Walleij
