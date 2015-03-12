From: peter@hurleysoftware.com (Peter Hurley)
Date: Thu, 12 Mar 2015 08:33:40 -0400
Subject: [PATCH] n_tty: use kmalloc() instead of vmalloc() to avoid crash
 on armada-xp
In-Reply-To: <5500502A.5060905@list.ru>
References: <54FF21BE.2040506@list.ru>
 <20150310171751.GD13687@e104818-lin.cambridge.arm.com>
 <54FF2986.6020503@list.ru> <20150310173807.GU8656@n2100.arm.linux.org.uk>
 <55003569.1010200@list.ru> <20150311124730.GZ8656@n2100.arm.linux.org.uk>
 <5500502A.5060905@list.ru>
Message-ID: <550187A4.8010704@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/2015 10:24 AM, Stas Sergeev wrote:
> However, while testing, I've suddenly got another crash happened
> a bit earlier than the previous one used to happen: (OOM? How??)
> ---
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 4.0.0-rc2-00137-gb672c98-dirty
> (root at host-010-117) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) )
> #2 SMP 5
> [    0.000000] CPU: ARMv7 Processor [562f5842] revision 2 (ARMv7),
> cr=10c5387d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction
> cache
> [    0.000000] Machine model: Marvell Armada XP Development Board
> DB-MV784MP-GP
> [    0.000000] Ignoring memory block 0x100000000 - 0x200000000

Once you patch your bootloader, you'll want to configure your kernel
for CONFIG_ARM_LPAE=y to enable the high 4GB of memory you have, as
it's being ignored in this config right now (as shown above and in
the oom message below).

> [    7.055570] Mem-info:
[...]
> [    7.314368] 983040 pages of RAM

Regards,
Peter Hurley
