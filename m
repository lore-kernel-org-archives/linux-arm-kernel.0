From: broonie@kernel.org (Mark Brown)
Date: Thu, 14 Aug 2014 20:57:16 +0100
Subject: [PATCH] arm64: configs: Enable X-Gene SATA and ethernet in defconfig
Message-ID: <1408046236-21005-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

Currently when run on an APM platform the ARMv8 defconfig has no viable
options for rootfs other than ramdisk which is rather limiting. Since
we already have both SATA and the bits needed for NFS root enabled we just
need to enable the relevant drivers so do that, helping enable direct
testing of upstream.

If the configuration ends up becoming too big we can consider modularising
some of the drivers and asking people to use an initramfs but for now this
is not an issue.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 1e52b741d806..d92ef3c54161 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -64,6 +64,8 @@ CONFIG_VIRTIO_BLK=y
 CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_ATA=y
+CONFIG_AHCI_XGENE=y
+CONFIG_PHY_XGENE=y
 CONFIG_PATA_PLATFORM=y
 CONFIG_PATA_OF_PLATFORM=y
 CONFIG_NETDEVICES=y
@@ -71,6 +73,7 @@ CONFIG_TUN=y
 CONFIG_VIRTIO_NET=y
 CONFIG_SMC91X=y
 CONFIG_SMSC911X=y
+CONFIG_NET_XGENE=y
 # CONFIG_WLAN is not set
 CONFIG_INPUT_EVDEV=y
 # CONFIG_SERIO_SERPORT is not set
-- 
2.0.1
