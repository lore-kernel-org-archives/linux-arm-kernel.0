From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed, 19 Sep 2018 11:53:43 +0100
Subject: [PATCH] arm64: cpu_errata: Remove ARM64_MISMATCHED_CACHE_LINE_SIZE
In-Reply-To: <1537353681-19677-1-git-send-email-will.deacon@arm.com>
References: <1537353681-19677-1-git-send-email-will.deacon@arm.com>
Message-ID: <233e9a8d-b3ef-9b9c-208b-f0fd9ea4e3fe@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/19/2018 11:41 AM, Will Deacon wrote:
> There's no need to treat mismatched cache-line sizes reported by CTR_EL0
> differently to any other mismatched fields that we treat as "STRICT" in
> the cpufeature code. In both cases we need to trap and emulate EL0
> accesses to the register, so drop ARM64_MISMATCHED_CACHE_LINE_SIZE and
> rely on ARM64_MISMATCHED_CACHE_TYPE instead.

The only reason was to avoid trapping the kernel accesses of CTR_EL0
for cache line sizes if there were no differences. If we are ok with
that, I am fine with the patch.

Cheers
Suzuki
