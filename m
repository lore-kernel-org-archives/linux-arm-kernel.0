From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 5 Jan 2017 17:09:31 +0000
Subject: [PATCH v3 2/9] arm64: cpufeature: remove explicit RAZ fields
In-Reply-To: <1483552147-9605-3-git-send-email-suzuki.poulose@arm.com>
References: <1483552147-9605-1-git-send-email-suzuki.poulose@arm.com>
 <1483552147-9605-3-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20170105170931.GD29765@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2017 at 05:49:00PM +0000, Suzuki K. Poulose wrote:
> From: Mark Rutland <mark.rutland@arm.com>
> 
> We currently have some RAZ fields described explicitly in our
> arm64_ftr_bits arrays. These are inconsistently commented, grouped,
> and/or applied, and maintaining these is error-prone.
> 
> Luckily, we don't need these at all. We'll never need to inspect RAZ
> fields to determine feature support, and init_cpu_ftr_reg() will ensure
> that any bits without a corresponding arm64_ftr_bits entry are treated
> as RES0 with strict matching requirements. In check_update_ftr_reg()
> we'll then compare these bits from the relevant cpuinfo_arm64
> structures, and need not store them in a arm64_ftr_reg.
> 
> This patch removes the unnecessary arm64_ftr_bits entries for RES0 bits.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
