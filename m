From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Thu, 12 Apr 2012 10:22:22 +0530
Subject: [PATCH] ARM: OMAP2+: remove redundant sysconfig context restore
In-Reply-To: <87zkahlrdc.fsf@ti.com>
References: <1334133256-20475-1-git-send-email-tarun.kanti@ti.com>
 <87zkahlrdc.fsf@ti.com>
Message-ID: <CAC83ZvKyh38=BdWg9ExTM20Sq_c3e-fo2JrH5Cmv80hY8TxLLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 12, 2012 at 6:04 AM, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> Since hwmod framework now manages sysconfig context save/restore
>> there is no more need to touch this register in driver. Hence,
>> remove restore of sysconfig register in omap_timer_restore_context.
>> This was causing incorrect context restore of sysconfig register.
>>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>
> While cleaning this up, you can remove it from 'struct timer_regs' ?in
> <plat/dmtimer.h> as well, since the code you remove is the only user.
Oh yes I missed that. Thanks.
--
Tarun
>
> Kevin
>
>> ---
>> ?arch/arm/plat-omap/dmtimer.c | ? ?2 --
>> ?1 files changed, 0 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
>> index 652139c..15e7882 100644
>> --- a/arch/arm/plat-omap/dmtimer.c
>> +++ b/arch/arm/plat-omap/dmtimer.c
>> @@ -82,8 +82,6 @@ static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u32 reg,
>>
>> ?static void omap_timer_restore_context(struct omap_dm_timer *timer)
>> ?{
>> - ? ? __raw_writel(timer->context.tiocp_cfg,
>> - ? ? ? ? ? ? ? ? ? ? timer->io_base + OMAP_TIMER_OCP_CFG_OFFSET);
>> ? ? ? if (timer->revision == 1)
>> ? ? ? ? ? ? ? __raw_writel(timer->context.tistat, timer->sys_stat);
