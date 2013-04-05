From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 05 Apr 2013 10:08:04 +0100
Subject: [PATCH 6/7] ARM: KVM: switch to a dual-step HYP init code
In-Reply-To: <1365113453.24496.26.camel@smoke>
References: <1364909115-3810-1-git-send-email-marc.zyngier@arm.com>
 <1364909115-3810-7-git-send-email-marc.zyngier@arm.com>
 <1365113453.24496.26.camel@smoke>
Message-ID: <515E9474.2070100@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/13 23:10, Geoff Levand wrote:
> Hi,
> 
> On Tue, 2013-04-02 at 14:25 +0100, Marc Zyngier wrote:
>> +	@ Jump to the trampoline page
>> +	ldr	r2, =#PAGE_MASK
>> +	adr	r3, target
>> +	bic	r3, r3, r2
>> +	ldr	r2, =#TRAMPOLINE_VA
>> +	add	r3, r3, r2
>> +	mov	pc, r3
> 
> I guess you need 'ldr r2, =PAGE_MASK'.
> 
>   arch/arm/kvm/init.S:114: Error: bad expression -- `ldr r2,=#(~((1<<12)-1))'
>   arch/arm/kvm/init.S:117: Error: bad expression -- `ldr r2,=#0xffff0000'

Oddly enough, this code compiles perfectly fine on my box.
What's your compiler/binutils versions?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
