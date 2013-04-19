From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 19 Apr 2013 16:29:08 +1000
Subject: linux-next: manual merge of the arm-soc tree with the gen-gpio tree
Message-ID: <20130419162908.69aa0cbccc708ea1ca563a11@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/plat-orion/Makefile between commit 43b426d6fae8 ("arm:
plat-orion: use GPIO driver on CONFIG_GPIOLIB") from the gen-gpio tree
and various commits from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/plat-orion/Makefile
index bbc0d6b,2eca54b..0000000
--- a/arch/arm/plat-orion/Makefile
+++ b/arch/arm/plat-orion/Makefile
@@@ -3,8 -3,6 +3,6 @@@
  #
  ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
  
- obj-y                             += addr-map.o
- 
 -orion-gpio-$(CONFIG_GENERIC_GPIO) += gpio.o
 +orion-gpio-$(CONFIG_GPIOLIB)      += gpio.o
  obj-$(CONFIG_PLAT_ORION_LEGACY)   += irq.o pcie.o time.o common.o mpp.o
  obj-$(CONFIG_PLAT_ORION_LEGACY)   += $(orion-gpio-y)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130419/57f3c14f/attachment.sig>
