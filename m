From: drjones@redhat.com (Andrew Jones)
Date: Thu, 19 Jul 2018 18:28:40 +0200
Subject: [PATCH v4 05/10] KVM: arm/arm64: vgic: Signal IRQs using their
 configured group
In-Reply-To: <1531746387-7033-6-git-send-email-christoffer.dall@arm.com>
References: <1531746387-7033-1-git-send-email-christoffer.dall@arm.com>
 <1531746387-7033-6-git-send-email-christoffer.dall@arm.com>
Message-ID: <20180719162840.gakzztsbrwdnu5x3@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2018 at 03:06:22PM +0200, Christoffer Dall wrote:
> Now when we have a group configuration on the struct IRQ, use this state
> when populating the LR and signaling interrupts as either group 0 or
> group 1 to the VM.  Depending on the model of the emulated GIC, and the
> guest's configuration of the VMCR, interrupts may be signaled as IRQs or
> FIQs to the VM.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> ---
>  include/linux/irqchip/arm-gic.h | 1 +
>  virt/kvm/arm/vgic/vgic-v2.c     | 3 +++
>  virt/kvm/arm/vgic/vgic-v3.c     | 6 +-----
>  3 files changed, 5 insertions(+), 5 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
