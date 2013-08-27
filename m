From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 27 Aug 2013 18:24:14 +1000
Subject: linux-next: manual merge of the arm-soc tree with the usb tree
Message-ID: <20130827182414.33ff08dc24b6762dec907f82@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/boot/dts/omap5.dtsi between commit 22a5aa170c52 ("usb: dwc3:
core: switch to snps,dwc3") from the usb tree and commit ec0a71838da2
("ARM: OMAP5: dts: fix reg property size") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/boot/dts/omap5.dtsi
index 07be2cd,4fc0912..0000000
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@@ -644,8 -644,8 +644,8 @@@
  			utmi-mode = <2>;
  			ranges;
  			dwc3 at 4a030000 {
 -				compatible = "synopsys,dwc3";
 +				compatible = "snps,dwc3";
- 				reg = <0x4a030000 0x1000>;
+ 				reg = <0x4a030000 0x10000>;
  				interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
  				usb-phy = <&usb2_phy>, <&usb3_phy>;
  				tx-fifo-resize;
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130827/521f0310/attachment.sig>
