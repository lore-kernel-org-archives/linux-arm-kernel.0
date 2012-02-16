From: rubini@gnudd.com (Alessandro Rubini)
Date: Thu, 16 Feb 2012 17:05:25 +0100
Subject: [PATCH] ARM: amba: don't include <asm/sizes.h>
Message-ID: <20120216160525.GA30558@mail.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The file uses no SZ_* symbol and some architectures miss sizes.h

Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
---

There a number of files including but not using it. This one
in particular I need under x86 so the fix is trivial.

However, I remember different feelings about sizes.h . Should it die
or should it proliferate to other archs using asm-generic/sizes.h ?


 drivers/amba/bus.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 01c2cf4..928f80f 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -18,7 +18,6 @@
 #include <linux/amba/bus.h>
 
 #include <asm/irq.h>
-#include <asm/sizes.h>
 
 #define to_amba_driver(d)	container_of(d, struct amba_driver, drv)
 
-- 
1.7.7.2
