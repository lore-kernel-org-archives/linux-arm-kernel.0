From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 29 Oct 2013 18:57:14 +1100
Subject: linux-next: manual merge of the arm-soc tree with the  tree
Message-ID: <20131029185714.f6a1eef0e6700b989bbdf5dc@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/Kconfig between commit 85649711a895 ("ARM: gemini: delete
<mach/gpio.h>") from the gpio tree and commit f3372c01816e ("ARM: gemini:
convert to GENERIC_CLOCKEVENTS") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/Kconfig
index 55be62c92b60,04163fece49f..000000000000
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@@ -391,8 -385,10 +390,9 @@@ config ARCH_CLPS711
  config ARCH_GEMINI
  	bool "Cortina Systems Gemini"
  	select ARCH_REQUIRE_GPIOLIB
- 	select ARCH_USES_GETTIMEOFFSET
+ 	select CLKSRC_MMIO
  	select CPU_FA526
+ 	select GENERIC_CLOCKEVENTS
 -	select NEED_MACH_GPIO_H
  	help
  	  Support for the Cortina Systems Gemini family SoCs
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131029/3b98d760/attachment.sig>
