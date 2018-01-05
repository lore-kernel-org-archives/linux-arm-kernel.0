From: peng.fan@nxp.com (Peng Fan)
Date: Fri,  5 Jan 2018 17:40:35 +0800
Subject: [PATCH] ARM: imx_v6_v7_defconfig: enable OP-TEE
Message-ID: <1515145235-12062-1-git-send-email-peng.fan@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables configs for Trusted Execution Environment(TEE) and
Open Portable Trusted Execution Environment(OP-TEE).

With Linux running in Trustzone non-secure world, OP-TEE OS runs in
secure world, linux could use secure services provided by OP-TEE.
With TEE/OP-TEE options selected, use the bindings
in Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
to let the driver probe work.

On i.MX6/7, now the bootflow is U-Boot->OP-TEE->Linux, OP-TEE will
automatically create that node.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
 Tested on i.MX7D-SDB with/without OP-TEE OS.
 OP-TEE needs https://github.com/OP-TEE/optee_os/pull/2052

 arch/arm/configs/imx_v6_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 29cd1ac48987..72c4231d1b62 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -368,6 +368,8 @@ CONFIG_PWM=y
 CONFIG_PWM_FSL_FTM=y
 CONFIG_PWM_IMX=y
 CONFIG_NVMEM_IMX_OCOTP=y
+CONFIG_TEE=y
+CONFIG_OPTEE=y
 CONFIG_MUX_MMIO=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
-- 
2.14.1
