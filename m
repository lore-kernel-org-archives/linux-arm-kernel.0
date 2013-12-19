From: horms@verge.net.au (Simon Horman)
Date: Thu, 19 Dec 2013 18:18:41 +0900
Subject: [PATCH] ARM: shmobile: r8a7790 - fix shdi resource sizes
In-Reply-To: <87sitsnygu.wl%kuninori.morimoto.gx@gmail.com>
References: <1387197528-1177-1-git-send-email-ben.dooks@codethink.co.uk>
 <1387197528-1177-2-git-send-email-ben.dooks@codethink.co.uk>
 <87sitsnygu.wl%kuninori.morimoto.gx@gmail.com>
Message-ID: <20131219091839.GA27244@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 16, 2013 at 03:54:47PM -0800, Kuninori Morimoto wrote:
> 
> Hi
> 
> > The r8a7790.dtsi file has four sdhi nodes which the first two have the wrong
> > resource size for their register block. This causes the sh_modbile_sdhi driver
> > to fail to communicate with card at-all.
> > 
> > Change sdhi{0,1} node size from 0x100 to 0x200 to correct these nodes
> > as per Kuninori Morimoto's response to the original patch where all four
> > nodes where changed. sdhi{2,3} are the correct size.
> > 
> > Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Cc: Simon Horman <horms@verge.net.au>
> > Cc: Linux SH <linux-sh@vger.kernel.org>
> > Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>
> > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > Tested-by: William Towle <william.towle@codethink.co.uk>
> > ---
> 
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks. I will queue up the following as a fix for v3.13.

From: Ben Dooks <ben.dooks@codethink.co.uk>

ARM: shmobile: r8a7790: fix shdi resource sizes

The r8a7790.dtsi file has four sdhi nodes which the first two have the wrong
resource size for their register block. This causes the sh_modbile_sdhi driver
to fail to communicate with card at-all.

Change sdhi{0,1} node size from 0x100 to 0x200 to correct these nodes
as per Kuninori Morimoto's response to the original patch where all four
nodes where changed. sdhi{2,3} are the correct size.

This bug has been present since sdhi resources were added to the r8a7790 by
8c9b1aa41853272a ("ARM: shmobile: r8a7790: add MMCIF and SDHI DT
templates") in v3.11-rc2.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Tested-by: William Towle <william.towle@codethink.co.uk>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 46e1d7e..9987dd0e 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -241,7 +241,7 @@
 
 	sdhi0: sdhi at ee100000 {
 		compatible = "renesas,sdhi-r8a7790";
-		reg = <0 0xee100000 0 0x100>;
+		reg = <0 0xee100000 0 0x200>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 165 4>;
 		cap-sd-highspeed;
@@ -250,7 +250,7 @@
 
 	sdhi1: sdhi at ee120000 {
 		compatible = "renesas,sdhi-r8a7790";
-		reg = <0 0xee120000 0 0x100>;
+		reg = <0 0xee120000 0 0x200>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 166 4>;
 		cap-sd-highspeed;
-- 
1.8.4
