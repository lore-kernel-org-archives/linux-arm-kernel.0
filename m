From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Thu, 18 Oct 2012 20:14:44 +0530
Subject: [PATCH 1/8] [media] s5p-fimc: Use clk_prepare_enable and
 clk_disable_unprepare
In-Reply-To: <507ED56E.1000406@samsung.com>
References: <1350472311-9748-1-git-send-email-sachin.kamat@linaro.org>
 <507EC1BF.6040107@samsung.com>
 <CAK9yfHymckQLOp=xavQ1sj5uJKRg7tFMXgvo68Dp8GL6N9g0JQ@mail.gmail.com>
 <507ED56E.1000406@samsung.com>
Message-ID: <CAK9yfHwovfqv=P-dMFgUNq67-NiZUC5CeD5biukk_B60boPEjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 October 2012 21:27, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
> On 10/17/2012 05:35 PM, Sachin Kamat wrote:
>>> Most of the s5p-* drivers have already added support for clk_(un)prepare.
>>> Thus most of your changes in this patch are not needed. I seem to have only
>>> missed fimc-mdevice.c, other modules are already reworked
>>
>> I did not find these changes in your tree. Please let me know the
>> branch where these changes are available.
>
> Are in Linus' tree, for quite long already, commits:
>
> 11a37c709797cc56f48905e68a3099b79cf08850
> [media] s5p-g2d: Added support for clk_prepare
>
> bd7d8888e99d67f778f4ee272346322c0b9cb378
> [media] s5p-fimc: convert to clk_prepare()/clk_unprepare()
>
> eb732518e0db585376f95256b18b2149240e3ad3
> [media] s5p-mfc: Added support for clk_prepare

Oh I see.. I dunno how i missed to notice this..


>
> Please note there was the media drivers reorganization recently, e.g.
> drivers/media/video/s5p-* changed to drivers/media/platform/s5p-*.

Right. I am aware of that.

>
>>> $ git grep -5  clk_prepare  -- drivers/media/platform/s5p-fimc
>>> drivers/media/platform/s5p-fimc/fimc-core.c-
>>> drivers/media/platform/s5p-fimc/fimc-core.c-    for (i = 0; i < MAX_FIMC_CLOCKS; i++) {
>>> drivers/media/platform/s5p-fimc/fimc-core.c-            fimc->clock[i] = clk_get(&fimc->pdev->dev, fimc_clocks[i]);
>>> drivers/media/platform/s5p-fimc/fimc-core.c-            if (IS_ERR(fimc->clock[i]))
>>
>>>> I would prefer you have added the required changes at fimc_md_get_clocks()
>>> and fimc_md_put_clocks() functions.
>>
>> Ok. I will check this.
>
> Thanks.
>
> --
> Regards,
> Sylwester

Thanks Sylwester.


-- 
With warm regards,
Sachin
