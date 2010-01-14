From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 14 Jan 2010 12:29:18 +0100
Subject: [PATCH v3] Add Samsung S5PC110 SoC support
Message-ID: <1263468579-5732-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series adds support for Samsung S5PC110 SoC. S5PC110 belongs
to S5PC1XX family (CortexA8 ARM core), but differs in many places from
the S5PC100 SoC: new memory map, different clock hierarchy, new gpio
banks and much more powerful integrated peripherals. Such differences
cannot be easily handled in the current Samsung machine&platform
framework. To avoid duplication of code and adding yet another plat-*
directory, we decided to introduce sub-platforms in the current s5pc1xx
platform.

First 9 patches prepare s5pc1xx platform code for introduction of the
new sub-platform approach. Then in the next 11 patches all core
functions and drivers are subsequently added, so S5PC110 sub-platform
gets similar level of support as S5PC100. The last patch updated
MAINTAINERS information.

This patch series has been prepared against next-s5pc100-common branch
from Ben's tree ( git://git.fluff.org/bjdooks/linux )

I hope these patches would be accepted together with recent S5PC6440
patches, so we would be able to start working together on dev-table
support for all Samsung SoCs.

Changes since v2

S5PC110 code has been adapted for all Samsung platform framework changes
(clksrc and common irq support).

Changes since v1

The following issues reported by Ben have been fixed: gpiolib support has
been rewriten, more SoC specific files have been moved to mach-s5pc*
directories (gpio chip, plls and clocks definitions). Also author/sender
issues are resolved.

The clock issue in S5PC110 driver has not been addressed. The driver
uses clock API in the same way as it is handled in other Samsung UART
drivers. This clock issue should be resolved in a separate patch which
would fix all Samsung drivers at once. Until then we would like to use
the current approach.

This patch series includes:

[PATCH 01/21] drivers: serial: S5PC100 serial driver cleanup
[PATCH 02/21] ARM: S5PC100: use 0x30008000 as memory base
[PATCH 03/21] ARM: S5PC1XX: create sub-platform for S5PC100 SoCs
[PATCH 04/21] ARM: S5PC1XX: prepare common cpu&clocks code for S5PC110 sub-platform
[PATCH 05/21] ARM: S5PC1XX: prepare common gpiolib code for S5PC110 sub-platform
[PATCH 06/21] ARM: S5PC1XX: move common s5pc1xx mach/* includes to plat-s5pc1xx/include/mach
[PATCH 07/21] ARM: S5PC1XX: cleanup of s5pc1xx common code
[PATCH 08/21] ARM: S5PC1XX: move s5pc100 specific device helpers to mach-s5pc100 dir
[PATCH 09/21] ARM: S5PC1XX: move common s5pc1xx s3c-fb regs to platform directory
[PATCH 10/21] drivers: serial: add support for Samsung S5PC110 SoC uart
[PATCH 11/21] ARM: S5PC1XX: add S5PC110 memory map
[PATCH 12/21] ARM: S5PC1XX: add S5PC110 cpu initialization code
[PATCH 13/21] ARM: S5PC1XX: add support for s5pc110 plls and clocks
[PATCH 14/21] ARM: S5PC1XX: add support for s5pc110 irqs
[PATCH 15/21] ARM: S5PC1XX: add support for s5pc110 gpio
[PATCH 16/21] ARM: S5PC1XX: add i2c platform helpers on s5pc110 sub-platform
[PATCH 17/21] ARM: S5PC1XX: enable S5PC110 sub-platform
[PATCH 18/21] ARM: S5PC1XX: add sdhci platform helpers for s5pc110 sub-platform
[PATCH 19/21] ARM: S5PC1XX: add framebuffer platform helpers for s5pc110 sub-platform
[PATCH 20/21] ARM: S5PC1XX: add support for SMDKC110 board
[PATCH 21/21] MAINTAINERS: add ARM/S5PC100 and ARM/S5PC110 architectures
