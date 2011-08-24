From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 24 Aug 2011 14:15:59 +0100
Subject: [PATCH 11/11] x86: Enable generic clk API on x86
In-Reply-To: <1314191759-16941-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20110824131324.GB16520@opensource.wolfsonmicro.com>
	<1314191759-16941-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1314191759-16941-11-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the generic clk API on x86, enabling use of the API by drivers for
x86 modules and also improving build coverage for clock API using devices.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/x86/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ff6d4e7..02ece2e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -74,6 +74,7 @@ config X86
 	select HAVE_BPF_JIT if (X86_64 && NET)
 	select CLKEVT_I8253
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
+	select GENERIC_CLK
 
 config INSTRUCTION_DECODER
 	def_bool (KPROBES || PERF_EVENTS)
-- 
1.7.5.4
