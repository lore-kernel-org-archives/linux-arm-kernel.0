From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 20 Nov 2009 10:57:16 -0500
Subject: [PATCH] [ARM] pxa: update flash structure in onenand info
Message-ID: <mailman.50.1258704715.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since flash structure is changed from flash_platform_data to
onenand_platform_data in generic driver. Update the struct in saar
and ttc platform driver.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/ttc_dkb.c |    2 +-
 arch/arm/mach-pxa/saar.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index bb26cb5..8f49b2b 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -85,7 +85,7 @@ static struct mtd_partition ttc_dkb_onenand_partitions[] = {
 	}
 };

-static struct flash_platform_data ttc_dkb_onenand_info = {
+static struct onenand_platform_data ttc_dkb_onenand_info = {
 	.parts		= ttc_dkb_onenand_partitions,
 	.nr_parts	= ARRAY_SIZE(ttc_dkb_onenand_partitions),
 };
diff --git a/arch/arm/mach-pxa/saar.c b/arch/arm/mach-pxa/saar.c
index 55c5e3a..465b51a 100644
--- a/arch/arm/mach-pxa/saar.c
+++ b/arch/arm/mach-pxa/saar.c
@@ -540,7 +540,7 @@ static struct mtd_partition saar_onenand_partitions[] = {
 	}
 };

-static struct flash_platform_data saar_onenand_info = {
+static struct onenand_platform_data saar_onenand_info = {
 	.parts		= saar_onenand_partitions,
 	.nr_parts	= ARRAY_SIZE(saar_onenand_partitions),
 };
-- 
1.5.6.5

--0016363b7984f612e20478c90646
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001--ARM-pxa-update-flash-structure-in-onenand-info.patch"
Content-Disposition: attachment; 
	filename="0001--ARM-pxa-update-flash-structure-in-onenand-info.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g294zp0p0

RnJvbSAxMGJjYTg3NjM1NDU4ZDUwODQzYWIyNjY5MzcyZDBmNTNiY2QxMzI1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYW9qaWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdAbWFydmVs
bC5jb20+CkRhdGU6IEZyaSwgMjAgTm92IDIwMDkgMTA6NTc6MTYgLTA1MDAKU3ViamVjdDogW1BB
VENIXSBbQVJNXSBweGE6IHVwZGF0ZSBmbGFzaCBzdHJ1Y3R1cmUgaW4gb25lbmFuZCBpbmZvCgpT
aW5jZSBmbGFzaCBzdHJ1Y3R1cmUgaXMgY2hhbmdlZCBmcm9tIGZsYXNoX3BsYXRmb3JtX2RhdGEg
dG8Kb25lbmFuZF9wbGF0Zm9ybV9kYXRhIGluIGdlbmVyaWMgZHJpdmVyLiBVcGRhdGUgdGhlIHN0
cnVjdCBpbiBzYWFyCmFuZCB0dGMgcGxhdGZvcm0gZHJpdmVyLgoKU2lnbmVkLW9mZi1ieTogSGFv
amlhbiBaaHVhbmcgPGhhb2ppYW4uemh1YW5nQG1hcnZlbGwuY29tPgotLS0KIGFyY2gvYXJtL21h
Y2gtbW1wL3R0Y19ka2IuYyB8ICAgIDIgKy0KIGFyY2gvYXJtL21hY2gtcHhhL3NhYXIuYyAgICB8
ICAgIDIgKy0KIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtbW1wL3R0Y19ka2IuYyBiL2FyY2gvYXJtL21h
Y2gtbW1wL3R0Y19ka2IuYwppbmRleCBiYjI2Y2I1Li44ZjQ5YjJiIDEwMDY0NAotLS0gYS9hcmNo
L2FybS9tYWNoLW1tcC90dGNfZGtiLmMKKysrIGIvYXJjaC9hcm0vbWFjaC1tbXAvdHRjX2RrYi5j
CkBAIC04NSw3ICs4NSw3IEBAIHN0YXRpYyBzdHJ1Y3QgbXRkX3BhcnRpdGlvbiB0dGNfZGtiX29u
ZW5hbmRfcGFydGl0aW9uc1tdID0gewogCX0KIH07CiAKLXN0YXRpYyBzdHJ1Y3QgZmxhc2hfcGxh
dGZvcm1fZGF0YSB0dGNfZGtiX29uZW5hbmRfaW5mbyA9IHsKK3N0YXRpYyBzdHJ1Y3Qgb25lbmFu
ZF9wbGF0Zm9ybV9kYXRhIHR0Y19ka2Jfb25lbmFuZF9pbmZvID0gewogCS5wYXJ0cwkJPSB0dGNf
ZGtiX29uZW5hbmRfcGFydGl0aW9ucywKIAkubnJfcGFydHMJPSBBUlJBWV9TSVpFKHR0Y19ka2Jf
b25lbmFuZF9wYXJ0aXRpb25zKSwKIH07CmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLXB4YS9z
YWFyLmMgYi9hcmNoL2FybS9tYWNoLXB4YS9zYWFyLmMKaW5kZXggNTVjNWUzYS4uNDY1YjUxYSAx
MDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1weGEvc2Fhci5jCisrKyBiL2FyY2gvYXJtL21hY2gt
cHhhL3NhYXIuYwpAQCAtNTQwLDcgKzU0MCw3IEBAIHN0YXRpYyBzdHJ1Y3QgbXRkX3BhcnRpdGlv
biBzYWFyX29uZW5hbmRfcGFydGl0aW9uc1tdID0gewogCX0KIH07CiAKLXN0YXRpYyBzdHJ1Y3Qg
Zmxhc2hfcGxhdGZvcm1fZGF0YSBzYWFyX29uZW5hbmRfaW5mbyA9IHsKK3N0YXRpYyBzdHJ1Y3Qg
b25lbmFuZF9wbGF0Zm9ybV9kYXRhIHNhYXJfb25lbmFuZF9pbmZvID0gewogCS5wYXJ0cwkJPSBz
YWFyX29uZW5hbmRfcGFydGl0aW9ucywKIAkubnJfcGFydHMJPSBBUlJBWV9TSVpFKHNhYXJfb25l
bmFuZF9wYXJ0aXRpb25zKSwKIH07Ci0tIAoxLjUuNi41Cgo=
--0016363b7984f612e20478c90646--
