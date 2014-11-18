From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Tue, 18 Nov 2014 00:30:20 +0000
Subject: [PATCH v5] of: replace Asahi Kasei Corp vendor prefix
In-Reply-To: <5469CD47.3040409@cogentembedded.com>
References: <878ulzx6hr.wl%kuninori.morimoto.gx@gmail.com>
 <20140922130026.GK3290@leverpostej>
 <CAMuHMdX22z97SbGS1HDiYfJ1PXxyEN2S8D7w4sr+4bUwD+mJZw@mail.gmail.com>
 <20140922132743.GM3290@leverpostej>
 <87y4rfhmgl.wl%kuninori.morimoto.gx@renesas.com>
 <1415845309.4269.6.camel@perches.com>
 <20141113025105.GA16652@verge.net.au>
 <87vbmjhj00.wl%kuninori.morimoto.gx@renesas.com>
 <20141113110740.GE3815@sirena.org.uk>
 <87k32yd0bd.wl%kuninori.morimoto.gx@renesas.com>
 <20141114093554.GC3810@ulmo>
 <87y4ra8xac.wl%kuninori.morimoto.gx@renesas.com>
 <5469CD47.3040409@cogentembedded.com>
Message-ID: <877fytxsde.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current vendor-prefixes.txt already has "ak" prefix for Asahi Kasei Corp
by ae8c4209af2c(of: Add vendor prefix for Asahi Kasei Corp.)

It went through the appropriate review process. But, almost all
Asahi Kasei chip drivers are using "asahi-kasei" prefix today.
(arch/arm/boot/dts/tegra20-seaboard.dts only is using "ak,ak8975",
 but there are instances of "asahi-kasei,ak8975" in other dts files.
 And drivers/iio/magnetometer/ak8975.c doesn't support "ak,ak8975" prefix)
So, we made a mistake there.

In addition, checkpatch.pl reports WARNING if it is using "asahi-kasei"
prerfix in DT file.
(DT compatible string vendor "asahi-kasei" appears un-documented)

Marking it deprecated and warning with checkpatch is certainly
preferable. So, this patch replace "ak" to "asahi-kasei" in
vendor-prefixes.txt. (and fixup tegra20-seaboard)

OTOH, Asahi Kasei is usually referred to as "AKM", but this patch
doesn't care about it. Because no DT is using that today.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Acked-by: Alexandre Courbot <acourbot@nvidia.com>
---
v4 -> v5

 - venter -> vendor on Subject
 - fixup Acked-by ordering

 .../devicetree/bindings/vendor-prefixes.txt        |    2 +-
 arch/arm/boot/dts/tegra20-seaboard.dts             |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 723999d..ddcb4cd 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -9,7 +9,6 @@ ad	Avionic Design GmbH
 adapteva	Adapteva, Inc.
 adi	Analog Devices, Inc.
 aeroflexgaisler	Aeroflex Gaisler AB
-ak	Asahi Kasei Corp.
 allwinner	Allwinner Technology Co., Ltd.
 altr	Altera Corp.
 amcc	Applied Micro Circuits Corporation (APM, formally AMCC)
@@ -20,6 +19,7 @@ amstaos	AMS-Taos Inc.
 apm	Applied Micro Circuits Corporation (APM)
 arm	ARM Ltd.
 armadeus	ARMadeus Systems SARL
+asahi-kasei	Asahi Kasei Corp.
 atmel	Atmel Corporation
 auo	AU Optronics Corporation
 avago	Avago Technologies
diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index a1d4bf9..7f5cf80 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -405,7 +405,7 @@
 		clock-frequency = <400000>;
 
 		magnetometer at c {
-			compatible = "ak,ak8975";
+			compatible = "asahi-kasei,ak8975";
 			reg = <0xc>;
 			interrupt-parent = <&gpio>;
 			interrupts = <TEGRA_GPIO(N, 5) IRQ_TYPE_LEVEL_HIGH>;
-- 
1.7.9.5
