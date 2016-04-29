From: isubramanian@apm.com (Iyappan Subramanian)
Date: Fri, 29 Apr 2016 11:10:12 -0700
Subject: [PATCH v2 0/3] drivers: net: xgene: fix: Get channel number from
 device binding
Message-ID: <1461953415-9741-1-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds 'channel' property to get ethernet to CPU channel number,
thus decoupling the Linux driver from static resource selection.

v2: Address review comments from v1
- removed irq reference from Linux driver
- added 'channel' property to get ethernet to CPU channel number

v1:
- Initial version

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
---

Iyappan Subramanian (3):
  drivers: net: xgene: Get channel number from device binding
  Documentation: dtb: xgene: Add channel property
  dtb: xgene: Add channel property

 Documentation/devicetree/bindings/net/apm-xgene-enet.txt |  2 ++
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi               |  1 +
 arch/arm64/boot/dts/apm/apm-storm.dtsi                   |  1 +
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c         | 15 ++++++++++++++-
 4 files changed, 18 insertions(+), 1 deletion(-)

-- 
1.9.1
