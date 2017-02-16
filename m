From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Thu, 16 Feb 2017 19:15:28 +0100
Subject: [PATCH 0/4] ARM: dts: da850-evm: vpif DT changes
Message-ID: <1487268932-6469-1-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds necessary changes to make vpif work on the da850-evm
board.

The first patch only contains whitespace error fixes.

The second patch add a pinctrl node for vpif display pins.

The third patch extends the vpif node with an output port.

The last patch adds the UI expander node and GPIO hogs that are needed
to select video capture functionality.

The last patch might not be the correct approach - if we wanted to
select camera input we'd need to have separate dts files in the
future.

In board file mode this is done at GPIO expander setup. We can't use
pdata quirks neither as they are called before the expander is probed.

Any ideas are welcome.

Bartosz Golaszewski (4):
  ARM: dts: da850-evm: fix whitespace errors
  ARM: dts: da850: add vpif video display pins
  ARM: dts: da850-evm: add the output port to the vpif node
  ARM: dts: da850-evm: add the UI expander node

 arch/arm/boot/dts/da850-evm.dts | 52 ++++++++++++++++++++++++++++++++++-------
 arch/arm/boot/dts/da850.dtsi    | 25 +++++++++++++++++---
 2 files changed, 65 insertions(+), 12 deletions(-)

-- 
2.9.3
