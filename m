From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 21 Mar 2018 15:18:37 +0000
Subject: [PATCH v4 15/22] arm64: capabilities: Change scope of VHE to
 Boot CPU feature
In-Reply-To: <20180313115120.17256-16-suzuki.poulose@arm.com>
References: <20180313115120.17256-1-suzuki.poulose@arm.com>
 <20180313115120.17256-16-suzuki.poulose@arm.com>
Message-ID: <20180321151837.GC16308@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2018 at 11:51:13AM +0000, Suzuki K Poulose wrote:
> We expect all CPUs to be running at the same EL inside the kernel
> with or without VHE enabled and we have strict checks to ensure
> that any mismatch triggers a kernel panic. If VHE is enabled,
> we use the feature based on the boot CPU and all other CPUs
> should follow. This makes it a perfect candidate for a cpability

Nit: capability (not worth fixing unless you respin for some other
reason though.)

> based on the boot CPU,  which should be matched by all the CPUs
> (both when is ON and OFF). This saves us some not-so-pretty
> hooks and special code, just for verifying the conflict.
> 
> The patch also makes the VHE capability entry depend on
> CONFIG_ARM64_VHE.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Dave Martin <dave.martin@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

[...]

Cheers
---Dave
