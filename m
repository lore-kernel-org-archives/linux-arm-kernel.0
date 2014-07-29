From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 29 Jul 2014 15:53:02 +1000
Subject: linux-next: manual merge of the irqchip tree with the arm-soc tree
Message-ID: <20140729155302.3c1d5437@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

Today's linux-next merge of the irqchip tree got a conflict in
Documentation/devicetree/bindings/arm/gic.txt between commit
f80b71397d09 ("ARM: brcmstb: gic: add compatible string for Broadcom
Brahma15") from the arm-soc tree and commit 3e44358c12cc ("") from the
irqchip tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc Documentation/devicetree/bindings/arm/gic.txt
index c7d2fa156678,d2eea0b75580..000000000000
--- a/Documentation/devicetree/bindings/arm/gic.txt
+++ b/Documentation/devicetree/bindings/arm/gic.txt
@@@ -16,8 -17,9 +17,10 @@@ Main node required properties
  	"arm,cortex-a9-gic"
  	"arm,cortex-a7-gic"
  	"arm,arm11mp-gic"
 +	"brcm,brahma-b15-gic"
+ 
  - interrupt-controller : Identifies the node as an interrupt controller
+ 
  - #interrupt-cells : Specifies the number of cells needed to encode an
    interrupt source.  The type shall be a <u32> and the value shall be 3.
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140729/caaf7c4e/attachment.sig>
