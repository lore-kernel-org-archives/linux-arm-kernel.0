From: drjones@redhat.com (Andrew Jones)
Date: Thu, 19 Jul 2018 18:08:46 +0200
Subject: [PATCH v4 01/10] KVM: arm/arm64: vgic: Define GICD_IIDR fields
 for GICv2 and GIv3
In-Reply-To: <1531746387-7033-2-git-send-email-christoffer.dall@arm.com>
References: <1531746387-7033-1-git-send-email-christoffer.dall@arm.com>
 <1531746387-7033-2-git-send-email-christoffer.dall@arm.com>
Message-ID: <20180719160846.gvguydoolpn2olzz@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2018 at 03:06:18PM +0200, Christoffer Dall wrote:
> Instead of hardcoding the shifts and masks in the GICD_IIDR register
> emulation, let's add the definition of these fields to the GIC header
> files and use them.
> 
> This will make things more obvious when we're going to bump the revision
> in the IIDR when we'll make guest-visible changes to the implementation.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> ---
>  include/linux/irqchip/arm-gic-v3.h | 10 ++++++++++
>  include/linux/irqchip/arm-gic.h    | 10 ++++++++++
>  virt/kvm/arm/vgic/vgic-mmio-v2.c   |  3 ++-
>  virt/kvm/arm/vgic/vgic-mmio-v3.c   |  3 ++-
>  4 files changed, 24 insertions(+), 2 deletions(-)
> 

Reviewed-by: Andrew Jones <drjones@redhat.com>
