From: carlo@caione.org (Carlo Caione)
Date: Sun,  4 May 2014 16:02:38 +0200
Subject: [PATCH 0/2] ARM: sunxi: Enable syscon for the system controller
Message-ID: <1399212160-26934-1-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The so called "system controller" in Allwinner A20 and A31 SoCs is
multi-purpose controller that tries to add misc functionality to one
memory region.
In these SoCs it controls the internal SRAM partitioning but it also
includes registers for chip versioning and NMI control.
This patch adds the proper nodes in the DTS files and enable the syscon
in the defconfig files.

Even though the system controller includes also register for managing the
NMI controller, these register are not mapped in the syscon since they
are directly used and mapped by the NMI controller itself.

Carlo Caione (2):
  ARM: sunxi: dts: Enable syscon in DTSI
  ARM: sunxi: Add syscon support in defconfig

 arch/arm/boot/dts/sun6i-a31.dtsi    | 5 +++++
 arch/arm/boot/dts/sun7i-a20.dtsi    | 5 +++++
 arch/arm/configs/multi_v7_defconfig | 1 +
 arch/arm/configs/sunxi_defconfig    | 1 +
 4 files changed, 12 insertions(+)

-- 
1.8.3.2
