From: ivan.khoronzhuk@ti.com (ivan.khoronzhuk)
Date: Mon, 25 Nov 2013 14:41:45 +0200
Subject: Fwd: [PATCH 7/8] watchdog: davinci: add "clocks" property
In-Reply-To: <20131125121529.GE32081@e106331-lin.cambridge.arm.com>
References: <1383680783-12114-8-git-send-email-ivan.khoronzhuk@ti.com>
 <527A28E8.4010204@ti.com> <201311231857.47104.arnd@arndb.de>
 <52932DA1.8040204@ti.com>
 <20131125121529.GE32081@e106331-lin.cambridge.arm.com>
Message-ID: <52934589.3000502@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/25/2013 02:15 PM, Mark Rutland wrote:
> On Mon, Nov 25, 2013 at 10:59:45AM +0000, ivan.khoronzhuk wrote:
>> On 11/23/2013 07:57 PM, Arnd Bergmann wrote:
>>> On Wednesday 06 November 2013, ivan.khoronzhuk wrote:
>>>> @@ -7,6 +7,10 @@ Required properties:
>>>>
>>>>    - reg : Should contain WDT registers location and length
>>>>
>>>> +- clocks: phandle reference to the controller clock.
>>>> +         Required only for Keystone arch.
>>>> +         See clock-bindings.txt
>>>> +
>>>>    Optional properties:
>>>>
>>>>    - timeout-sec:         Contains the watchdog timeout in seconds
>>>
>>> I think it should really be listed under "Optional properties" and the
>>> reference to Keystone removed. Note how the binding would need
>>> to change otherwise if another platform started to use the clock, which
>>> is a little silly.
>>>
>>> 	Arnd
>>>
>>
>> Ok, I'll move clocks property under "Optional properties" and describe it
>> as following:
>>
>> Optional properties:
>> - timeout-sec : Contains the watchdog timeout in seconds
>> - clocks: phandle reference to the controller clock.
>> 	  Needed if platform uses clocks.
>> 	  See clock-bindings.txt
>
> Nit: clocks aren't just phandles, they have a clock-specifier too (which
> might be 0 cells).
>
> Otherwise this looks fine to me.
>
> Mark.
>

... I will replace it to:
Optional properties:
- timeout-sec : Contains the watchdog timeout in seconds
- clocks: the clock feeding the watchdog timer.
	  Needed if platform uses clocks.
	  See clock-bindings.txt

Is it OK?

-- 
Regards,
Ivan Khoronzhuk
