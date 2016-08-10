From: james.morse@arm.com (James Morse)
Date: Wed, 10 Aug 2016 17:26:44 +0100
Subject: [PATCH v24 2/9] memblock: add memblock_cap_memory_range()
In-Reply-To: <20160809015526.28479-1-takahiro.akashi@linaro.org>
References: <20160809015248.28414-2-takahiro.akashi@linaro.org>
 <20160809015526.28479-1-takahiro.akashi@linaro.org>
Message-ID: <57AB55C4.1070200@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akashi,

On 09/08/16 02:55, AKASHI Takahiro wrote:
> Crash dump kernel uses only a limited range of memory as System RAM.
> On arm64 implementation, a new device tree property,
> "linux,usable-memory-range," is used to notify crash dump kernel of
> this range.[1]
> But simply excluding all the other regions, whatever their memory types
> are, doesn't work, especially, on the systems with ACPI. Since some of
> such regions will be later mapped as "device memory" by ioremap()/
> acpi_os_ioremap(), it can cause errors like unalignment accesses.[2]
> This issue is akin to the one reported in [3].
> 
> So this patch follows Chen's approach, and implements a new function,
> memblock_cap_memory_range(), which will exclude only the memory regions
> that are not marked "NOMAP" from memblock.memory.

This (and the next patch) fixes the acpi related unaligned access problem I had.
I've tested it on a Juno r1 and Seattle B0.

Tested-by: James Morse <james.morse@arm.com>


Thanks,

James
