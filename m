From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 14 Oct 2014 10:47:34 +0100
Subject: [RFC PATCH] arm/arm64: KVM: Fix BE accesses to GICv2 EISR and
 ELRSR regs
In-Reply-To: <1411913066-3787-1-git-send-email-christoffer.dall@linaro.org>
 (Christoffer Dall's message of "Sun, 28 Sep 2014 15:04:26 +0100")
References: <1411913066-3787-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <86k343geyx.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 28 2014 at 03:04:26 PM, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> The EIRSR and ELRSR registers are 32-bit registers on GICv2, and we
> store these as an array of two such registers on the vgic vcpu struct.
> However, we access them as a single 64-bit value or as a bitmap pointer
> in the generic vgic code, which breaks BE support.
>
> Instead, store them as u64 values on the vgic structure and do the
> word-swapping in the assembly code, which already handles the byte order
> for BE systems.
>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

(still going through my email backlog, hence the delay).

This looks like a valuable fix. Haven't had a chance to try it (no BE
setup at hand) but maybe Victor can help reproducing this?.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
