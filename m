From: daniel.lezcano@free.fr (Daniel Lezcano)
Date: Thu, 11 Apr 2013 07:58:26 +0200
Subject: [PATCH 13/18] ARM: tegra2: cpuidle: use init/exit common routine
In-Reply-To: <1365642100.1806.5.camel@jlo-ubuntu-64.nvidia.com>
References: <1365603743-5618-1-git-send-email-daniel.lezcano@linaro.org>
 <1365603743-5618-14-git-send-email-daniel.lezcano@linaro.org>
 <1365642100.1806.5.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <51665102.10301@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/2013 03:01 AM, Joseph Lo wrote:
> On Wed, 2013-04-10 at 22:22 +0800, Daniel Lezcano wrote:
>> Remove the duplicated code and use the cpuidle common code for initialization.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  arch/arm/mach-tegra/cpuidle-tegra20.c |   33 +--------------------------------
>>  1 file changed, 1 insertion(+), 32 deletions(-)
>>
>> diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
>> index f1f6ac4..d6c2ba6 100644
>> --- a/arch/arm/mach-tegra/cpuidle-tegra20.c
>> +++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
>> @@ -70,8 +70,6 @@ static struct cpuidle_driver tegra_idle_driver = {
>>  	.safe_state_index = 0,
>>  };
>>  
>> -static DEFINE_PER_CPU(struct cpuidle_device, tegra_idle_device);
>> -
>>  #ifdef CONFIG_PM_SLEEP
>>  #ifdef CONFIG_SMP
>>  static void __iomem *pmc = IO_ADDRESS(TEGRA_PMC_BASE);
>> @@ -220,34 +218,5 @@ static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
>>  
>>  int __init tegra20_cpuidle_init(void)
>>  {
>> -	int ret;
>> -	unsigned int cpu;
>> -	struct cpuidle_device *dev;
>> -	struct cpuidle_driver *drv = &tegra_idle_driver;
>> -
>> -#ifdef CONFIG_PM_SLEEP
>> -	tegra_tear_down_cpu = tegra20_tear_down_cpu;
>> -#endif
> Hi Daniel,
>
> Please keep these 3 lines above, just like you did for Tegra30.
>
> Thanks,
> Joseph

Oups, thanks !

  -- Daniel
