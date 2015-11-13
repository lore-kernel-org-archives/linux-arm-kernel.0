From: horms@verge.net.au (Simon Horman)
Date: Fri, 13 Nov 2015 10:11:23 +0900
Subject: [PATCH v2 3/3] ARM: shmobile: gose: Add QSPI device to DT
In-Reply-To: <56447D49.6060907@cogentembedded.com>
References: <1447291763-27527-1-git-send-email-horms+renesas@verge.net.au>
 <1447291763-27527-4-git-send-email-horms+renesas@verge.net.au>
 <56447D49.6060907@cogentembedded.com>
Message-ID: <20151113011123.GI20462@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2015 at 02:51:37PM +0300, Sergei Shtylyov wrote:
> On 11/12/2015 4:29 AM, Simon Horman wrote:
> 
> >Enable the QSPI controller in the gose device tree.
> >
> >Based similar work for the silk board by by Vladimir Barinov and
> >Sergei Shtylyov.
> >
> >Cc: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> >Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >
> >---
> >Tested: Read /dev/mtd0 with 512K blocks at 1.7MB/s
> >
> >v2
> >* Move partitions into partitions subnode
> >   as suggested by Geert Uytterhoeven.
> >---
> >  arch/arm/boot/dts/r8a7793-gose.dts | 43 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >
> >diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
> >index 1575ef759047..79be514d3a1c 100644
> >--- a/arch/arm/boot/dts/r8a7793-gose.dts
> >+++ b/arch/arm/boot/dts/r8a7793-gose.dts
> [...]
> >@@ -92,3 +97,41 @@
> >
> >  	status = "okay";
> >  };
> >+
> >+&qspi {
> >+	pinctrl-0 = <&qspi_pins>;
> >+	pinctrl-names = "default";
> >+
> >+	status = "okay";
> >+
> >+	flash at 0 {
> >+		compatible = "spansion,s25fl512s", "jedec,spi-nor";
> >+		reg = <0>;
> >+		spi-max-frequency = <30000000>;
> >+		spi-tx-bus-width = <4>;
> >+		spi-rx-bus-width = <4>;
> >+		spi-cpol;
> >+		spi-cpha;
> >+		m25p,fast-read;
> >+
> >+		partitions{
> 
>    Need space before {.

Thanks, I have corrected that and queued this up for v4.5.
