From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 28 May 2014 11:11:38 +0100
Subject: [PATCH v2 0/9] arm64: KVM: debug infrastructure support
In-Reply-To: <20140528095833.GO16428@lvm>
References: <1400604945-25247-1-git-send-email-marc.zyngier@arm.com>
 <20140525153421.GA3866@lvm> <5385B2DD.8090200@arm.com>
 <20140528095833.GO16428@lvm>
Message-ID: <5385B65A.9000803@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/05/14 10:58, Christoffer Dall wrote:
> On Wed, May 28, 2014 at 10:56:45AM +0100, Marc Zyngier wrote:
>> On 25/05/14 16:34, Christoffer Dall wrote:
>>> On Tue, May 20, 2014 at 05:55:36PM +0100, Marc Zyngier wrote:
>>>> This patch series adds debug support, a key feature missing from the
>>>> KVM/arm64 port.
>>>>
>>>> The main idea is to keep track of whether the debug registers are
>>>> "dirty" (changed by the guest) or not. In this case, perform the usual
>>>> save/restore dance, for one run only. It means we only have a penalty
>>>> if a guest is actively using the debug registers.
>>>>
>>>> The amount of registers is properly frightening, but CPUs actually
>>>> only implement a subset of them. Also, there is a number of registers
>>>> we don't bother emulating (things having to do with external debug and
>>>> OSlock).
>>>
>>> What is the rationale about not having to deal with external debug and
>>> OSlock?
>>
>> External debug is when you actually plug a physical JTAG into the CPU.
>> OSlock is a way to prevent "other software" to play with the debug
>> registers. My understanding is that it is only useful in combination
>> with the external debug.
>>
>> In both case, implementing support for this is probably not worth the
>> effort, at least for the time being.
>>
> OK, can we document that somewhere clearly in the code then so we know
> how we can simply ignore those registers?

Sure. I'll add some documentation.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
