From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Wed, 20 Jul 2016 20:26:11 +0530
Subject: [net-next PATCH 0/3] add support for impedance control for TI dp83867
 phy and fix 2nd ethernet on dra72 rev C evm
Message-ID: <20160720145614.13132-1-mugunthanvnm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for configurable impedance control for TI dp83867
phy via devicetree. More documentation in [1]
CPSW second ethernet is not working, fix it by enabling
impedance configuration on the phy.

Public Datasheet - http://www.ti.com/lit/ds/symlink/dp83867ir.pdf

Mugunthan V N (3):
  net: phy: dp83867: Add documentation for optional impedance control
  net: phy: dp83867: add support for MAC impedance configuration
  ARM: dts: dra72-evm-revc: fix non-working cpsw second ethernet

 .../devicetree/bindings/net/ti,dp83867.txt         |  7 +++++++
 arch/arm/boot/dts/dra72-evm-revc.dts               |  2 ++
 drivers/net/phy/dp83867.c                          | 22 ++++++++++++++++++++++
 3 files changed, 31 insertions(+)

-- 
2.9.2.368.g08bb350
