From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 31 Mar 2014 13:24:57 +1100
Subject: linux-next: manual merge of the net-next tree with the arm-soc tree
Message-ID: <20140331132457.2d8d71019a52033bbef5b2c2@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the net-next tree got a conflict in
Documentation/devicetree/bindings/net/stmmac.txt between commit
50b4af414d41 ("dts: stmmac: Document the clocks property in the stmmac
base document") from the arm-soc tree and commit e8f08ee0ad86 ("DT: net:
document Ethernet bindings in one place") from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc Documentation/devicetree/bindings/net/stmmac.txt
index 9a0c1b7bee29,5748351fb9df..000000000000
--- a/Documentation/devicetree/bindings/net/stmmac.txt
+++ b/Documentation/devicetree/bindings/net/stmmac.txt
@@@ -31,13 -30,7 +30,11 @@@ Optional properties
  - resets: Should contain a phandle to the STMMAC reset signal, if any
  - reset-names: Should contain the reset signal name "stmmaceth", if a
  	reset phandle is given
- - max-frame-size:	Maximum Transfer Unit (IEEE defined MTU), rather
- 			than the maximum frame size.
+ - max-frame-size: See ethernet.txt file in the same directory
 +- clocks: If present, the first clock should be the GMAC main clock,
 +  further clocks may be specified in derived bindings.
 +- clocks-names: One name for each entry in the clocks property, the
 +  first one should be "stmmaceth".
  
  Examples:
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140331/d9266fa6/attachment.sig>
