From: linus.walleij@stericsson.com (Linus WALLEIJ)
Date: Thu, 24 Jun 2010 14:17:51 +0200
Subject: FW: Regression in next-20100618
Message-ID: <CEE6BB42CAD6E947908279175AF8470A025FD0D69A@EXDCVYMBSTM006.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looping in linux-arm-kernel in case there are more people having
this regression on -next since 20100618.

I verified that the regression also appears on U300, and I
suspect all platforms using PL011 to suffer from it, including
Versatile, RealView and SPEAr for example.

Symptom: garbage characters at TTY prompt after boot.

Trying to figure out what is causing this but failing :-/

Yours,
Linus Walleij

-----Original Message-----
From: Linus WALLEIJ 
Sent: den 23 juni 2010 23:54
To: 'Alan Cox'
Cc: 'Greg Kroah-Hartman'; 'linux-kernel at vger.kernel.org'
Subject: Regression in next-20100618

Hi Alan,

I have a regression in the next tree from 20100618, the prompt
freezes on the U8500. Drilling down with git bisecting found:

34ffc9670d67fe068f9d8582dd4d2a18d9a61205
Author: Alan Cox <alan@linux.intel.com>
Date:   Tue Jun 1 22:53:00 2010 +0200

    serial: Use block_til_ready helper

    Our code now rather closely resembles the helper, so switch to it.

    Signed-off-by: Alan Cox <alan@linux.intel.com>
    Cc: Arnd Bergmann <arnd@arndb.de>
    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

Reverting the commit makes the problem go away.

This platform is using drivers/serial/amba-pl011.c

Any ideas I could try out to help troubleshooting this one?
It could be that you're provoking some bug in amba-pl011.c.

Yours,
Linus Walleij
