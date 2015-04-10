From: pbonzini@redhat.com (Paolo Bonzini)
Date: Fri, 10 Apr 2015 11:13:32 +0200
Subject: [RFC PATCH] arm64: KVM: remove fpsimd save/restore from the world
 switch
In-Reply-To: <552793CF.8050904@arm.com>
References: <1428598439-5217-1-git-send-email-marc.zyngier@arm.com>
 <55278CAD.70302@redhat.com> <552793CF.8050904@arm.com>
Message-ID: <5527943C.3030400@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/04/2015 11:11, Marc Zyngier wrote:
>> Good idea!  Does ARM have a way to do "lazy" save/restore?  On x86 we
>> know if the FP/SIMD state was in use on the host, and we can force an
>> exit the first time the guest uses the FP/SIMD.
>>
>> On ARM, it wouldn't be a problem to handle this kind of exit straight in
>> EL2 (similar to the hack Ard used when playing with memory attributes).
> 
> We already do this on the 32bit port, and it works fine.
> 
> I did some experimentations on arm64 a long while ago (see the
> kvm-arm64/lazy-fp branch in my tree), and it wasn't that great,
> apparently because aarch64 userspace tends to be much more FP happy than
> aarch32, but I'm not completely sure about it. Also this is from a time
> when I didn't have much HW to play with...
> 
> Maybe I should resurrect it and compare it to what this patch does, just
> as a comparison point.

This patch looks like very nice low-hanging fruit anyway.  Would you
like to have it in 4.1?

Paolo
