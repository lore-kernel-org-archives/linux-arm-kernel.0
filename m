From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 29 Mar 2013 16:59:52 +0900
Subject: [PATCH 00/03 v4] ARM: shmobile: r8a73a4 APE6EVM board support
Message-ID: <20130329075952.15748.6290.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: r8a73a4 APE6EVM board support (V4)

[PATCH 01/03 v3] ARM: shmobile: APE6EVM base support
[PATCH 02/03 v2] ARM: shmobile: APE6EVM PFC support
[PATCH 03/03 v3] ARM: shmobile: APE6EVM LAN9220 support

This series is V4 of initial support for the APE6EVM board.

The APE6EVM board makes use of the r8a73a4 SoC and has a
couple of different I/O devices on board, but with this
series only support for the SCIFA0 UART and the Ethernet
chip is included.

In the future support for more I/O devices will be added as
incremental feature patches.

Changes since V3:
- Make use of 64-bit DT addresses

Changes since V2:
- Use PINCTRL instead of function GPIOs.
- Modify bootargs to enable DHCP and NFS root.
- Now depends on r8a73a4 PFC V2

Changes since V1:
- Went from single patch to series
- Use ape6evm_add_standard_devices() to setup SoC devices and clocks
- Use PFC to configure SCIFA0
- Add Ethernet support including PFC support

For more details please see the individual patches.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas-next-20130329 in renesas.git
 
 Depends on the following patch:
 [PATCH] ARM: shmobile: r8a73a4 SoC 64-bit DT support

 arch/arm/boot/dts/Makefile             |    1 
 arch/arm/boot/dts/r8a73a4-ape6evm.dts  |   54 ++++++++++++++++++
 arch/arm/mach-shmobile/Kconfig         |    8 ++
 arch/arm/mach-shmobile/Makefile        |    1 
 arch/arm/mach-shmobile/board-ape6evm.c |   94 ++++++++++++++++++++++++++++++++
 5 files changed, 156 insertions(+), 2 deletions(-)
