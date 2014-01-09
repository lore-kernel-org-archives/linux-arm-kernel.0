From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 08 Jan 2014 17:50:18 -0800
Subject: [PATCH v2 0/9] CPU enable method based SMP/hotplug + MSM
 conversion
In-Reply-To: <201401082237.36626.arnd@arndb.de>
References: <1387845593-10050-1-git-send-email-sboyd@codeaurora.org>
 <201401082237.36626.arnd@arndb.de>
Message-ID: <52CE005A.3070802@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/14 13:37, Arnd Bergmann wrote:
> On Tuesday 24 December 2013, Stephen Boyd wrote:
>> This is a rework of patches sent a months back by Rohit[1].
>> The goal of these patches is to add support for SMP and (basic)
>> hotplug on MSM based SoCs. To get there, we add support for a
>> generic way to hook in SMP/hotplug support code based on DT. To
>> show how it's used, we convert the MSM8660 SMP support code over
>> to the new method. After that we add support for the rest of the
>> upstream MSM SoCs (note these patches are piled high on top of
>> Rohit's patches to add 8074 support to MSM[2] and my follow ups[3,4],
>> but this should only matter to the MSM maintainers).
>>
>> This is one of the last items of code that still requires us to have
>> a mach directory and a machine descriptor. We should be able to move
>> the hotplug/smp code out of mach directories if this approach is
>> accepted.
> The implementation looks ok to me, but I wonder whether on a global
> scale we want to tie it more closely to the cpuidle implementations.
> We already have a drivers/cpuidle framework, and while I admit
> that I'm not familiar with the code in there, I would assume that
> the smp operations and the cpuidle code usually go hand in hand.

Sure. Right now the smp ops code is fairly well tied into the arch layer
so it sounds like there is some future work when we move this stuff out
of the mach directory.

Would arm-soc be able to pick these patches up for 3.14? I think
everything is in place for these patches now that Mark has reviewed them.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
