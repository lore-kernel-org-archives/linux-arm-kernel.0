From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 03 Sep 2015 16:04:58 +0100
Subject: [PATCH 5/9] arm/arm64: KVM: Use appropriate define in VGIC reset
 code
In-Reply-To: <1440942866-23802-6-git-send-email-christoffer.dall@linaro.org>
References: <1440942866-23802-1-git-send-email-christoffer.dall@linaro.org>
 <1440942866-23802-6-git-send-email-christoffer.dall@linaro.org>
Message-ID: <55E8619A.9030604@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/08/15 14:54, Christoffer Dall wrote:
> We currently initialize the SGIs to be enabled in the VGIC code, but we
> use the VGIC_NR_PPIS define for this purpose, instead of the the more
> natural VGIC_NR_SGIS.  Change this slightly confusing use of the
> defines.
> 
> Note: This should have no functional change, as both names are defined
> to the number 16.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Ah, that's a confusing one, well spotted.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
