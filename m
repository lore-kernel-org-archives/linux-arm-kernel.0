From: julien.thierry@arm.com (Julien Thierry)
Date: Tue, 5 Jun 2018 16:00:39 +0100
Subject: [PATCH v2 0/5] arm64: perf: Support for chained counters
In-Reply-To: <1527591356-10934-1-git-send-email-suzuki.poulose@arm.com>
References: <1527591356-10934-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <3cbe09d3-7878-d53d-0918-dfb38ac89353@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 29/05/18 11:55, Suzuki K Poulose wrote:
> This series adds support for counting PMU events using 64bit counters
> for arm64 PMU.
> 
> The Arm v8 PMUv3 supports combining two adjacent 32bit counters
> (low even and hig odd counters) to count a given "event" in 64bit mode.
> This series adds the support for 64bit events in the core arm_pmu driver
> infrastructure and adds the support for armv8 64bit kernel PMU to use
> chained counters to count in 64bit mode. For CPU cycles, we use the cycle
> counter in 64bit mode, when requested. If the cycle counter is not available,
> we fall back to chaining the counters.
> 
> Tested on Juno, Fast models. Applies on 4.17-rc4
> 

For the series:

Reviewed-by: Julien Thierry <julien.thierry@arm.com>

-- 
Julien Thierry
