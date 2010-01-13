From: uri.yosef@gmail.com (Uri Yosef)
Date: Wed, 13 Jan 2010 16:24:48 +0200
Subject: kernel boot failure on with s32440/mini2440 with git head
	(dd59f6c76b2)
In-Reply-To: <4B4217E7.5000207@simtec.co.uk>
References: <4B2E4A65.8070207@walsimou.com>
	<200912211410.12014.jbe@pengutronix.de>
	<dc447790912210526l3247b8fdxfc3f7c4c99706b04@mail.gmail.com>
	<4B37A6D4.9000301@walsimou.com> <4B4217E7.5000207@simtec.co.uk>
Message-ID: <c7df016d1001130624s596ad2d3ub302f2bcea481234@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 4, 2010 at 6:31 PM, Ben Dooks <ben@simtec.co.uk> wrote:
> Gaye Abdoulaye Walsimou wrote:
>> M P wrote:
>>> On Mon, Dec 21, 2009 at 1:10 PM, Juergen Beisert <jbe@pengutronix.de> wrote:
>>>
>>>> On Sonntag, 20. Dezember 2009, Gaye Abdoulaye Walsimou wrote:
>>>>
>>>>> Hello list,
>>>>> I have here a boot Oops (see below) with the latest git revision of
>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git,
>>>>> which does not happen with 2.6.32.
>>>>> Thanks in advance for comments.
>>>>> Regards
>>>>>
>>> I have a patch in my git that related to that :
>>> http://repo.or.cz/w/linux-2.6/mini2440.git/commit/db47bd31f00a06370795a9d94ed973f78060841a
>>>
>>> I need to push that to the list as soon as I rebase on 2.6.33.
>>>
>>> Michael
>>>
>>
>> Dear all,
>> It is this[1] commit which breaks mini2440 board, reverting its changes
>> in mini2440 code make things working again.
>> By the way Michel, as you're mini2440 maintainer, why there is no pull
>> requests for changes in your repository [2]
>> (for example
>> http://repo.or.cz/w/linux-2.6/mini2440.git/commit/db47bd31f00a06370795a9d94ed973f78060841a)
>> ?
>>
>> Best reagrads,
>> AWG
>>
>> [1] ?ARM: S3C: Add NAND device platform data set call:
>> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=2a3a18045b136487b22733d57410e6dccd34ac84
>> [2] http://repo.or.cz/w/linux-2.6/mini2440.git
>
> fix already sent for this. see for-linus/samsung tree on git.fluff.org

Dear all,

I still get the same issue with kernel 2.6.33-rc4 (see log).
Any idea?

Regards,
Uri Yosef

Uncompressing Linux... done, booting the kernel.
Linux version 2.6.33-rc4 (uri at mylinux) (gcc version 4.4.1 (Sourcery
G++ Lite 2009q3-67) ) #1 Wed Jan 13 16:00:38 IST 2010
CPU: ARM920T [41129200] revision 0 (ARMv4T), cr=c0007177
CPU: VIVT data cache, VIVT instruction cache
Machine: MINI2440
Memory policy: ECC disabled, Data cache writeback
CPU S3C2440A (id 0x32440001)
S3C24XX Clocks, Copyright 2004 Simtec Electronics
S3C244X: core 405.000 MHz, memory 101.250 MHz, peripheral 50.625 MHz
CLOCK: Slow mode (1.500 MHz), fast, MPLL on, UPLL on
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
Kernel command line: root=/dev/mtdblock3 console=ttySAC0,115200 mini2440=1tb
PID hash table entries: 256 (order: -2, 1024 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 64MB = 64MB total
Memory: 61048KB available (3260K code, 351K data, 120K init, 0K highmem)
SLUB: Genslabs=11, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Hierarchical RCU implementation.
NR_IRQS:85
irq: clearing subpending status 00000002
Console: colour dummy device 80x30
console [ttySAC0] enabled
Calibrating delay loop... 201.93 BogoMIPS (lpj=504832)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
devtmpfs: initialized
NET: Registered protocol family 16
MINI2440: Option string mini2440=1tb
MINI2440: 't' ignored, touchscreen not compiled in
MINI2440: LCD 0:240x320 [1:800x480] 2:1024x768
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 5 [#1]
last sysfs file:
Modules linked in:
CPU: 0    Not tainted  (2.6.33-rc4 #1)
PC is at memcpy+0x64/0x29c
LR is at kmemdup+0x2c/0x34
pc : [<c01396e4>]    lr : [<c007369c>]    psr: 00000013
sp : c3823f44  ip : 0000001c  fp : 00000000
r10: 00000000  r9 : 00000000  r8 : 00000000
r7 : 00000000  r6 : 00000000  r5 : c3846b60  r4 : 00000004
r3 : c3846ae0  r2 : ffffffe4  r1 : 00000000  r0 : c3846b60
Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: c000717f  Table: 30004000  DAC: 00000017
Process swapper (pid: 1, stack limit = 0xc3822270)
Stack: (0xc3823f44 to 0xc3824000)
3f40:          c3846b60 00000000 00000000 00000000 c3846b60 00000004 c007369c
3f60: c3846ba0 c3846c00 00000000 c000ef50 00000003 0000006c c00221b8 c000d5bc
3f80: c038e430 00000002 00000003 00000001 c0373018 c0022088 00000000 00000000
3fa0: 00000000 00000000 00000000 00000000 c000b1f0 00000000 00000000 c000b208
3fc0: c0394780 c0026384 c000b1f0 00000000 c0394780 c001f0dc c001ed30 00000000
3fe0: 00000000 00000000 00000000 c00083f0 00000000 c0027874 ab74b01f 5dd0f80e
Code: e4915004 e4916004 e4917004 e4918004 (e491e004)
---[ end trace 2719ed1c00000000 ]---
