From: rnayak@ti.com (Rajendra Nayak)
Date: Wed, 16 Feb 2011 14:56:35 +0530
Subject: [PATCH] OMAP2+: PM: Enable all clk autoidle only if CONFIG_PM
Message-ID: <mailman.145.1297849114.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Autoidle for all clocks is disabled during clock
framework initialization.
Enable them here (late in the boot process) only
if CONFIG_PM is enabled.

While here, also update the comment to remove
the TODO's which are already addressed.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/pm.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index b507702..f888986 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -262,13 +262,14 @@ static int __init omap2_common_pm_late_init(void)
 	/* Smartreflex device init */
 	omap_devinit_smartreflex();

+#ifdef CONFIG_PM
 	/*
-	 * Set all OMAP3/4 DPLLs to autoidle.
-	 * XXX TODO: Add all the iclk autoidles in here as well,
-	 * the OMAP2 DPLL, the OMAP2 APLLs, and the AUTOEXTCLKMODE
-	 * control here too.
+	 * Set all OMAP2/3/4 DPLLs to autoidle.
+	 * Set OMAP2 APLLs, and the AUTOEXTCLKMODE to autoidle.
+	 * Set all the iclk autoidle,
 	 */
 	omap_clk_enable_autoidle_all();
+#endif

 	return 0;
 }
-- 
1.7.0.4

--0016368e29f72cfb64049c6308f9
Content-Type: application/octet-stream; 
	name="0001-OMAP2-PM-Enable-all-clk-autoidle-only-if-CONFIG_PM.patch"
Content-Disposition: attachment; 
	filename="0001-OMAP2-PM-Enable-all-clk-autoidle-only-if-CONFIG_PM.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: cae10b18c864105_0.1

RnJvbSA1NzJiZjk1Y2Y0YWEzZDNhMWM3MzI1NGY2N2UyN2U2MmYxMDhmNGUxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYWplbmRyYSBOYXlhayA8cm5heWFrQHRpLmNvbT4KRGF0ZTog
V2VkLCAxNiBGZWIgMjAxMSAxNDo1NjozNSArMDUzMApTdWJqZWN0OiBbUEFUQ0hdIE9NQVAyKzog
UE06IEVuYWJsZSBhbGwgY2xrIGF1dG9pZGxlIG9ubHkgaWYgQ09ORklHX1BNCgpBdXRvaWRsZSBm
b3IgYWxsIGNsb2NrcyBpcyBkaXNhYmxlZCBkdXJpbmcgY2xvY2sKZnJhbWV3b3JrIGluaXRpYWxp
emF0aW9uLgpFbmFibGUgdGhlbSBoZXJlIChsYXRlIGluIHRoZSBib290IHByb2Nlc3MpIG9ubHkK
aWYgQ09ORklHX1BNIGlzIGVuYWJsZWQuCgpXaGlsZSBoZXJlLCBhbHNvIHVwZGF0ZSB0aGUgY29t
bWVudCB0byByZW1vdmUKdGhlIFRPRE8ncyB3aGljaCBhcmUgYWxyZWFkeSBhZGRyZXNzZWQuCgpT
aWduZWQtb2ZmLWJ5OiBSYWplbmRyYSBOYXlhayA8cm5heWFrQHRpLmNvbT4KLS0tCiBhcmNoL2Fy
bS9tYWNoLW9tYXAyL3BtLmMgfCAgICA5ICsrKysrLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1v
bWFwMi9wbS5jIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9wbS5jCmluZGV4IGI1MDc3MDIuLmY4ODg5
ODYgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gtb21hcDIvcG0uYworKysgYi9hcmNoL2FybS9t
YWNoLW9tYXAyL3BtLmMKQEAgLTI2MiwxMyArMjYyLDE0IEBAIHN0YXRpYyBpbnQgX19pbml0IG9t
YXAyX2NvbW1vbl9wbV9sYXRlX2luaXQodm9pZCkKIAkvKiBTbWFydHJlZmxleCBkZXZpY2UgaW5p
dCAqLwogCW9tYXBfZGV2aW5pdF9zbWFydHJlZmxleCgpOwogCisjaWZkZWYgQ09ORklHX1BNCiAJ
LyoKLQkgKiBTZXQgYWxsIE9NQVAzLzQgRFBMTHMgdG8gYXV0b2lkbGUuCi0JICogWFhYIFRPRE86
IEFkZCBhbGwgdGhlIGljbGsgYXV0b2lkbGVzIGluIGhlcmUgYXMgd2VsbCwKLQkgKiB0aGUgT01B
UDIgRFBMTCwgdGhlIE9NQVAyIEFQTExzLCBhbmQgdGhlIEFVVE9FWFRDTEtNT0RFCi0JICogY29u
dHJvbCBoZXJlIHRvby4KKwkgKiBTZXQgYWxsIE9NQVAyLzMvNCBEUExMcyB0byBhdXRvaWRsZS4K
KwkgKiBTZXQgT01BUDIgQVBMTHMsIGFuZCB0aGUgQVVUT0VYVENMS01PREUgdG8gYXV0b2lkbGUu
CisJICogU2V0IGFsbCB0aGUgaWNsayBhdXRvaWRsZSwKIAkgKi8KIAlvbWFwX2Nsa19lbmFibGVf
YXV0b2lkbGVfYWxsKCk7CisjZW5kaWYKIAogCXJldHVybiAwOwogfQotLSAKMS43LjAuNAoK
--0016368e29f72cfb64049c6308f9--
