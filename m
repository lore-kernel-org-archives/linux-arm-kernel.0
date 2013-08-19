From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Mon, 19 Aug 2013 14:56:10 +0100
Subject: [RFC PATCH v2 3/4] powerpc: refactor of_get_cpu_node to support
 other architectures
In-Reply-To: <5212177C.8000709@gmail.com>
References: <1376586580-5409-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376674791-28244-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376674791-28244-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <2032060.4bgTKOdEX2@flatron> <1376777376.25016.11.camel@pasglop>
 <20130819101922.GI3719@e106331-lin.cambridge.arm.com>
 <5212177C.8000709@gmail.com>
Message-ID: <521223FA.5050903@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/08/13 14:02, Rob Herring wrote:
> On 08/19/2013 05:19 AM, Mark Rutland wrote:
>> On Sat, Aug 17, 2013 at 11:09:36PM +0100, Benjamin Herrenschmidt wrote:
>>> On Sat, 2013-08-17 at 12:50 +0200, Tomasz Figa wrote:
>>>> I wonder how would this handle uniprocessor ARM (pre-v7) cores, for
>>>> which 
>>>> the updated bindings[1] define #address-cells = <0> and so no reg 
>>>> property.
>>>>
>>>> [1] - http://thread.gmane.org/gmane.linux.ports.arm.kernel/260795
>>>
>>> Why did you do that in the binding ? That sounds like looking to create
>>> problems ... 
>>>
>>> Traditionally, UP setups just used "0" as the "reg" property on other
>>> architectures, why do differently ?
>>
>> The decision was taken because we defined our reg property to refer to
>> the MPIDR register's Aff{2,1,0} bitfields, and on UP cores before v7
>> there's no MPIDR register at all. Given there can only be a single CPU
>> in that case, describing a register that wasn't present didn't seem
>> necessary or helpful.
> 
> What exactly reg represents is up to the binding definition, but it
> still should be present IMO. I don't see any issue with it being
> different for pre-v7.
> 
Yes it's better to have 'reg' with value 0 than not having it.
Otherwise this generic of_get_cpu_node implementation would need some
_hack_ to handle that case.

Regards,
Sudeep
