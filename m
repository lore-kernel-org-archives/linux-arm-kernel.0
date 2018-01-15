From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 15 Jan 2018 18:01:27 +0000
Subject: [PATCH v3 11/13] arm64: Implement branch predictor hardening for
 affected Cortex-A CPUs
In-Reply-To: <20180109161218.2079-1-suzuki.poulose@arm.com>
References: <1515432758-26440-12-git-send-email-will.deacon@arm.com>
 <20180109161218.2079-1-suzuki.poulose@arm.com>
Message-ID: <20180115180127.jkwe6pbp4j7xcdhl@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 09, 2018 at 04:12:18PM +0000, Suzuki K. Poulose wrote:
> arm64: capabilities: Handle duplicate entries for a capability
> 
> Sometimes a single capability could be listed multiple times with
> differing matches(), e.g, CPU errata for different MIDR versions.
> This breaks verify_local_cpu_feature() and this_cpu_has_cap() as
> we stop checking for a capability on a CPU with the first
> entry in the given table, which is not sufficient. Make sure we
> run the checks for all entries of the same capability. We do
> this by fixing __this_cpu_has_cap() to run through all the
> entries in the given table for a match and reuse it for
> verify_local_cpu_feature().
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/kernel/cpufeature.c | 44 ++++++++++++++++++++++--------------------
>  1 file changed, 23 insertions(+), 21 deletions(-)

Applied. Thanks.

-- 
Catalin
