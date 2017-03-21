From: broonie@kernel.org (Mark Brown)
Date: Tue, 21 Mar 2017 18:45:36 +0000
Subject: Applied "ARM: dts: sun8i: Update audio-routing with renamed widgets"
 to the asoc tree
In-Reply-To: <20170309095602.13809-4-mylene.josserand@free-electrons.com>
Message-ID: <E1cqOmm-00016S-N3@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ARM: dts: sun8i: Update audio-routing with renamed widgets

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From eb3abaea7ea42619a48fa84e4b1ff48f1b18d863 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?=
 <mylene.josserand@free-electrons.com>
Date: Sat, 18 Mar 2017 08:55:09 +0100
Subject: [PATCH] ARM: dts: sun8i: Update audio-routing with renamed widgets
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The digital AIF interfaces has been renamed in the sun8i audio codec
driver so the audio-routing in the device tree must be renamed too.

Signed-off-by: Myl??ne Josserand <mylene.josserand@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm/boot/dts/sun8i-a33.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index 18c174fef84f..0467fb365bfc 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -113,8 +113,8 @@
 		simple-audio-card,mclk-fs = <512>;
 		simple-audio-card,aux-devs = <&codec_analog>;
 		simple-audio-card,routing =
-			"Left DAC", "Digital Left DAC",
-			"Right DAC", "Digital Right DAC";
+			"Left DAC", "AIF1 Slot 0 Left",
+			"Right DAC", "AIF1 Slot 0 Right";
 		status = "disabled";
 
 		simple-audio-card,cpu {
-- 
2.11.0
