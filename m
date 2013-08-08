From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 8 Aug 2013 15:40:43 +1000
Subject: linux-next: manual merge of the mvebu tree with the i2c tree
Message-ID: <20130808154043.fe160a4e178e87a8c1c5a045@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the mvebu tree got a conflict in
Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt between
commit f480adaf1b71 ("i2c: mv64xxx: Document the newly introduced
allwinner compatible") from the i2c tree and commit e7c4a1e9f937 ("ARM:
dts: mvebu: Introduce a new compatible string for mv64xxx-i2c") from the
mvebu tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
index 6113f92,c5dd952..0000000
--- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
@@@ -4,7 -4,8 +4,9 @@@
  Required properties :
  
   - reg             : Offset and length of the register set for the device
 - - compatible      : Should be "marvell,mv64xxx-i2c" and "marvell,mv7230-i2c"
 -for controller which support the I2C Transaction Generator
 + - compatible      : Should be "marvell,mv64xxx-i2c" or "allwinner,sun4i-i2c"
++                     or "marvell,mv7230-i2c" for controller which support
++                     the I2C Transaction Generator
   - interrupts      : The interrupt number
  
  Optional properties :
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130808/d8fa821d/attachment.sig>
