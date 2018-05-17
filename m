From: greg@kroah.com (Greg KH)
Date: Thu, 17 May 2018 11:01:15 +0200
Subject: [PATCH 2/2] [stable 4.4] arm64: Add work around for Arm
 Cortex-A55 Erratum 1024718
In-Reply-To: <1526295664-22187-2-git-send-email-suzuki.poulose@arm.com>
References: <1526295664-22187-1-git-send-email-suzuki.poulose@arm.com>
 <1526295664-22187-2-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20180517090115.GE25318@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 12:01:04PM +0100, Suzuki K Poulose wrote:
> commit ece1397cbc89c51914fae1aec729539cfd8bd62b upstream
> 
> Some variants of the Arm Cortex-55 cores (r0p0, r0p1, r1p0) suffer
> from an erratum 1024718, which causes incorrect updates when DBM/AP
> bits in a page table entry is modified without a break-before-make
> sequence. The work around is to disable the hardware DBM feature
> on the affected cores. The hardware Access Flag management features
> is not affected.
> 
> The hardware DBM feature is a non-conflicting capability, i.e, the
> kernel could handle cores using the feature and those without having
> the features running at the same time. So this work around is detected
> at early boot time, rather than delaying it until the CPUs are brought
> up into the kernel with MMU turned on. This also avoids other complexities
> with late CPUs turning online, with or without the hardware DBM features.
> 
> Cc: stable at vger.kernel.org # v4.4
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Note: The upstream commit is on top of a reworked capability
> infrastructure for arm64 heterogeneous systems, which allows
> delaying the CPU model checks. This backport is based on the
> original version of the patch [0], which checks the affected
> CPU models during the early boot.
> 
> [0] https://lkml.kernel.org/r/20180116102323.3470-1-suzuki.poulose at arm.com

Thanks for these, now queued up.

greg k-h
