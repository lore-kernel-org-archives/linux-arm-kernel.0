From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Fri, 25 Feb 2011 14:38:31 +0100
Subject: [PATCH 6/6] eukrea_mbimxsd51: add SD Card detect
In-Reply-To: <1298641111-12957-1-git-send-email-eric@eukrea.com>
References: <1298641111-12957-1-git-send-email-eric@eukrea.com>
Message-ID: <1298641111-12957-6-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
index fe70e76..04927ff 100644
--- a/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
+++ b/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
@@ -103,6 +103,10 @@ static iomux_v3_cfg_t eukrea_mbimxsd_pads[] = {
 	MX51_PAD_DI1_D1_CS__GPIO3_4,
 	/* LCD RST */
 	MX51_PAD_CSI1_D9__GPIO3_13,
+	/* SD1 CD */
+	_MX51_PAD_GPIO1_0__SD1_CD | MUX_PAD_CTRL(PAD_CTL_PUS_22K_UP |
+			PAD_CTL_PKE | PAD_CTL_SRE_FAST |
+			PAD_CTL_DSE_HIGH | PAD_CTL_PUE | PAD_CTL_HYS),
 };
 
 #define GPIO_LED1	IMX_GPIO_NR(3, 30)
-- 
1.7.4
