From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 15 Sep 2015 21:00:59 +0200
Subject: [PATCH] KVM: arm64: add workaround for Cortex-A57 erratum #852523
In-Reply-To: <55F6EBD4.30809@arm.com>
References: <1442243163-2675-1-git-send-email-will.deacon@arm.com>
 <55F6EBD4.30809@arm.com>
Message-ID: <20150915190059.GR15712@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 14, 2015 at 04:46:28PM +0100, Marc Zyngier wrote:
> On 14/09/15 16:06, Will Deacon wrote:
> > When restoring the system register state for an AArch32 guest at EL2,
> > writes to DACR32_EL2 may not be correctly synchronised by Cortex-A57,
> > which can lead to the guest effectively running with junk in the DACR
> > and running into unexpected domain faults.
> > 
> > This patch works around the issue by re-ordering our restoration of the
> > AArch32 register aliases so that they happen before the AArch64 system
> > registers. Ensuring that the registers are restored in this order
> > guarantees that they will be correctly synchronised by the core.
> > 
> > Cc: <stable@vger.kernel.org>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> 

Looks good to me too, and I just gave this a spin with my loop test on
Juno as well.

Thanks,
-Christoffer
