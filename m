From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 3 Mar 2011 14:20:57 +0100
Subject: Compiling a kernel for armv5 + armv6
Message-ID: <20110303132056.GB18351@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Doing so currently breaks with:

arch/arm/kernel/entry-armv.S: Assembler messages:
arch/arm/kernel/entry-armv.S:196: Error: selected processor does not support `strex r1,r2,[sp]'
arch/arm/kernel/entry-armv.S:228: Error: selected processor does not support `strex r1,r2,[sp]'
arch/arm/kernel/entry-armv.S:286: Error: selected processor does not support `strex r1,r2,[sp]'
arch/arm/kernel/entry-armv.S:323: Error: selected processor does not support `strex r1,r2,[sp]'

These are used in svc_exit and restore_user_regs.

Is there a way to fix this or do we have to live with this?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
