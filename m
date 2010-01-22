From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 22 Jan 2010 08:11:36 +0100
Subject: [PATCH v3 0/9] ARM: S5PV210: Add support for Samsung's S5PV210 CPU
In-Reply-To: <007101ca9af8$c9d273e0$5d775ba0$%kim@samsung.com>
References: <007101ca9af8$c9d273e0$5d775ba0$%kim@samsung.com>
Message-ID: <009601ca9b32$2532b270$6f981750$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Friday, January 22, 2010 1:21 AM Kukjin Kim wrote:

> This patch set adds support for Samsung's S5PV210 CPU. The S5PV210 integrates
> a ARM Cortex A8 microprocessor with several other peripherals to support
> features such as multimedia, storage, graphics and gaming. The S5PV210 can be
> used in products such as Netbooks and Mobile devices.
> 
> This patch set consists of the following patches.
> 
> [PATCH v3 1/9] ARM: S5PV210: Add Samsung S5PV210 CPU support
> [PATCH v3 2/9] ARM: S5PV210: Add clock support for S5PV210
> [PATCH v3 3/9] ARM: S5PV210: Add IRQ support
> [PATCH v3 4/9] ARM: S5PV210: Update Kconfig and Makefiles
> [PATCH v3 5/9] ARM: S5PV210: Add SMDKV210 board support file
> [PATCH v3 6/9] ARM: S5PV210: Add SMDKC110 board support file
> [PATCH v3 7/9] ARM: S5PV210: Add S5PV210 configuration file
> [PATCH v3 8/9] ARM: S5PV210: Add S5PC110 configuration file
> [PATCH v3 9/9] ARM: S5PV210: Add serial port support

What about a patch changing the value of ARM_L1_CACHE_SHIFT to 6
if S5PV210/S5PC110 arch is selected? At least S5PC110 has 64bit of
L1 cache line size so all kmalloced areas should be properly
aligned to cache line size to avoid cache aliasing (especially
when doing DMA transfers).
 
Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
