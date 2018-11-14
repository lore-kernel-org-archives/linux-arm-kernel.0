From: geoff@infradead.org (Geoff Levand)
Date: Wed, 14 Nov 2018 12:40:37 -0800
Subject: [PATCH 2/2] arm64: Enable HW_RANDOM_VIRTIO in defconfig
In-Reply-To: <b5ec42f8-b736-0fd4-628a-180fe9a8b55e@infradead.org>
References: <b5ec42f8-b736-0fd4-628a-180fe9a8b55e@infradead.org>
Message-ID: <90284e75-b20d-1f66-c050-eb4aa3cff6ec@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When testing in QEMU its often nice to have a good random
number device.  Enable HW_RANDOM_VIRTIO to allow host
random number devices to be accessible in the QEMU guest.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 94b704716c2e..a9321a7e575a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -318,6 +318,7 @@ CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
 CONFIG_SERIAL_MVEBU_UART=y
 CONFIG_SERIAL_DEV_BUS=y
 CONFIG_VIRTIO_CONSOLE=y
+CONFIG_HW_RANDOM_VIRTIO=m
 CONFIG_TCG_TPM=y
 CONFIG_TCG_TIS_I2C_INFINEON=y
 CONFIG_I2C_CHARDEV=y
-- 
2.17.1
