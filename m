From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 15 Feb 2013 12:56:47 +0000
Subject: [PATCH 16/35] mfd: ab8500: Add more platform checks
In-Reply-To: <1360933026-30325-1-git-send-email-lee.jones@linaro.org>
References: <1360933026-30325-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1360933026-30325-17-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here we add the functionality to check for:

 - Earlier versions of the AB8505 than 2p0
 - Earlier versions of the AB9540 than 2p0

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 include/linux/mfd/abx500/ab8500.h |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/mfd/abx500/ab8500.h b/include/linux/mfd/abx500/ab8500.h
index f432cef..7e323fc 100644
--- a/include/linux/mfd/abx500/ab8500.h
+++ b/include/linux/mfd/abx500/ab8500.h
@@ -432,6 +432,16 @@ static inline int is_ab8500_2p0(struct ab8500 *ab)
 	return (is_ab8500(ab) && (ab->chip_id == AB8500_CUT2P0));
 }
 
+static inline int is_ab8505_2p0_earlier(struct ab8500 *ab)
+{
+       return (is_ab8505(ab) && (ab->chip_id < AB8500_CUT2P0));
+}
+
+static inline int is_ab9540_2p0_or_earlier(struct ab8500 *ab)
+{
+       return (is_ab9540(ab) && (ab->chip_id < AB8500_CUT2P0));
+}
+
 #ifdef CONFIG_AB8500_DEBUG
 void ab8500_dump_all_banks(struct device *dev);
 void ab8500_debug_register_interrupt(int line);
-- 
1.7.10.4
