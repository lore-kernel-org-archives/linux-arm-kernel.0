From: horms@verge.net.au (Simon Horman)
Date: Thu, 15 Feb 2018 17:14:05 +0100
Subject: [PATCH 2/4] arm64: dts: renesas: r8a77995: add FCPVD nodes
In-Reply-To: <1541765.WkmPmS7X3L@avalon>
References: <1518474330-8713-1-git-send-email-kbingham@kernel.org>
 <1518474330-8713-3-git-send-email-kbingham@kernel.org>
 <1541765.WkmPmS7X3L@avalon>
Message-ID: <20180215161404.pywzt7m3ccd7gygu@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 13, 2018 at 02:32:22PM +0200, Laurent Pinchart wrote:
> Hi Kieran,
> 
> Thank you for the patch.
> 
> On Tuesday, 13 February 2018 00:25:27 EET Kieran Bingham wrote:
> > From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> > 
> > The FCPVD handles the interface between the VSPD and memory.
> > 
> > Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> I would however squash this with patch 1/4 from the same series.

Thanks, I've taken the liberty of doing so when applying this patch.
The result is as follows:

From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH] arm64: dts: renesas: r8a77995: add FCPV[BD] node

The FCPVB handles the interface between the VSPB and memory.
The FCPVD handles the interface between the VSPD and memory.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
[simon: squahsed FCPVB and FCPVD patches]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77995.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
index cd3c6a30fc47..196a917afea6 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
@@ -691,6 +691,33 @@
 			#phy-cells = <0>;
 			status = "disabled";
 		};
+
+		fcpvb0: fcp at fe96f000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xfe96f000 0 0x200>;
+			clocks = <&cpg CPG_MOD 607>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+			resets = <&cpg 607>;
+			iommus = <&ipmmu_vp0 5>;
+		};
+
+		fcpvd0: fcp at fea27000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xfea27000 0 0x200>;
+			clocks = <&cpg CPG_MOD 603>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+			resets = <&cpg 603>;
+			iommus = <&ipmmu_vi0 8>;
+		};
+
+		fcpvd1: fcp at fea2f000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xfea2f000 0 0x200>;
+			clocks = <&cpg CPG_MOD 602>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+			resets = <&cpg 602>;
+			iommus = <&ipmmu_vi0 9>;
+		};
 	};
 
 	timer {
-- 
2.11.0
