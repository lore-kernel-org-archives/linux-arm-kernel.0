From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 22 Jun 2016 17:26:56 +0100
Subject: [PATCH v6 10/15] KVM: arm64: connect LPIs to the VGIC emulation
In-Reply-To: <1466165327-32060-11-git-send-email-andre.przywara@arm.com>
References: <1466165327-32060-1-git-send-email-andre.przywara@arm.com>
 <1466165327-32060-11-git-send-email-andre.przywara@arm.com>
Message-ID: <576ABC50.6000201@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/06/16 13:08, Andre Przywara wrote:
> LPIs are dynamically created (mapped) at guest runtime and their
> actual number can be quite high, but is mostly assigned using a very
> sparse allocation scheme. So arrays are not an ideal data structure
> to hold the information.
> We use an RCU protected list to hold all mapped LPIs. vgic_its_get_lpi()
> iterates the list using RCU list primitives, so it's safe to be called
> from an non-preemptible context like the KVM exit/entry path.
> Also we store a pointer to that struct vgic_irq in our struct its_itte,
> so we can easily access it.
> Eventually we call our new vgic_its_get_lpi() from vgic_get_irq(), so
> the VGIC code gets transparently access to LPIs.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

I'm skipping the review of this particular patch until you've switched
to the kref API.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
