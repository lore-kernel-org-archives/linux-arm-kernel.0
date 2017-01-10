From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 10 Jan 2017 17:55:00 +0000
Subject: [PATCH v3 04/10] Documentation: perf: hisi: Documentation for
 HiP05/06/07 PMU event counting.
In-Reply-To: <1483339777-23973-1-git-send-email-anurup.m@huawei.com>
References: <1483339777-23973-1-git-send-email-anurup.m@huawei.com>
Message-ID: <20170110175500.GD24036@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 02, 2017 at 01:49:37AM -0500, Anurup M wrote:
> +The Hisilicon SoC HiP05/06/07 chips consist of various independent system
> +device PMU's such as L3 cache(L3C) and Miscellaneous Nodes(MN).
> +These PMU devices are independent and have hardware logic to gather
> +statistics and performance information.
> +
> +HiP0x chips are encapsulated by multiple CPU and IO die's. The CPU die is
> +called as Super CPU cluster (SCCL) which includes 16 cpu-cores. Every SCCL
> +is further grouped as CPU clusters (CCL) which includes 4 cpu-cores each.
> +Each SCCL has 1 L3 cache and 1 MN units.

Are there systems with multiple SCCLs? Or is there only one SCCL per
system?

> +The L3 cache is shared by all CPU cores in a CPU die. The L3C has four banks
> +(or instances). Each bank or instance of L3C has Eight 32-bit counter
> +registers and also event control registers. The HiP05/06 chip L3 cache has
> +22 statistics events. The HiP07 chip has 66 statistics events. These events
> +are very useful for debugging.

Is an L3C associated with a subset of physical memory (as with the ARM
CCN's L3C), or is it associated with a set of CPUs (e.g.  only those in
a single SCCL) covering all physical memory (as with each CPU's L1 &
L2)?

Thanks,
Mark.
