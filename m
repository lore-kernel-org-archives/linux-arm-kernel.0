From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 03 Jul 2014 11:24:23 +0200
Subject: [PATCH 08/16] ARM: mvebu: Use a local variable to store the resume
 address
In-Reply-To: <20140630170952.6d92f96d@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>	<1403875377-940-9-git-send-email-gregory.clement@free-electrons.com>
 <20140630170952.6d92f96d@free-electrons.com>
Message-ID: <53B52147.9070601@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 30/06/2014 17:09, Thomas Petazzoni wrote:
> Dear Gregory CLEMENT,
> 
> On Fri, 27 Jun 2014 15:22:49 +0200, Gregory CLEMENT wrote:
> 
>> +static void *mvebu_cpu_resume;
>> +
>>  static struct platform_device mvebu_v7_cpuidle_device = {
>>  	.name = "cpuidle-armada-370-xp",
>>  };
>> @@ -281,7 +283,7 @@ static int mvebu_v7_cpu_pm_notify(struct notifier_block *self,
>>  {
>>  	if (action == CPU_PM_ENTER) {
>>  		unsigned int hw_cpu = cpu_logical_map(smp_processor_id());
>> -		mvebu_pmsu_set_cpu_boot_addr(hw_cpu, armada_370_xp_cpu_resume);
>> +		mvebu_pmsu_set_cpu_boot_addr(hw_cpu, mvebu_cpu_resume);
> 
> Instead of doing this in the CPU_PM_ENTER notifier, do we have a reason
> to not do it in the do_armada_370_xp_cpu_suspend() function, and then
> do_armada_38x_suspend() function respectively? Those functions are
> already SoC-specific, so surely, they already know whether the resume
> path should go through armada_370_xp_cpu_resume() or
> armada_38x_cpu_resume(), no?

Now that all this code is also part of pmsu and no more in the cpu dile driver.
It should be possible. Let me see what it implies about the path code.

Thanks,

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
