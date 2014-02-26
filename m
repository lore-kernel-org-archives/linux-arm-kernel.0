From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 26 Feb 2014 12:46:35 +1100
Subject: linux-next: manual merge of the mvebu tree with the arm-soc tree
Message-ID: <20140226124635.46eb18b096b7835e28e62d3e@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the mvebu tree got a conflict in
arch/arm/boot/dts/Makefile between commit 8fc1b0f87d9f ("ARM: qcom: Split
Qualcomm support into legacy and multiplatform") from the arm-soc tree
and commit a02dd0271d01 ("ARM: mvebu: select dtbs from MACH_ARMADA_*")
from the mvebu tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/boot/dts/Makefile
index cf8bb9f05c94,01f9ceb450ca..000000000000
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@@ -123,9 -138,16 +139,13 @@@ kirkwood := 
  	kirkwood-ts219-6282.dtb \
  	kirkwood-ts419-6281.dtb \
  	kirkwood-ts419-6282.dtb
+ dtb-$(CONFIG_ARCH_KIRKWOOD) += $(kirkwood)
+ dtb-$(CONFIG_MACH_KIRKWOOD) += $(kirkwood)
+ dtb-$(CONFIG_ARCH_LPC32XX) += ea3250.dtb phy3250.dtb
  dtb-$(CONFIG_ARCH_MARCO) += marco-evb.dtb
  dtb-$(CONFIG_ARCH_MOXART) += moxart-uc7112lx.dtb
- dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
 -dtb-$(CONFIG_ARCH_MSM) += qcom-msm8660-surf.dtb \
 -	qcom-msm8960-cdp.dtb \
 -	qcom-apq8074-dragonboard.dtb
+ dtb-$(CONFIG_MACH_ARMADA_370) += \
+ 	armada-370-db.dtb \
  	armada-370-mirabox.dtb \
  	armada-370-netgear-rn102.dtb \
  	armada-370-netgear-rn104.dtb \
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140226/06e5c9d0/attachment.sig>
