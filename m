From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 4 Jun 2010 13:06:59 +0200
Subject: Heads up: Linus plans to kill ARM defconfigs
In-Reply-To: <201006032155.19349.marek.vasut@gmail.com>
References: <20100603192459.GA9169@n2100.arm.linux.org.uk>
	<201006032155.19349.marek.vasut@gmail.com>
Message-ID: <20100604110659.GA14543@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 03, 2010 at 09:55:19PM +0200, Marek Vasut wrote:
> Dne ?t 3. ?ervna 2010 21:24:59 Russell King - ARM Linux napsal(a):
> > The subject says everything you need to know.  Randy provided this
> > link earlier:
> > 
> >   http://lkml.org/lkml/2010/6/2/472
> > 
> > Linus doesn't appear to be listening to reason, so I see now this as
> > a fait accompli.  It'll apparantly happen at the next merge window.
> 
> The defconfigs age ... there's no point keeping them. They'll be useless crap 
> unless someone updates them often anyway.
Some time ago I wrote a little script that minimized a .config and
applied it to ns9xxx_defconfig.

The result is that ns9xxx_defconfig only has 79 lines while the average
is >1200.  (I have to admit that ns9xxx isn't complete by far as there
are no device drivers in tree, but anyhow, after $(make
ns9xxx_defconfig) the resulting .config has 1181 lines.) Would it already
help to apply it to all defconfigs?  A nice effect is that changes to
these small files are smaller and so easier to understand.  IIRC I posted
the script to linux-kbuild back then.  I can try to find and apply it
before the next merge window.

And I want to point out that there are efforts to merge all arch-mx* and
plat-mxc and so reduce the number of defconfigs from seven[1] to one.
Eric picked up on the runtime-physoffset patches that are currently a
stopper for (AFAIK) several merges.

Best regards
Uwe

[1] IIRC I recently saw a patch that adds mx25_defconfig, so there are
even eight imx defconfigs.

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
