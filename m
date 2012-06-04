From: gerg@snapgear.com (Greg Ungerer)
Date: Mon, 4 Jun 2012 14:42:28 +1000
Subject: Freescale fec.c driver breakage
Message-ID: <4FCC3CB4.5030107@snapgear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Sascha,

Commit f4d40de39a23f0c39cca55ac63e1175c69c3d2f7 ("net fec: do not
depend on grouped clocks") breaks compilation of the FEC driver for
non iMX platforms in linux-3.5-rc1. For example when compiling for
ColdFire I get:

	  LD      vmlinux
     drivers/built-in.o: In function `fec_probe':
     fec.c:(.devinit.text+0x1e0): undefined reference to `devm_clk_get'

Trivially we could conditionalize the code block that calls
devm_clk_get() in the probe routine, but that is kind of ugly.

Can you come up with a better fix?

Regards
Greg


-- 
------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg at snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close                             FAX:         +61 7 3217 5323
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
