From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 12 Nov 2018 16:18:53 +0100
Subject: [PATCH v2 10/10] arm64: defconfig: Enable Tegra TCU
In-Reply-To: <20181112151853.29289-1-thierry.reding@gmail.com>
References: <20181112151853.29289-1-thierry.reding@gmail.com>
Message-ID: <20181112151853.29289-11-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

The Tegra Combined UART is used on some Tegra194 devices as a way of
multiplexing output from multiple producers onto a single physical UART.
Enable this by default so that it can be used as the default console to
write kernel messages to.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c0a5275210c7..fdb9d60905ac 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -300,6 +300,7 @@ CONFIG_SERIAL_MESON_CONSOLE=y
 CONFIG_SERIAL_SAMSUNG=y
 CONFIG_SERIAL_SAMSUNG_CONSOLE=y
 CONFIG_SERIAL_TEGRA=y
+CONFIG_SERIAL_TEGRA_TCU=y
 CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_MSM=y
 CONFIG_SERIAL_MSM_CONSOLE=y
-- 
2.19.1
