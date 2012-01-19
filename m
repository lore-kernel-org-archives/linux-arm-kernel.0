From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 19 Jan 2012 19:39:22 +0100
Subject: [PATCH] mach-sa1100: add missing module_init() call
Message-ID: <1326998362-7630-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Jornada SSP driver is supposed to be initialized by a
module_init() call, but it was missed at some merge point. Since
the driver mostly pass calls through it magically works anyway,
but needs to be rectified.

Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-sa1100/jornada720_ssp.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-sa1100/jornada720_ssp.c b/arch/arm/mach-sa1100/jornada720_ssp.c
index f50b00b..b412fc0 100644
--- a/arch/arm/mach-sa1100/jornada720_ssp.c
+++ b/arch/arm/mach-sa1100/jornada720_ssp.c
@@ -198,3 +198,5 @@ static int __init jornada_ssp_init(void)
 {
 	return platform_driver_register(&jornadassp_driver);
 }
+
+module_init(jornada_ssp_init);
-- 
1.7.7.5
