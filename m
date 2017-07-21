From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Fri, 21 Jul 2017 13:22:00 +0200
Subject: [PATCH v2 0/4] RGMII RX and TX clock delays using Atheros 8035
Message-ID: <2617d673-ef81-5e7f-4730-ed3aa3f1c2c6@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes from v1
- Drop support for disabling RX and TX clock delays
(it breaks some boards). Document the issues instead.
- Split the MAC patch in two unrelated parts
- Fix the vantage 1172 DTS

Marc Gonzalez (4):
  net: phy: at803x: Document RGMII RX and TX clock delay issues
  net: ethernet: nb8800: Set RGMII_MODE for all RGMII modes
  net: ethernet: nb8800: Fix RGMII TX clock delay setup
  ARM: dts: tango4: Add RGMII RX and TX clock delays

 arch/arm/boot/dts/tango4-vantage-1172.dts |  2 +-
 drivers/net/ethernet/aurora/nb8800.c      |  8 +++++---
 drivers/net/phy/at803x.c                  | 12 ++++++++++++
 3 files changed, 18 insertions(+), 4 deletions(-)

-- 
2.11.0
