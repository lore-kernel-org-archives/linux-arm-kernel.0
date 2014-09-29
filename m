From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 29 Sep 2014 19:08:04 +0900
Subject: [PATCHv3 3/4] ARM: exynos: Add exynos3250 compatible to use
 generic cpufreq driver
In-Reply-To: <CAKohpokXNEYZBqsKyJDMUCZA7BY_E0=G5eVmTx_cBKvAyoSi9w@mail.gmail.com>
References: <1411628707-8496-1-git-send-email-cw00.choi@samsung.com>
 <1411628707-8496-4-git-send-email-cw00.choi@samsung.com>
 <CAKohpokXNEYZBqsKyJDMUCZA7BY_E0=G5eVmTx_cBKvAyoSi9w@mail.gmail.com>
Message-ID: <54292F84.4060906@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/29/2014 06:58 PM, Viresh Kumar wrote:
> On 25 September 2014 00:05, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>> This patch add exynos3250 compatible string to exynos_cpufreq_matches
>> for supporting generic cpufreq driver on Exynos3250.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>> Cc: Tomasz Figa <tomasz.figa@gmail.com>
>> Cc: Thomas Abraham <thomas.ab@samsung.com>
>> ---
>>  arch/arm/mach-exynos/exynos.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
>> index 8923d37..1318d69 100644
>> --- a/arch/arm/mach-exynos/exynos.c
>> +++ b/arch/arm/mach-exynos/exynos.c
>> @@ -285,6 +285,7 @@ static const struct of_device_id exynos_cpufreq_matches[] = {
>>         { .compatible = "samsung,exynos5420", .data = "arm-bL-cpufreq-dt" },
>>         { .compatible = "samsung,exynos5250", .data = "cpufreq-cpu0" },
>>         { .compatible = "samsung,exynos4210", .data = "cpufreq-cpu0" },
>> +       { .compatible = "samsung,exynos3250", .data = "cpufreq-cpu0" },
> 
> cpufreq-cpu0 is renamed to cpufreq-dt now.

As you comment, I checked it on following patch. I'll change it.
https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/drivers/cpufreq/cpufreq-dt.c?h=linux-next&id=978027e170fbf428ccb1dedcdaa8f1eb7ced97f4

Thanks,
Chanwoo Choi
