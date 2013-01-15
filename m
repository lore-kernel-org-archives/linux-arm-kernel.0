From: gleb@redhat.com (Gleb Natapov)
Date: Tue, 15 Jan 2013 17:35:55 +0200
Subject: [kvmarm] [PATCH v5 03/14] KVM: ARM: Initial skeleton to compile
 KVM support
In-Reply-To: <FE4B72B9-F302-49BA-98D7-E674247BD093@suse.de>
References: <20130108183811.46302.58543.stgit@ubuntu>
 <20130108183855.46302.40539.stgit@ubuntu>
 <20130114184908.GB12489@redhat.com>
 <CANM98qJoOxG_g7Dz+65vfGmzi3MOXqE=AjbVBtimeqLL9TgV8w@mail.gmail.com>
 <20130115133207.GM11529@redhat.com>
 <FE4B72B9-F302-49BA-98D7-E674247BD093@suse.de>
Message-ID: <20130115153555.GF12489@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 15, 2013 at 02:43:26PM +0100, Alexander Graf wrote:
> 
> On 15.01.2013, at 14:32, Gleb Natapov wrote:
> 
> > On Mon, Jan 14, 2013 at 05:17:31PM -0500, Christoffer Dall wrote:
> >> On Mon, Jan 14, 2013 at 1:49 PM, Gleb Natapov <gleb@redhat.com> wrote:
> >>> A couple of general question about ABI. If they were already answered
> >>> just refer me to the previous discussion.
> >>> 
> >>> On Tue, Jan 08, 2013 at 01:38:55PM -0500, Christoffer Dall wrote:
> >>>> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> >>>> index a4df553..4237c27 100644
> >>>> --- a/Documentation/virtual/kvm/api.txt
> >>>> +++ b/Documentation/virtual/kvm/api.txt
> >>>> @@ -293,7 +293,7 @@ kvm_run' (see below).
> >>>> 4.11 KVM_GET_REGS
> >>>> 
> >>>> Capability: basic
> >>>> -Architectures: all
> >>>> +Architectures: all except ARM
> >>>> Type: vcpu ioctl
> >>>> Parameters: struct kvm_regs (out)
> >>>> Returns: 0 on success, -1 on error
> >>>> @@ -314,7 +314,7 @@ struct kvm_regs {
> >>>> 4.12 KVM_SET_REGS
> >>>> 
> >>>> Capability: basic
> >>>> -Architectures: all
> >>>> +Architectures: all except ARM
> >>>> Type: vcpu ioctl
> >>>> Parameters: struct kvm_regs (in)
> >>>> Returns: 0 on success, -1 on error
> >>>> @@ -600,7 +600,7 @@ struct kvm_fpu {
> >>>> 4.24 KVM_CREATE_IRQCHIP
> >>> Why KVM_GET_REGS/KVM_SET_REGS are not usable for arm?
> >>> 
> >> 
> >> We use the ONE_REG API instead and we don't want to support two
> >> separate APIs to user space.
> >> 
> > I suppose fetching all registers is not anywhere on a fast path in
> > userspace :)
> 
> If it's ever going to be in a fast path, we will add MULTI_REG which will feature an array of ONE_REG structs to fetch multiple registers at once.
> 
And I hope it will not be. On x86 only the broken vmware PV
interface requires reading registers for emulation.

This reminds me the question I wanted to ask you about ONE_REG
interface. Why architecture is encoded in register name? Is architecture
implied by HW the code is running on anyway?

--
			Gleb.
