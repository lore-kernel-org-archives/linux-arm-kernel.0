From: prakity@marvell.com (Philip Rakity)
Date: Sun, 19 Dec 2010 20:23:02 -0800
Subject: [PATCH] sdhci: enable CAP support for SD/eMMC/Wifi cards that are =
Message-ID: <mailman.78.1293002007.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

marked permanent

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci-pxa.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
index 4c2a252..1a58c7b 100644
--- a/drivers/mmc/host/sdhci-pxa.c
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -136,6 +136,11 @@ static int __devinit sdhci_pxa_probe(struct platform_d=
evice *pdev)
 	if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
 		host->mmc->caps |=3D MMC_CAP_8_BIT_DATA;
=20
+	if (pdata->flags & PXA_FLAG_CARD_PERMANENT) {
+		host->mmc->caps |=3D MMC_CAP_NONREMOVABLE;
+		host->quirks |=3D SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+	}
+
 	/* do not rely on u-boot to enable the clocks */
 	enable_clock(host);
=20
--=20
1.6.0.4



--_002_C62C801BBA494DC893C942EC8A69BBB2marvellcom_
Content-Type: application/octet-stream;
	name="0011-sdhci-enable-CAP-support-for-SD-eMMC-Wifi-cards-tha.patch"
Content-Description: 0011-sdhci-enable-CAP-support-for-SD-eMMC-Wifi-cards-tha.patch
Content-Disposition: attachment;
	filename="0011-sdhci-enable-CAP-support-for-SD-eMMC-Wifi-cards-tha.patch";
	size=991; creation-date="Tue, 21 Dec 2010 23:09:19 GMT";
	modification-date="Tue, 21 Dec 2010 23:09:19 GMT"
Content-Transfer-Encoding: base64

RnJvbSAzNmI5MDFjZGU5NGVlYmVjMGVlYjU0YTBmOGUyYTkxMjMyYTg2YmIwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaGlsaXAgUmFraXR5IDxwcmFraXR5QG1hcnZlbGwuY29tPgpE
YXRlOiBTdW4sIDE5IERlYyAyMDEwIDIwOjIzOjAyIC0wODAwClN1YmplY3Q6IFtQQVRDSF0gc2Ro
Y2k6IGVuYWJsZSBDQVAgc3VwcG9ydCBmb3IgU0QvZU1NQy9XaWZpIGNhcmRzIHRoYXQgYXJlIG1h
cmtlZCBwZXJtYW5lbnQKClNpZ25lZC1vZmYtYnk6IFBoaWxpcCBSYWtpdHkgPHByYWtpdHlAbWFy
dmVsbC5jb20+Ci0tLQogZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1weGEuYyB8ICAgIDUgKysrKysK
IDEgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktcHhhLmMgYi9kcml2ZXJzL21tYy9ob3N0L3Nk
aGNpLXB4YS5jCmluZGV4IDRjMmEyNTIuLjFhNThjN2IgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbW1j
L2hvc3Qvc2RoY2ktcHhhLmMKKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1weGEuYwpAQCAt
MTM2LDYgKzEzNiwxMSBAQCBzdGF0aWMgaW50IF9fZGV2aW5pdCBzZGhjaV9weGFfcHJvYmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAlpZiAocGRhdGEtPmZsYWdzICYgUFhBX0ZMQUdf
U0RfOF9CSVRfQ0FQQUJMRV9TTE9UKQogCQlob3N0LT5tbWMtPmNhcHMgfD0gTU1DX0NBUF84X0JJ
VF9EQVRBOwogCisJaWYgKHBkYXRhLT5mbGFncyAmIFBYQV9GTEFHX0NBUkRfUEVSTUFORU5UKSB7
CisJCWhvc3QtPm1tYy0+Y2FwcyB8PSBNTUNfQ0FQX05PTlJFTU9WQUJMRTsKKwkJaG9zdC0+cXVp
cmtzIHw9IFNESENJX1FVSVJLX0JST0tFTl9DQVJEX0RFVEVDVElPTjsKKwl9CisKIAkvKiBkbyBu
b3QgcmVseSBvbiB1LWJvb3QgdG8gZW5hYmxlIHRoZSBjbG9ja3MgKi8KIAllbmFibGVfY2xvY2so
aG9zdCk7CiAKLS0gCjEuNi4wLjQKCg==

--_002_C62C801BBA494DC893C942EC8A69BBB2marvellcom_--
