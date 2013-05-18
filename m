From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sat, 18 May 2013 19:21:18 +0200
Subject: ARM: 3.10-rc1 does not boot anymore on OpenBlocks AX3
In-Reply-To: <20130518170158.GB1936@1wt.eu>
References: <20130518170158.GB1936@1wt.eu>
Message-ID: <5197B88E.1050305@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Willy,

On 05/18/2013 07:01 PM, Willy Tarreau wrote:
> Hi Gregory,
> 
> I wanted to give a try to your marvell-pcie-v10-and-seb-clks branch on
> my AX3 and got the following error, which I also got after switching
> back to plain 3.10-rc1 :
> 
> Uncompressing Linux... done, booting the kernel.
> Booting Linux on physical CPU 0x0
> Linux version 3.10.0-rc-mvebu (willy at pcw) (gcc version 4.7.3 20130205 (prerelease) (crosstool-NG 1.18.0) ) #6 SMP Sat May 18 17:40:55 CEST 2013
> CPU: ARMv7 Processor [562f5842] revision 2 (ARMv7), cr=10c53c7d
> CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
> Machine: Marvell Armada 370/XP (Device Tree), model: PlatHome OpenBlocks AX3-4 board
> bootconsole [earlycon0] enabled
> INITRD: 0x07000040+0x00a5c000 is not a memory region - disabling initrd
> Memory policy: ECC disabled, Data cache writealloc
> Kernel panic - not syncing: ERROR: Failed to allocate 0x1000 bytes below 0x0.

This is a known issue (at least by me! ;) ).
You have 2 choices:
- either you disable CONFIG_ARM_APPENDED_DTB
- or you appliy the patch "ARM: zImage: Convert 32bits memory size
 and address from ATAG to 64bits DTB"
see https://patchwork.kernel.org/patch/2566771/

This patch have been applied by Russell King in his git tree, and I hope
he will push it soon to Linus for the 3.10-rc2.

By the way I also sent an other fix for led and gpio button:
https://patchwork.kernel.org/patch/2582531/

Regards,


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
