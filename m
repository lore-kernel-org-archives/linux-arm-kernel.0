From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Wed, 6 Mar 2013 16:11:05 -0800
Subject: [kvmarm] [PATCH 00/29] ARM: KVM: pre-arm64 KVM/arm rework
In-Reply-To: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
References: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130307001105.GA23427@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 05, 2013 at 02:42:54AM +0000, Marc Zyngier wrote:
> This patch series is reworking KVM/arm in order to prepare the code
> to be shared with the upcoming KVM/arm64.
> 
> Nothing major here, just a lot of accessors, small cleanups and fixes
> to make the code useable on arm64.
> 
> This code has been tested on VE-TC2 and arm64 models. As always,
> comments are most welcome.
> 
> Marc Zyngier (29):
>   ARM: KVM: convert GP registers from u32 to unsigned long
>   ARM: KVM: abstract fault register accesses
>   ARM: KVM: abstract HSR_ISV away
>   ARM: KVM: abstract HSR_WNR away
>   ARM: KVM: abstract HSR_SSE away
>   ARM: KVM: abstract HSR_SRT_{MASK,SHIFT} away
>   ARM: KVM: abstract external abort detection away
>   ARM: KVM: abstract S1TW abort detection away
>   ARM: KVM: abstract SAS decoding away
>   ARM: KVM: abstract IL decoding away
>   ARM: KVM: abstract exception class decoding away
>   ARM: KVM: abstract fault decoding away
>   ARM: KVM: abstract HSR_EC_IABT away
>   ARM: KVM: move kvm_condition_valid to emulate.c
>   ARM: KVM: move exit handler selection to a separate file
>   ARM: KVM: move kvm_handle_wfi to handle_exit.c
>   ARM: KVM: abstract most MMU operations
>   ARM: KVM: remove superfluous include from kvm_vgic.h
>   ARM: KVM: move hyp init to kvm_host.h
>   ARM: KVM: use kvm_kernel_vfp_t as an abstract type for VFP containers
>   ARM: KVM: allow HYP mappings to be at an offset from kernel mappings
>   ARM: KVM: fix address validation for HYP mappings

These ones were already applied?

See https://github.com/columbia/linux-kvm-arm/tree/kvm-arm-fixes

>   ARM: KVM: sanitize freeing of HYP page tables

applied

>   ARM: KVM: move kvm_target_cpu to guest.c
>   ARM: KVM: fix fault_ipa computing
>   ARM: KVM: vgic: decouple alignment restriction from page size
>   ARM: KVM: move include of asm/idmap.h to kvm_mmu.h
>   ARM: KVM: change kvm_tlb_flush_vmid to kvm_tlb_flush_vmid_ipa

These ones were also already applied.

>   ARM: KVM: Fix length of mmio access

applied.

I will send a pull request to kvm/master for these ones.

-Christoffer
