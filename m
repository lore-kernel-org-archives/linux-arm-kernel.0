From: richardliu@ms1.techarea.org (Richard Liu)
Date: Mon, 19 Apr 2010 11:09:11 +0800
Subject: Change ARM Cache Type from Write-Back Cached Write Allocate to
	Write-Back, No Allocate
Message-ID: <4BCBC957.90302@ms1.techarea.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on ARM11 MPCore TRM r1p0
Page 5-16

At TLB table, TEX cache memory support 4 type cache types
1) Noncachabled
2) Write-Back cached Write Allocate, Buffered
3) Write-Through cached, No Allocate on Write, Buffered
4) Write-Back cached, No Allocate on Write, Buffered.

 From ARM's information, if change the TEX type to Write-Through,
the L1 Cache would be "behavior is noncacheable"
I think we can disable L1/L2 cache to reach the same result.

If want to change the default setting from "Write-Back cached Write 
Allocate, Buffered" to "Write-Back cached, No Allocate on Write, Buffered".
How to modify the build_mem_type_table in file mmu.c?
And should it need more patches on others part like L1 or L2 coherence 
function?
