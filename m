From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 13 Jan 2015 11:16:36 +1100
Subject: linux-next: manual merge of the imx-mxs tree with the arm-soc tree
Message-ID: <20150113111636.7bc5785c@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Today's linux-next merge of the imx-mxs tree got a conflict in
arch/arm/boot/dts/Makefile between commit 6f1650f15bc4 ("ARM: dts: Only
build dtb if associated Arch and/or SoC is enabled") from the arm-soc
tree and commit 99fc5ba0bfb6 ("ARM: dts: imx6sx: add i.mx6sx sabreauto
board support") from the imx-mxs tree.

I fixed it up (I think - see below) and can carry the fix as necessary
(no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/boot/dts/Makefile
index 1c1cefc434a2,1236b8c0eb60..000000000000
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@@ -295,15 -265,12 +296,16 @@@ dtb-$(CONFIG_SOC_IMX6Q) += 
  	imx6q-tx6q-1010-comtft.dtb \
  	imx6q-tx6q-1020.dtb \
  	imx6q-tx6q-1020-comtft.dtb \
 -	imx6q-tx6q-1110.dtb \
 -	imx6sl-evk.dtb \
 +	imx6q-tx6q-1110.dtb
 +dtb-$(CONFIG_SOC_IMX6SL) += \
 +	imx6sl-evk.dtb
 +dtb-$(CONFIG_SOC_IMX6SX) += \
+ 	imx6sx-sabreauto.dtb \
  	imx6sx-sdb.dtb \
 +dtb-$(CONFIG_SOC_LS1021A) += \
  	ls1021a-qds.dtb \
 -	ls1021a-twr.dtb \
 +	ls1021a-twr.dtb
 +dtb-$(CONFIG_SOC_VF610) += \
  	vf500-colibri-eval-v3.dtb \
  	vf610-colibri-eval-v3.dtb \
  	vf610-cosmic.dtb \
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150113/3cf6eac9/attachment.sig>
