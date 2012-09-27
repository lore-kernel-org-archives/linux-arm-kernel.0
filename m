From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 27 Sep 2012 15:39:10 +0100
Subject: [PATCH 06/15] KVM: ARM: Initial skeleton to compile KVM support
In-Reply-To: <20120927141314.GK25916@mudshark.cambridge.arm.com>
References: <20120915153359.21241.86002.stgit@ubuntu>
 <20120915153508.21241.47712.stgit@ubuntu>
 <20120925152055.GC28728@mudshark.cambridge.arm.com>
 <50625DB2.4000700@virtualopensystems.com>
 <20120927141314.GK25916@mudshark.cambridge.arm.com>
Message-ID: <5064650E.2090009@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/09/12 15:13, Will Deacon wrote:
> On Wed, Sep 26, 2012 at 02:43:14AM +0100, Christoffer Dall wrote:
>> On 09/25/2012 11:20 AM, Will Deacon wrote:
>>>
>>>> +static inline u32 *vcpu_pc(struct kvm_vcpu *vcpu)
>>>> +{
>>>> +       return vcpu_reg(vcpu, 15);
>>>> +}
>>>
>>> If you stick a struct pt_regs into struct kvm_regs, you could reuse ARM_pc
>>> here etc.
>>>
>>
>> I prefer not to, because we'd have those registers presumably for usr
>> mode and then we only define the others explicit. I think it's much
>> clearer to look at kvm_regs today.
> 
> I disagree and think that you should reuse as much of the arch/arm/ code as
> possible. Not only does it make it easier to read by people who are familiar
> with that code (and in turn get you more reviewers) but it also means that
> we limit the amount of duplication that we have.
> 
> I think Marc (CC'd) had a go at this with some success.

Yup, I have it converted already. It requires a number of changes, but I
took this opportunity to do some other cleanup (world switch
save/restore code, mostly).

Patches are at the top of mu kvm-cleanup branch.

	M.
-- 
Jazz is not dead. It just smells funny...
