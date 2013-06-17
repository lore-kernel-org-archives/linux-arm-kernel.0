From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 17 Jun 2013 16:43:14 +1000
Subject: linux-next: manual merge of the arm-soc tree with the net-next tree
Message-ID: <20130617164314.16ac062ac1d9f9a880aa1e07@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-shmobile/clock-r8a7778.c between commit 589ebdef7e31
("sh_eth: get R8A777x support out of #ifdef") from the net-next tree and
commits 1189b1cb50a0 ("ARM: shmobile: r8a7778: add SDHI clock support")
and 02474a41e618 ("ARM: shmobile: r8a7778: add USB support") from the
arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-shmobile/clock-r8a7778.c
index 9614b07,53798e5..0000000
--- a/arch/arm/mach-shmobile/clock-r8a7778.c
+++ b/arch/arm/mach-shmobile/clock-r8a7778.c
@@@ -76,8 -136,22 +136,22 @@@ static struct clk mstp_clks[MSTP_NR] = 
  };
  
  static struct clk_lookup lookups[] = {
+ 	/* main */
+ 	CLKDEV_CON_ID("shyway_clk",	&s_clk),
+ 	CLKDEV_CON_ID("peripheral_clk",	&p_clk),
+ 
  	/* MSTP32 clocks */
+ 	CLKDEV_DEV_ID("sh_mmcif", &mstp_clks[MSTP331]), /* MMC */
+ 	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP323]), /* SDHI0 */
+ 	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP322]), /* SDHI1 */
+ 	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP321]), /* SDHI2 */
 -	CLKDEV_DEV_ID("sh-eth",	&mstp_clks[MSTP114]), /* Ether */
 +	CLKDEV_DEV_ID("r8a777x-ether", &mstp_clks[MSTP114]), /* Ether */
+ 	CLKDEV_DEV_ID("ehci-platform", &mstp_clks[MSTP100]), /* USB EHCI port0/1 */
+ 	CLKDEV_DEV_ID("ohci-platform", &mstp_clks[MSTP100]), /* USB OHCI port0/1 */
+ 	CLKDEV_DEV_ID("i2c-rcar.0", &mstp_clks[MSTP030]), /* I2C0 */
+ 	CLKDEV_DEV_ID("i2c-rcar.1", &mstp_clks[MSTP029]), /* I2C1 */
+ 	CLKDEV_DEV_ID("i2c-rcar.2", &mstp_clks[MSTP028]), /* I2C2 */
+ 	CLKDEV_DEV_ID("i2c-rcar.3", &mstp_clks[MSTP027]), /* I2C3 */
  	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[MSTP026]), /* SCIF0 */
  	CLKDEV_DEV_ID("sh-sci.1", &mstp_clks[MSTP025]), /* SCIF1 */
  	CLKDEV_DEV_ID("sh-sci.2", &mstp_clks[MSTP024]), /* SCIF2 */
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130617/6ff767fb/attachment.sig>
