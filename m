From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 31 Jul 2015 08:38:03 +1000
Subject: linux-next: manual merge of the at91 tree with the arm-soc tree
Message-ID: <20150731083803.71c9d466@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

Today's linux-next merge of the at91 tree got a conflict in:

  arch/arm/mach-at91/sama5.c

between commit:

  19c233b79d1a ("ARM: appropriate __init annotation for const data")

from the arm-soc tree and commit:

  a6e41317b9b8 ("ARM: at91/soc: add basic support for new sama5d2 SoC")

from the at91 tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-at91/sama5.c
index 8fc47630bbc8,90c3c3051ae7..000000000000
--- a/arch/arm/mach-at91/sama5.c
+++ b/arch/arm/mach-at91/sama5.c
@@@ -63,7 -65,8 +65,8 @@@ DT_MACHINE_START(sama5_dt, "Atmel SAMA5
  	.dt_compat	= sama5_dt_board_compat,
  MACHINE_END
  
 -static const char *sama5_alt_dt_board_compat[] __initconst = {
 +static const char *const sama5_alt_dt_board_compat[] __initconst = {
+ 	"atmel,sama5d2",
  	"atmel,sama5d4",
  	NULL
  };
