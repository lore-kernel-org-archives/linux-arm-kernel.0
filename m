From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 29 Mar 2013 11:45:51 +0100
Subject: [PATCH 4/9] ARM: OMAP4: cpuidle: fix wrong driver initialization
In-Reply-To: <51556F1D.5030208@ti.com>
References: <1364553095-25110-1-git-send-email-daniel.lezcano@linaro.org>
 <1364553095-25110-4-git-send-email-daniel.lezcano@linaro.org>
 <51556F1D.5030208@ti.com>
Message-ID: <515570DF.5010608@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/29/2013 11:38 AM, Santosh Shilimkar wrote:
> On Friday 29 March 2013 04:01 PM, Daniel Lezcano wrote:
>> The driver is initialized several times. This is wrong and if the
>> return code of the function was checked, it will return -EINVAL.
>>
>> Move this initialization out of the loop.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
> Fix for this is already and v2 of the patch is here [1]

Ah, ok. Thanks for reviewing the patch.

Can we find a solution to have a single entry point to sumbit patches
for all the cpuidle drivers ?

Otherwise, consolidating them is a pain: a patch for the samsung tree,
another one for the at91 tree, etc ... and wait for all the trees to
sync before continuing to consolidate the code.

Wouldn't be worth to move these drivers under the PM umbrella instead of
the SoC specific code ?

Any idea to simplify the cpuidle consolidation and maintenance ?

Thanks
  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
