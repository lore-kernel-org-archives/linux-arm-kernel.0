From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 3 Mar 2011 15:47:14 +0530
Subject: [PATCH V2 01/13] dw_dmac: Remove compilation dependency from AVR32
	and put on HAVE_CLK
In-Reply-To: <cover.1299146382.git.viresh.kumar@st.com>
References: <cover.1299146382.git.viresh.kumar@st.com>
Message-ID: <25131616c787e711b89733b4098cde7207b696de.1299146382.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver will now be used in atleast two platforms AVR32 & ARM. And there is
no actual hardware dependency of this driver over AVR32 or ARM. So this
dependency can be removed altogether.

Also dw_dmac driver uses clk framework and must have compilation dependency on
HAVE_CLK

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/dma/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 1c28816..3822fe1 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -82,7 +82,7 @@ config INTEL_IOP_ADMA
 
 config DW_DMAC
 	tristate "Synopsys DesignWare AHB DMA support"
-	depends on AVR32
+	depends on HAVE_CLK
 	select DMA_ENGINE
 	default y if CPU_AT32AP7000
 	help
-- 
1.7.2.2
