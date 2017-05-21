From: ralph.sennhauser@gmail.com (Ralph Sennhauser)
Date: Sun, 21 May 2017 14:49:01 +0200
Subject: [PATCH 12/13] clk: mvebu: add support for 1866MHz variants
In-Reply-To: <20170521124903.11050-1-ralph.sennhauser@gmail.com>
References: <20170521124903.11050-1-ralph.sennhauser@gmail.com>
Message-ID: <20170521124903.11050-13-ralph.sennhauser@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Linksys WRT3200ACM CPU is clocked at 1866MHz. Add 1866MHz to
the list of supported CPU frequencies.

Noticed by the following warning:
[    0.000000] Selected CPU frequency (16) unsupported

Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
---
 drivers/clk/mvebu/armada-38x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mvebu/armada-38x.c b/drivers/clk/mvebu/armada-38x.c
index 8bccf4e..6a92eb6 100644
--- a/drivers/clk/mvebu/armada-38x.c
+++ b/drivers/clk/mvebu/armada-38x.c
@@ -49,7 +49,8 @@ static const u32 armada_38x_cpu_frequencies[] __initconst = {
 	0, 0, 0, 0,
 	1066 * 1000 * 1000, 0, 0, 0,
 	1332 * 1000 * 1000, 0, 0, 0,
-	1600 * 1000 * 1000,
+	1600 * 1000 * 1000, 0, 0, 0,
+	1866 * 1000 * 1000
 };
 
 static u32 __init armada_38x_get_cpu_freq(void __iomem *sar)
-- 
2.10.2
