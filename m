From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 10 Sep 2014 14:10:57 +1000
Subject: linux-next: manual merge of the pm tree with the mvebu tree
Message-ID: <20140910141057.21726568@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

Today's linux-next merge of the pm tree got a conflict in
arch/arm/configs/mvebu_v7_defconfig between commit fc9fa8714a75 ("ARM:
mvebu: update v7 defconfig with useful options") from the mvebu tree
and commit 978027e170fb ("cpufreq: cpu0: rename driver and internals to
'cpufreq_dt'") from the pm tree.

I fixed it up (maybe - see below) and can carry the fix as necessary
(no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/configs/mvebu_v7_defconfig
index 0acbe1134eba,7309988b0f1f..000000000000
--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@@ -25,14 -29,12 +25,15 @@@ CONFIG_ZBOOT_ROM_TEXT=0x
  CONFIG_ZBOOT_ROM_BSS=0x0
  CONFIG_ARM_APPENDED_DTB=y
  CONFIG_ARM_ATAG_DTB_COMPAT=y
 +CONFIG_CPU_FREQ=y
  CONFIG_CPU_IDLE=y
  CONFIG_ARM_MVEBU_V7_CPUIDLE=y
 -CONFIG_CPU_FREQ=y
+ CONFIG_CPUFREQ_DT=y
  CONFIG_VFP=y
 +CONFIG_NEON=y
  CONFIG_NET=y
 +CONFIG_PACKET=y
 +CONFIG_UNIX=y
  CONFIG_INET=y
  CONFIG_IP_PNP=y
  CONFIG_IP_PNP_DHCP=y
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140910/afcfb06c/attachment.sig>
