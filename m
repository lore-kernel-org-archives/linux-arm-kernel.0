From: isubramanian@apm.com (Iyappan Subramanian)
Date: Mon, 26 Oct 2015 15:25:14 -0700
Subject: [PATCH net-next v2 0/2] drivers: xgene: Add support RGMII TX/RX delay
 configuration
Message-ID: <1445898316-21372-1-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

X-Gene RGMII ethernet controller has a RGMII bridge that performs the
task of converting the RGMII signal {RX_CLK,RX_CTL, RX_DATA[3:0]} from
PHY to GMII signal {RX_DV,RX_ER,RX_DATA[7:0]} and vice versa.  This
RGMII bridge has a provision to internally delay the input RX_CLK and
the output TX_CLK using configuration registers. This will help in
maintain the CLK-CTL delay relationship in various operating
conditions.

This patch adds support RGMII TX/RX delay configuration.

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
---

Iyappan Subramanian (2):
  drivers: net: xgene: Add support RGMII TX/RX delay configuration
  Documentation: dts: xgene: Add TX/RX delay field

 .../devicetree/bindings/net/apm-xgene-enet.txt     | 10 +++++
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.c     |  8 +++-
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.h     |  1 +
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c   | 49 ++++++++++++++++++++++
 drivers/net/ethernet/apm/xgene/xgene_enet_main.h   |  2 +
 5 files changed, 69 insertions(+), 1 deletion(-)

-- 
1.9.1
