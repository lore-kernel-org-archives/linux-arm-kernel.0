From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 18 Jun 2015 18:04:14 +0100
Subject: [PATCH v2 1/2] arm64: KVM: Optimize arm64 fp/simd save/restore
In-Reply-To: <1434491452-19177-2-git-send-email-m.smarduch@samsung.com>
References: <1434491452-19177-1-git-send-email-m.smarduch@samsung.com>
 <1434491452-19177-2-git-send-email-m.smarduch@samsung.com>
Message-ID: <5582FA0E.6030409@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/06/15 22:50, Mario Smarduch wrote:
> This patch only saves and restores FP/SIMD registers on Guest access. To do
> this cptr_el2 FP/SIMD trap is set on Guest entry and later checked on exit.
> lmbench, hackbench show significant improvements, for 30-50% exits FP/SIMD
> context is not saved/restored
> 
> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>

Looks nice and clean.

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
