From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 15 Sep 2010 22:40:19 +0530
Subject: [PATCH] omap: Update and rename common defconfig for omap2plus dev=
Message-ID: <mailman.240.1284575173.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ices

This patch addresses below things:
- Renaming existing omap3_defconfig which has OMAP2, OMAP3 and OMAP4 builds
  enabled to more appropriate name 'omap2plus_defconfig'
- L1 cache shift is suppose to be 5 on OMAP4 where as it is 6 on previous
  OMAPs. Keeping it to 5 is safer option for OMAP4 and previous OMAPs. For
  OMAP3 only build the shift would be still 6
- Enable needed Errata's for OMAP4 to work with DMA based device drivers
	CONFIG_PL310_ERRATA_588369=3Dy
	CONFIG_ARM_ERRATA_720789=3Dy
- Enable the Micrel ethernet controller
	CONFIG_KS8851=3Dy
	CONFIG_KS8851_MLL=3Dy

With above three changes, OMAP4 ethernet, mmc etc works reliably.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 .../{omap3_defconfig =3D> omap2plus_defconfig}       |    3 +++
 arch/arm/mach-omap2/Kconfig                        |    4 +++-
 2 files changed, 6 insertions(+), 1 deletions(-)
 rename arch/arm/configs/{omap3_defconfig =3D> omap2plus_defconfig} (99%)

diff --git a/arch/arm/configs/omap3_defconfig b/arch/arm/configs/omap2plus_=
defconfig
similarity index 99%
rename from arch/arm/configs/omap3_defconfig
rename to arch/arm/configs/omap2plus_defconfig
index 833a9bc..3d27dd0 100644
--- a/arch/arm/configs/omap3_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -53,6 +53,7 @@ CONFIG_MACH_SBC3530=3Dy
 CONFIG_MACH_OMAP_3630SDP=3Dy
 CONFIG_MACH_OMAP_4430SDP=3Dy
 CONFIG_ARM_THUMBEE=3Dy
+CONFIG_ARM_L1_CACHE_SHIFT=3D5
 CONFIG_NO_HZ=3Dy
 CONFIG_HIGH_RES_TIMERS=3Dy
 CONFIG_SMP=3Dy
@@ -139,6 +140,8 @@ CONFIG_SMSC_PHY=3Dy
 CONFIG_NET_ETHERNET=3Dy
 CONFIG_SMC91X=3Dy
 CONFIG_SMSC911X=3Dy
+CONFIG_KS8851=3Dy
+CONFIG_KS8851_MLL=3Dy
 CONFIG_LIBERTAS=3Dy
 CONFIG_LIBERTAS_USB=3Dy
 CONFIG_LIBERTAS_SDIO=3Dy
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index b48bacf..bb85f24 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -35,7 +35,7 @@ config ARCH_OMAP3
 	default y
 	select CPU_V7
 	select USB_ARCH_HAS_EHCI
-	select ARM_L1_CACHE_SHIFT_6
+	select ARM_L1_CACHE_SHIFT_6 if !ARCH_OMAP4
=20
 config ARCH_OMAP4
 	bool "TI OMAP4"
@@ -43,6 +43,8 @@ config ARCH_OMAP4
 	depends on ARCH_OMAP2PLUS
 	select CPU_V7
 	select ARM_GIC
+	select PL310_ERRATA_588369
+	select ARM_ERRATA_720789
=20
 comment "OMAP Core Type"
 	depends on ARCH_OMAP2
--=20
1.6.0.4


--_002_EAF47CD23C76F840A9E7FCE10091EFAB02CD25FF3Bdbde02enttico_
Content-Type: application/octet-stream;
	name="0001-omap-Update-and-rename-common-defconfig-for-omap2pl.patch"
Content-Description: 0001-omap-Update-and-rename-common-defconfig-for-omap2pl.patch
Content-Disposition: attachment;
	filename="0001-omap-Update-and-rename-common-defconfig-for-omap2pl.patch";
	size=2501; creation-date="Thu, 16 Sep 2010 00:01:20 GMT";
	modification-date="Thu, 16 Sep 2010 00:01:20 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyNmM5MDhjZDliYWYzY2MwYjIyZjA0ZjI5Y2JlYjI2ZTA4YWQwNWU4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYW50b3NoIFNoaWxpbWthciA8c2FudG9zaC5zaGlsaW1rYXJA
dGkuY29tPgpEYXRlOiBXZWQsIDE1IFNlcCAyMDEwIDIyOjQwOjE5ICswNTMwClN1YmplY3Q6IFtQ
QVRDSF0gb21hcDogVXBkYXRlIGFuZCByZW5hbWUgY29tbW9uIGRlZmNvbmZpZyBmb3Igb21hcDJw
bHVzIGRldmljZXMKClRoaXMgcGF0Y2ggYWRkcmVzc2VzIGJlbG93IHRoaW5ncwoKLSBSZW5hbWlu
ZyBleGlzdGluZyBvbWFwM19kZWZjb25maWcgd2hpY2ggaGFzIE9NQVAyLCBPTUFQMyBhbmQgT01B
UDQgYnVpbGRzCiAgZW5hYmxlZCB0byBtb3JlIGFwcHJvcHJpYXRlIG5hbWUgJ29tYXAycGx1c19k
ZWZjb25maWcnCi0gTDEgY2FjaGUgc2hpZnQgaXMgc3VwcG9zZSB0byBiZSA1IG9uIE9NQVA0IHdo
ZXJlIGFzIGl0IGlzIDYgb24gcHJldmlvdXMKICBPTUFQcy4gS2VlcGluZyBpdCB0byA1IGlzIHNh
ZmVyIG9wdGlvbiBmb3IgT01BUDQgYW5kIHByZXZpb3VzIE9NQVBzLiBGb3IKICBPTUFQMyBvbmx5
IGJ1aWxkIHRoZSBzaGlmdCB3b3VsZCBiZSBzdGlsbCA2Ci0gRW5hYmxlIG5lZWRlZCBFcnJhdGEn
cyBmb3IgT01BUDQgdG8gd29yayB3aXRoIERNQSBiYXNlZCBkZXZpY2UgZHJpdmVycwoJQ09ORklH
X1BMMzEwX0VSUkFUQV81ODgzNjk9eQoJQ09ORklHX0FSTV9FUlJBVEFfNzIwNzg5PXkKLSBFbmFi
bGUgdGhlIE1pY3JlbCBldGhlcm5ldCBjb250cm9sbGVyCglDT05GSUdfS1M4ODUxPXkKCUNPTkZJ
R19LUzg4NTFfTUxMPXkKCldpdGggYWJvdmUgdGhyZWUgY2hhbmdlcywgT01BUDQgZXRoZXJuZXQs
IG1tYyBldGMgd29ya3MgcmVsaWFibHkuCgpTaWduZWQtb2ZmLWJ5OiBTYW50b3NoIFNoaWxpbWth
ciA8c2FudG9zaC5zaGlsaW1rYXJAdGkuY29tPgotLS0KIC4uLi97b21hcDNfZGVmY29uZmlnID0+
IG9tYXAycGx1c19kZWZjb25maWd9ICAgICAgIHwgICAgMyArKysKIGFyY2gvYXJtL21hY2gtb21h
cDIvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgNCArKystCiAyIGZpbGVzIGNo
YW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKIHJlbmFtZSBhcmNoL2FybS9j
b25maWdzL3tvbWFwM19kZWZjb25maWcgPT4gb21hcDJwbHVzX2RlZmNvbmZpZ30gKDk5JSkKCmRp
ZmYgLS1naXQgYS9hcmNoL2FybS9jb25maWdzL29tYXAzX2RlZmNvbmZpZyBiL2FyY2gvYXJtL2Nv
bmZpZ3Mvb21hcDJwbHVzX2RlZmNvbmZpZwpzaW1pbGFyaXR5IGluZGV4IDk5JQpyZW5hbWUgZnJv
bSBhcmNoL2FybS9jb25maWdzL29tYXAzX2RlZmNvbmZpZwpyZW5hbWUgdG8gYXJjaC9hcm0vY29u
Zmlncy9vbWFwMnBsdXNfZGVmY29uZmlnCmluZGV4IDgzM2E5YmMuLjNkMjdkZDAgMTAwNjQ0Ci0t
LSBhL2FyY2gvYXJtL2NvbmZpZ3Mvb21hcDNfZGVmY29uZmlnCisrKyBiL2FyY2gvYXJtL2NvbmZp
Z3Mvb21hcDJwbHVzX2RlZmNvbmZpZwpAQCAtNTMsNiArNTMsNyBAQCBDT05GSUdfTUFDSF9TQkMz
NTMwPXkKIENPTkZJR19NQUNIX09NQVBfMzYzMFNEUD15CiBDT05GSUdfTUFDSF9PTUFQXzQ0MzBT
RFA9eQogQ09ORklHX0FSTV9USFVNQkVFPXkKK0NPTkZJR19BUk1fTDFfQ0FDSEVfU0hJRlQ9NQog
Q09ORklHX05PX0haPXkKIENPTkZJR19ISUdIX1JFU19USU1FUlM9eQogQ09ORklHX1NNUD15CkBA
IC0xMzksNiArMTQwLDggQEAgQ09ORklHX1NNU0NfUEhZPXkKIENPTkZJR19ORVRfRVRIRVJORVQ9
eQogQ09ORklHX1NNQzkxWD15CiBDT05GSUdfU01TQzkxMVg9eQorQ09ORklHX0tTODg1MT15CitD
T05GSUdfS1M4ODUxX01MTD15CiBDT05GSUdfTElCRVJUQVM9eQogQ09ORklHX0xJQkVSVEFTX1VT
Qj15CiBDT05GSUdfTElCRVJUQVNfU0RJTz15CmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW9t
YXAyL0tjb25maWcgYi9hcmNoL2FybS9tYWNoLW9tYXAyL0tjb25maWcKaW5kZXggYjQ4YmFjZi4u
YmI4NWYyNCAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9LY29uZmlnCisrKyBiL2Fy
Y2gvYXJtL21hY2gtb21hcDIvS2NvbmZpZwpAQCAtMzUsNyArMzUsNyBAQCBjb25maWcgQVJDSF9P
TUFQMwogCWRlZmF1bHQgeQogCXNlbGVjdCBDUFVfVjcKIAlzZWxlY3QgVVNCX0FSQ0hfSEFTX0VI
Q0kKLQlzZWxlY3QgQVJNX0wxX0NBQ0hFX1NISUZUXzYKKwlzZWxlY3QgQVJNX0wxX0NBQ0hFX1NI
SUZUXzYgaWYgIUFSQ0hfT01BUDQKIAogY29uZmlnIEFSQ0hfT01BUDQKIAlib29sICJUSSBPTUFQ
NCIKQEAgLTQzLDYgKzQzLDggQEAgY29uZmlnIEFSQ0hfT01BUDQKIAlkZXBlbmRzIG9uIEFSQ0hf
T01BUDJQTFVTCiAJc2VsZWN0IENQVV9WNwogCXNlbGVjdCBBUk1fR0lDCisJc2VsZWN0IFBMMzEw
X0VSUkFUQV81ODgzNjkKKwlzZWxlY3QgQVJNX0VSUkFUQV83MjA3ODkKIAogY29tbWVudCAiT01B
UCBDb3JlIFR5cGUiCiAJZGVwZW5kcyBvbiBBUkNIX09NQVAyCi0tIAoxLjYuMC40Cgo=

--_002_EAF47CD23C76F840A9E7FCE10091EFAB02CD25FF3Bdbde02enttico_--
