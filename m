From: christoffer.dall@arm.com (Christoffer Dall)
Date: Tue, 6 Nov 2018 09:26:57 +0100
Subject: [PATCH] arm64: KVM: Don't generate UNDEF when LORegion feature
 is present
In-Reply-To: <20181105153026.169248-1-marc.zyngier@arm.com>
References: <20181105153026.169248-1-marc.zyngier@arm.com>
Message-ID: <20181106082657.GI12057@e113682-lin.lund.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2018 at 03:30:26PM +0000, Marc Zyngier wrote:
> We currently hide the LORegion feature, and generate an UNDEF
> if the guest dares using the corresponding registers. This is
> a bit extreme, as ARMv8.1 guarantees the feature to be present.
> 
> The guest should check the feature register before doing anything,
> but we could also give the guest some slack (read "allow the
> guest to be a bit stupid").
> 
> So instead of unconditionnaly deliver an exception, let's
> only do it when the host doesn't support LORegion at all (or
> when the feature has been sanitized out), and treat the registers
> as RAZ/WI otherwise (with the exception of LORID_EL1 being RO).
> 
> Fixes: cc33c4e20185 ("arm64/kvm: Prohibit guest LOR accesses")
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@arm.com>
