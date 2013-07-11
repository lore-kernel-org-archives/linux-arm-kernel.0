From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 11 Jul 2013 13:53:26 +0200
Subject: [PATCH V2] ARM: cpuidle: davinci: Fix target residency
In-Reply-To: <51CD3063.5010309@ti.com>
References: <1372345800-26792-1-git-send-email-daniel.lezcano@linaro.org>
 <51CD3063.5010309@ti.com>
Message-ID: <51DE9CB6.40706@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/28/2013 08:42 AM, Sekhar Nori wrote:
> On 6/27/2013 8:40 PM, Daniel Lezcano wrote:
>> The commit 19976c2a88d125aec16b9255c7197c297bbdd637 changed the target
>> residency to 100000, assuming this is a careless mistake.
>>
>> commit 19976c2a88d125aec16b9255c7197c297bbdd637
>> Author: Robert Lee <rob.lee@linaro.org>
>> Date:   Tue Mar 20 15:22:45 2012 -0500
>>
>>     ARM: davinci: Consolidate time keeping and irq enable
>>
>>     Enable core cpuidle timekeeping and irq enabling and remove that
>>     handling from this code.
>>
>>     Signed-off-by: Robert Lee <rob.lee@linaro.org>
>>     Reviewed-by: Kevin Hilman <khilman@ti.com>
>>     Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>     Acked-by: Jean Pihet <j-pihet@ti.com>
>>     Signed-off-by: Len Brown <len.brown@intel.com>
>>
>> The same happened to the at91's cpuidle driver.
>>
>> Fix it by putting the initial value to 10000.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Acked-by: Sekhar Nori <nsekhar@ti.com>

Hi Sekhar,

I applied this patch on my tree for the next PM pull request.

Thanks
  -- Daniel



-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
