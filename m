From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 21 Mar 2018 15:22:27 +0000
Subject: [PATCH v4 21/22] arm64: Delay enabling hardware DBM feature
In-Reply-To: <20180313115120.17256-22-suzuki.poulose@arm.com>
References: <20180313115120.17256-1-suzuki.poulose@arm.com>
 <20180313115120.17256-22-suzuki.poulose@arm.com>
Message-ID: <20180321152226.GD16308@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2018 at 11:51:19AM +0000, Suzuki K Poulose wrote:
> We enable hardware DBM bit in a capable CPU, very early in the
> boot via __cpu_setup. This doesn't give us a flexibility of
> optionally disable the feature, as the clearing the bit
> is a bit costly as the TLB can cache the settings. Instead,
> we delay enabling the feature until the CPU is brought up
> into the kernel. We use the feature capability mechanism
> to handle it.
> 
> The hardware DBM is a non-conflicting feature. i.e, the kernel
> can safely run with a mix of CPUs with some using the feature
> and the others don't. So, it is safe for a late CPU to have
> this capability and enable it, even if the active CPUs don't.
> 
> To get this handled properly by the infrastructure, we
> unconditionally set the capability and only enable it
> on CPUs which really have the feature. Also, we print the
> feature detection from the "matches" call back to make sure
> we don't mislead the user when none of the CPUs could use the
> feature.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Dave Martin <dave.martin@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

[...]

Reviewed-by: Dave Martin <Dave.Martin@arm.com>
