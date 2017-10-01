From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 2 Oct 2017 00:19:35 +0200
Subject: i2c-omap.c vs. qemu: too much work in one irq (and broken boot)
In-Reply-To: <20171001204215.GA9928@amd>
References: <20171001204215.GA9928@amd>
Message-ID: <20171001221935.GA29628@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> I'm trying to get qemu emulation of Nokia N900 to work, but
> unfortunately i2c-omap.c breaks boot in the emulator (real hardware
> works ok).

I started bisection. v4.6 works, v4.7 is broken. (It still may be
config difference or something).

This looked suspect, so I tried reverting it, but it did not help. And
it is only significant change in i2c-omap.c. So... this may be a lot
of fun.

commit 126a66caec4a00b8d66dbc3174b0efa905cf68c3
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Mon Apr 4 16:55:23 2016 +0300

Unfortunately, mmc is broken in v4.6, so its useless for
emulation... [ 3.236724] mmc1: error -22 whilst initialising SDIO card

Ideas?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171002/df3ab2e2/attachment.sig>
