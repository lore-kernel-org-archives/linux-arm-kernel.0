From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 13 Nov 2012 15:17:54 +1100
Subject: linux-next: manual merge of the arm-soc tree with the pinctrl tree
Message-ID: <20121113151754.98aa6471baaf062826c3b133@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/tty/serial/atmel_serial.c between commit 784557decc48 ("tty:
atmel_serial: add pinctrl support") from the pinctrl tree and commit
bcd2360c1ff9 ("arm: at91: move platfarm_data to
include/linux/platform_data/atmel.h") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/tty/serial/atmel_serial.c
index 65f891b,5660ec2..0000000
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@@ -39,7 -39,7 +39,8 @@@
  #include <linux/atmel_pdc.h>
  #include <linux/atmel_serial.h>
  #include <linux/uaccess.h>
 +#include <linux/pinctrl/consumer.h>
+ #include <linux/platform_data/atmel.h>
  
  #include <asm/io.h>
  #include <asm/ioctls.h>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121113/64cc7050/attachment.sig>
