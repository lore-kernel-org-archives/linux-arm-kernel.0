From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 17 Sep 2012 18:02:11 +1000
Subject: linux-next: manual merge of the arm-soc tree with the input tree
Message-ID: <20120917180211.de28c6e4ad5ed73ae43c162e@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/input/keyboard/omap-keypad.c between commit 9e14f36bb577 ("Input:
omap-keypad - fixed formatting") from the input tree and commit
f799a3d8fe17 ("Input: omap-keypad: Remove dependencies to mach includes")
from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).  Please resist white space only patches :-(

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/input/keyboard/omap-keypad.c
index b03c5b9,2bda5f0b..0000000
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@@ -421,10 -346,9 +346,9 @@@ err4
  err3:
  	device_remove_file(&pdev->dev, &dev_attr_enable);
  err2:
 -	for (i = row_idx - 1; i >=0; i--)
 +	for (i = row_idx - 1; i >= 0; i--)
  		gpio_free(row_gpios[i]);
- err1:
 -	for (i = col_idx - 1; i >=0; i--)
 +	for (i = col_idx - 1; i >= 0; i--)
  		gpio_free(col_gpios[i]);
  
  	kfree(omap_kp);
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120917/23138847/attachment.sig>
