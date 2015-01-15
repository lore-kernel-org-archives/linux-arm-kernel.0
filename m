From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 15 Jan 2015 11:38:40 +1100
Subject: linux-next: manual merge of the renesas tree with the arm-soc tree
Message-ID: <20150115113840.71ab0a39@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

Today's linux-next merge of the renesas tree got a conflict in
arch/arm/boot/dts/Makefile between commit cb612390e546 ("ARM: dts: Only
build dtb if associated Arch and/or SoC is enabled") from the arm-soc
tree and commits 9ccba8abd0a7 ("ARM: shmobile: kzm9g: Build DTS for
Multiplatform") and 93c9f0228a3d ("ARM: shmobile: kzm9g-reference:
Remove board C code and DT file") from the renesas tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/boot/dts/Makefile
index 95fed8145ac9,be6e2607da88..000000000000
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@@ -466,10 -411,8 +466,9 @@@ dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += 
  	r8a7778-bockw-reference.dtb \
  	r8a7779-marzen.dtb \
  	sh7372-mackerel.dtb \
- 	sh73a0-kzm9g.dtb \
- 	sh73a0-kzm9g-reference.dtb
+ 	sh73a0-kzm9g.dtb
 -dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb \
 +dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
 +	emev2-kzm9d.dtb \
  	r7s72100-genmai.dtb \
  	r8a73a4-ape6evm.dtb \
  	r8a7740-armadillo800eva.dtb \
@@@ -477,9 -420,9 +476,10 @@@
  	r8a7790-lager.dtb \
  	r8a7791-henninger.dtb \
  	r8a7791-koelsch.dtb \
- 	r8a7794-alt.dtb
+ 	r8a7794-alt.dtb \
+ 	sh73a0-kzm9g.dtb
 -dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_arria5_socdk.dtb \
 +dtb-$(CONFIG_ARCH_SOCFPGA) += \
 +	socfpga_arria5_socdk.dtb \
  	socfpga_arria10_socdk.dtb \
  	socfpga_cyclone5_socdk.dtb \
  	socfpga_cyclone5_sockit.dtb \
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150115/c8f91cb9/attachment.sig>
