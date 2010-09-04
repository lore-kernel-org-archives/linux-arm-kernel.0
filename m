From: adrian.hunter@nokia.com (Adrian Hunter)
Date: Sat, 04 Sep 2010 09:10:23 +0300
Subject: [PATCH] MMC: move regulator handling closer to core v2
In-Reply-To: <AANLkTik-uLMUz2g2znaF0K43D8CONsGdjrRqxTCqpS_X@mail.gmail.com>
References: <1283268367-3525-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTik-uLMUz2g2znaF0K43D8CONsGdjrRqxTCqpS_X@mail.gmail.com>
Message-ID: <4C81E2CF.8070406@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote:
> 2010/8/31 Linus Walleij <linus.walleij@stericsson.com>:
> 
>> After discovering a problem in regulator reference counting I
>> took Mark Brown's advice to move the reference count into the
>> MMC core by making the regulator status a member of
>> struct mmc_host.
> 
> This has an Reveiwed-by from the regulator maintainer and
> seems to address all comments, noone is objection so Andrew
> can you pick it up?

One of our contractors had a look at the patch and had this comment:

One comment/question:
/host/mmci.c in function
"static int __devexit mmci_remove(struct amba_device *dev)" there is code:
         if (regulator_is_enabled(host->vcc))
             regulator_disable(host->vcc);
should "ret = mmc_regulator_set_ocr(mmc, host->vcc, 0);" be added here?

> 
> Yours,
> Linus Walleij
> 
