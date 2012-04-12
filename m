From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 12 Apr 2012 11:13:45 -0700
Subject: [PATCH] arm: vic.c: local variables should not be exposed globally
Message-ID: <201204121113.45642.hartleys@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The variable 'vic_syscore_ops' is only referenced in this file and
should be marked static to prevent it from being exposed globally.

This quiets the sparse waring:

warning: symbol 'vic_syscore_ops' was not declared. Should it be static?

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
index 7e288f9..9dc2183 100644
--- a/arch/arm/common/vic.c
+++ b/arch/arm/common/vic.c
@@ -142,7 +142,7 @@ static int vic_suspend(void)
 	return 0;
 }
 
-struct syscore_ops vic_syscore_ops = {
+static struct syscore_ops vic_syscore_ops = {
 	.suspend	= vic_suspend,
 	.resume		= vic_resume,
 };
