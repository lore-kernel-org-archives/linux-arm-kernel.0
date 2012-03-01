From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 1 Mar 2012 16:40:01 +1100
Subject: linux-next: manual merge of the arm-soc tree with the gpio tree
Message-ID: <20120301164001.77a063ceed2deaf37cf68e3c@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got conflicts in
arch/arm/mach-omap1/gpio16xx.c between commit ab985f0f7c2c ("gpio/omap:
cleanup omap_gpio_mod_init function") from the gpio tree and commit
63325ff235de ("ARM: OMAP1: Move 16xx GPIO system clock to platform init
code") from the arm-soc tree.

OK, I can't decide which is correct here - the former adds this code
inside the loop (even though it seems to not depend on anything in the
loop) and the latter adds it before.  I have used the former (but am
happy to be corrected).  And both commits remove the code in
drivers/gpio/gpio-omap.c.

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120301/65462ffa/attachment.sig>
