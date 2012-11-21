From: tushar.behera@linaro.org (Tushar Behera)
Date: Wed, 21 Nov 2012 09:02:55 +0530
Subject: [PATCH v2] ARM: gic: Fix sparse warning
Message-ID: <1353468775-3894-1-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gic_irq_domain_ops is only used in this file, so should be marked as
static.

Fixes following sparse warning.

arch/arm/common/gic.c:638:29: warning: symbol 'gic_irq_domain_ops' was
not declared. Should it be static?

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
---
Changes for V2:
* Updated commit message to specify that it was a sparse warning, not
a compilation warning.

 arch/arm/common/gic.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index aa52699..4896dec 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -635,7 +635,7 @@ static int gic_irq_domain_xlate(struct irq_domain *d,
 	return 0;
 }
 
-const struct irq_domain_ops gic_irq_domain_ops = {
+static const struct irq_domain_ops gic_irq_domain_ops = {
 	.map = gic_irq_domain_map,
 	.xlate = gic_irq_domain_xlate,
 };
-- 
1.7.4.1
