From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:02:32 +0200
Subject: [PATCH] arm64: defconfig: compile ak4613 and renesas sound as modules
In-Reply-To: <cover.1501509815.git.horms+renesas@verge.net.au>
References: <cover.1501509815.git.horms+renesas@verge.net.au>
Message-ID: <140cb4111a51381f51f6cdcc97113f2d04e5939b.1501509815.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Compile the renesas sound and ak4613 drivers as modules to reduce the ARM64
kernel size. These modules are currently only used by Renesas platforms so
there should little risk of negative impact of this change on other users.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
[simon: consolidated two patches into one]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/configs/defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6c7d147eed54..a8948bb5167f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -380,8 +380,8 @@ CONFIG_SND=y
 CONFIG_SND_SOC=y
 CONFIG_SND_BCM2835_SOC_I2S=m
 CONFIG_SND_SOC_SAMSUNG=y
-CONFIG_SND_SOC_RCAR=y
-CONFIG_SND_SOC_AK4613=y
+CONFIG_SND_SOC_RCAR=m
+CONFIG_SND_SOC_AK4613=m
 CONFIG_SND_SIMPLE_CARD=y
 CONFIG_USB=y
 CONFIG_USB_OTG=y
-- 
2.1.4
