From: jonathan.austin@arm.com (Jonathan Austin)
Date: Mon, 18 Mar 2013 19:02:58 +0000
Subject: Anyone implement Cortex A9 FIQ
In-Reply-To: <CAHrpEqSO89Lx=EGTJJ_XOFwkHqL=heoOUQCtJUzm6D7mEAbWiw@mail.gmail.com>
References: <CAHrpEqSQ1n_WUfxoraKZFS2A8NjdP_MCcWmJdCjcon_QwgX4Hw@mail.gmail.com>
 <5142FBF5.3010307@arm.com>
 <CAHrpEqSO89Lx=EGTJJ_XOFwkHqL=heoOUQCtJUzm6D7mEAbWiw@mail.gmail.com>
Message-ID: <514764E2.6040101@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/03/13 01:15, Frank Li wrote:
> 2013/3/15 Jonathan Austin <jonathan.austin@arm.com>:
>> Hi Frank,
>>
>>
>> On 15/03/13 07:38, Frank Li wrote:
>>>
>>> All:
>>>               Recently, we need real time work run in cortex A9.
>>>               Did anyone use FIQ on Cortex A9?
>>>
>>
>> What are you actually trying to do? There's quite a lot more complexity to
>> being able to do real-time work on an A-class processor than just using FIQ,
>> and much of that would be platform specific. For example on ARMv7A, we
>> generally can't assume that FIQ can be used by the non-secure world...
>
> There are period task run every 125us.
> Task is quick simply, just put virtual multi DMA queue to real DMA queue.
> Small memory copy and set some hardware register.
>

Whether this is feasible will really depend on what platform you're on - 
if there's a secure monitor then FIQs are out of the question anyway. 
Can you tell us more about the system?

If your average interrupt latency is low then you should just be able to 
do this with normal IRQs (have you got threaded interrupt handlers?)

What is it about the situation that leads you to believe that you *need* 
FIQ?

Jonny
