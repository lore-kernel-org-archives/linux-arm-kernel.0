From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 18 Sep 2017 10:11:09 +0200
Subject: Linux-next broken for 2 weeks was Re: n900 in next-20170901
In-Reply-To: <20170918020126.GA19200@js1304-P5Q-DELUXE>
References: <20170903203737.GA12475@amd> <20170905201314.GE5024@atomide.com>
 <20170905233241.GA19231@js1304-P5Q-DELUXE>
 <20170906133057.GH5024@atomide.com>
 <20170907073038.GA2111@js1304-P5Q-DELUXE>
 <20170907161650.GP5024@atomide.com> <20170915131817.GA19486@amd>
 <20170918020126.GA19200@js1304-P5Q-DELUXE>
Message-ID: <20170918081109.GA11661@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > > After commit 9caf25f996e8, user for CMA memory should use to check
> > > > PageHighmem in order to get proper virtual address of the page. If
> > > > someone doesn't use it, it is possible to use wrong virtual address
> > > > and it then causes the use of wrong physical address.
> > > > CONFIG_DEBUG_VIRTUAL would catch this case.
> > > 
> > > OK, no extra output of current next with CONFIG_DEBUG_VIRTUAL=y.
> > > Booting of n900 hangs with just the same error:
> > > 
> > > save_secure_sram() returns 0000ff02
> > > 
> > > > If it doesn't help, is there a way to test n900 configuration in QEMU?
> > > 
> > > I doubt that QEMU n900 boots in secure mode but instead shows
> > > the SoC as general purpose SoC. If so, you'd have to patch the
> > > omap3_save_secure_ram_context() to attempt to save secure RAM
> > > context in all cases. If that works then debugging with any
> > > omap3 board like beagleboard in QEMU should work.
> > 
> > Okay, linux-next from today still does not boot on n900. Is it
> > something new, or was this still not fixed in -next?
> 
> Hello,
> 
> Still not fixed in -next since I cannot regenerate the error.

Unfortunately, rest of the world can reproduce the error, and it means
linux-next is useless for us.

I'd expect you to drop the relevant tree from linux-next when the
error was reported. Clearly, those patches are unsuitable for 4.15, as
they are broken, so they should not be in linux-next.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170918/2e123912/attachment.sig>
