From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Mon, 13 May 2013 15:42:57 -0700
Subject: [PATCH v2] ARM: KVM: prevent NULL pointer dereferences with KVM
 VCPU ioctl
In-Reply-To: <519167D3.4030600@linaro.org>
References: <1368052086-25059-1-git-send-email-andre.przywara@linaro.org>
 <20130513055253.GC64337@ubuntu> <519167D3.4030600@linaro.org>
Message-ID: <CAEDV+gKTYCh8zTPJAxSmwhuyWo7K5Ej75giryR-pv5oqHdURSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 13, 2013 at 3:23 PM, Andre Przywara
<andre.przywara@linaro.org> wrote:
> ooks like a natural candidate, but unfortunately struct kvm_vcpu is opaque
> here, so dereferencing it does not work without further changes which I do
> not deem to be justified. I used kvm_coproc.h instead, which is loosely
> related (KVM_[SG]ET_ONE_REG) and just simply works. If you don't think
> that's appropriate, just drop me a note. Patch follows in a separate mail.

eh, not crazy about the idea. x86 has
arch/x86/include/asm/kvm_guest.h, which may be the most appropriate,
or this could be generalized to other architectures as well and
included in include/linux/kvm_host.h.

we can just stick it in arch/arm/kvm/arm.c for now and move later if
need be, no need to create a fuzz.

-Christoffer
