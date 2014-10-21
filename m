From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 21 Oct 2014 11:07:57 +0200
Subject: [PATCH v2 5/5] ARM: berlin: Enable SATA on Sony NSZ-GS7
In-Reply-To: <1413882477-27922-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1413882477-27922-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1413882477-27922-6-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marvell Berlin BG2 based Sony NSZ-GS7 has an unpopulated SATA plug
on its PCB solder side. As it is quite easy to populate and I have
done it, enable AHCI and SATA by default.

Acked-by: Antoine T?nart <antoine.tenart@free-electrons.com>
Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Kishon Vijay Abraham I <kishon@ti.com> 
Cc: "Antoine T?nart" <antoine.tenart@free-electrons.com>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org 
---
 arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts b/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts
index c72bfd468d10..0a13e8a5da15 100644
--- a/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts
+++ b/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts
@@ -26,4 +26,11 @@
 	};
 };
 
+&ahci { status = "okay"; };
+
+/* Unpopulated SATA plug on solder side */
+&sata0 { status = "okay"; };
+
+&sata_phy { status = "okay"; };
+
 &uart0 { status = "okay"; };
-- 
2.1.1
