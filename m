From: drjones@redhat.com (Andrew Jones)
Date: Thu, 19 Jul 2018 18:31:55 +0200
Subject: [PATCH v4 06/10] KVM: arm/arm64: vgic: Permit uaccess writes to
 return errors
In-Reply-To: <1531746387-7033-7-git-send-email-christoffer.dall@arm.com>
References: <1531746387-7033-1-git-send-email-christoffer.dall@arm.com>
 <1531746387-7033-7-git-send-email-christoffer.dall@arm.com>
Message-ID: <20180719163155.atqejnaf63njizyj@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2018 at 03:06:23PM +0200, Christoffer Dall wrote:
> Currently we do not allow any vgic mmio write operations to fail, which
> makes sense from mmio traps from the guest.  However, we should be able
> to report failures to userspace, if userspace writes incompatible values
> to read-only registers.  Rework the internal interface to allow errors
> to be returned on the write side for userspace writes.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
> ---
>  virt/kvm/arm/vgic/vgic-mmio-v3.c | 12 +++++++-----
>  virt/kvm/arm/vgic/vgic-mmio.c    | 18 +++++++++++++-----
>  virt/kvm/arm/vgic/vgic-mmio.h    | 19 +++++++++++--------
>  3 files changed, 31 insertions(+), 18 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
