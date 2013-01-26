From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 26 Jan 2013 16:43:59 +0100
Subject: [PATCH v2 3/3] arm: kirkwood: Enable cpufreq and ondemand on
 kirkwood_defconfig
In-Reply-To: <1359215039-2848-1-git-send-email-andrew@lunn.ch>
References: <1359215039-2848-1-git-send-email-andrew@lunn.ch>
Message-ID: <1359215039-2848-4-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a cpufreq driver for kirkwood, enable it in
kirkwood_defconfig and set the default governer to ondemand.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/configs/kirkwood_defconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
index 93f3794..6ecb7de 100644
--- a/arch/arm/configs/kirkwood_defconfig
+++ b/arch/arm/configs/kirkwood_defconfig
@@ -55,6 +55,9 @@ CONFIG_AEABI=y
 # CONFIG_OABI_COMPAT is not set
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_STAT_DETAILS=y
+CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_CPU_IDLE=y
 CONFIG_NET=y
 CONFIG_PACKET=y
-- 
1.7.10.4
