From: pbonzini@redhat.com (Paolo Bonzini)
Date: Fri, 10 Jul 2015 13:02:56 +0200
Subject: [PATCH 07/13] arm64: KVM: VHE: Patch out use of HVC
In-Reply-To: <559D63EC.2090602@arm.com>
References: <1436372356-30410-1-git-send-email-marc.zyngier@arm.com>
 <1436372356-30410-8-git-send-email-marc.zyngier@arm.com>
 <559D5A8A.4030901@redhat.com> <559D63EC.2090602@arm.com>
Message-ID: <559FA660.2050102@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/07/2015 19:54, Marc Zyngier wrote:
> Alternatively, I could move it to arch/arm64/include/asm (renamed to
> kvm_vhe_macros.h?), which would solve this issue. I just gave it a go,
> and that seems sensible enough.

Yes, that would do.  Alternatively:

* create kvm_hyp_macros.h and put more stuff in there from kvm_mmu.h

* just put it in kvm_host.h

Whatever looks better to you.

Paolo

> Thanks for the suggestion!
