From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 20 Nov 2009 14:42:32 +0100
Subject: [PATCH v2] Add Samsung S5PC110 SoC support
In-Reply-To: <1258551194-16018-1-git-send-email-m.szyprowski@samsung.com>
References: <1258551194-16018-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1258724572-19176-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This preliminary patch series adds support for Samsung S5PC110 SoC.
S5PC110 belongs to S5PC1XX family (CortexA8 ARM core), but differs in
many places from the S5PC100 SoC: new memory map, different clock
hierarchy, new gpio banks and much more powerful integrated peripherals.
Such differences cannot be easily handled in the current Samsung
machine&platform framework. To avoid duplication of code and adding yet
another plat-* directory, we decided to introduce sub-platforms in
the current s5pc1xx platform.

First 8 patches prepare s5pc1xx platform code for introduction of the
new sub-platform approach. Then in the next 11 patches all core
functions and drivers are subsequently added, so S5PC110 sub-platform
gets similar level of support as S5PC100. The last patch updated
MAINTAINERS information.

This patch series has been prepared against latest ARM Kernel tree from
http://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-2.6-arm.git/

This is the second version of this patch series. The following issues
reported by Ben have been fixed: gpiolib support has been rewriten, more
SoC specific files have been moved to mach-s5pc* directories (gpio chip,
plls and clocks definitions). Also author/sender issues are resolved.

The clock issue in S5PC110 driver has not been addressed. The driver
uses clock API in the same way as it is handled in other Samsung UART
drivers. This clock issue should be resolved in a separate patch which
would fix all Samsung drivers at once. Until then we would like to use
the current approach.

This patch series includes:

[PATCH 01/20] ARM: S5PC100: use 0x30008000 as memory base
[PATCH 02/20] ARM: S5PC1XX: create sub-platform for S5PC100 SoCs
[PATCH 03/20] ARM: S5PC1XX: prepare common cpu&clocks code for S5PC110 sub-platform
[PATCH 04/20] ARM: S5PC1XX: prepare common gpiolib code for S5PC110 sub-platform
[PATCH 05/20] ARM: S5PC1XX: move common s5pc1xx mach/* includes to plat-s5pc1xx/include/mach
[PATCH 06/20] ARM: S5PC1XX: cleanup of s5pc1xx common code
[PATCH 07/20] ARM: S5PC1XX: move s5pc100 specific device helpers to mach-s5pc100 dir
[PATCH 08/20] ARM: S5PC1XX: move common s5pc1xx s3c-fb regs to platform directory
[PATCH 09/20] drivers: serial: add support for Samsung S5PC110 SoC uart
[PATCH 10/20] ARM: S5PC1XX: add S5PC110 memory map
[PATCH 11/20] ARM: S5PC1XX: add S5PC110 cpu initialization code
[PATCH 12/20] ARM: S5PC1XX: add support for s5pc110 plls and clocks
[PATCH 13/20] ARM: S5PC1XX: add support for s5pc110 irqs
[PATCH 14/20] ARM: S5PC1XX: add support for s5pc110 gpio
[PATCH 15/20] ARM: S5PC1XX: add i2c platform helpers on s5pc110 sub-platform
[PATCH 16/20] ARM: S5PC1XX: enable S5PC110 sub-platform
[PATCH 17/20] ARM: S5PC1XX: add sdhci platform helpers for s5pc110 sub-platform
[PATCH 18/20] ARM: S5PC1XX: add framebuffer platform helpers for s5pc110 sub-platform
[PATCH 19/20] ARM: S5PC1XX: add support for SMDKC110 board
[PATCH 20/20] MAINTAINERS: add ARM/S5PC100 and ARM/S5PC110 architectures
