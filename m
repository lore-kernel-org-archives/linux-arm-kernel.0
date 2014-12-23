From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 23 Dec 2014 12:14:20 +0000
Subject: [PATCH v5 09/19] arm/arm64: KVM: make the value of ICC_SRE_EL1 a
 per-VM variable
In-Reply-To: <1418042274-3246-10-git-send-email-andre.przywara@arm.com> (Andre
 Przywara's message of "Mon, 8 Dec 2014 12:37:44 +0000")
References: <1418042274-3246-1-git-send-email-andre.przywara@arm.com>
 <1418042274-3246-10-git-send-email-andre.przywara@arm.com>
Message-ID: <868uhy1s2r.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 08 2014 at 12:37:44 PM, Andre Przywara <andre.przywara@arm.com> wrote:
> ICC_SRE_EL1 is a system register allowing msr/mrs accesses to the
> GIC CPU interface for EL1 (guests). Currently we force it to 0, but
> for proper GICv3 support we have to allow guests to use it (depending
> on their selected virtual GIC model).
> So add ICC_SRE_EL1 to the list of saved/restored registers on a
> world switch, but actually disallow a guest to change it by only
> restoring a fixed, once-initialized value.
> This value depends on the GIC model userland has chosen for a guest.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
