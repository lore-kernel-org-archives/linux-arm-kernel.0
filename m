From: srinivas.kandagatla@st.com (srinivas.kandagatla at st.com)
Date: Wed, 4 Dec 2013 13:10:13 +0000
Subject: [PATCH] ARM: multi_v7_defconfig: Fix STi support
Message-ID: <1386162613-13492-1-git-send-email-srinivas.kandagatla@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch adds ST serial driver (st-asc) and ICPLUS ethernet PHY to
multi_v7_defconfig. All STi based SOCs use ST-ASC as default serial
console, and most of the STi SOC based boards have ICPLUS external
ethernet PHY. These two options makes the system boot nfs root with
console.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
 arch/arm/configs/multi_v7_defconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 4a5903e..d5a6f32 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -68,6 +68,7 @@ CONFIG_NET_CALXEDA_XGMAC=y
 CONFIG_KS8851=y
 CONFIG_SMSC911X=y
 CONFIG_STMMAC_ETH=y
+CONFIG_ICPLUS_PHY=y
 CONFIG_MDIO_SUN4I=y
 CONFIG_KEYBOARD_SPEAR=y
 CONFIG_SERIO_AMBAKMI=y
@@ -90,6 +91,8 @@ CONFIG_SERIAL_XILINX_PS_UART=y
 CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
 CONFIG_SERIAL_FSL_LPUART=y
 CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
+CONFIG_SERIAL_ST_ASC=y
+CONFIG_SERIAL_ST_ASC_CONSOLE=y
 CONFIG_I2C_DESIGNWARE_PLATFORM=y
 CONFIG_I2C_SIRF=y
 CONFIG_I2C_TEGRA=y
-- 
1.7.6.5
