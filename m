From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 26 Mar 2015 10:56:12 +0000
Subject: [PATCH 4/7] clocksource: dw_apb_timer_of: make IO endian agnostic
In-Reply-To: <5513D4A6.9070301@linaro.org>
References: <1427282610-10350-1-git-send-email-ben.dooks@codethink.co.uk>
 <1427282610-10350-5-git-send-email-ben.dooks@codethink.co.uk>
 <5513D4A6.9070301@linaro.org>
Message-ID: <5513E5CC.3040807@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/03/15 09:43, Daniel Lezcano wrote:
> On 03/25/2015 12:23 PM, Ben Dooks wrote:
>> The dw_apb_timer_of timer is using __raw_readl to access the timer
>> register, which is causing issues when the system is running in
>> big endian mode. Fix this by using readl_relaxed() which should
>> account for the endian settings.
>>
>> This fixes issues where the time jumps around in the dmesg output
>> due to returnling __le32 values.
>>
>> For an example, these two console lines show time running backwards:
>>
>> [   49.882572] CPU1: failed to come online
>> [   43.282457] Brought up 1 CPUs
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> 
> Hi Ben,
> 
> Through which tree this patch is supposed to go ?

I think yours is probably the best one for it, it doesn't depend
on anything else in the series.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
