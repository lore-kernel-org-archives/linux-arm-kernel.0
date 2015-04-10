From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 10 Apr 2015 10:40:16 +0100
Subject: [RFC PATCH] arm64: KVM: remove fpsimd save/restore from the world
 switch
In-Reply-To: <5527943C.3030400@redhat.com>
References: <1428598439-5217-1-git-send-email-marc.zyngier@arm.com>
 <55278CAD.70302@redhat.com> <552793CF.8050904@arm.com>
 <5527943C.3030400@redhat.com>
Message-ID: <55279A80.5030709@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04/15 10:13, Paolo Bonzini wrote:
> 
> 
> On 10/04/2015 11:11, Marc Zyngier wrote:
>>> Good idea!  Does ARM have a way to do "lazy" save/restore?  On x86 we
>>> know if the FP/SIMD state was in use on the host, and we can force an
>>> exit the first time the guest uses the FP/SIMD.
>>>
>>> On ARM, it wouldn't be a problem to handle this kind of exit straight in
>>> EL2 (similar to the hack Ard used when playing with memory attributes).
>>
>> We already do this on the 32bit port, and it works fine.
>>
>> I did some experimentations on arm64 a long while ago (see the
>> kvm-arm64/lazy-fp branch in my tree), and it wasn't that great,
>> apparently because aarch64 userspace tends to be much more FP happy than
>> aarch32, but I'm not completely sure about it. Also this is from a time
>> when I didn't have much HW to play with...
>>
>> Maybe I should resurrect it and compare it to what this patch does, just
>> as a comparison point.
> 
> This patch looks like very nice low-hanging fruit anyway.  Would you
> like to have it in 4.1?

It is a bit "fresh off the compiler", hence the RFC tag. I'm going to
run some tests on it during the day, using slightly less braindead
hardware (the HiKey board is nice because of its form factor, but that's
the only nice thing about it...).

Once I'm confident it doesn't introduce any regression, it will be worth
considering.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
