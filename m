From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 24 Feb 2014 13:37:52 +1100
Subject: linux-next: manual merge of the sound-asoc tree with the mvebu tree
Message-ID: <20140224133752.bc1ffffa4e81edb76a76e555@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the sound-asoc tree got a conflict in
sound/soc/kirkwood/Kconfig between commit cd34edc2eab2 ("drivers: Enable
building of Kirkwood drivers for mach-mvebu") from the  tree and commit
9a0d5113ac0e ("ASoC: kirkwood: enable Kirkwood driver for mvebu
platforms") from the sound-asoc tree.

I fixed it up (Probably incorrectly - see below) and can carry the fix as
necessary (no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc sound/soc/kirkwood/Kconfig
index 106e2e22fed2,2dc3ecf34801..000000000000
--- a/sound/soc/kirkwood/Kconfig
+++ b/sound/soc/kirkwood/Kconfig
@@@ -1,6 -1,6 +1,6 @@@
  config SND_KIRKWOOD_SOC
  	tristate "SoC Audio for the Marvell Kirkwood and Dove chips"
- 	depends on ARCH_KIRKWOOD || ARCH_DOVE || MACH_KIRKWOOD || COMPILE_TEST
 -	depends on ARCH_KIRKWOOD || ARCH_DOVE || ARCH_MVEBU || COMPILE_TEST
++	depends on ARCH_KIRKWOOD || ARCH_DOVE || MACH_KIRKWOOD || ARCH_MVEBU || COMPILE_TEST
  	help
  	  Say Y or M if you want to add support for codecs attached to
  	  the Kirkwood I2S interface. You will also need to select the
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140224/4c56b376/attachment.sig>
