From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sun, 11 Aug 2013 12:53:41 +0800
Subject: [PATCH v6 08/11] ARM: pxa: init dma debugfs in late level
In-Reply-To: <52067865.60506@gmail.com>
References: <1374833133-21119-1-git-send-email-haojian.zhuang@gmail.com>
 <1374833133-21119-9-git-send-email-haojian.zhuang@gmail.com>
 <52067865.60506@gmail.com>
Message-ID: <CAN1soZzV2NTGVwVm6Jb3N-c_qxC98+2OVik8Psnv5Yp7ZsDf4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 11, 2013 at 1:29 AM, Daniel Mack <zonque@gmail.com> wrote:
> Hi Haojian,
>
> On 26.07.2013 12:05, Haojian Zhuang wrote:
>> Remove pxa_init_dma() from core_initcall level since it's unncecssary
>> for DT mode. But dma debugfs is also included in pxa_init_dma().
>> So only initiliaze dma debugfs in late_initcall level.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
>> ---
>>  arch/arm/mach-mmp/mmp2.c   |  2 +-
>>  arch/arm/mach-mmp/pxa168.c |  2 +-
>>  arch/arm/mach-mmp/pxa910.c |  2 +-
>>  arch/arm/plat-pxa/dma.c    | 30 ++++++++++++++++++++----------
>>  4 files changed, 23 insertions(+), 13 deletions(-)
>
> This will collide with my dma rework series, which removes
> arch/arm/plat-pxa/dma.c eventually. Do you think it's possible to just
> drop that patch here and wait for my series to settle?
>
>
> Daniel
>

Sure. I'll drop it from my patch list.

Best Regards
Haojian
