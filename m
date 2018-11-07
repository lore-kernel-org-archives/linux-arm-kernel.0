From: marc.w.gonzalez@free.fr (Marc Gonzalez)
Date: Wed, 7 Nov 2018 21:19:03 +0100
Subject: [PATCH 9/9] arm64: defconfig: Drop redundant sound codec options
In-Reply-To: <8b49a92b-ca92-1fca-cd09-3bcd7a3dcbb9@free.fr>
References: <8b49a92b-ca92-1fca-cd09-3bcd7a3dcbb9@free.fr>
Message-ID: <8fa3ac06-aec1-1a27-b166-1c68b56a26ac@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SND_SOC_RK3399_GRU_SOUND selects SND_SOC_DA7219, SND_SOC_MAX98357A,
SND_SOC_RT5514, SND_SOC_RT5514_SPI.

SND_SOC_ROCKCHIP_RT5645 selects SND_SOC_RT5645.

SND_SOC_RL6231 is pulled in for SND_SOC_RT5514 and SND_SOC_RT5645.

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 arch/arm64/configs/defconfig | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 75d5ed7ea53d..4910b76f1002 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -499,12 +499,6 @@ CONFIG_SND_SOC_RK3399_GRU_SOUND=m
 CONFIG_SND_SOC_SAMSUNG=y
 CONFIG_SND_SOC_RCAR=m
 CONFIG_SND_SOC_AK4613=m
-CONFIG_SND_SOC_DA7219=m
-CONFIG_SND_SOC_MAX98357A=m
-CONFIG_SND_SOC_RL6231=m
-CONFIG_SND_SOC_RT5514=m
-CONFIG_SND_SOC_RT5514_SPI=m
-CONFIG_SND_SOC_RT5645=m
 CONFIG_SND_SIMPLE_CARD=m
 CONFIG_SND_AUDIO_GRAPH_CARD=m
 CONFIG_I2C_HID=m
-- 
2.17.1
