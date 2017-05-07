From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sun, 07 May 2017 13:13:37 +0100
Subject: [PATCH v7 14/24] KVM: arm64: vgic-v3:
 vgic_v3_lpi_sync_pending_status
In-Reply-To: <1494084283-12723-15-git-send-email-eric.auger@redhat.com> (Eric
 Auger's message of "Sat, 6 May 2017 17:24:33 +0200")
References: <1494084283-12723-1-git-send-email-eric.auger@redhat.com>
 <1494084283-12723-15-git-send-email-eric.auger@redhat.com>
Message-ID: <87wp9skgpa.fsf@on-the-bus.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 06 2017 at  4:24:33 pm BST, Eric Auger <eric.auger@redhat.com> wrote:
> this new helper synchronizes the irq pending_latch
> with the LPI pending bit status found in rdist pending table.
> As the status is consumed, we reset the bit in pending table.
>
> As we need the PENDBASER_ADDRESS() in vgic-v3, let's move its
> definition in the irqchip header. We restore the full length
> of the field, ie [51:16]. Same for PROPBASER_ADDRESS with full
> field length of [51:12].
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead, it just smell funny.
