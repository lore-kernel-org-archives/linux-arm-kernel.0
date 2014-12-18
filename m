From: m.smarduch@samsung.com (Mario Smarduch)
Date: Thu, 18 Dec 2014 11:27:19 -0800
Subject: Help on kvm_tlb_flush_vmid_ipa usage
Message-ID: <54932A97.3060103@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When this function is called IPA address is used.
Looking at the HYP implementation it uses the IPA
directly in tlbi instructions. But reading the TLB maintnance
instruction syntax, bit [35:0] should be set to
IPA[47:12]. I traced the source code but don't see
the adjustment. I must be missing something
given this function is fundamental to KVM MMU.

Thanks,
  Mario
