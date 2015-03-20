From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 20 Mar 2015 19:39:23 +0100
Subject: [PATCH V3 0/8] ARM: cpuidle: Unify the ARM64/ARM DT approach
In-Reply-To: <20150320183111.GA8891@red-moon>
References: <1426851841-2072-1-git-send-email-daniel.lezcano@linaro.org>
 <20150320183111.GA8891@red-moon>
Message-ID: <550C695B.7080200@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/20/2015 07:31 PM, Lorenzo Pieralisi wrote:
> Hi Daniel,
>
> On Fri, Mar 20, 2015 at 11:43:53AM +0000, Daniel Lezcano wrote:
>> There is a big number of cpuidle drivers for the ARM architecture.
>>
>> These drivers have been cleaned up and grouped into the drivers/cpuidle
>> directory to keep track of the changes more easily and ensure the code
>> is following the same scheme across the drivers.
>>
>> That had the benefit of simplifying the code and factor out a lot of common
>> parts. Beside that, as the drivers belong to the 'drivers' directory, we had
>> to split the arch specific bits and the generic code in order to keep
>> everything self contained. The platform driver paradigm was used for this
>> purpose.
>>
>> Unfortunately, this approach is now no longer accepted and a different solution
>> must be provided to reach the same goal: one example is the Qualcomm cpuidle
>> driver upstreaming attempt.
>>
>> In the meantime, ARM64 developed a generic cpuidle driver based on DT definition.
>>
>> The DT definition provides an 'enable-method' to specify one of the cpu
>> operations (PSCI, ...).
>>
>> This patchset unify this driver with ARM32, using the same DT definition.
>>
>> Thanks with this patchset we can use the 'enable-method' to specify a cpu
>> operations, hence get rid of the platform driver approach and go further in the
>> cpuidle driver flexibility via the DT.
>
> I had a look and the series seems fine, if you have a branch I can pull from
> I will test on arm64 and add the required tags.

Yes, sure.

http://git.linaro.org/git-ro/people/daniel.lezcano/linux.git cpuidle/4.1

Thanks !

   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
