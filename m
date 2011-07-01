From: heechul@illinois.edu (heechul Yun)
Date: Fri, 1 Jul 2011 00:04:42 -0700
Subject: Unnecessary cache-line flush on page table updates ?
Message-ID: <BANLkTin7aJXjpEH_WzJi5zaAtH8kFcTZeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin,

Based on TRM of Cortex A9, the MMU reads page table entries from L1-D
cache not from memory. Then I think we do not need to flush the cache
line in the following code because MMU will always see up-to-date view
of page table in both UP and SMP systems.

linux/arch/arm/mm/proc-v7.S

ENTRY(cpu_v7_set_pte_ext)
	...
        mcr     p15, 0, r0, c7, c10, 1          @ flush_pte from
D-cache // why we need this in A9?
        ?

If this is a necessary one, could you please explain the reason? Thanks.
