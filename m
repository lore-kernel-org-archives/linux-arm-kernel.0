From: will.deacon@arm.com (Will Deacon)
Date: Mon, 22 Aug 2016 11:00:07 +0100
Subject: [PATCH 6/8] arm64: Introduce raw_{d,i}cache_line_size
In-Reply-To: <1471525832-21209-7-git-send-email-suzuki.poulose@arm.com>
References: <1471525832-21209-1-git-send-email-suzuki.poulose@arm.com>
 <1471525832-21209-7-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160822100007.GB14680@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 18, 2016 at 02:10:30PM +0100, Suzuki K Poulose wrote:
> On systems with mismatched i/d cache min line sizes, we need to use
> the smallest size possible across all CPUs. This will be done by fetching
> the system wide safe value from CPU feature infrastructure.
> However the some special users(e.g kexec, hibernate) would need the line
> size on the CPU (rather than the system wide), when the system wide
> feature may not be accessible. Provide another helper which will fetch
> cache line size on the current CPU.

Why are these users "special"? Using a smaller line size shouldn't affect
correctness, and I don't see kexec and hibernate as being performance
critical in their cache maintenance.

Will
