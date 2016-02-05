From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 5 Feb 2016 08:56:00 +0000
Subject: [PATCH v3 00/23] arm64: Virtualization Host Extension support
In-Reply-To: <20160204192641.GJ13974@cbox>
References: <1454522416-6874-1-git-send-email-marc.zyngier@arm.com>
 <20160204192641.GJ13974@cbox>
Message-ID: <56B463A0.7010801@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/02/16 19:26, Christoffer Dall wrote:
> On Wed, Feb 03, 2016 at 05:59:53PM +0000, Marc Zyngier wrote:
>> ARMv8.1 comes with the "Virtualization Host Extension" (VHE for
>> short), which enables simpler support of Type-2 hypervisors.
>>
>> This extension allows the kernel to directly run at EL2, and
>> significantly reduces the number of system registers shared between
>> host and guest, reducing the overhead of virtualization.
>>
>> In order to have the same kernel binary running on all versions of the
>> architecture, this series makes heavy use of runtime code patching.
>>
>> The first 22 patches massage the KVM code to deal with VHE and enable
>> Linux to run at EL2. The last patch catches an ugly case when VHE
>> capable CPUs are paired with some of their less capable siblings. This
>> should never happen, but hey...
>>
>> I have deliberately left out some of the more "advanced"
>> optimizations, as they are likely to distract the reviewer from the
>> core infrastructure, which is what I care about at the moment.
>>
>> Note: GDB is currently busted on VHE systems, as it checks for version
>>       6 on the debug architecture, while VHE is version 7. The
>>       binutils people are on the case.
>>
>> This has been tested on the FVP_Base_SLV-V8-A model, and based on
>> v4.5-rc2. I've put a branch out on:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/vhe
>>
> 
> You can have my reviewed-by on all patches that I didn't already review
> or ack explicitly.

Thanks for the review, much appreciated.

> Only exception is the debug stuff where I didn't manage to page in the
> context, so hopefully familiar with that code can have a look.

I think this will have to be Mr Deacon.

Thanks again,

	M.
-- 
Jazz is not dead. It just smells funny...
