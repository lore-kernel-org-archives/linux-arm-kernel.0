From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 26 Mar 2015 11:58:22 +0100
Subject: [PATCH 4/7] clocksource: dw_apb_timer_of: make IO endian agnostic
In-Reply-To: <5513E5CC.3040807@codethink.co.uk>
References: <1427282610-10350-1-git-send-email-ben.dooks@codethink.co.uk>
 <1427282610-10350-5-git-send-email-ben.dooks@codethink.co.uk>
 <5513D4A6.9070301@linaro.org> <5513E5CC.3040807@codethink.co.uk>
Message-ID: <5513E64E.1060802@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/26/2015 11:56 AM, Ben Dooks wrote:
> On 26/03/15 09:43, Daniel Lezcano wrote:
>> On 03/25/2015 12:23 PM, Ben Dooks wrote:
>>> The dw_apb_timer_of timer is using __raw_readl to access the timer
>>> register, which is causing issues when the system is running in
>>> big endian mode. Fix this by using readl_relaxed() which should
>>> account for the endian settings.
>>>
>>> This fixes issues where the time jumps around in the dmesg output
>>> due to returnling __le32 values.
>>>
>>> For an example, these two console lines show time running backwards:
>>>
>>> [   49.882572] CPU1: failed to come online
>>> [   43.282457] Brought up 1 CPUs
>>>
>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>
>> Hi Ben,
>>
>> Through which tree this patch is supposed to go ?
>
> I think yours is probably the best one for it, it doesn't depend
> on anything else in the series.

Ok, thanks.

   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
