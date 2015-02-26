From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 26 Feb 2015 10:06:15 +0100
Subject: [PATCH] cpuidle: mvebu: update cpuidle thresholds for Armada
 XP SOCs
In-Reply-To: <alpine.LNX.2.02.1502251624570.11958@sbrk.org>
References: <alpine.LNX.2.02.1502131534360.8729@sbrk.sbrk.org>
 <54ED9D92.90506@linaro.org> <alpine.LNX.2.02.1502251624570.11958@sbrk.org>
Message-ID: <54EEE207.7090006@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/25/2015 04:56 PM, Sebastien Rannou wrote:
> Hi Daniel,
>
> Thanks for the explanation and thanks for the link, I wish I had read
> it beforehand.
>
> On Wed, 25 Feb 2015, Daniel Lezcano wrote:
>> If you have the possibility, I would suggest to apply the right methodology to
>> find the right values by using the description in the wiki page [1]. If you
>> can access to the energy values to enter / exit the state and the power
>> consumed in each idle state, then you can mathematically compute the right
>> values.
>
> Unfortunately I don't have access to the cost of transitions between
> states, nor do I have the time taken by each transition (which I could
> have used to infer the cost). I only have the power consumption of the
> different states.

If you have the consumption for the different idle state + running, you 
have 60% of the data :)

> I plan to find the adequate values by testing different combinations,
> but it is going to take some efforts before having a second
> patch.

You may waste your time because of the non deterministic prediction. 
Sometimes you will test with right values but wrong prediction and a 
cache 50% filled, sometimes you will test with wrong values and wrong 
prediction but a cache 20% filled etc ...

The only way to measure accurately is to identify the cpu power rails 
and measure the current peak when entering/exiting the different idle 
states with a device (oscilloscope, or whatever).

> Since this patch already improves the situation by using the
> vendor's values, I think it is a move in the right direction, even
> though not being the most adequate values.

Just to clarify, vendor's values are from an out-of-tree which means it 
does not exist from an opensource pov and hence does not enter in the 
equation to pick the patch or not.

Regarding the values you measured for perf and power, it appears we have 
a improvement in terms of performance but with a power consumption 
degradation.

I am not against this patch, but I would like to have the ack from 
another Armada maintainer (Jason, Andrew or Sebastian) to be sure this 
trade-off is accepted.

Thanks

   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
