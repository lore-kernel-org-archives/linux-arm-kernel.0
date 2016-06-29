From: broonie@kernel.org (Mark Brown)
Date: Wed, 29 Jun 2016 19:05:31 +0100
Subject: Applied "ARM: dts: meson: minix-neo-x8: define PMIC as power
 controller" to the regulator tree
In-Reply-To: <20160605001749.4062-2-stefan@agner.ch>
Message-ID: <E1bIJrf-0003iU-F2@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ARM: dts: meson: minix-neo-x8: define PMIC as power controller

has been applied to the regulator tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 229d641d72d1ecfd21186a52c38d012149097eec Mon Sep 17 00:00:00 2001
From: Stefan Agner <stefan@agner.ch>
Date: Tue, 28 Jun 2016 22:53:18 -0700
Subject: [PATCH] ARM: dts: meson: minix-neo-x8: define PMIC as power
 controller

The PMIC driver used to register itself as poweroff controller by
default, hence assuming that this device is using the PMIC as
system power controller.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Acked-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/meson8-minix-neo-x8.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/meson8-minix-neo-x8.dts b/arch/arm/boot/dts/meson8-minix-neo-x8.dts
index 4f536bb1f002..8bceb8d343f6 100644
--- a/arch/arm/boot/dts/meson8-minix-neo-x8.dts
+++ b/arch/arm/boot/dts/meson8-minix-neo-x8.dts
@@ -80,6 +80,7 @@
 	pmic at 32 {
 		compatible = "ricoh,rn5t618";
 		reg = <0x32>;
+		system-power-controller;
 
 		regulators {
 		};
-- 
2.8.1
