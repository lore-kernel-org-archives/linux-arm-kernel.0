From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 21 Jul 2016 16:05:56 +0100
Subject: [PATCH] [4.7] arm64: Honor nosmp kernel command line option
In-Reply-To: <1469096127-1136-1-git-send-email-suzuki.poulose@arm.com>
References: <1469096127-1136-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160721150556.GE16666@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2016 at 11:15:27AM +0100, Suzuki K. Poulose wrote:
> Passing "nosmp" should boot the kernel with a single processor, without
> provision to enable secondary CPUs even if they are present. "nosmp" is
> implemented by setting maxcpus=0. At the moment we still mark the secondary
> CPUs present even with nosmp, which allows the userspace to bring them
> up. This patch corrects the smp_prepare_cpus() to honor the maxcpus == 0.
> 
> Commit 44dbcc93ab67145 ("arm64: Fix behavior of maxcpus=N") fixed the
> behavior for maxcpus >= 1, but broke maxcpus = 0.
> 
> Fixes: commit 44dbcc93ab67145 ("arm64: Fix behavior of maxcpus=N")
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Queued for 4.8, with Mark's comment and a cc stable for 4.7

-- 
Catalin
