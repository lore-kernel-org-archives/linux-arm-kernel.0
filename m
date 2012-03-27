From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Mar 2012 08:56:00 +0100
Subject: [PATCH v8 RESEND] ARM: net: JIT compiler for packet filters
In-Reply-To: <20120325133506.GG5611@n2100.arm.linux.org.uk>
References: <1331933316-10197-1-git-send-email-mgherzan@gmail.com>
 <20120319.172005.1889334604020296555.davem@davemloft.net>
 <4F6EEAB5.7070009@gmail.com> <20120325095711.GC5611@n2100.arm.linux.org.uk>
 <4F6F19C2.60602@gmail.com> <20120325133506.GG5611@n2100.arm.linux.org.uk>
Message-ID: <20120327075600.GL5611@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mircea, could you please supply an ack for the below fix to silence a
warning.  Thanks.

8<=====
ARM: fix Kconfig warning for HAVE_BPF_JIT

Last night's randconfig and the allnoconfig builds spat out the
following warning while building:

warning: (ARM) selects HAVE_BPF_JIT which has unmet direct dependencies (NET)

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9e21b6e..6a54606 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -33,7 +33,7 @@ config ARM
 	select GENERIC_IRQ_SHOW
 	select CPU_PM if (SUSPEND || CPU_IDLE)
 	select GENERIC_PCI_IOMAP
-	select HAVE_BPF_JIT
+	select HAVE_BPF_JIT if NET
 	help
 	  The ARM series is a line of low-power-consumption RISC chip designs
 	  licensed by ARM Ltd and targeted at embedded applications and
