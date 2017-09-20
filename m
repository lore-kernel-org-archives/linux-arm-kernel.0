From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 20 Sep 2017 19:02:24 +0900
Subject: [PATCH 0/5] nvmem: some cleanups and sparse warning fixes
In-Reply-To: <1505134864-11975-1-git-send-email-yamada.masahiro@socionext.com>
References: <1505134864-11975-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNAQHoDN=SOLA6AxyeCOUObRwy6nJHizo6xoDEX1gybvqNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srinivas,


2017-09-11 22:00 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>
> Socionext is trying to add a new nvmem driver.
>
> Before adding a new one, I'd like to be sure about the preferred
> coding style in this subsystem, and build-up cleaner code base.
>
> Please pick up what you like.  Please feel free to throw away
> what you do not like.
>
> 1/5, 2/5: convert kzalloc to stack because nvmem_config
> is small one-time use data.
> This is what we agreed in the discussion.
>
> 3/5, 4/5: fix sparse warning
> For mtk-efuse, qfprom, the base address is the only private data
> but, assigning (void __iomem *) to ->priv directly causes sparse
> warnings.
>
> 5/5: clean-up of owner settings - if the owner field matches
> nvmem->dev->driver->onwer, we need not set the onwer field
> explicitly.


Does this series look OK?

Thanks.




-- 
Best Regards
Masahiro Yamada
