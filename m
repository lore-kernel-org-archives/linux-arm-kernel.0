From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 4 Apr 2013 08:33:40 +0100
Subject: [PATCH] ARM: ux500: Over-ride TCDM size when booting the DB8540
 platform
In-Reply-To: <CACRpkdbh-DJti2ny=uBe-b_vGkQBNL=emMuZ6+_cE5jvRsA4sA@mail.gmail.com>
References: <1364908916-29803-1-git-send-email-lee.jones@linaro.org>
 <1364908916-29803-5-git-send-email-lee.jones@linaro.org>
 <CACRpkdbh-DJti2ny=uBe-b_vGkQBNL=emMuZ6+_cE5jvRsA4sA@mail.gmail.com>
Message-ID: <20130404073340.GA6892@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PRCMU's Tightly Coupled Data Memory on the DB8540 platform is
8kB larger than it's predecessor's. We need to reflect that in its
Device Tree. By re-specifying the address and size of the device
we effectively over-ride the previous values with more accurate
ones.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/ccu8540.dts |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/ccu8540.dts b/arch/arm/boot/dts/ccu8540.dts
index 02e8e1a..f829689 100644
--- a/arch/arm/boot/dts/ccu8540.dts
+++ b/arch/arm/boot/dts/ccu8540.dts
@@ -21,6 +21,11 @@
 	};
 
 	soc-u9500 {
+		prcmu at 80157000 {
+			reg = <0x80157000 0x2000>, <0x801b0000 0x8000>, <0x801b8000 0x3000>;
+			reg-names = "prcmu", "prcmu-tcpm-per4", "prcmu-tcdm-per4";
+		};
+
 		uart at 80120000 {
 			status = "okay";
 		};
-- 
1.7.10.4
