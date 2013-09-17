From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Tue, 17 Sep 2013 10:27:41 +0100
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Fix STi support
In-Reply-To: <1379410003-9911-1-git-send-email-srinivas.kandagatla@st.com>
References: <1379410003-9911-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <1379410061-10020-1-git-send-email-srinivas.kandagatla@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch adds ST serial driver (st-asc) and ICPLUS ethernet PHY to
multi_v7_defconfig. All STi based SOCs use this as ST-ASC as default
serial console, and most of the STi SOC based boards have ICPLUS
external ethernet PHY. These two options makes the system boot with nfs
root and console.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
 arch/arm/configs/multi_v7_defconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 6e572c6..49bec9c 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -65,6 +65,7 @@ CONFIG_NET_CALXEDA_XGMAC=y
 CONFIG_KS8851=y
 CONFIG_SMSC911X=y
 CONFIG_STMMAC_ETH=y
+CONFIG_ICPLUS_PHY=y
 CONFIG_MDIO_SUN4I=y
 CONFIG_KEYBOARD_SPEAR=y
 CONFIG_SERIO_AMBAKMI=y
@@ -87,6 +88,8 @@ CONFIG_SERIAL_XILINX_PS_UART=y
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
