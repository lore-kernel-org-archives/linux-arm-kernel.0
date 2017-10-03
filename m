From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 3 Oct 2017 11:38:24 +0200
Subject: i2c-omap.c vs. qemu: too much work in one irq (and broken boot)
In-Reply-To: <20171002072331.GB25930@pali>
References: <20171001204215.GA9928@amd> <20171001221935.GA29628@amd>
 <20171002072331.GB25930@pali>
Message-ID: <20171003093824.GA3769@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > I'm trying to get qemu emulation of Nokia N900 to work, but
> > > unfortunately i2c-omap.c breaks boot in the emulator (real hardware
> > > works ok).
> > 
> > I started bisection. v4.6 works, v4.7 is broken. (It still may be
> > config difference or something).
> > 
> > This looked suspect, so I tried reverting it, but it did not help. And
> > it is only significant change in i2c-omap.c. So... this may be a lot
> > of fun.
> > 
> > commit 126a66caec4a00b8d66dbc3174b0efa905cf68c3
> > Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Date:   Mon Apr 4 16:55:23 2016 +0300
> > 
> > Unfortunately, mmc is broken in v4.6, so its useless for
> > emulation... [ 3.236724] mmc1: error -22 whilst initialising SDIO card
> 
> Hi! You can apply special patch to make mmc work in both qemu and real
> N900 device for previous kernel versions...
> 
> https://github.com/pali/linux-n900/commit/eb080ecdcfc5868d8e36d0f5f42d9cb7f13b4db9

Thanks a lot, this fixes mmc for me.

But I'm still stuck with v4.6 kernel for qemu. Do newer kernels work
there for anyone?

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171003/dfb777a6/attachment.sig>
