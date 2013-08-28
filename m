From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 28 Aug 2013 08:37:30 +0200
Subject: [PATCH 11/12] cpuidle: mvebu: Add initial cpu idle support for
 Armada 370/XP SoC
In-Reply-To: <87d2oz7qym.fsf@linaro.org>
References: <1377240797-4047-1-git-send-email-gregory.clement@free-electrons.com>
 <1377240797-4047-12-git-send-email-gregory.clement@free-electrons.com>
 <87d2oz7qym.fsf@linaro.org>
Message-ID: <521D9AAA.1090408@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On 27/08/2013 05:28, Kevin Hilman wrote:
> Hi Gregory,
> 
> Gregory CLEMENT <gregory.clement@free-electrons.com> writes:
> 
>> Add wfi/cpu idle/cpu deep idle power states support for Armada XP SoC.
>>
>> All the latencies and the power consumption values used at the
>> "armada_370_xp_idle_driver" structure are preliminary and will be
>> modified in the future after running some measurements and analysis.
>>
>> Based on the work of Nadav Haklai.
>>
>> Signed-off-by: Nadav Haklai <nadavh@marvell.com>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> 
> [...]
> 
>> +int pm_support = WFI;
>> +static int __init pm_enable_setup(char *str)
>> +{
>> +	if (!strncmp(str, "wfi", 3))
>> +		pm_support = WFI;
>> +	else if (!strncmp(str, "idle", 4))
>> +		pm_support = MV_CPU_IDLE;
>> +	else if (!strncmp(str, "deepidle", 6))
>> +		pm_support = MV_CPU_DEEP_IDLE;
>> +	else if (!strncmp(str, "off", 3))
>> +		pm_support = DISABLED;
>> +
>> +	return 1;
>> +}
>> +__setup("pm_level=", pm_enable_setup);
> 
> Why is this new (but undocumented) kernel commandline needed when there
> is already a way to configure the deepest C state from userspace?
> (c.f. the 'disable' file under /sys/devices/system/cpu/cpuX/cpuidle/stateY)

You're right I should remove this. I wanted look see if we really need it the first
time I started to work on this series and then I forgot!

Thanks,

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
