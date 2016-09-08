From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 8 Sep 2016 11:02:48 +0100
Subject: [PATCH 00/19] Handle guest-generated SErrors/Aborts
In-Reply-To: <AM5PR0802MB2452C619386893AAFFAE490D9EFB0@AM5PR0802MB2452.eurprd08.prod.outlook.com>
References: <1473166937-15271-1-git-send-email-marc.zyngier@arm.com>
 <AM5PR0802MB2452C619386893AAFFAE490D9EFB0@AM5PR0802MB2452.eurprd08.prod.outlook.com>
Message-ID: <57D13748.8070703@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wei,

On 08/09/16 10:47, Wei Chen wrote:
> Hi Marc,
> 
> On 2016/9/6 21:09, Marc Zyngier wrote:
>> A little known "feature" of giving guest access to real memory mapped
>> HW is that it could trigger asynchronous aborts (SError on ARMv8) if
>> the guest accesses it in a non-conventional way (and depending on how
>> HW and firmware have been integrated). So far, KVM lacks any support
>> to handle this gracefully.
> 
> I can reproduce this issue on Seattle board (ARM64), but I can't
> reproduce it on FVP (Cortex-A15x2 ARM32). Did you mean that this issue 
> onlu takes place on ARMv8? Have you ever reproduced this issue on any 
> ARM32 platform?

On a 32bit platform, I've only managed to get an external abort firing
while running at EL1 and then taken to HYP. But that doesn't mean that
32bit systems are immune to this. It completely depends on the system
integration (how fast the error generating peripheral replies and how
the error is exposed to the CPU, for example).

As for the model, I'd be surprised if it had any facility for this. Most
of that is IMPDEF, and ignoring the error seems to be a valid
implementation...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
