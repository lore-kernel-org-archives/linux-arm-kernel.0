From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 5 Jan 2017 18:39:06 +0000
Subject: [PATCH v3 8/9] arm64: cpufeature: Expose CPUID registers by
 emulation
In-Reply-To: <1483552147-9605-9-git-send-email-suzuki.poulose@arm.com>
References: <1483552147-9605-1-git-send-email-suzuki.poulose@arm.com>
 <1483552147-9605-9-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20170105183906.GI29765@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2017 at 05:49:06PM +0000, Suzuki K. Poulose wrote:
> This patch adds the hook for emulating MRS instruction to
> export the 'user visible' value of supported system registers.
> We emulate only the following id space for system registers:
> 
>  Op0=3, Op1=0, CRn=0, CRm=[0, 4-7]
> 
> The rest will fall back to SIGILL. This capability is also
> advertised via a new HWCAP_CPUID.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
