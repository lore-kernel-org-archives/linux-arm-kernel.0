From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 21 Jul 2016 16:02:20 +0100
Subject: [PATCH] arm64: Fix incorrect per-cpu usage for boot CPU
In-Reply-To: <1469095975-976-1-git-send-email-suzuki.poulose@arm.com>
References: <1469095975-976-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160721150219.GD16666@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2016 at 11:12:55AM +0100, Suzuki K. Poulose wrote:
> In smp_prepare_boot_cpu(), we invoke cpuinfo_store_boot_cpu to  store
> the cpuinfo in a per-cpu ptr, before initialising the per-cpu offset for
> the boot CPU. This patch reorders the sequence to make sure we initialise
> the per-cpu offset before accessing the per-cpu area.
> 
> Commit 4b998ff1885eec ("arm64: Delay cpuinfo_store_boot_cpu") fixed the
> issue where we modified the per-cpu area even before the kernel initialises
> the per-cpu areas, but failed to wait until the boot cpu updated it's
> offset.
> 
> Fixes: commit 4b998ff1885eec ("arm64: Delay cpuinfo_store_boot_cpu")
> Cc: <stable@vger.kernel.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Applied. Thanks.

-- 
Catalin
