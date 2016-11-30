From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 30 Nov 2016 10:10:24 -0600
Subject: [PATCH] soc: ti: qmss: fix the case when !SMP
In-Reply-To: <5501170.dgvo5UdPBX@wuerfel>
References: <20161129221508.10551-1-grygorii.strashko@ti.com>
 <5501170.dgvo5UdPBX@wuerfel>
Message-ID: <a76f3e4e-6148-b1b6-2e33-aa4fead15aee@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/30/2016 05:37 AM, Arnd Bergmann wrote:
> On Tuesday, November 29, 2016 4:15:08 PM CET Grygorii Strashko wrote:
>>                 range->num_irqs++;
>>
>> -               if (oirq.args_count == 3)
>> +               if (IS_ENABLED(SMP) && oirq.args_count == 3)
>>                         range->irqs[i].cpu_map =
>>                                 (oirq.args[2] & 0x0000ff00) >> 8;
>>
>
> I think you mean CONFIG_SMP, not SMP. With the change above, the
> code will never be executed.
>

Thanks. I'll resend.

-- 
regards,
-grygorii
