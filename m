From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 21 Oct 2013 15:02:51 +0100
Subject: [RFC PATCH 0/5] arm/arm64: KVM: dynamic VGIC sizing
In-Reply-To: <1380888978-27725-1-git-send-email-marc.zyngier@arm.com>
References: <1380888978-27725-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20131021140251.GD39411@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 04, 2013 at 01:16:13PM +0100, Marc Zyngier wrote:
> So far, the VGIC data structures have been statically sized, meaning
> that we always have to support more interrupts than we actually want,
> and more CPU interfaces than we should.
> 
> This is a waste of resource, and is the kind of things that should be
> tuneable. This series partially addresses that issue by changing the
> data structures to be dynamically allocated.
> 
> The various sizes are still static, but the VGIC code itself doesn't
> have any reference to these anymore. Once plugged into the new device
> API, we should be able to size it entierely dynamically.
> 
> I'm hopping for this series to be merged with Christoffer's VGIC
> device control API.

Review it and you can stop hopping (must be hard on your legs).
I'll be happy to help with the merge ;)

> 
> This has been (lightly) tested on both ARM (TC2) and arm64 (model).
> 
>      M.
> 
> Marc Zyngier (5):
>   arm/arm64: KVM: vgic: switch to dynamic allocation
>   arm/arm64: KVM: vgic: kill VGIC_NR_SHARED_IRQS
>   arm/arm64: KVM: vgic: kill VGIC_MAX_CPUS
>   arm/arm64: KVM: vgic: handle out-of-range MMIO accesses
>   arm/arm64: KVM: vgic: kill VGIC_NR_IRQS
> 
>  arch/arm/kvm/arm.c     |   5 +-
>  include/kvm/arm_vgic.h |  49 ++++-----
>  virt/kvm/arm/vgic.c    | 263 ++++++++++++++++++++++++++++++++++++++++---------
>  3 files changed, 249 insertions(+), 68 deletions(-)
> 
> -- 
> 1.8.2.3
> 
> 

-- 
Christoffer
