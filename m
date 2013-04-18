From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 18 Apr 2013 10:56:08 +0200
Subject: [V3 patch 02/19] ARM: shmobile: cpuidle: remove shmobile_enter_wfi
 prototype
In-Reply-To: <516FAF28.80002@ti.com>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
 <1365770165-27096-3-git-send-email-daniel.lezcano@linaro.org>
 <516FAF28.80002@ti.com>
Message-ID: <516FB528.90006@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/18/2013 10:30 AM, Santosh Shilimkar wrote:
> On Friday 12 April 2013 06:05 PM, Daniel Lezcano wrote:
>> Commit 688036b538974de32ce55be8b0e013b003992abc removed the function
>> 'shmobile_enter_wfi' but we forgot to remove the definition in the header file.
>>
>> Note this function is just an alias to 'cpu_do_idle()' wrapped into a cpuidle
>> function callback prototype which already exists with the default WFI state
>> and the arm_simple_enter function.
>>
>> Remove the function prototype.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
> You can actually fold this into 1/19. No strong opinion though.

Initially it was folded but Simon wanted to split it in two, thus 1/19
and 2/19.


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
