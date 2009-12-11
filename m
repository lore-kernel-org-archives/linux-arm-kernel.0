From: insane79@yandex.ru (Dennis Semakin)
Date: Fri, 11 Dec 2009 16:05:28 +0300
Subject: Linux on Toradex Colibri PXA320
Message-ID: <52701260536728@webmail34.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everbody

Excuse me, but I want to ask you a something.
Something strange is going on with my Colibri PXA320. Not so long time ago I have changed a computer module (not the board, but the module!) for the similar.
And my linux doesn't boot at all, though it booted completely on analog module.
Fist time I've got kernel BUG error at mm/bootmem.c: 243!

On another time I've got this:
//begin
Uncompressing Linux.............................................................
..................................................... done, booting the kernel.
<4>kernel/printk.cel.CPU: AoO1Aarmv5te [69056826] revision 6 (ARMv5TE), cr=00003
97f
<4>kernel/printk.cCPU: on cache
<4>kernel/printk.c data cacCPU: on cache
<4>kernel/printk.c data cache,  instruction cache
<4>kernel/printk.c continue.
<4>kernel/printk.cnowb is deprecated; use cachepolicy=uncached
<4>kernel/printk.cnowb is deprecated; use cachepolicy=uncached
<4>kernel/printk.cMemory policy: ECC disabled, Data cache uncached
<4>kernel/printk.cu -> 0
<4>kernel/printk.ctalpages: 0
<4>kernel/printk.c
<4>kernel/printk.crealsize 3224473384
<4>kernel/printk.creserved
<6>kernel/printk.cRO Mode clock: 60.00MHz (inactive)
<6>kernel/printk.cRun Mode clock: 403.00MHz (*31)
<6>kernel/printk.cTurbo Mode clock: 806.00MHz (*2, active)
<6>kernel/printk.cHSIO bus clock: 0.00MHz
<4>kernel/printk.ctch:1
<4>kernel/printk.c/initPID hash table entries: 512 (order: 9, 2048 bytes)
<6>kernel/printk.cche hash table entries: 16384 (order: 4, 65536 bytes)
<6>kernel/printk.cInode-cache hash table entries: 8192 (order: 3, 32768 bytes)
<6>kernel/printk.cMemory: 128MB = 128MB total
<5>kernel/printk.cMemory: 125980KB available (3284K code, 383K data, 104K init,
0K highmem)
<4>kernel/printk.ckmalloc-11
<6>kernel/printk.cNR_IRQS:192
<6>kernel/printk.cInternal error: n: pc=%p
<4>kernel/printk.c: 0 [#1]
<4>kernel/printk.cBad IRQ0
<4>kernel/printk.cfat_calc_dir_size+0xc/0x400 [fat_calc_dir_size+0xc/0x400 [fat]
 )
<4>kernel/printk.cPC is at fat_alloc_inode+0x0/0xe8 [fat_alloc_inode+0x0/0xe8 [f
at_alloc_inode+0x0/0xe8 [fat_alloc_]
<4>kernel/printk.cLR is at 0,9600n8
<4>kernel/printk.cp : c004f90c00000000  r9 : c0359fb8  r8 : 000012c0
<4>kernel/printk.cr7 : 00100100  r6 : 3a3ffac0  r5 : c7801200  r4 : c03ae39c
<4>kernel/printk.cr3 : 00000001  r2 : c035f54c  r1 : 0000001e  r0 : c035f548
<4>kernel/printk.cFlags: nzcv  IRQs on  FIQs off  Mode SVC_32  ISA UK12_32  Segm
ent %s
<4>kernel/printk.c
<4>kernel/printk.cControl: 0000397b  Table: 80004018  DAC: 00000035
<4>kernel/printk.cProcess swapper (pid: 0, sta (pid: -1070227752, stack limit =
0x36392c30)
<4>kernel/printk.c = 0x%p)
<4>kernel/printk.c(0xc0359fb8 to 0xc035a000)
<4>kernel/printk.c9fa0:                                                       c0
01bf18 c001cca0
<4>kernel/printk.c9fc0: c035c3d8 c0013a70 8001b7dc c0383504 c0383510 c0008ab0 c0
0084f0 00000000
<4>kernel/printk.c9fe0: 00000000 c001cca0 0000397d c0383798 c001d0a4 80008034 00
000000 00000000
<4>kernel/printk.cunwind: Unknown symbol addreswn symbol address c001c00c
<4>kernel/printk.cs c001c00c
<4>kernel/printk.cCode: 00000000 736e6f63 00656c6f 53797474 (36392c30)
<4>kernel/printk.cInternal error: n: pc=%p
<4>kernel/printk.c: 0 [#2]
<4>kernel/printk.cBad IRQ0
<4>kernel/printk.cfat_calc_dir_size+0xc/0x400 [fat_calc_dir_size+0xc/0x400 [fat]
 )
<4>kernel/printk.cPC is at fat_alloc_inode+0x0/0xe8 [fat_alloc_inode+0x0/0xe8 [f
at_alloc_inode+0x0/0xe8 [fat_alloc_]
<4>kernel/printk.cLR is at 0,9600n8
<4>kernel/printk.cp : c004f90c00000000  r9 : c0359fb8  r8 : 000012c0
<4>kernel/printk.cr7 : 00100100  r6 : 3a3ffac0  r5 : c7801200  r4 : c03ae39c
<4>kernel/printk.cr3 : 00000001  r2 : c035f54c  r1 : 0000001e  r0 : c035f548
<4>kernel/printk.cFlags: nzcv  IRQs on  FIQs off  Mode SVC_32  ISA UK12_32  Segm
ent %s
<4>kernel/printk.c
<4>kernel/printk.cControl: 0000397b  Table: 80004018  DAC: 00000035
<4>kernel/printk.cProcess swapper (pid: 0, sta (pid: -1070227752, stack limit =
0x36392c30)
<4>kernel/printk.c = 0x%p)
<4>kernel/printk.c(0xc0359fb8 to 0xc035a000)
<4>kernel/printk.c9fa0:                                                       c0
01bf18 c001cca0
<4>kernel/printk.c9fc0: c035c3d8 c0013a70 8001b7dc c0383504 c0383510 c0008ab0 c0
0084f0 00000000
<4>kernel/printk.c9fe0: 00000000 c001cca0 0000397d c0383798 c001d0a4 80008034 00
000000 00000000
<4>kernel/printk.cunwind: Unknown symbol addreswn symbol address c001c00c
<4>kernel/printk.cs c001c00c
<4>kernel/printk.cCode: 00000000 736e6f63 00656c6f 53797474 (36392c30)
<4>kernel/printk.c---[ end trace 0000000000000081 ]---
<4>kernel/printk.cs:-1070053430 (null)()
//end

Then I began to get different errors : Unable to handle kernel NULL pointer at viutual address xxxxx, 
unable to handle kernel paging request at virtual address xxxxx... and so on...
I think It's something wrong with memory addressing(managment). But where?

I know that bootmem is a boot-time physical allocator and configurator.
Here is a code where BUG() was happen:

229 static void __init __free(bootmem_data_t *bdata,
230 unsigned long sidx, unsigned long eidx)
231 {
232 unsigned long idx;
233
234 bdebug("nid=%td start=%lx end=%lx\n", bdata - bootmem_node_data,
235 sidx + bdata->node_min_pfn,
236 eidx + bdata->node_min_pfn);
237
238 if (bdata->hint_idx > sidx)
239 bdata->hint_idx = sidx;
240 for (idx = sidx; idx < eidx; idx++)
241 if (!test_and_clear_bit(idx, bdata->node_bootmem_map))
242 BUG(); //HERE
243 }

If it is a physical memory bug, then why does windows CE boot very well?

One more thing I'm using EBoot for bootloader and I didn't touch any files in linux/arch/arm/mm and linux/mm
directories.

Thanks a lot
Best regards
Dennis Semakin
