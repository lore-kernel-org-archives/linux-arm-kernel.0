From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 04 Jun 2013 15:59:35 +0100
Subject: Planning the merge of KVM/arm64
In-Reply-To: <CAMJs5B_PB1pNVCO_EK7aTghN23L+d0RovAFi7inrVsJb5STWOA@mail.gmail.com>
References: <51ADDDAE.4040705@arm.com>
 <CAMJs5B_PB1pNVCO_EK7aTghN23L+d0RovAFi7inrVsJb5STWOA@mail.gmail.com>
Message-ID: <51AE00D7.9030607@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/06/13 15:50, Christoffer Dall wrote:
> On 4 June 2013 05:29, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> Guys,
>>
>> The KVM/arm64 code is now, as it seems, in good enough shape to be
>> merged. I've so far addressed all the comments, and it doesn't seem any
>> worse then what is queued for its 32bit counterpart.
>>
> 
> huh?

That was supposed to be a joke. Obviously, my sense of humour has failed
to impress you here. I'll improve on that in another version of the same
email... ;-)

>> For reference, it is sitting there:
>> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
>> kvm-arm64/kvm
>>
>> What is not defined yet is the merge path:
>> - It is touching some of the arm64 core code, so it would be better if
>> it was merged through the arm64 tree
>> - It is depending on some of the patches in the core KVM queue (the
>> vgic/timer move to virt/kvm/arm/)
>> - It is also depending on some of the patches that are in the KVM/ARM
>> queue (parametrized timer interrupt, some MMU/MMIO fixes)
>>
>> So I can see two possibilities:
>> - Either I can rely on a stable branch from both KVM and KVM/ARM trees
>> on which I can base my tree for Catalin/Will to pull,
>> - Or I ask Catalin to only pull the arm64 part *minus the Kconfig*, and
>> only merge this last bit when the dependencies are satisfied in Linus' tree.
>>
>> What do you guys think?
>>
> I would think you would prefer option (1) to get the code in cleaner.
> Both the KVM/next tree is stable and I can provide you with a stable
> KVM/ARM tree. But I really don't feel strongly about this.

That'd be my preferred choice too. Let's see what the KVM maintainers'
position on that.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
