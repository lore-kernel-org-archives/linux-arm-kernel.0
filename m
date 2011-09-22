From: mturquette@ti.com (Mike Turquette)
Date: Thu, 22 Sep 2011 15:27:02 -0700
Subject: [PATCH v2 7/7] x86: Enable generic clk API on x86
In-Reply-To: <1316730422-20027-1-git-send-email-mturquette@ti.com>
References: <1316730422-20027-1-git-send-email-mturquette@ti.com>
Message-ID: <1316730422-20027-8-git-send-email-mturquette@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@opensource.wolfsonmicro.com>

Enable the generic clk API on x86, enabling use of the API by drivers for
x86 modules and also improving build coverage for clock API using devices.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
No change since v1

 arch/x86/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6a47bb2..571b2c5 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -73,6 +73,7 @@ config X86
 	select HAVE_BPF_JIT if (X86_64 && NET)
 	select CLKEVT_I8253
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
+	select GENERIC_CLK
 
 config INSTRUCTION_DECODER
 	def_bool (KPROBES || PERF_EVENTS)
-- 
1.7.4.1
