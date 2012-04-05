From: b32955@freescale.com (Huang Shijie)
Date: Thu, 5 Apr 2012 14:37:44 +0800
Subject: Using GPMI-NAND driver on iMX28 using 3.4-rc1?
In-Reply-To: <CAOMZO5AoFnM=cCR-kS4A1k2xY_bRd9+gN1p9bFxdyPS2-UdbkQ@mail.gmail.com>
References: <CAOdLEarFOdmDBS0iDmafLeBU=NNWxWjejTvJ-eEkQjRO12+VYg@mail.gmail.com>	<20120404070157.GB24930@pengutronix.de>	<CAOdLEaqXyvHzTRSq2=RquZLqEO6kMEp11rjKJ+UtSqtF4nr-EA@mail.gmail.com>	<20120404183314.GF17187@pengutronix.de>	<CAOdLEaoboQowyx3T9ONjv-Y3q1JfFRb4ahS8CNrzeJi3N8Dczg@mail.gmail.com>	<CAOMZO5AsbFDXHs3JRLC5=1MjZ7QrxciqV25xpZQL1Yvk3boQmw@mail.gmail.com>	<CAOdLEaoEDr7fnswwV-Gs8tZF9Zj-RFnRa9Z=eqRFd0==OgV10Q@mail.gmail.com>
 <CAOMZO5AoFnM=cCR-kS4A1k2xY_bRd9+gN1p9bFxdyPS2-UdbkQ@mail.gmail.com>
Message-ID: <4F7D3DB8.6080009@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All:
> On Wed, Apr 4, 2012 at 7:07 PM, Sam Gandhi<samgandhi9@gmail.com>  wrote:
>
>> I reverted that commit and I still see following  error!
> Huang,
>
> Are you able to use gpmi on mx28 running 3.4-rc1?
>
I also meet the same problem today.


>> flash_erase /dev/mtd1 0 0
>> Erasing 1------------[ cut here ]------------
>> kernel BUG at /home/sam/linux/drivers/dma/dmaengine.h:53!
the mxs-dma has added some patches about the cookie.
The bug is in the dmaengine.h.

So let more people know this bug.

BR
Huang Shijie


>> Internal error: Oops - BUG: 0 [#1] PREEMPT ARM
>> Modules linked in:
>> CPU: 0    Not tainted  (3.4.0-rc1-09876-g2e4bb28-dirty #1)
>> PC is at mxs_dma_int_handler+0xfc/0x16c
>> LR is at handle_irq_event_percpu+0xc4/0x258
>> pc : [<c024c924>]    lr : [<c006e47c>]    psr: 60000093
>> sp : c3aadb00  ip : c3aadb28  fp : c3aadb24
>> r10: 00000000  r9 : c0529058  r8 : 00000000
>> r7 : 00000010  r6 : 00000004  r5 : c3811000  r4 : 00000004
>> r3 : c38111e0  r2 : 00000000  r1 : 00000000  r0 : 00000058
>> Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
>> Control: 0005317f  Table: 42cd8000  DAC: 00000015
>> Process flash_erase (pid: 1205, stack limit = 0xc3aac270)
>> Stack: (0xc3aadb00 to 0xc3aae000)
>> db00: c026514c c006e5d4 c39c5800 00000058 f5000000 c3aadc0c c3aadb64 c3aadb28
>> db20: c006e47c c024c838 c3aadb54 c3aadb38 c000c5a8 c000b0dc c000b0fc c0529058
>> db40: c39c5800 f5000000 c3aadc0c ffffffff 00000000 00000000 c3aadb7c c3aadb68
>> db60: c006e674 c006e3c8 c0529058 00000000 c3aadb94 c3aadb80 c0071040 c006e620
>> db80: c0070f7c 00000058 c3aadbac c3aadb98 c006dcc0 c0070f8c 00000130 00000058
>> dba0: c3aadbc4 c3aadbb0 c0009f1c c006dca0 c024c338 20000013 c3aadbd4 c3aadbc8
>> dbc0: c0008648 c0009ebc c3aadc34 c3aadbd8 c03a3894 c0008640 00007efa f5004000
>> dbe0: 00000300 c3811268 c3811294 c3811294 00000000 c3811268 ffffffff 00000000
>> dc00: 00000000 c3aadc34 f5004000 c3aadc20 c024c32c c024c338 20000013 ffffffff
>> dc20: c024c308 c390b000 c3aadc54 c3aadc38 c0291ad8 c024c318 00000001 c390b000
>> dc40: 00000000 c390b4dc c3aadc8c c3aadc58 c0292600 c0291a9c 00000003 00000000
>> dc60: 00000006 00830001 00000000 00000000 c390b000 00000070 ffffffff c390b078
>> dc80: c3aadca4 c3aadc90 c02910f4 c0292500 c02910a0 c390b298 c3aadccc c3aadca8
>> dca0: c028cb40 c02910b0 c390b078 c390b298 c390b298 00000000 0000000b c2cd45c0
>> dcc0: c3aadce4 c3aadcd0 c0288f44 c028ca48 c390b078 c2cb9540 c3aadd84 c3aadce8
>> dce0: c028d7ec c0288f18 00020000 00000000 c026514c c006e5d4 00000000 00000000
>> dd00: c2cb9540 00000040 00000000 00000000 045e0000 00000000 00000000 00000000
>> dd20: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>> dd40: 00000000 00000000 00000000 00000000 00000000 00000000 c3aadd84 00a00000
>> dd60: 00000000 c2cb9540 c39da000 00000238 00000000 c2cd45c0 c3aadd94 c3aadd88
>> dd80: c028db74 c028d720 c3aaddbc c3aadd98 c0284018 c028db68 c0283fd8 becdd8f0
>> dda0: c39da000 03be0000 00000000 00020000 c3aadde4 c3aaddc0 c0281648 c0283fe8
>> ddc0: c028609c becdd8f0 c3aadef8 c2cb9540 c3aac000 c3aac000 c3aadf24 c3aadde8
>> dde0: c0286b38 c02815d8 c000c5a8 c000b0dc c000b0fc c3aac000 00000000 c2cd45c0
>> de00: c00497a8 00000000 00000000 c000c594 c3aade64 c3aade50 c03a5978 c0260854
>> de20: 00000000 c03a5978 c3aade54 c3aade38 c000c5a8 c01dc574 00000003 00000001
>> de40: c3aade9c c3aade50 c01dc574 c007374c c3aade7c c3aade60 c000c5a8 c000b0dc
>> de60: c000b0fc 0007ffff 00000000 ffffffff 00000003 00000000 00000001 c3b3a980
>> de80: c38bba08 000000a4 c3aadec4 c2cf8b80 c3aadeb4 c3aadea0 c01e1c48 c01dc4c8
>> dea0: c3aadec4 00000000 c3aadf54 c3aadeb8 c01e1d04 c01e1c04 00000000 c03a58c4
>> dec0: 00000000 00000001 00000000 c38bb830 c34a6500 00000000 00000000 00000000
>> dee0: 03be0000 00000000 00020000 00000000 00000000 00000000 c3aadef8 c3aadef8
>> df00: c053e0c0 c38bba00 becdd8f0 40104d14 00000000 00000000 c3aadf44 c3aadf28
>> df20: c02871f8 c02866e4 becdd8f0 00005452 40104d14 00000003 c3aadf54 c3aadf48
>> df40: c00eb238 c02871cc c3aadf74 c3aadf58 c00ebf2c c00eb214 c3aadf74 c3aadf68
>> df60: c38bba00 becdd8f0 c3aadfa4 c3aadf78 c00ebfb0 c00ebd78 c3aadf9c 00000000
>> df80: c0009f20 becdd958 00013008 00000003 00000036 c00091a8 00000000 c3aadfa8
>> dfa0: c0008f40 c00ebf60 becdd958 00013008 00000003 40104d14 becdd8f0 00000001
>> dfc0: becdd958 00013008 00000003 00000036 000001df 00000000 00000008 00000000
>> dfe0: 00000000 becdd8e0 b6eb4f28 b6e3926c 20000010 00000003 00000001 00000000
>> Backtrace:
>> [<c024c828>] (mxs_dma_int_handler+0x0/0x16c) from [<c006e47c>]
>> (handle_irq_event_percpu+0xc4/0x258)
>>   r7:c3aadc0c r6:f5000000 r5:00000058 r4:c39c5800
>> [<c006e3b8>] (handle_irq_event_percpu+0x0/0x258) from [<c006e674>]
>> (handle_irq_event+0x64/0x84)
>> [<c006e610>] (handle_irq_event+0x0/0x84) from [<c0071040>]
>> (handle_level_irq+0xc4/0xf8)
>>   r5:00000000 r4:c0529058
>> [<c0070f7c>] (handle_level_irq+0x0/0xf8) from [<c006dcc0>]
>> (generic_handle_irq+0x30/0x40)
>>   r4:00000058 r3:c0070f7c
>> [<c006dc90>] (generic_handle_irq+0x0/0x40) from [<c0009f1c>]
>> (handle_IRQ+0x70/0x94)
>>   r4:00000058 r3:00000130
>> [<c0009eac>] (handle_IRQ+0x0/0x94) from [<c0008648>] (asm_do_IRQ+0x18/0x1c)
>>   r5:20000013 r4:c024c338
>> [<c0008630>] (asm_do_IRQ+0x0/0x1c) from [<c03a3894>] (__irq_svc+0x34/0x78)
>> Exception stack(0xc3aadbd8 to 0xc3aadc20)
>> dbc0:                                                       00007efa f5004000
>> dbe0: 00000300 c3811268 c3811294 c3811294 00000000 c3811268 ffffffff 00000000
>> dc00: 00000000 c3aadc34 f5004000 c3aadc20 c024c32c c024c338 20000013 ffffffff
>> [<c024c308>] (mxs_dma_tx_submit+0x0/0x44) from [<c0291ad8>]
>> (start_dma_without_bch_irq+0x4c/0xa0)
>>   r4:c390b000 r3:c024c308
>> [<c0291a8c>] (start_dma_without_bch_irq+0x0/0xa0) from [<c0292600>]
>> (gpmi_send_command+0x110/0x120)
>>   r6:c390b4dc r5:00000000 r4:c390b000 r3:00000001
>> [<c02924f0>] (gpmi_send_command+0x0/0x120) from [<c02910f4>]
>> (gpmi_cmd_ctrl+0x54/0x78)
>>   r7:c390b078 r6:ffffffff r5:00000070 r4:c390b000
>> [<c02910a0>] (gpmi_cmd_ctrl+0x0/0x78) from [<c028cb40>]
>> (nand_command_lp+0x108/0x260)
>>   r4:c390b298 r3:c02910a0
>> [<c028ca38>] (nand_command_lp+0x0/0x260) from [<c0288f44>]
>> (nand_check_wp+0x3c/0x60)
>> [<c0288f08>] (nand_check_wp+0x0/0x60) from [<c028d7ec>]
>> (nand_erase_nand+0xdc/0x448)
>>   r5:c2cb9540 r4:c390b078
>> [<c028d710>] (nand_erase_nand+0x0/0x448) from [<c028db74>]
>> (nand_erase+0x1c/0x20)
>> [<c028db58>] (nand_erase+0x0/0x20) from [<c0284018>] (part_erase+0x40/0x8c)
>> [<c0283fd8>] (part_erase+0x0/0x8c) from [<c0281648>] (mtd_erase+0x80/0x94)
>>   r8:00020000 r7:00000000 r6:03be0000 r5:c39da000 r4:becdd8f0
>> r3:c0283fd8
>> [<c02815c8>] (mtd_erase+0x0/0x94) from [<c0286b38>] (mtdchar_ioctl+0x464/0xae8)
>>   r9:c3aac000 r8:c3aac000 r7:c2cb9540 r6:c3aadef8 r4:becdd8f0
>> r3:c028609c
>> [<c02866d4>] (mtdchar_ioctl+0x0/0xae8) from [<c02871f8>]
>> (mtdchar_unlocked_ioctl+0x3c/0x54)
>> [<c02871bc>] (mtdchar_unlocked_ioctl+0x0/0x54) from [<c00eb238>]
>> (vfs_ioctl+0x34/0x50)
>>   r7:00000003 r6:40104d14 r5:00005452 r4:becdd8f0
>> [<c00eb204>] (vfs_ioctl+0x0/0x50) from [<c00ebf2c>] (do_vfs_ioctl+0x1c4/0x1e8)
>> [<c00ebd68>] (do_vfs_ioctl+0x0/0x1e8) from [<c00ebfb0>] (sys_ioctl+0x60/0x84)
>>   r5:becdd8f0 r4:c38bba00
>> [<c00ebf50>] (sys_ioctl+0x0/0x84) from [<c0008f40>] (ret_fast_syscall+0x0/0x2c)
>>   r8:c00091a8 r7:00000036 r6:00000003 r5:00013008 r4:becdd958
>> Code: 1a000006 e59310b4 e3510000 ca000000 (e7f001f2)
>> 28 Kibyte @ 35c0000 -- 2---[ end trace 5deaba3c2a545554 ]---
