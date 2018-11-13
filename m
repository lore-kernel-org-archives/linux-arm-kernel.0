From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Tue, 13 Nov 2018 10:51:39 +0100
Subject: [PATCH 0/3] make pin-controller use hwspinlock
Message-ID: <20181113095142.32015-1-benjamin.gaignard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series allow to protect pin controller configuration registers
with a hwspinlock to avoid conflicting accesses between processors.

Benjamin Gaignard (3):
  dt-bindings: pinctrl: stm32: Document hwlocks properties
  pinctrl: stm32: protect configuration registers with a hwspinlock
  ARM: dts: stm32: Add hwlock for pinctrl

 .../bindings/pinctrl/st,stm32-pinctrl.txt          |  1 +
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi          |  1 +
 drivers/pinctrl/stm32/pinctrl-stm32.c              | 71 +++++++++++++++++++++-
 3 files changed, 72 insertions(+), 1 deletion(-)

-- 
2.15.0
