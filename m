From: hemanthv@ti.com (Hemanth V)
Date: Fri, 11 Sep 2009 19:28:56 +0530
Subject: Highmem crash
Message-ID: <049b01ca32e8$01b7baa0$LocalHost@wipultra793>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

I am seeing the below crash if I pass __GFP_HIGHMEM flag to
dma_alloc_coherent. Is this a known issue. I am currently using
2.6.31-rc7 kernel along with 2 latest highmem patches from Nicolas Pitre
tree (http://git.marvell.com/?p=orion.git;a=summary).

Thanks
Hemanth

<Unable to handle kernel NULL pointer dereference@virtual address 
00000000

<1>pgd = cfab4000

<1>[00000000] *pgd=8e3f5031[00000000] *pgd=8e3f5031, *pte=00000000,
*pte=00000000, *ppte=00000000, *ppte=00000000

Internal error: Oops: 817 [#1]

<d>Modules linked in:Modules linked in: omap2_mcspi_new_datatest(+)
omap2_mcspi_new_datatest(+)

CPU: 0 Not tainted (2.6.31-rc7-omap1-06908-gf1cc27d-dirty #9)

PC is at __memzero+0x24/0x80

LR is at 0x0

pc : [<c017d8e4>] lr : [<00000000>] psr: 20000013

sp : cf9e1d4c ip : 00000000 fp : cf9e1d9c

r10: 00000000 r9 : cf9e0000 r8 : c04758a4

r7 : 00000002 r6 : 00001000 r5 : c0893380 r4 : 00000000

r3 : 00000000 r2 : 00000000 r1 : 00000fc0 r0 : 00000000

Flags: nzCv IRQs on FIQs on Mode SVC_32 ISA ARM Segment user

Control: 10c5387d Table: 8fab4019 DAC: 00000015

Process insmod (pid: 519, stack limit = 0xcf9e02e8)

Stack: (0xcf9e1d4c to 0xcf9e2000)

[<c017d8e4>] [<c017d8e4>] (__memzero+0x24/0x80) (__memzero+0x24/0x80) from
[<c0034510>] from [<c0034510>] (dma_alloc_coherent+0x58/0x64)
