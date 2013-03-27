From: Barry.Song@csr.com (Barry Song)
Date: Wed, 27 Mar 2013 11:06:39 +0800
Subject: [PATCH] arm: prima2: export sirfsoc_reset_device as the common API of
 drivers
Message-ID: <1364353599-30731-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "renwei.wu" <renwei.wu@csr.com>

sirfsoc_reset_device() should be an API used by other SiRF drivers.
This patch exports it.
devices who want to reset just need to add reset_bit in .dts.

Signed-off-by: Renwei Wu <Renwei.Wu@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/mach-prima2/rstc.c |    1 +
 include/linux/sirfsoc_rst.h |    6 ++++++
 2 files changed, 7 insertions(+), 0 deletions(-)
 create mode 100644 include/linux/sirfsoc_rst.h

diff --git a/arch/arm/mach-prima2/rstc.c b/arch/arm/mach-prima2/rstc.c
index 435019c..6c40913 100644
--- a/arch/arm/mach-prima2/rstc.c
+++ b/arch/arm/mach-prima2/rstc.c
@@ -79,6 +79,7 @@ int sirfsoc_reset_device(struct device *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL(sirfsoc_reset_device);
 
 #define SIRFSOC_SYS_RST_BIT  BIT(31)
 
diff --git a/include/linux/sirfsoc_rst.h b/include/linux/sirfsoc_rst.h
new file mode 100644
index 0000000..b29017a
--- /dev/null
+++ b/include/linux/sirfsoc_rst.h
@@ -0,0 +1,6 @@
+#ifndef _SIRFSOC_RST_H_
+#define _SIRFSOC_RST_H_
+
+int sirfsoc_reset_device(struct device *dev);
+
+#endif
-- 
1.7.5.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
