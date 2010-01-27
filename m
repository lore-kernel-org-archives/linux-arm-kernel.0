From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 27 Jan 2010 19:09:50 +0900
Subject: [PATCH v4 0/8] ARM: S5PV210: Add support for Samsung's S5PV210 CPU
Message-ID: <009d01ca9f38$df32bdf0$9d9839d0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch set adds support for Samsung's S5PV210 CPU. The S5PV210 integrates
a ARM Cortex A8 microprocessor with several other peripherals to support
features such as multimedia, storage, graphics and gaming. The S5PV210 can be
used in products such as Netbooks and Mobile devices.

This patch set consists of the following patches.

[PATCH v4 1/8] ARM: S5PV210: Add Samsung S5PV210 CPU support
[PATCH v4 2/8] ARM: S5PV210: Add clock support for S5PV210
[PATCH v4 3/8] ARM: S5PV210: Add IRQ support	
[PATCH v4 4/8] ARM: S5PV210: Update Kconfig and Makefiles
[PATCH v4 5/8] ARM: S5PV210: Add SMDKV210 board support file
[PATCH v4 6/8] ARM: S5PV210: Add SMDKC110 board support file
[PATCH v4 7/8] ARM: S5PV210: Add S5PV210 configuration file
[PATCH v4 8/8] ARM: S5PV210: Add S5PC110 configuration file


Changes since v3 :

1. Removed unnecessary CONFIG_CPU_S5PV210_INIT, CONFIG_CPU_S5PV210_CLOCK, and
CONFIG_S5PC110_XXX_TYPE.
2. Renamed mach-s5pv210/s5pv210-init.c and s5pv210-clock.c to just
mach-s5pv210/init.c and clock.c
3. Common macros are used such as S3C_PA_XXX and S3C_VA_XXX
4. Renamed S5P_VA_VICx definitions as VA_VICx
5. Removed unnecessary definitions in the header files like map.h
6. Added v210 specific debug macros.
7. Added VIC2 and VIC3 definitions.
8. Applied Marek's suggestion about ARM_L1_CACHE_SHIFT value changing to 6
9. Separated serial support patch which can be applied to S5PV210/S5PC110,
and S5P6442.
10. Fixed Makefiles as per Ben's suggestion.


Changes since v2 :

1. Use SPARSEMEM as Russell suggested.
2. Fixed code as per comments from Ben in linux-samsung-soc mailing list.


Changes since v1 :

1. Removed mach/s5pv210/include/mach/gpio-core.h file.
2. Removed unused clock gate defines.
3. Removed machine fixup code from smdkv210 and smdkc110 board support.
4. Merged Kconfig and Makefiles with other source code patches.
5. Replaced multiple definition of UART info with macro.


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
System LSI Division, SAMSUNG ELECTRONICS CO., LTD.
