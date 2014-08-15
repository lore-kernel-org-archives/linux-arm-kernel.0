From: juri.lelli@arm.com (Juri Lelli)
Date: Fri, 15 Aug 2014 17:36:05 +0100
Subject: [PATCH v2] cpuidle/cpuidle-big_little: fix reading cpu id part
 number
In-Reply-To: <7hwqa9ww6n.fsf@paris.lan>
References: <1408004865-27525-1-git-send-email-juri.lelli@arm.com>
 <7hwqa9ww6n.fsf@paris.lan>
Message-ID: <53EE36F5.7000801@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/08/14 17:32, Kevin Hilman wrote:
> Juri Lelli <juri.lelli@arm.com> writes:
> 
>> Commit af040ffc9ba1 ("ARM: make it easier to check the CPU part number
>> correctly") changed ARM_CPU_PART_X masks, and the way they are returned and
>> checked against. Usage of read_cpuid_part_number() is now deprecated, and
>> calling places updated accordingly. This actually broke cpuidle-big_little
>> initialization, as bl_idle_driver_init() performs a check using an hardcoded
>> mask on cpu_id.
>>
>> Create an interface to perform the check (that is now even easier to read).
>> Define also a proper mask (ARM_CPU_PART_MASK) that makes this kind of checks
>> cleaner and helps preventing bugs in the future. Update usage accordingly.
> 
> [...]
> 
> Tested-by: Kevin Hilman <khilman@linaro.org>
> 

Great, thanks!

> FWIW, I can confirm that this patch is needed for cpuidle-big_little to
> work on the Exynos5800/Chromebook2.
> 

Ok, the patch has been already sent to Russell's patch system.

Best,

- Juri

> Kevin
> 
