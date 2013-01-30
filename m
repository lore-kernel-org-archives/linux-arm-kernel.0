From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 31 Jan 2013 00:36:47 +1100
Subject: linux-next: manual merge of the arm-soc tree with the pinctrl tree
Message-ID: <20130131003647.daebd2aed733d0304c2c7aa0@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/pinctrl/pinctrl-nomadik.c between commit e32af8894588
("pinctrl/nomadik: add device tree support") from the pinctrl tree and
commit 6010d40320f8 ("ARM: nomadik: move GPIO and pinctrl to device
tree") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/pinctrl/pinctrl-nomadik.c
index 39c1651,ef21a66..0000000
--- a/drivers/pinctrl/pinctrl-nomadik.c
+++ b/drivers/pinctrl/pinctrl-nomadik.c
@@@ -2104,7 -1846,11 +2104,11 @@@ static struct pinctrl_desc nmk_pinctrl_
  
  static const struct of_device_id nmk_pinctrl_match[] = {
  	{
+ 		.compatible = "stericsson,nmk-pinctrl-stn8815",
+ 		.data = (void *)PINCTRL_NMK_STN8815,
+ 	},
+ 	{
 -		.compatible = "stericsson,nmk_pinctrl",
 +		.compatible = "stericsson,nmk-pinctrl",
  		.data = (void *)PINCTRL_NMK_DB8500,
  	},
  	{},
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130131/b17bd058/attachment.sig>
