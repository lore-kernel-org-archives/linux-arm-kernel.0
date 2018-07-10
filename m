From: will.deacon@arm.com (Will Deacon)
Date: Tue, 10 Jul 2018 15:31:06 +0100
Subject: [PATCH v5 0/7] arm64: perf: Support for chained counters
In-Reply-To: <1531213084-27417-1-git-send-email-suzuki.poulose@arm.com>
References: <1531213084-27417-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20180710143105.GC9022@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki,

On Tue, Jul 10, 2018 at 09:57:57AM +0100, Suzuki K Poulose wrote:
> This series adds support for counting PMU events using 64bit counters
> for arm64 PMU.
> 
> The Arm v8 PMUv3 supports combining two adjacent 32bit counters
> (low even and hig odd counters) to count a given "event" in 64bit mode.
> This series adds the support for 64bit events in the core arm_pmu driver
> infrastructure and adds the support for armv8 64bit kernel PMU to use
> chained counters to count in 64bit mode. For CPU cycles, we use the cycle
> counter in 64bit mode, only when requested. If the cycle counter is not
> available, we fall back to chaining the counters.
> 
> Tested on Juno, Fast models. Applies on 4.18-rc4

Thanks, this looks pretty good to me. How far did you get with the perf
fuzzer?

Will
