From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Thu, 11 Feb 2016 11:28:52 -0500
Subject: [PATCH v2 1/6] Revert "drivers/tty/serial: make 8250/8250_mtk.c
 explicitly non-modular"
In-Reply-To: <3873766.I9XIY0R8gT@wuerfel>
References: <1455205297-1021302-1-git-send-email-arnd@arndb.de>
 <1455205297-1021302-2-git-send-email-arnd@arndb.de>
 <20160211160021.GF28452@windriver.com> <3873766.I9XIY0R8gT@wuerfel>
Message-ID: <20160211162852.GJ28452@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Re: [PATCH v2 1/6] Revert "drivers/tty/serial: make 8250/8250_mtk.c explicitly non-modular"] On 11/02/2016 (Thu 17:06) Arnd Bergmann wrote:

> On Thursday 11 February 2016 11:00:22 Paul Gortmaker wrote:
> > [[PATCH v2 1/6] Revert "drivers/tty/serial: make 8250/8250_mtk.c explicitly non-modular"] On 11/02/2016 (Thu 16:41) Arnd Bergmann wrote:
> > 
> > > This reverts commit d72d391c126e, which tried to remove dead code but
> > > left the driver in a useless state when the main 8250 driver is a
> > 
> > Am I misunderstanding something?  The commit didn't cause the driver to
> > be in a useless state for 8250=m.  But rather isn't that it was a
> > pre-existing condition, independent of the change to 8250_mtk.c to
> > remove the dead code in d72d391c126e?
> > 
> > Since the commit did not touch Kconfig or Makefile, I can't see how it
> > could cause some new useless state that did not already exist, and hence
> > the "Fixes:" tag is invalid as well.
> 
> My wording may have been bad here. What I meant to say is that it
> was broken before the patch, and still broken after the patch.

OK, no problem. I just didn't want Greg/Jiri to think I was sending them
broken commits.   Will need a v3 to get rid of the extra module.h
anyway, so that gives you a chance to reword.

> 
> The Fixes tag was meant to just be a reference to the commit I'm
> reverting.

Yeah, but since the stable people trigger off of that, and since the
revert doesn't really fix anything, that is probably best removed.
The stable trees don't need the revert.

Thanks,
Paul.
--
> 
> 	Arnd
