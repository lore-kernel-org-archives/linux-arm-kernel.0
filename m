From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 17 Sep 2012 18:02:28 +1000
Subject: linux-next: manual merge of the arm-soc tree with the  tree
Message-ID: <20120917180228.c64369b4586a2a31042d4175@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-imx/clk-imx51-imx53.c between commit 75453a08e365 ("ARM:
i.MX5: Add nand oftree support") from the mtd tree and commit
a745f039b901 ("ARM i.MX53: register CAN clocks") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-imx/clk-imx51-imx53.c
index e81f17a,e5165a8..0000000
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@@ -456,7 -461,10 +462,11 @@@ int __init mx53_clocks_init(unsigned lo
  	clk_register_clkdev(clk[ssi1_ipg_gate], NULL, "63fcc000.ssi");
  	clk_register_clkdev(clk[ssi2_ipg_gate], NULL, "50014000.ssi");
  	clk_register_clkdev(clk[ssi3_ipg_gate], NULL, "63fd0000.ssi");
 +	clk_register_clkdev(clk[nfc_gate], NULL, "63fdb000.nand");
+ 	clk_register_clkdev(clk[can1_ipg_gate], "ipg", "53fc8000.can");
+ 	clk_register_clkdev(clk[can1_serial_gate], "per", "53fc8000.can");
+ 	clk_register_clkdev(clk[can2_ipg_gate], "ipg", "53fcc000.can");
+ 	clk_register_clkdev(clk[can2_serial_gate], "per", "53fcc000.can");
  
  	/* set SDHC root clock to 200MHZ*/
  	clk_set_rate(clk[esdhc_a_podf], 200000000);
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120917/8f8474c5/attachment.sig>
