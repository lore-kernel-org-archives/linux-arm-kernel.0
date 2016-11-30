From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 30 Nov 2016 11:10:51 -0600
Subject: [PATCH] soc: ti: qmss: fix the case when !SMP
In-Reply-To: <2531f769-dd28-dfbd-0ed7-b209ef6ae98d@oracle.com>
References: <20161129221508.10551-1-grygorii.strashko@ti.com>
 <5501170.dgvo5UdPBX@wuerfel>
 <2531f769-dd28-dfbd-0ed7-b209ef6ae98d@oracle.com>
Message-ID: <0a2d9284-d1e3-c848-42a4-66b06babba80@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Santosh,

On 11/30/2016 11:01 AM, Santosh Shilimkar wrote:
> Hi Grygorii,
>
> On 11/30/2016 3:37 AM, Arnd Bergmann wrote:
>> On Tuesday, November 29, 2016 4:15:08 PM CET Grygorii Strashko wrote:
>>>                 range->num_irqs++;
>>>
>>> -               if (oirq.args_count == 3)
>>> +               if (IS_ENABLED(SMP) && oirq.args_count == 3)
>>>                         range->irqs[i].cpu_map =
>>>                                 (oirq.args[2] & 0x0000ff00) >> 8;
>>>
>>
>> I think you mean CONFIG_SMP, not SMP. With the change above, the
>> code will never be executed.
>>
> Is that the full patch ? Can you post updated patch wit above fixed
> and copy me. I will pick it up.
>

I've sent v2.

For some reason you e-email is not working - delivery failure
ssantosh at kernel.org

-- 
regards,
-grygorii
