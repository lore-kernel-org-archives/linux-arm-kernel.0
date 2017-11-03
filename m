From: cmetcalf@mellanox.com (Chris Metcalf)
Date: Fri, 3 Nov 2017 13:36:14 -0400
Subject: [PATCH v16 12/13] arm, tile: turn off timer tick for
 oneshot_stopped state
In-Reply-To: <20171103171801.xzxyypt3axyawu7l@lakrids.cambridge.arm.com>
References: <1509728692-10460-1-git-send-email-cmetcalf@mellanox.com>
 <1509728692-10460-13-git-send-email-cmetcalf@mellanox.com>
 <20171103171801.xzxyypt3axyawu7l@lakrids.cambridge.arm.com>
Message-ID: <f3d78953-506b-adc7-376d-e4d6d08c04e7@mellanox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/3/2017 1:18 PM, Mark Rutland wrote:
> Hi Chris,
>
> On Fri, Nov 03, 2017 at 01:04:51PM -0400, Chris Metcalf wrote:
>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>> index fd4b7f684bd0..61ea7f907c56 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>> @@ -722,6 +722,8 @@ static void __arch_timer_setup(unsigned type,
>>   		}
>>   	}
>>   
>> +	clk->set_state_oneshot_stopped = clk->set_state_shutdown;
> AFAICT, we've set up this callback since commit:
>
>    cf8c5009ee37d25c ("clockevents/drivers/arm_arch_timer: Implement ->set_state_oneshot_stopped()")
>
> ... so I don't beleive this is necessary, and I think this change can be
> dropped.

Thanks, I will drop it.? I missed the semantic merge conflict there.

I extracted the arch/tile specific part of the change and just pushed it 
through
the tile tree.

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com
