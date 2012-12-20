From: Barry.Song@csr.com (Barry Song)
Date: Thu, 20 Dec 2012 20:13:52 +0800
Subject: [PATCH 2/9] ARM: PRIMA2: enable AUTO_ZRELADDR for SIRF in Kconfig
In-Reply-To: <1356005639-23466-1-git-send-email-Barry.Song@csr.com>
References: <1356005639-23466-1-git-send-email-Barry.Song@csr.com>
Message-ID: <1356005639-23466-3-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

prima2 and marco have different memory base address. prima2
begins from 0 and marco begins from

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 8c83d98..aa8ea1a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -396,6 +396,7 @@ config ARCH_GEMINI
 config ARCH_SIRF
 	bool "CSR SiRF"
 	select ARCH_REQUIRE_GPIOLIB
+	select AUTO_ZRELADDR
 	select COMMON_CLK
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
-- 
1.7.5.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
