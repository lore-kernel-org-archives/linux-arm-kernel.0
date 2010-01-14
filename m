From: walsimou@walsimou.com (Gaye Abdoulaye Walsimou)
Date: Thu, 14 Jan 2010 08:12:55 +0100
Subject: kernel boot failure on with s32440/mini2440 with git head
	(dd59f6c76b2)
In-Reply-To: <4B4E5646.20300@simtec.co.uk>
References: <4B2E4A65.8070207@walsimou.com>	
	<200912211410.12014.jbe@pengutronix.de>	
	<dc447790912210526l3247b8fdxfc3f7c4c99706b04@mail.gmail.com>	
	<4B37A6D4.9000301@walsimou.com> <4B4217E7.5000207@simtec.co.uk>
	<c7df016d1001130624s596ad2d3ub302f2bcea481234@mail.gmail.com>
	<4B4E5646.20300@simtec.co.uk>
Message-ID: <4B4EC3F7.8060908@walsimou.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben Dooks wrote:
>>
>> Dear all,
>>
>> I still get the same issue with kernel 2.6.33-rc4 (see log).
>> Any idea?
>>
>> Regards,
>> Uri Yosef
>>
>> Uncompressing Linux... done, booting the kernel.
>> Linux version 2.6.33-rc4 (uri at mylinux) (gcc version 4.4.1 (Sourcery
>> G++ Lite 2009q3-67) ) #1 Wed Jan 13 16:00:38 IST 2010
>> CPU: ARM920T [41129200] revision 0 (ARMv4T), cr=c0007177
>> CPU: VIVT data cache, VIVT instruction cache
>> Machine: MINI2440
>> Memory policy: ECC disabled, Data cache writeback
>> CPU S3C2440A (id 0x32440001)
>> S3C24XX Clocks, Copyright 2004 Simtec Electronics
>> S3C244X: core 405.000 MHz, memory 101.250 MHz, peripheral 50.625 MHz
>> CLOCK: Slow mode (1.500 MHz), fast, MPLL on, UPLL on
>> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
>> Kernel command line: root=/dev/mtdblock3 console=ttySAC0,115200 mini2440=1tb
>> PID hash table entries: 256 (order: -2, 1024 bytes)
>> Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
>> Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
>> Memory: 64MB = 64MB total
>> Memory: 61048KB available (3260K code, 351K data, 120K init, 0K highmem)
>> SLUB: Genslabs=11, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
>> Hierarchical RCU implementation.
>> NR_IRQS:85
>> irq: clearing subpending status 00000002
>> Console: colour dummy device 80x30
>> console [ttySAC0] enabled
>> Calibrating delay loop... 201.93 BogoMIPS (lpj=504832)
>> Mount-cache hash table entries: 512
>> CPU: Testing write buffer coherency: ok
>> devtmpfs: initialized
>> NET: Registered protocol family 16
>> MINI2440: Option string mini2440=1tb
>> MINI2440: 't' ignored, touchscreen not compiled in
>> MINI2440: LCD 0:240x320 [1:800x480] 2:1024x768
>> Unable to handle kernel NULL pointer dereference at virtual address 00000000
>> pgd = c0004000
>> [00000000] *pgd=00000000
>> Internal error: Oops: 5 [#1]
>> last sysfs file:
>> Modules linked in:
>> CPU: 0    Not tainted  (2.6.33-rc4 #1)
>> PC is at memcpy+0x64/0x29c
>> LR is at kmemdup+0x2c/0x34
>>     
>
> This looks like a new issue to me, please compile your kernel
> with sufficient debug information so that a full backtrace can
> be generated and we can find out where this is happening.
>
>   

No this is not a new issue, it's the same I reported. As I said
previously reverting
the changes introduced by commit[1] in mini2440 code, make the board to
be able boot again.

[1]  ARM: S3C: Add NAND device platform data set call:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=2a3a18045b136487b22733d57410e6dccd34ac84

Best regards,
AWG
