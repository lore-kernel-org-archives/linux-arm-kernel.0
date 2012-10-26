From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 26 Oct 2012 14:24:34 +1100
Subject: linux-next: manual merge of the arm-soc tree with the gpio-lw tree
Message-ID: <20121026142434.00b97d865478dabafbeb2c52@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/Kconfig between commit a3b8d4a51357 ("GPIO: Add support for GPIO
on CLPS711X-target platform") from the gpio-lw tree and commit
4a8355c4c34f ("ARM: clps711x: convert to clockevents") from the arm-soc
tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/Kconfig
index a7c541e,d9b7a84..0000000
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@@ -366,8 -364,6 +366,7 @@@ config ARCH_CNS3XX
  
  config ARCH_CLPS711X
  	bool "Cirrus Logic CLPS711x/EP721x/EP731x-based"
 +	select ARCH_REQUIRE_GPIOLIB
- 	select ARCH_USES_GETTIMEOFFSET
  	select CLKDEV_LOOKUP
  	select COMMON_CLK
  	select CPU_ARM720T
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121026/5fac8e72/attachment.sig>
