From: kyungmin.park@samsung.com (Kyungmin Park)
Date: Mon, 22 Oct 2012 08:44:47 +0900
Subject: [PATCH] ARM: EXYNOS: exynos4-dt: Set .smp field of machine
 descriptor
In-Reply-To: <2064474.beoN9hr7Vi@flatron>
References: <1350035378-31989-1-git-send-email-t.figa@samsung.com>
 <2064474.beoN9hr7Vi@flatron>
Message-ID: <CAH9JG2W-Tg5ZwzwuXg3-56KhiLwQS3rGktweRG8XwdVMda=HBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Arnd, Olof,

Tomasz,
I think it's better to add arm-soc maintainers at CC when send the patches.
Samsung patches doesn't handled or merged with proper time.

Thank you,
Kyungmin Park

On 10/22/12, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> On Friday 12 of October 2012 11:49:38 Tomasz Figa wrote:
>> This patch adds missing initializer of .smp field of machine descriptor
>> of Exynos 4 DT machine.
>>
>> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
>> ---
>>  arch/arm/mach-exynos/mach-exynos4-dt.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/mach-exynos/mach-exynos4-dt.c
>> b/arch/arm/mach-exynos/mach-exynos4-dt.c index 7222e3c..d6bdcfb 100644
>> --- a/arch/arm/mach-exynos/mach-exynos4-dt.c
>> +++ b/arch/arm/mach-exynos/mach-exynos4-dt.c
>> @@ -119,6 +119,7 @@ static char const *exynos4_dt_compat[] __initdata =
>> {
>>
>>  DT_MACHINE_START(EXYNOS4210_DT, "Samsung Exynos4 (Flattened Device
>> Tree)") /* Maintainer: Thomas Abraham <thomas.abraham@linaro.org> */
>> +	.smp		= smp_ops(exynos_smp_ops),
>>  	.init_irq	= exynos4_init_irq,
>>  	.map_io		= exynos4_dt_map_io,
>>  	.handle_irq	= gic_handle_irq,
>
> Ping. I think this should be considered a fix.
>
> Best regards,
> Tomasz Figa
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc"
> in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
