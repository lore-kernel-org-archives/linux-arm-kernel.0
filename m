From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 16 Aug 2011 11:25:31 +0200
Subject: [PATCH] amba: consolidate PrimeCell magic
In-Reply-To: <000101cc5bf5$c38bdca0$4aa395e0$%kim@samsung.com>
References: <1313402104-27024-1-git-send-email-linus.walleij@stericsson.com>
	<001601cc5be9$275a5200$760ef600$%kim@samsung.com>
	<CACRpkdZ=cPen0KvK3__iabu8Xwhz8Yjcb-ev-qLe_AY4jaYACA@mail.gmail.com>
	<000101cc5bf5$c38bdca0$4aa395e0$%kim@samsung.com>
Message-ID: <CACRpkdYTPzcrMCr_Fj_shMzHc9A_BSa4j3GESP56nGx609ae=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/8/16 Boojin Kim <boojin.kim@samsung.com>:

> Actually, I tested this patch after applying my patches that uses
> 'dma-pl330' driver instead of the samsung specific 's3c-pl330' driver.
> 'dma-pl330' driver is registered as 'amba_device'. So, this has already
> checked on 'drivers/amba/bus.c' as your notice.
> But, 's3c-pl330' driver is registered as 'platform_device'. So, This check
> is required.
> In my opinion, This check can be deleted if caller device is registered as
> 'amba_device'.

My latest (v2) version of the patch deletes the check.

But doing that is dependent on the s3c-pl330 going away and
being replaced by the dmaengine driver, else I think we shall try to
keep the check (I will have to make it work without
dereferencing the amba_device or it will break).

Is it your plan to replace s3c-pl330 with the drivers/dma/pl330.c
driver, so I can safely delete this code?

Thanks,
Linus Walleij
