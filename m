From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 24 Jun 2015 19:25:07 +0300
Subject: [PATCH V2 4/5] drivers/rtc/rtc-ds1307.c: Support optional wakeup
 interrupt source
In-Reply-To: <558AD5B1.8030406@ti.com>
References: <1435076114-12416-1-git-send-email-nm@ti.com>
 <1435076114-12416-5-git-send-email-nm@ti.com> <558ACE87.6040509@ti.com>
 <558AD5B1.8030406@ti.com>
Message-ID: <558AD9E3.3070309@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/24/2015 07:07 PM, Nishanth Menon wrote:
> On 06/24/2015 10:36 AM, Grygorii Strashko wrote:
>> On 06/23/2015 07:15 PM, Nishanth Menon wrote:
> [...]
> 
>>> +		ds1307->wakeirq = of_irq_get(node, 1);
>>> +		if (ds1307->wakeirq <= 0) {
>>> +			if (ds1307->wakeirq == -EPROBE_DEFER) {
>>> +				err = ds1307->wakeirq;
>>> +				goto exit;
>>> +			}
>>> +			ds1307->wakeirq = 0;
>>> +			goto no_irq;
>>> +		}
>>
>> Might be above code could be done a little bit simpler?
>>
>> 		err = of_irq_get(node, 1);
>> 		if (err <= 0) {
>> 			if (err == -EPROBE_DEFER)
>> 				goto exit;
>> 			goto no_irq;
> 
> I had considered it, but problem with this approach is that is err
> does not get reset back to 0 and probe will fail as it flows through
> the rest of the code.. which is not our intent.
> 
>> 		}
>> 		ds1307->wakeirq = err;

As I can see from final code (after applying all patches) - It should work.
But I will not insist :)

-- 
regards,
-grygorii
