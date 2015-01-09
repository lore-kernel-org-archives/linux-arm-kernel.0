From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 09 Jan 2015 10:28:31 +0530
Subject: [PATCH] drivers: cpuidle: don't initialize big.LITTLE driver
 if MCPM is unavailable
In-Reply-To: <7hh9w1vwzr.fsf@deeprootsystems.com>
References: <1420698544-10277-1-git-send-email-sudeep.holla@arm.com>	<54AE459B.8010703@linaro.org>
 <54AE4ADF.3030307@arm.com>	<54AE55CE.6040201@linaro.org>
 <54AE5C8F.9080600@arm.com>	<54AE65EC.3050808@linaro.org>
 <20150108122958.GB32308@red-moon> <7hh9w1vwzr.fsf@deeprootsystems.com>
Message-ID: <54AF5FF7.5080308@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Friday 09 January 2015 01:57 AM, Kevin Hilman wrote:
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:
>
>> On Thu, Jan 08, 2015 at 11:11:40AM +0000, Daniel Lezcano wrote:
>>

[...]

>> 3) Sudeep's patch is not hiding anything. If CCI is in DT, CCI is
>> probed so mcpm_is_available() == true. If the firmware is borked
>> the idle states will be entered and we will notice there is
>> something wrong
>>
>> So overall I think Sudeep's patch is sound. I also think we should
>> improve the way we detect if MCPM is available, and again, I think
>> the CPU operations on arm64 are a good example that we can and we
>> should replicate.
>
> This patch disables CPUidle all together, but shouldn't it just
> disable the states that rely on MCPM?  IOW, C1 should still work just
> fine since it doesn't use MCPM, right?  So, rather than fail the
> init, it should just drop any MCPM states (e.g. set ->state_count =
> 1)
>

As Daniel pointed out, if there's no cpuidle driver or if cpuidle fails
to choose a convenient idle state, we fall back to the default arch idle
method(arch_cpu_idle)

Regards,
Sudeep
