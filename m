From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 20 Aug 2012 22:19:59 +0800
Subject: [PATCH 5/6] ARM: mxs: select SPARSE_IRQ
In-Reply-To: <1345472400-31262-1-git-send-email-shawn.guo@linaro.org>
References: <1345472400-31262-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1345472400-31262-6-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With icoll and gpio interrupt controllers adopt irqdomain support and
all interrupt nubmers are retrieved from device tree, it's save to
select SPARSE_IRQ for mxs now.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7207086..58bffb3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -491,6 +491,7 @@ config ARCH_MXS
 	select HAVE_CLK_PREPARE
 	select MULTI_IRQ_HANDLER
 	select PINCTRL
+	select SPARSE_IRQ
 	select USE_OF
 	help
 	  Support for Freescale MXS-based family of processors
-- 
1.7.5.4
