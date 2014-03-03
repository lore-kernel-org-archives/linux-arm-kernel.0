From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 3 Mar 2014 16:38:35 +1100
Subject: linux-next: manual merge of the watchdog tree with the arm-soc tree
Message-ID: <20140303163835.303fbfd4fa64507e0e3db33c@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wim,

Today's linux-next merge of the watchdog tree got a conflict in
drivers/watchdog/Kconfig between commit 59416745bb8c ("watchdog: orion:
Enable the build on ARCH_MVEBU") from the arm-soc tree and commit
db5dd336cb23 ("watchdog: orion: prepare new Dove DT Kconfig variable")
from the watchdog tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/watchdog/Kconfig
index f1ff408c4b17,90f950d039c4..000000000000
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@@ -292,7 -301,7 +301,7 @@@ config DAVINCI_WATCHDO
  
  config ORION_WATCHDOG
  	tristate "Orion watchdog"
- 	depends on ARCH_ORION5X || ARCH_KIRKWOOD || ARCH_DOVE || ARCH_MVEBU
 -	depends on ARCH_ORION5X || ARCH_KIRKWOOD || ARCH_DOVE || MACH_DOVE
++	depends on ARCH_ORION5X || ARCH_KIRKWOOD || ARCH_DOVE || ARCH_MVEBU || MACH_DOVE
  	select WATCHDOG_CORE
  	help
  	  Say Y here if to include support for the watchdog timer
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140303/92b00333/attachment.sig>
