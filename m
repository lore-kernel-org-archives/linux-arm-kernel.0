From: drjones@redhat.com (Andrew Jones)
Date: Thu, 19 Jul 2018 19:09:32 +0200
Subject: [PATCH v4 07/10] KVM: arm/arm64: vgic: Return error on
 incompatible uaccess GICD_IIDR writes
In-Reply-To: <1531746387-7033-8-git-send-email-christoffer.dall@arm.com>
References: <1531746387-7033-1-git-send-email-christoffer.dall@arm.com>
 <1531746387-7033-8-git-send-email-christoffer.dall@arm.com>
Message-ID: <20180719170932.cqdilzdzfahugkf5@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2018 at 03:06:24PM +0200, Christoffer Dall wrote:
> If userspace attempts to write a GICD_IIDR that does not match the
> kernel version, return an error to userspace.  The intention is to allow
> implementation changes inside KVM while avoiding silently breaking
> migration resulting in guests not running without any clear indication
> of what went wrong.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> ---
>  virt/kvm/arm/vgic/vgic-mmio-v2.c | 21 ++++++++++++++++++---
>  virt/kvm/arm/vgic/vgic-mmio-v3.c | 21 ++++++++++++++++++---
>  2 files changed, 36 insertions(+), 6 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
