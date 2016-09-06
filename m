From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 6 Sep 2016 12:53:37 +0200
Subject: [PATCH v2 5/7] arm64: KVM: vgic-v2: Add the GICV emulation
 infrastructure
In-Reply-To: <1473150527-4729-6-git-send-email-marc.zyngier@arm.com>
References: <1473150527-4729-1-git-send-email-marc.zyngier@arm.com>
 <1473150527-4729-6-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160906105337.GK30513@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2016 at 09:28:45AM +0100, Marc Zyngier wrote:
> In order to efficiently perform the GICV access on behalf of the
> guest, we need to be able to avoid going back all the way to
> the host kernel.
> 
> For this, we introduce a new hook in the world switch code,
> conveniently placed just after populating the fault info.
> At that point, we only have saved/restored the GP registers,
> and we can quickly perform all the required checks (data abort,
> translation fault, valid faulting syndrome, not an external
> abort, not a PTW).
> 
> Coming back from the emulation code, we need to skip the emulated
> instruction. This involves an additional bit of save/restore in
> order to be able to access the guest's PC (and possibly CPSR if
> this is a 32bit guest).
> 
> At this stage, no emulation code is provided.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
