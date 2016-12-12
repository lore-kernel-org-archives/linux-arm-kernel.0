From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Tue, 13 Dec 2016 00:14:29 +0530
Subject: [PATCH 0/2] ARM: v7-A !MMU fixes for fun (&fame)
In-Reply-To: <20161211131028.3019-1-afzal.mohd.ma@gmail.com>
References: <20161211131028.3019-1-afzal.mohd.ma@gmail.com>
Message-ID: <20161212184429.GA5219@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Dec 11, 2016 at 06:40:28PM +0530, Afzal Mohammed wrote:

> Kernel reached the stage of invoking user space init & panicked, though
> it could not reach till prompt for want of user space executables
> 
> So far i have not come across a toolchain (or a way to create toolchain)
> to create !MMU user space executables for Cortex-A.

Now able to reach prompt using buildroot initramfs, Thanks to
Peter Korsgaard for suggesting the way to create user space executables
for !MMU Cortex-A.

> multi_v7_defconfig was used & all platforms except TI OMAP/AM/DM/DRA &
> Freescale i.MX family was deselected. ARM_MPU option was disabled as
> Vladimir had given an early warning. DRAM_BASE was set to 0x80000000.
> During the course of bringup, futex was causing issues, hence FUTEX was
> removed. L1 & L2 caches were disabled in config. High vectors were
> disabled & vectors were made to remap to base of RAM. An additional OMAP
> specific change to avoid one ioremap was also required.

For the sake of completeness,
SMP was disabled & flat binary support enabled in Kernel.

Regards
afzal
