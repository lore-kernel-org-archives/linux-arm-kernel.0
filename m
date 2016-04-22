From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 22 Apr 2016 14:33:56 +0100
Subject: [PATCH v4 3/5] irqchip/gic: Restore CPU interface checking
In-Reply-To: <1461324335-5081-4-git-send-email-suzuki.poulose@arm.com>
References: <1461324335-5081-1-git-send-email-suzuki.poulose@arm.com>
 <1461324335-5081-4-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160422133356.GK2998@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2016 at 12:25:33PM +0100, Suzuki K. Poulose wrote:
> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> When introducing the whole CPU feature detection framework,
> we lost the capability to detect a mismatched GIC configuration
> (using the GICv2 MMIO interface, but having the system register
> interface enabled).
> 
> In order to solve this, use the new this_cpu_has_cap() helper.
> Also move the check to the CPU interface path in order to catch
> systems where the first CPU has been correctly configured,
> but the secondaries are not.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
