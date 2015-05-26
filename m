From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 26 May 2015 14:52:19 +0100
Subject: [PATCHv3 01/12] arm/arm64: kvm: add missing PSCI include
In-Reply-To: <1432648350-5454-1-git-send-email-mark.rutland@arm.com>
References: <1432648350-5454-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1432648350-5454-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We make use of the PSCI function IDs, but don't explicitly include the
header which defines them. Relying on transitive header includes is
fragile and will be broken as headers are refactored.

This patch includes the relevant header file directly so as to avoid
future breakage.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/psci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
index 02fa8ef..7e9398c 100644
--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -24,6 +24,8 @@
 #include <asm/kvm_psci.h>
 #include <asm/kvm_host.h>
 
+#include <uapi/linux/psci.h>
+
 /*
  * This is an implementation of the Power State Coordination Interface
  * as described in ARM document number ARM DEN 0022A.
-- 
1.9.1
