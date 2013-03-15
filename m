From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 15 Mar 2013 16:46:45 -0500
Subject: ep93xx irq-vic regression
Message-ID: <ADE657CA350FB648AAC2C43247A983F0020980106C9F@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello all,

Yesterday I tried upgrading my ep93xx system from 3.6.6 to 3.8.3.
The kernel compiles fine but the machine would not boot. It just
hangs when the bootloader (RedBoot) tries to exec the kernel.

I then tried 3.7.0 and it works fine.

I did a bisect and got down to this commit:

$ git bisect bad
07c9249f1fa90cc8189bed44c0bcece664596a72 is the first bad commit
commit 07c9249f1fa90cc8189bed44c0bcece664596a72
Author: Linus Walleij <linus.walleij@linaro.org>
Date:   Tue Oct 16 18:50:00 2012 +0100

    ARM: 7554/1: VIC: use irq_domain_add_simple()

Any ideas on what might be the problem?

Regards,
Hartley
