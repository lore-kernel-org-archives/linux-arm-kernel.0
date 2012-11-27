From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 27 Nov 2012 15:52:23 +1100
Subject: linux-next: manual merge of the arm-soc tree with the battery tree
Message-ID: <20121127155223.849e73a08fc1b382d4622ff8@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/power/Kconfig between commit bd9e8ab2d58d ("ab8500: Add
devicetree support for btemp") from the battery tree and commit
96ff0f5c7efd ("power: Add simple poweroff-gpio driver") from the arm-soc
tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/power/Kconfig
index 263499f,b1d956d..0000000
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@@ -346,6 -329,15 +346,8 @@@ config AB8500_B
  	help
  	  Say Y to include support for AB8500 battery management.
  
 -config AB8500_BATTERY_THERM_ON_BATCTRL
 -	bool "Thermistor connected on BATCTRL ADC"
 -	depends on AB8500_BM
 -	help
 -	  Say Y to enable battery temperature measurements using
 -	  thermistor connected on BATCTRL ADC.
 -
+ source "drivers/power/reset/Kconfig"
+ 
  endif # POWER_SUPPLY
  
  source "drivers/power/avs/Kconfig"
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121127/5ac41480/attachment.sig>
