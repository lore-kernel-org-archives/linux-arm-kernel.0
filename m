From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 17 Mar 2014 16:37:52 +1100
Subject: linux-next: manual merge of the tip tree with the arm-soc tree
Message-ID: <20140317163752.f93d266cffa1cbdfcd1f9f8d@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the tip tree got a conflict in
drivers/clocksource/Kconfig between commit 3f8e8cee2f4b ("clocksource:
qcom: Move clocksource code out of mach-msm") from the arm-soc tree and
commit fd3f1270d237 ("clocksource: Add Kconfig entries for CMT, MTU2, TMU
and STI") from the tip tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/clocksource/Kconfig
index 6510ec4f45ff,4f754a972139..000000000000
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@@ -141,5 -141,46 +141,49 @@@ config VF_PIT_TIME
  	help
  	  Support for Period Interrupt Timer on Freescale Vybrid Family SoCs.
  
 +config CLKSRC_QCOM
 +	bool
++
+ config SYS_SUPPORTS_SH_CMT
+         bool
+ 
+ config SYS_SUPPORTS_SH_MTU2
+         bool
+ 
+ config SYS_SUPPORTS_SH_TMU
+         bool
+ 
+ config SYS_SUPPORTS_EM_STI
+         bool
+ 
+ config SH_TIMER_CMT
+ 	bool "Renesas CMT timer driver" if COMPILE_TEST
+ 	default SYS_SUPPORTS_SH_CMT
+ 	help
+ 	  This enables build of a clocksource and clockevent driver for
+ 	  the Compare Match Timer (CMT) hardware available in 16/32/48-bit
+ 	  variants on a wide range of Mobile and Automotive SoCs from Renesas.
+ 
+ config SH_TIMER_MTU2
+ 	bool "Renesas MTU2 timer driver" if COMPILE_TEST
+ 	default SYS_SUPPORTS_SH_MTU2
+ 	help
+ 	  This enables build of a clockevent driver for the Multi-Function
+ 	  Timer Pulse Unit 2 (TMU2) hardware available on SoCs from Renesas.
+ 	  This hardware comes with 16 bit-timer registers.
+ 
+ config SH_TIMER_TMU
+ 	bool "Renesas TMU timer driver" if COMPILE_TEST
+ 	default SYS_SUPPORTS_SH_TMU
+ 	help
+ 	  This enables build of a clocksource and clockevent driver for
+ 	  the 32-bit Timer Unit (TMU) hardware available on a wide range
+ 	  SoCs from Renesas.
+ 
+ config EM_TIMER_STI
+ 	bool "Renesas STI timer driver" if COMPILE_TEST
+ 	default SYS_SUPPORTS_EM_STI
+ 	help
+ 	  This enables build of a clocksource and clockevent driver for
+ 	  the 48-bit System Timer (STI) hardware available on a SoCs
+ 	  such as EMEV2 from former NEC Electronics.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140317/d8f18fff/attachment.sig>
