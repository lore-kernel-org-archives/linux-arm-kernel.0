From: dietmar.eggemann@arm.com (Dietmar Eggemann)
Date: Mon, 9 Oct 2017 18:55:07 +0100
Subject: [PATCH 4/4] arm: dts: r8a7790: add cpu capacity-dmips-mhz
 information
In-Reply-To: <20170918073946.GA9156@verge.net.au>
References: <20170830144120.9312-1-dietmar.eggemann@arm.com>
 <20170830144120.9312-5-dietmar.eggemann@arm.com>
 <20170918073946.GA9156@verge.net.au>
Message-ID: <a0099e02-096c-f8e0-0380-ecb9549f20b4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/09/17 08:39, Simon Horman wrote:
> On Wed, Aug 30, 2017 at 03:41:20PM +0100, Dietmar Eggemann wrote:
>> The following 'capacity-dmips-mhz' dt property values are used:
>>
>> Cortex-A15: 1024, Cortex-A7: 539
>>
>> They have been derived form the cpu_efficiency values:
>>
>> Cortex-A15: 3891, Cortex-A7: 2048
>>
>> by scaling them so that the Cortex-A15s (big cores) use 1024.
>>
>> The cpu_efficiency values were originally derived from the "Big.LITTLE
>> Processing with ARM Cortex?-A15 & Cortex-A7" white paper
>> (http://www.cl.cam.ac.uk/~rdm34/big.LITTLE.pdf). Table 1 lists 1.9x
>> (3891/2048) as the Cortex-A15 vs Cortex-A7 performance ratio for the
>> Dhrystone benchmark.
>>
>> The following platform is affected once cpu-invariant accounting
>> support is re-connected to the task scheduler:
> 
> Thanks, applied for v4.15.
> 
> My understanding from the following comment in the cover letter is that not
> currently the case and this there is no behavioural change in applying this
> patch.
> 
> For the record I observed the following with and without this patch
> applied. I believe this is the expected result.
> 
> v4.14-rc1
> # cat /sys/devices/system/cpu/cpu*/cpu_capacity
> 1535
> 1535
> 1535
> 1535
> 1024
> 1024
> 1024
> 1024
> 
> v4.14-rc1 + patch
> # cat /sys/devices/system/cpu/cpu*/cpu_capacity
> 1024
> 1024
> 1024
> 1024
> 539
> 539
> 539
> 539

Thanks Simon! Yes, that is the expected behaviour. And sorry for not
responding earlier!

With exynos542{0,2} and r8a7790 switching to the 'capacity-dmips-mhz'
based solution in v4.15, I can push for removal of the cpu_efficency
code [patch 1/4].
