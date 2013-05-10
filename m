From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 10 May 2013 09:23:56 +0200
Subject: [RFC PATCH 1/2] ARM: KVM: move GIC/timer code to a common location
In-Reply-To: <20130509181101.GA17253@gmail.com>
References: <1367589773-5609-1-git-send-email-marc.zyngier@arm.com>
 <1367589773-5609-2-git-send-email-marc.zyngier@arm.com>
 <20130509181101.GA17253@gmail.com>
Message-ID: <f816c184d2512dad242b383deac7453e@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 9 May 2013 11:11:01 -0700, Christoffer Dall
<cdall@cs.columbia.edu>
wrote:
> On Fri, May 03, 2013 at 03:02:52PM +0100, Marc Zyngier wrote:
>> As KVM/arm64 is looming on the horizon, it makes sense to move some
>> of the common code to a single location in order to reduce duplication.
>> 
>> The code could live anywhere. Actually, most of KVM is already built
>> with a bunch of ugly ../../.. hacks in the various Makefiles, so we're
>> not exactly talking about style here. But maybe it is time to start
>> moving into a less ugly direction.
>> 
>> The include files must be in a "public" location, as they are accessed
>> from non-KVM files (arch/arm/kernel/asm-offsets.c).
>> 
>> For this purpose, introduce two new locations:
>> - virt/kvm/arm/ : x86 and ia64 already share the ioapic code in
>>   virt/kvm, so this could be seen as a (very ugly) precedent.
>> - include/kvm/  : there is already an include/xen, and while the
>>   intent is slightly different, this seems as good a location as
>>   any
> 
> This overall looks ok, just a few points:
> 
> 1. Should we have a namespace per arch in the include directory, as in
>    include/kvm/arm?

So I thought of that at one point, but discarded the idea because it seems
to convey the wrong message:
We're moving the include files because they are architecture independent,
and referring to an architecture name in the path feels a bit odd. Or maybe
arm-common?

I don't have strong feelings about it though...

> 2. We could drop the kvm_ prefix from the include files now

Agreed.

It would be interesting to see what the KVM maintainers think of all this.
Gleb? Paolo?

        M.
-- 
Fast, cheap, reliable. Pick two.
