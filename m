From: robherring2@gmail.com (Rob Herring)
Date: Tue, 14 May 2013 11:53:34 -0500
Subject: [PATCH v2] ARM: KVM: prevent NULL pointer dereferences with KVM
 VCPU ioctl
In-Reply-To: <5191E2BF.5040102@linaro.org>
References: <1368052086-25059-1-git-send-email-andre.przywara@linaro.org>
 <20130513055253.GC64337@ubuntu> <519167D3.4030600@linaro.org>
 <CAEDV+gKTYCh8zTPJAxSmwhuyWo7K5Ej75giryR-pv5oqHdURSQ@mail.gmail.com>
 <5191E2BF.5040102@linaro.org>
Message-ID: <51926C0E.2000504@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/14/2013 02:07 AM, Andre Przywara wrote:
> On 05/14/2013 12:42 AM, Christoffer Dall wrote:
>> On Mon, May 13, 2013 at 3:23 PM, Andre Przywara
>> <andre.przywara@linaro.org> wrote:
>>> ooks like a natural candidate, but unfortunately struct kvm_vcpu is
>>> opaque
>>> here, so dereferencing it does not work without further changes which
>>> I do
>>> not deem to be justified. I used kvm_coproc.h instead, which is loosely
>>> related (KVM_[SG]ET_ONE_REG) and just simply works. If you don't think
>>> that's appropriate, just drop me a note. Patch follows in a separate
>>> mail.
>>
>> eh, not crazy about the idea. x86 has
>> arch/x86/include/asm/kvm_guest.h, which may be the most appropriate,
>> or this could be generalized to other architectures as well and
>> included in include/linux/kvm_host.h.
>>
>> we can just stick it in arch/arm/kvm/arm.c for now and move later if
>> need be, no need to create a fuzz.
> 
> Ok, would you mind to commit v2 and add the "inline" on the way?

You don't really need the inline if it's not in a header. The compiler
will inline it anyway.

Rob
