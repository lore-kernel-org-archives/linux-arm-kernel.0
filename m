From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Mon, 7 Nov 2011 15:39:05 +0530
Subject: [PATCH v8 16/24] gpio/omap: use pm-runtime framework
In-Reply-To: <87lirvbykm.fsf@ti.com>
References: <1317803593-12259-1-git-send-email-tarun.kanti@ti.com>
 <1317803593-12259-17-git-send-email-tarun.kanti@ti.com>
 <87lirvbykm.fsf@ti.com>
Message-ID: <CAC83Zv+QFbaZucM8V36qG6tvz_KiFfwGSCxjJSoT60LY2LLuNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 4, 2011 at 10:43 PM, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> Call runtime pm APIs pm_runtime_get_sync() and pm_runtime_put_sync()
>> for enabling/disabling clocks appropriately. Remove syscore_ops and
>> instead use SET_RUNTIME_PM_OPS macro.
>>
>> Signed-off-by: Charulatha V <charu@ti.com>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>> ?arch/arm/mach-omap2/gpio.c | ? ?2 -
>> ?drivers/gpio/gpio-omap.c ? | ? 67 +++++++++++++++++++++++++++++---------------
>> ?2 files changed, 44 insertions(+), 25 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
>> index 5ae1cf3..a992802 100644
>> --- a/arch/arm/mach-omap2/gpio.c
>> +++ b/arch/arm/mach-omap2/gpio.c
>> @@ -146,8 +146,6 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
>> ? ? ? ? ? ? ? return PTR_ERR(od);
>> ? ? ? }
>>
>> - ? ? omap_device_disable_idle_on_suspend(od);
>> -
>
> No description in the changelog about this change. ?(Yes, I understand
> why it's removed, but it needs to be described in the changelog so when
> I forget, I'll have a way to remember.)
Yes, I will put a description explaining that this is not needed after
driver is runtime adapted.
--
Tarun
>
> Kevin
>
