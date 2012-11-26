From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 26 Nov 2012 21:31:52 +1100
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
Message-ID: <20121126213152.60b52e19d7fc84ce94c356c3@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/tty/serial/atmel_serial.c between commit 95e629b761ce
("ARM/AVR32: get rid of serial_at91.h") from the arm tree and commit
bcd2360c1ff9 ("arm: at91: move platfarm_data to
include/linux/platform_data/atmel.h") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/tty/serial/atmel_serial.c
index 1a8a271,5660ec2..0000000
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@@ -39,13 -39,13 +39,12 @@@
  #include <linux/atmel_pdc.h>
  #include <linux/atmel_serial.h>
  #include <linux/uaccess.h>
 +#include <linux/pinctrl/consumer.h>
+ #include <linux/platform_data/atmel.h>
  
  #include <asm/io.h>
  #include <asm/ioctls.h>
  
- #include <mach/board.h>
- 
 -#include <asm/mach/serial_at91.h>
 -
  #ifdef CONFIG_ARM
  #include <mach/cpu.h>
  #include <asm/gpio.h>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121126/7ad920e4/attachment.sig>
