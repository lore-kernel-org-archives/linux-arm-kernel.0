From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 27 Jun 2016 13:08:55 +0200
Subject: [PATCH] arm64: KVM: fix build with CONFIG_ARM_PMU disabled
In-Reply-To: <1465382335-5024-1-git-send-email-sudeep.holla@arm.com>
References: <1465382335-5024-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <20160627110855.GE26498@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 11:38:55AM +0100, Sudeep Holla wrote:
> When CONFIG_ARM_PMU is disabled, we get the following build error:
> 
> arch/arm64/kvm/sys_regs.c: In function 'pmu_counter_idx_valid':
> arch/arm64/kvm/sys_regs.c:564:27: error: 'ARMV8_PMU_CYCLE_IDX' undeclared (first use in this function)
>   if (idx >= val && idx != ARMV8_PMU_CYCLE_IDX)
>                            ^
> arch/arm64/kvm/sys_regs.c:564:27: note: each undeclared identifier is reported only once for each function it appears in
> arch/arm64/kvm/sys_regs.c: In function 'access_pmu_evcntr':
> arch/arm64/kvm/sys_regs.c:592:10: error: 'ARMV8_PMU_CYCLE_IDX' undeclared (first use in this function)
>     idx = ARMV8_PMU_CYCLE_IDX;
>           ^
> arch/arm64/kvm/sys_regs.c: In function 'access_pmu_evtyper':
> arch/arm64/kvm/sys_regs.c:638:14: error: 'ARMV8_PMU_CYCLE_IDX' undeclared (first use in this function)
>    if (idx == ARMV8_PMU_CYCLE_IDX)
>               ^
> arch/arm64/kvm/hyp/switch.c:86:15: error: 'ARMV8_PMU_USERENR_MASK' undeclared (first use in this function)
>   write_sysreg(ARMV8_PMU_USERENR_MASK, pmuserenr_el0);
> 
> This patch fixes the build with CONFIG_ARM_PMU disabled.
> 
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Applied, thanks.

-Christoffer
