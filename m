From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 4 Jun 2013 10:10:30 +0200
Subject: [PATCH] ARM: atags: add support for Marvell's u-boot
In-Reply-To: <alpine.LFD.2.03.1306031502450.1200@syhkavp.arg>
References: <1370277937-2965-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130603171017.GN18614@n2100.arm.linux.org.uk>
 <20130603175629.GH5008@1wt.eu>
 <20130603181437.GO3803@titan.lakedaemon.net>
 <20130603183057.GA9868@1wt.eu>
 <20130603184148.GQ3803@titan.lakedaemon.net>
 <alpine.LFD.2.03.1306031502450.1200@syhkavp.arg>
Message-ID: <20130604101030.232b3743@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Nicolas Pitre,

On Mon, 03 Jun 2013 15:07:45 -0400 (EDT), Nicolas Pitre wrote:

> Isn't upstream U-Boot supporting Marvell devices properly these days?  

No, upstream U-Boot has no support for Armada 370 and Armada XP.
Sebastian and I have started adding support for Armada 370 and Armada
XP in Barebox, but it's gonna take a while before it has enough
features to be practically useful.

And as Jason said, even though Armada 370 and Armada XP have a working
UART-based recovery method, users are also scared of doing bootloader
updates, and on some consumer products, the UART is not necessarily
easily available to the average users (may need some soldering skills,
a level-shifter to use the TTL UART of the board, etc.).

Practically, even on platforms such as Kirkwood that do have upstream
U-Boot support, I believe the vast majority of people are still running
the original U-Boot, even though they decided to use an upstream kernel
by installing for example Debian on their NAS. So the use case of a
mainline kernel on a Marvell-specific U-Boot should be supported is
pretty common.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
