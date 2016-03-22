From: will.deacon@arm.com (Will Deacon)
Date: Tue, 22 Mar 2016 09:47:32 +0000
Subject: [PATCH 1/5] arm64/perf: Changed events naming convention for
 uniformity
In-Reply-To: <1458133309-17045-2-git-send-email-ashoks@broadcom.com>
References: <1458133309-17045-1-git-send-email-ashoks@broadcom.com>
 <1458133309-17045-2-git-send-email-ashoks@broadcom.com>
Message-ID: <20160322094732.GB31126@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ashok,

On Wed, Mar 16, 2016 at 06:01:45AM -0700, Ashok Kumar wrote:
> Changed events name to the format _L1/2/3I/D_CACHE/TLB_.
> For e.g. moved ARMV8_PMUV3_PERFCTR_L1_DCACHE_REFILL to
> ARMV8_PMUV3_PERFCTR_L1D_CACHE_REFILL in line with the already
> existing definitions like ARMV8_PMUV3_PERFCTR_L3D_CACHE_WB.
> 
> Added _ACCESS keyword to some of the definitions
> (ARMV8_PMUV3_PERFCTR_L1D_TLB, ARMV8_PMUV3_PERFCTR_L1I_TLB, etc)
> in line with the already existing definitions like
> ARMV8_PMUV3_PERFCTR_L1_DCACHE_ACCESS for clarity.
> 
> Corrected typo L21 to L2I in ARMV8_PMUV3_PERFCTR_L21_TLB_REFILL,
> ARMV8_PMUV3_PERFCTR_L21_TLB

I don't mind renaming these events, but could we have them matching the
names in the ARM ARM, please? For example:

> -#define ARMV8_PMUV3_PERFCTR_L1D_TLB				0x25
> -#define ARMV8_PMUV3_PERFCTR_L1I_TLB				0x26
> -#define ARMV8_PMUV3_PERFCTR_L2I_CACHE				0x27
> +#define ARMV8_PMUV3_PERFCTR_L1D_TLB_ACCESS			0x25
> +#define ARMV8_PMUV3_PERFCTR_L1I_TLB_ACCESS			0x26
> +#define ARMV8_PMUV3_PERFCTR_L2I_CACHE_ACCESS			0x27

These really are called "L1D_TLB, L1I_TLB and L2I_CACHE" without the
"_ACCESS" suffix.

Will
