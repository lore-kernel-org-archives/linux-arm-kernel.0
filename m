From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed, 25 Aug 2010 14:52:53 +0800
Subject: [PATCH 3/3] [ARM] mmp: support sparse irq
Message-ID: <mailman.213.1282733115.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add sparse IRQ support in ARCH_MMP.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/Kconfig                      |    1 +
 arch/arm/mach-mmp/include/mach/irqs.h |    4 +---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 45f93e1..eb1d43d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -511,6 +511,7 @@ config ARCH_MMP
 	select GENERIC_CLOCKEVENTS
 	select TICK_ONESHOT
 	select PLAT_PXA
+	select SPARSE_IRQ
 	help
 	  Support for Marvell's PXA168/PXA910(MMP) and MMP2 processor line.

diff --git a/arch/arm/mach-mmp/include/mach/irqs.h
b/arch/arm/mach-mmp/include/mach/irqs.h
index b379cde..a09d328 100644
--- a/arch/arm/mach-mmp/include/mach/irqs.h
+++ b/arch/arm/mach-mmp/include/mach/irqs.h
@@ -222,10 +222,8 @@
 #define IRQ_GPIO_NUM			192
 #define IRQ_GPIO(x)			(IRQ_GPIO_START + (x))

-/* Board IRQ - 64 by default, increase if not enough */
 #define IRQ_BOARD_START			(IRQ_GPIO_START + IRQ_GPIO_NUM)
-#define IRQ_BOARD_END			(IRQ_BOARD_START + 64)

-#define NR_IRQS				(IRQ_BOARD_END)
+#define NR_IRQS				(IRQ_BOARD_START)

 #endif /* __ASM_MACH_IRQS_H */
-- 
1.5.6.5

--001485f5ce5c825969048ea393f5
Content-Type: text/x-patch; charset=US-ASCII; name="0003--ARM-mmp-support-sparse-irq.patch"
Content-Disposition: attachment; 
	filename="0003--ARM-mmp-support-sparse-irq.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gda1xg3k0

RnJvbSBjZGYyYTY3NDlmNWMwMWZmZTI4NWIwYjEwNDI3NTU3YjNjMmY3M2NkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYW9qaWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdAbWFydmVs
bC5jb20+CkRhdGU6IFdlZCwgMjUgQXVnIDIwMTAgMTQ6NTI6NTMgKzA4MDAKU3ViamVjdDogW1BB
VENIIDMvM10gW0FSTV0gbW1wOiBzdXBwb3J0IHNwYXJzZSBpcnEKCkFkZCBzcGFyc2UgSVJRIHN1
cHBvcnQgaW4gQVJDSF9NTVAuCgpTaWduZWQtb2ZmLWJ5OiBIYW9qaWFuIFpodWFuZyA8aGFvamlh
bi56aHVhbmdAbWFydmVsbC5jb20+Ci0tLQogYXJjaC9hcm0vS2NvbmZpZyAgICAgICAgICAgICAg
ICAgICAgICB8ICAgIDEgKwogYXJjaC9hcm0vbWFjaC1tbXAvaW5jbHVkZS9tYWNoL2lycXMuaCB8
ICAgIDQgKy0tLQogMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vS2NvbmZpZyBiL2FyY2gvYXJtL0tjb25maWcKaW5k
ZXggNDVmOTNlMS4uZWIxZDQzZCAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vS2NvbmZpZworKysgYi9h
cmNoL2FybS9LY29uZmlnCkBAIC01MTEsNiArNTExLDcgQEAgY29uZmlnIEFSQ0hfTU1QCiAJc2Vs
ZWN0IEdFTkVSSUNfQ0xPQ0tFVkVOVFMKIAlzZWxlY3QgVElDS19PTkVTSE9UCiAJc2VsZWN0IFBM
QVRfUFhBCisJc2VsZWN0IFNQQVJTRV9JUlEKIAloZWxwCiAJICBTdXBwb3J0IGZvciBNYXJ2ZWxs
J3MgUFhBMTY4L1BYQTkxMChNTVApIGFuZCBNTVAyIHByb2Nlc3NvciBsaW5lLgogCmRpZmYgLS1n
aXQgYS9hcmNoL2FybS9tYWNoLW1tcC9pbmNsdWRlL21hY2gvaXJxcy5oIGIvYXJjaC9hcm0vbWFj
aC1tbXAvaW5jbHVkZS9tYWNoL2lycXMuaAppbmRleCBiMzc5Y2RlLi5hMDlkMzI4IDEwMDY0NAot
LS0gYS9hcmNoL2FybS9tYWNoLW1tcC9pbmNsdWRlL21hY2gvaXJxcy5oCisrKyBiL2FyY2gvYXJt
L21hY2gtbW1wL2luY2x1ZGUvbWFjaC9pcnFzLmgKQEAgLTIyMiwxMCArMjIyLDggQEAKICNkZWZp
bmUgSVJRX0dQSU9fTlVNCQkJMTkyCiAjZGVmaW5lIElSUV9HUElPKHgpCQkJKElSUV9HUElPX1NU
QVJUICsgKHgpKQogCi0vKiBCb2FyZCBJUlEgLSA2NCBieSBkZWZhdWx0LCBpbmNyZWFzZSBpZiBu
b3QgZW5vdWdoICovCiAjZGVmaW5lIElSUV9CT0FSRF9TVEFSVAkJCShJUlFfR1BJT19TVEFSVCAr
IElSUV9HUElPX05VTSkKLSNkZWZpbmUgSVJRX0JPQVJEX0VORAkJCShJUlFfQk9BUkRfU1RBUlQg
KyA2NCkKIAotI2RlZmluZSBOUl9JUlFTCQkJCShJUlFfQk9BUkRfRU5EKQorI2RlZmluZSBOUl9J
UlFTCQkJCShJUlFfQk9BUkRfU1RBUlQpCiAKICNlbmRpZiAvKiBfX0FTTV9NQUNIX0lSUVNfSCAq
LwotLSAKMS41LjYuNQoK
--001485f5ce5c825969048ea393f5--
