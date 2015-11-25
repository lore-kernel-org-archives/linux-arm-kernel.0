From: geliangtang@163.com (Geliang Tang)
Date: Wed, 25 Nov 2015 21:12:19 +0800
Subject: [PATCH 6/7] ARM: davinci: fix a problematic usage of WARN()
In-Reply-To: <86c73f180d3054c1bf17bdac8c89026209167c9b.1448456395.git.geliangtang@163.com>
References: <86c73f180d3054c1bf17bdac8c89026209167c9b.1448456395.git.geliangtang@163.com>
Message-ID: <06d69890c56bd84a831a1dccee26e34b4988a241.1448456395.git.geliangtang@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WARN() takes a condition and a format string. The condition was
omitted. So I added it.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 arch/arm/mach-davinci/board-dm355-evm.c     | 2 +-
 arch/arm/mach-davinci/board-dm355-leopard.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index c71dd99..e47f24c 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -385,7 +385,7 @@ static __init void dm355_evm_init(void)
 
 	aemif = clk_get(&dm355evm_dm9000.dev, "aemif");
 	if (IS_ERR(aemif))
-		WARN("%s: unable to get AEMIF clock\n", __func__);
+		WARN(1, "%s: unable to get AEMIF clock\n", __func__);
 	else
 		clk_prepare_enable(aemif);
 
diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
index 680a7a2..83b625c 100644
--- a/arch/arm/mach-davinci/board-dm355-leopard.c
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c
@@ -243,7 +243,7 @@ static __init void dm355_leopard_init(void)
 
 	aemif = clk_get(&dm355leopard_dm9000.dev, "aemif");
 	if (IS_ERR(aemif))
-		WARN("%s: unable to get AEMIF clock\n", __func__);
+		WARN(1, "%s: unable to get AEMIF clock\n", __func__);
 	else
 		clk_prepare_enable(aemif);
 
-- 
2.5.0
