From: drjones@redhat.com (Andrew Jones)
Date: Thu, 19 Jul 2018 19:26:21 +0200
Subject: [PATCH v4 08/10] KVM: arm/arm64: vgic: Allow configuration of
 interrupt groups
In-Reply-To: <1531746387-7033-9-git-send-email-christoffer.dall@arm.com>
References: <1531746387-7033-1-git-send-email-christoffer.dall@arm.com>
 <1531746387-7033-9-git-send-email-christoffer.dall@arm.com>
Message-ID: <20180719172621.3ti7xfpvcrn3waww@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2018 at 03:06:25PM +0200, Christoffer Dall wrote:
> Implement the required MMIO accessors for GICv2 and GICv3 for the
> IGROUPR distributor and redistributor registers.
> 
> This can allow guests to change behavior compared to running on previous
> versions of KVM, but only to align with the architecture and hardware
> implementations.
> 
> This also allows userspace to configure the interrupts groups for GICv3.
> We don't allow userspace to write the groups on GICv2 just yet, because
> that would result in GICv2 guests not receiving interrupts after
> migrating from an older kernel that exposes GICv2 interrupts as group 1.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> ---
>  virt/kvm/arm/vgic/vgic-init.c    |  2 +-
>  virt/kvm/arm/vgic/vgic-mmio-v2.c | 13 ++++++++++++-
>  virt/kvm/arm/vgic/vgic-mmio-v3.c | 11 +++++++++--
>  virt/kvm/arm/vgic/vgic-mmio.c    | 38 ++++++++++++++++++++++++++++++++++++++
>  virt/kvm/arm/vgic/vgic-mmio.h    |  6 ++++++
>  5 files changed, 66 insertions(+), 4 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
