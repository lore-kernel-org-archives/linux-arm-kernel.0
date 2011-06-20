From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 20 Jun 2011 14:40:29 +0100
Subject: [PATCH 4/4] ARM: Documentation: clarify entry requirements for ARM
	versus Thumb-2
In-Reply-To: <1308577229-23681-1-git-send-email-dave.martin@linaro.org>
References: <1308577229-23681-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1308577229-23681-5-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the kernel entry requirements are not explicit about
whether the kernel should be entered in ARM or Thumb-2.

Now that the boot protocol consistently requires the kernel Image
or zImage to be entered in ARM state, document this requirement
explicitly.

A different rule will be needed for Cortex-M class CPUs as and when
support for these lands upstream, since these CPUs don't support
the ARM instruction set at all: a note is added to the effect that
the kernel must be entered in Thumb on such systems.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 Documentation/arm/Booting |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/arm/Booting b/Documentation/arm/Booting
index 4e686a2..a341d87 100644
--- a/Documentation/arm/Booting
+++ b/Documentation/arm/Booting
@@ -164,3 +164,8 @@ In either case, the following conditions must be met:
 - The boot loader is expected to call the kernel image by jumping
   directly to the first instruction of the kernel image.
 
+  On CPUs supporting the ARM instruction set, the entry must be
+  made in ARM state, even for a Thumb-2 kernel.
+
+  On CPUs supporting only the Thumb instruction set such as
+  Cortex-M class CPUs, the entry must be made in Thumb state.
-- 
1.7.4.1
