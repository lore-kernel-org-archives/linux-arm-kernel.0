From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 16 Apr 2013 17:00:10 +1000
Subject: linux-next: manual merge of the arm-soc tree with the input tree
Message-ID: <20130416170010.9c2bf713b12fa89e663aea2d@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-shmobile/board-armadillo800eva.c between commit
cbaf7f808081 ("ARM - shmobile: Armadillo800EVA: Move st1232 reset pin
handling") from the input tree and commits ead10fed8b4b ("ARM: shmobile:
armadillo: Replace GPIO_PORTx enum with GPIO port numbers") and
0b7d78202260 ("ARM: shmobile: r8a7740: Migrate from INTC to GIC") from
the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-shmobile/board-armadillo800eva.c
index 881e5c0,81db74a..0000000
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@@ -890,8 -1000,7 +1009,8 @@@ static struct st1232_pdata st1232_i2c0_
  static struct i2c_board_info i2c0_devices[] = {
  	{
  		I2C_BOARD_INFO("st1232-ts", 0x55),
- 		.irq = evt2irq(0x0340),
+ 		.irq = irq_pin(10),
 +		.platform_data = &st1232_i2c0_pdata,
  	},
  	{
  		I2C_BOARD_INFO("wm8978", 0x1a),
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130416/3b686bf6/attachment.sig>
