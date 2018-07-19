From: drjones@redhat.com (Andrew Jones)
Date: Thu, 19 Jul 2018 18:16:59 +0200
Subject: [PATCH v4 04/10] KVM: arm/arm64: vgic: Add group field to struct
 irq
In-Reply-To: <1531746387-7033-5-git-send-email-christoffer.dall@arm.com>
References: <1531746387-7033-1-git-send-email-christoffer.dall@arm.com>
 <1531746387-7033-5-git-send-email-christoffer.dall@arm.com>
Message-ID: <20180719161659.zd6cc3xyqxp2rwju@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2018 at 03:06:21PM +0200, Christoffer Dall wrote:
> In preparation for proper group 0 and group 1 support in the vgic, we
> add a field in the struct irq to store the group of all interrupts.
> 
> We initialize the group to group 0 when emulating GICv2 and to group 1
> when emulating GICv3, just like we treat them today.  LPIs are always
> group 1.  We also continue to ignore writes from the guest, preserving
> existing functionality, for now.
> 
> Finally, we also add this field to the vgic debug logic to show the
> group for all interrupts.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> ---
>  include/kvm/arm_vgic.h         |  1 +
>  virt/kvm/arm/vgic/vgic-debug.c |  8 +++++---
>  virt/kvm/arm/vgic/vgic-init.c  | 19 +++++++++++++++++--
>  virt/kvm/arm/vgic/vgic-its.c   |  1 +
>  4 files changed, 24 insertions(+), 5 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
