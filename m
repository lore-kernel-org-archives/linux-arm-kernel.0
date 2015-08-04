From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 4 Aug 2015 16:33:52 +0200
Subject: [PATCH v3 07/11] KVM: arm/arm64: vgic: Allow HW interrupts to be
 queued to a guest
In-Reply-To: <1437753309-17989-8-git-send-email-marc.zyngier@arm.com>
References: <1437753309-17989-1-git-send-email-marc.zyngier@arm.com>
 <1437753309-17989-8-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150804143352.GF29335@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 04:55:05PM +0100, Marc Zyngier wrote:
> To allow a HW interrupt to be injected into a guest, we lookup the
> guest virtual interrupt in the irq_phys_map list, and if we have
> a match, encode both interrupts in the LR.
> 
> We also mark the interrupt as "active" at the host distributor level.
> 
> On guest EOI on the virtual interrupt, the host interrupt will be
> deactivated.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
