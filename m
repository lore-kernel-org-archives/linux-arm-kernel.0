From: prakity@marvell.com (Philip Rakity)
Date: Mon, 20 Dec 2010 14:42:22 -0800
Subject: [PATCH] mach-mmp: Enable multiple platform support for SD/MMC cloc=
Message-ID: <mailman.90.1293002165.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

k adjustment

Set timing for brownstone for SD/MMC cards to enable detection

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 arch/arm/mach-mmp/brownstone.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.=
c
index 1f11744..e4e458c 100644
--- a/arch/arm/mach-mmp/brownstone.c
+++ b/arch/arm/mach-mmp/brownstone.c
@@ -142,14 +142,22 @@ static struct i2c_board_info brownstone_twsi1_info[] =
=3D {
 };
=20
 static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc0 =3D {
-	.max_speed	=3D 25000000,
+	.adjust_clocks	=3D 1,
+	.clk_select	=3D 1,
+	.clk_delay	=3D 31,
 };
=20
 static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc1 =3D {
+	.adjust_clocks	=3D 1,
+	.clk_select	=3D 1,
+	.clk_delay	=3D 15,
 	.flags		=3D PXA_FLAG_CARD_PERMANENT,
 };
=20
 static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc2 =3D {
+	.adjust_clocks	=3D 1,
+	.clk_select	=3D 1,
+	.clk_delay	=3D 15,
 	.flags		=3D PXA_FLAG_CARD_PERMANENT |
 				PXA_FLAG_SD_8_BIT_CAPABLE_SLOT,
 };
--=20
1.6.0.4

--_002_A649508723A4480FB6B820D8B3FC3750marvellcom_
Content-Type: application/octet-stream;
	name="0013-mach-mmp-Enable-multiple-platform-support-for-SD-MM.patch"
Content-Description: 0013-mach-mmp-Enable-multiple-platform-support-for-SD-MM.patch
Content-Disposition: attachment;
	filename="0013-mach-mmp-Enable-multiple-platform-support-for-SD-MM.patch";
	size=1255; creation-date="Tue, 21 Dec 2010 23:09:37 GMT";
	modification-date="Tue, 21 Dec 2010 23:09:37 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyNjk5NmQwMGQ2YTNjOTY3NjU4MTYyOTdlYzNmMTU3NjhhODk3N2Q5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaGlsaXAgUmFraXR5IDxwcmFraXR5QG1hcnZlbGwuY29tPgpE
YXRlOiBNb24sIDIwIERlYyAyMDEwIDE0OjQyOjIyIC0wODAwClN1YmplY3Q6IFtQQVRDSF0gbWFj
aC1tbXA6IEVuYWJsZSBtdWx0aXBsZSBwbGF0Zm9ybSBzdXBwb3J0IGZvciBTRC9NTUMgY2xvY2sg
YWRqdXN0bWVudAoKU2V0IHRpbWluZyBmb3IgYnJvd25zdG9uZSBmb3IgU0QvTU1DIGNhcmRzIHRv
IGVuYWJsZSBkZXRlY3Rpb24KClNpZ25lZC1vZmYtYnk6IFBoaWxpcCBSYWtpdHkgPHByYWtpdHlA
bWFydmVsbC5jb20+Ci0tLQogYXJjaC9hcm0vbWFjaC1tbXAvYnJvd25zdG9uZS5jIHwgICAxMCAr
KysrKysrKystCiAxIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW1tcC9icm93bnN0b25lLmMgYi9hcmNoL2Fy
bS9tYWNoLW1tcC9icm93bnN0b25lLmMKaW5kZXggMWYxMTc0NC4uZTRlNDU4YyAxMDA2NDQKLS0t
IGEvYXJjaC9hcm0vbWFjaC1tbXAvYnJvd25zdG9uZS5jCisrKyBiL2FyY2gvYXJtL21hY2gtbW1w
L2Jyb3duc3RvbmUuYwpAQCAtMTQyLDE0ICsxNDIsMjIgQEAgc3RhdGljIHN0cnVjdCBpMmNfYm9h
cmRfaW5mbyBicm93bnN0b25lX3R3c2kxX2luZm9bXSA9IHsKIH07CiAKIHN0YXRpYyBzdHJ1Y3Qg
c2RoY2lfcHhhX3BsYXRkYXRhIG1tcDJfc2RoX3BsYXRkYXRhX21tYzAgPSB7Ci0JLm1heF9zcGVl
ZAk9IDI1MDAwMDAwLAorCS5hZGp1c3RfY2xvY2tzCT0gMSwKKwkuY2xrX3NlbGVjdAk9IDEsCisJ
LmNsa19kZWxheQk9IDMxLAogfTsKIAogc3RhdGljIHN0cnVjdCBzZGhjaV9weGFfcGxhdGRhdGEg
bW1wMl9zZGhfcGxhdGRhdGFfbW1jMSA9IHsKKwkuYWRqdXN0X2Nsb2Nrcwk9IDEsCisJLmNsa19z
ZWxlY3QJPSAxLAorCS5jbGtfZGVsYXkJPSAxNSwKIAkuZmxhZ3MJCT0gUFhBX0ZMQUdfQ0FSRF9Q
RVJNQU5FTlQsCiB9OwogCiBzdGF0aWMgc3RydWN0IHNkaGNpX3B4YV9wbGF0ZGF0YSBtbXAyX3Nk
aF9wbGF0ZGF0YV9tbWMyID0geworCS5hZGp1c3RfY2xvY2tzCT0gMSwKKwkuY2xrX3NlbGVjdAk9
IDEsCisJLmNsa19kZWxheQk9IDE1LAogCS5mbGFncwkJPSBQWEFfRkxBR19DQVJEX1BFUk1BTkVO
VCB8CiAJCQkJUFhBX0ZMQUdfU0RfOF9CSVRfQ0FQQUJMRV9TTE9ULAogfTsKLS0gCjEuNi4wLjQK
Cg==

--_002_A649508723A4480FB6B820D8B3FC3750marvellcom_--
