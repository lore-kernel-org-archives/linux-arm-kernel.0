From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 22 Apr 2016 14:50:15 +0100
Subject: [PATCH v4 5/5] arm64: Fix behavior of maxcpus=N
In-Reply-To: <1461324335-5081-6-git-send-email-suzuki.poulose@arm.com>
References: <1461324335-5081-1-git-send-email-suzuki.poulose@arm.com>
 <1461324335-5081-6-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160422135014.GM2998@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2016 at 12:25:35PM +0100, Suzuki K. Poulose wrote:
> maxcpu=n sets the number of CPUs activated at boot time to a max of n,
> but allowing the remaining CPUs to be brought up later if the user
> decides to do so. However, on arm64 due to various reasons, we disallowed
> hotplugging CPUs beyond n, by marking them not present. Now that
> we have checks in place to make sure the hotplugged CPUs have compatible
> features with system and requires no new errata, relax the restriction.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
