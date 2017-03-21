From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 21 Mar 2017 11:06:47 +0000
Subject: [PATCH 3/9] KVM: arm/arm64: vgic: Get rid of live_lrs
In-Reply-To: <20170320105818.20481-4-cdall@linaro.org>
References: <20170320105818.20481-1-cdall@linaro.org>
 <20170320105818.20481-4-cdall@linaro.org>
Message-ID: <af684b2d-9668-0164-cb87-1234e914c800@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/03/17 10:58, Christoffer Dall wrote:
> From: Christoffer Dall <christoffer.dall@linaro.org>
> 
> There is no need to calculate and maintain live_lrs when we always
> populate the lowest numbered LRs first on every entry and clear all LRs
> on every exit.

Indeed, that's a leftover of the old vgic, where we were keeping things
in place and not always reallocating LRs like we do now.

> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
