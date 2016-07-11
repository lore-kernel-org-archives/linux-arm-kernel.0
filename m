From: geoff@infradead.org (Geoff Levand)
Date: Mon, 11 Jul 2016 14:55:54 -0700
Subject: [PATCH 6/8] arm64: Introduce raw_{d,i}cache_line_size
In-Reply-To: <1467977839-27543-8-git-send-email-suzuki.poulose@arm.com>
References: <1467977839-27543-1-git-send-email-suzuki.poulose@arm.com>
 <1467977839-27543-8-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1468274154.2977.1.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-07-08 at 12:37 +0100, Suzuki K Poulose wrote:
> On systems with mismatched i/d cache min line sizes, we need to use
> the smallest size possible across all CPUs. This will be done by fetching
> the system wide safe value from CPU feature infrastructure.
> However the some special users(e.g kexec, hibernate) would need the line
> size on the CPU (rather than the system wide), when the system wide
> feature may not be accessible. Provide another helper which will fetch
> cache line size on the current CPU.
> 

Looks OK for what kexec needs.

Acked-by: Geoff Levand <geoff@infradead.org>
