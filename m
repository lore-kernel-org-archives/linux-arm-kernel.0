From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sun, 5 Sep 2010 11:05:33 +0200
Subject: [PATCH] MMC: move regulator handling closer to core v2
In-Reply-To: <4C81E2CF.8070406@nokia.com>
References: <1283268367-3525-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTik-uLMUz2g2znaF0K43D8CONsGdjrRqxTCqpS_X@mail.gmail.com>
	<4C81E2CF.8070406@nokia.com>
Message-ID: <AANLkTi=n=h=00QM-Tgy_3E425f+ZeTEkF=mfnUpt1+vS@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/9/4 Adrian Hunter <adrian.hunter@nokia.com>:

> One of our contractors had a look at the patch and had this comment:
>
> One comment/question:
> /host/mmci.c in function
> "static int __devexit mmci_remove(struct amba_device *dev)" there is code:
> ? ? ? ?if (regulator_is_enabled(host->vcc))
> ? ? ? ? ? ?regulator_disable(host->vcc);
> should "ret = mmc_regulator_set_ocr(mmc, host->vcc, 0);" be added here?

Good catch!

Since it's in the remove() we can't do much about the return value from that
call but we should sure use the _set_ocr() so fixed it and pushed v3.

Yours,
Linus Walleij
