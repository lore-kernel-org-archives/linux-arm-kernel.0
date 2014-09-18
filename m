From: jonghwa3.lee@samsung.com (jonghwa3.lee at samsung.com)
Date: Thu, 18 Sep 2014 11:04:16 +0900
Subject: [RESEND PATCH] arm: exynos: Allow rtc alarm and tick wakeup irq
 for exynos3250.
In-Reply-To: <CAGm_ybjMaLHPALp519fe=UdMy1DeJbcxUxJN+hcPecttY7A_tQ@mail.gmail.com>
References: <1410923262-4771-1-git-send-email-jonghwa3.lee@samsung.com>
 <CAGm_ybjMaLHPALp519fe=UdMy1DeJbcxUxJN+hcPecttY7A_tQ@mail.gmail.com>
Message-ID: <541A3DA0.1040805@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014? 09? 17? 17:53, Vikas Sajjan wrote:

> Hi,
> 
> On Wed, Sep 17, 2014 at 8:52 AM, Jonghwa Lee <jonghwa3.lee@samsung.com> wrote:
>> Add rtc alarm and tick irq to wakeup sources in exynos3250.
>>
>> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
>> Acked-by : Chanwoo choi <cw00.choi@samsung.com>
>> ---
>>  arch/arm/mach-exynos/pm.c |    9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
>> index fa7218a..d78dcf9 100644
>> --- a/arch/arm/mach-exynos/pm.c
>> +++ b/arch/arm/mach-exynos/pm.c
>> @@ -66,6 +66,12 @@ static struct sleep_save exynos_core_save[] = {
>>
>>  static u32 exynos_irqwake_intmask = 0xffffffff;
>>
>> +static const struct exynos_wkup_irq exynos3250_wkup_irq[] = {
>> +       { 105, BIT(1) }, /* RTC alarm */
>> +       { 106, BIT(2) }, /* RTC tick */
>> +       { /* sentinel */ },
>> +};
>> +
>>  static const struct exynos_wkup_irq exynos4_wkup_irq[] = {
>>         { 76, BIT(1) }, /* RTC alarm */
>>         { 77, BIT(2) }, /* RTC tick */
>> @@ -81,9 +87,10 @@ static const struct exynos_wkup_irq exynos5250_wkup_irq[] = {
>>  static int exynos_irq_set_wake(struct irq_data *data, unsigned int state)
>>  {
>>         const struct exynos_wkup_irq *wkup_irq;
>> -
>>         if (soc_is_exynos5250())
>>                 wkup_irq = exynos5250_wkup_irq;
>> +       else if (soc_is_exynos3250())
>> +               wkup_irq = exynos3250_wkup_irq;
> 
> 
> Don't add anymore soc_is_exynosxxx() checks, please rebase on [1],
> which refactors the pm.c to use DT based lookup.
> 
> [1] http://www.spinics.net/lists/arm-kernel/msg355266.html
>


Okay, I'll wait those patches are merged, then I'll rebase and repost it.

Thanks,
Jonghwa.
