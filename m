From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 18 Jun 2015 09:26:44 +0200
Subject: [PATCH v6 0/7] Add Mediatek MMC driver
In-Reply-To: <CAP=VYLpBymmAVY7LoFJR5+QTxL4CN7t+PrLFCxaoAN_a9S4Jbw@mail.gmail.com>
References: <1434367253-26577-1-git-send-email-chaotian.jing@mediatek.com>
 <CAPDyKFrAbAFR7_p5O4bPh6FZEBVhGZ2rq3htCKcF2QgQuCEf2g@mail.gmail.com>
 <CAP=VYLpBymmAVY7LoFJR5+QTxL4CN7t+PrLFCxaoAN_a9S4Jbw@mail.gmail.com>
Message-ID: <CAPDyKFrG6iNQs6be3sWtVX8+UYs2du5=YUGHvyRsxnFH+8cA0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 June 2015 at 23:01, Paul Gortmaker <paul.gortmaker@windriver.com> wrote:
> On Tue, Jun 16, 2015 at 4:03 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 15 June 2015 at 13:20, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>>> This series enables MMC support on the MT8135/MT8173 platform.
>>> MT8135 has 5 MMC controllers and MT8173 has 4 MMC controllers.
>>>
>>> Changes base on Ulf's comments
>>> Make hclk mandatory in the driver code
>>> Change host->hclk to host->src_clk_freq
>>> Add linux/pm.h
>>>
>>> Chaotian Jing (3):
>>>   mmc: dt-bindings: add Mediatek MMC bindings
>>>   mmc: mediatek: Add Mediatek MMC driver.
>
> This commit breaks when merged to linux-next since it gets
> exposed as an implicit module.h user that does not include
> that header:
>
>    drivers/mmc/host/mtk-sd.c:1459:1: note: in expansion of macro
> 'module_platform_driver'
>     module_platform_driver(mt_msdc_driver);
>     ^
>    include/linux/device.h:1296:1: error: type defaults to 'int' in
> declaration of 'module_init' [-Werror=implicit-int]
>     module_init(__driver##_init); \
>     ^
>
> Since the code doesn't exist in mainline, I can't fix it from
> within my header cleanup series, so can you please add
> an appropriate include of module.h to the above?
>
> Also, I noticed the Makefile addition from this commit
> is whitespace mangled; might as well fix that too if
> rebasing to fix the include problem.
>
> Thanks,
> Paul.

Paul, appreciate your feedback!
I have re-based my next branch and updated the commit according to
your suggestions.

Kind regards
Uffe
