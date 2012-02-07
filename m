From: nils.faerber@kernelconcepts.de (Nils Faerber)
Date: Tue, 07 Feb 2012 15:41:54 +0100
Subject: Kirkwood, kernel 3.2, vmalloc region overlap, not starting up
Message-ID: <4F313832.1070600@kernelconcepts.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!
I am in the process of upgrading board support for my TK71 board from
2.6.38 to 3.2 and am now halted by this strange issue...

The board support for the TK71 is almost identical to the 3.2 included
board files for e.g. the Sheevaplug or the rd88f6281 reference design.
After applying my board patch and re-inserting my machine ID again the
kernel freezes very early.

After enabling earlyprintk I get the following:

Uncompressing Linux... done, booting the kernel.

[    0.000000] Linux version 3.2.0-00012-g980d683-dirty (nils at moi) (gcc
version 4.4.2 (GCC) ) #30 Tue Feb 7 15:18:57 CET 2012
[    0.000000] CPU: Feroceon 88FR131 [56251311] revision 1 (ARMv5TE),
cr=00053977
[    0.000000] CPU: VIVT data cache, VIVT instruction cache

[    0.000000] Machine: TK71 Kirkwood based Q7 formfactor board

[    0.000000] bootconsole [earlycon0] enabled

[    0.000000] Ignoring RAM at 00000000-0fffffff (vmalloc region
overlap).
[    0.000000] Memory policy: ECC disabled, Data cache writeback

[    0.000000] Kernel panic - not syncing: ERROR: Failed to allocate
0x1000 bytes below 0x0.
[    0.000000]

[    0.000000] Backtrace:

[    0.000000] [<c000c2a0>] (dump_backtrace+0x0/0x110) from [<c0319b84>]
(dump_stack+0x18/0x1c)

The overlapping region in question is exactly my whole RAM so no
surprise the kernel will not start-up much further. The whole stuff is
working properly with 2.6.38.
I am using U-Boot as bootloader - "U-Boot 2010.03-01252-gcb89b82-dirty".

Since the only board/platform specific patch is in my board file I
compared that very carefully to the other Kirkwood boards that exist in
the 3.2 kernel - but I did not find any major difference and especially
nothing that could explain this memory region problem.

Are there any other changes that I am missing from 2.6.38 to 3.2 that
could explain the above?
What needs to be done to resolve this?

Any hint would be very much appreciated.

Many thanks!

Cheers
  nils

-- 
kernel concepts GbR      Tel: +49-271-771091-12
Sieghuetter Hauptweg 48  Fax: +49-271-771091-19
D-57072 Siegen           Mob: +49-176-21024535
http://www.kernelconcepts.de
