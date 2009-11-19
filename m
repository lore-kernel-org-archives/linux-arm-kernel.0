From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 19 Nov 2009 18:53:27 +0100
Subject: i.MX audio support
In-Reply-To: <20091119162830.GA31336@rakim.wolfsonmicro.main>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<20091119162830.GA31336@rakim.wolfsonmicro.main>
Message-ID: <20091119175327.GV30179@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Thu, Nov 19, 2009 at 04:28:30PM +0000, Mark Brown wrote:
> On Thu, Nov 19, 2009 at 04:48:14PM +0100, Sascha Hauer wrote:
> 
> > There already is a driver for i.MX in the tree, this one is a nearly complete
> > rewrite. I haven't touched the in Kernel driver with these patches. The in
> > Kernel driver has several problems, it doesn't use ioremap, uses direct pointer
> > derefs instead of proper access functions and the only board supported so far is
> > itself not supported in mainline.
> 
> I've CCed in Javier who wrote the currently merged code.
> 
> I'll review these patches tomorrow or over the weekend, however this
> jumps out at me as being something that we'd want to fix before merging
> since having two drivers for the same bit of hardware always leads to
> problems going forwards.  I don't mind how this is addressed, replacing
> the existing driver or incrementally fixing it would both work for me
> (the latter is obviously preferrable but equally well we don't want to
> get bogged down).

My work isn't based on the mainline driver but some older (also
Freescale based) code. Putting this into an incremental series would
mean quite some work.
Lets wait for your review before making further decisions.

> 
> The approach of using FIQ for i.MX3x until SDMA gets merged seems like a
> reasonable one.  It's not ideal but it will work and it shouldn't create
> any problems transitioning to SDMA when that is submitted.

Which is in unforseeable future. So far I haven't seen anyone getting
far on this task.

> 
> BTW, might be nice to use --no-chain-reply-to for git send-email - it
> makes long patch sets look a lot nicer in a threaded mail reader.  Not a
> big deal, though.

I usually use the chain reply option because otherwise the patches
sometimes get the wrong order when doing git am on a mailbox.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
