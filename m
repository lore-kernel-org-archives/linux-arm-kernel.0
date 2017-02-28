From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 28 Feb 2017 17:15:12 +0100
Subject: [PATCH v3 0/4] ARM: dts: da850-evm: vpif DT changes
Message-ID: <1488298516-14363-1-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds necessary changes to make vpif work on the da850-evm
board.

The first patch only contains whitespace error fixes.

The second patch add a pinctrl node for vpif display pins.

The third adds the UI expander node that is needed to select the video
capture functionality.

The last patch extends the vpif node with an output port.

v1 -> v2:
- used enable-gpios property instead of gpio hogs
- renamed the UI expander
- corrected the commit message in patch 2/4

v2 -> v3:
- removed the enable-gpios property - it may take some more time to
  determine the correct solution for enable-gpios, so I decided to
  respin the series without it and send it later as a follow-up

Bartosz Golaszewski (4):
  ARM: dts: da850-evm: fix whitespace errors
  ARM: dts: da850: add vpif video display pins
  ARM: dts: da850-evm: add the UI expander node
  ARM: dts: da850-evm: add the output port to the vpif node

 arch/arm/boot/dts/da850-evm.dts | 31 +++++++++++++++++++++----------
 arch/arm/boot/dts/da850.dtsi    | 25 ++++++++++++++++++++++---
 2 files changed, 43 insertions(+), 13 deletions(-)

-- 
2.9.3
