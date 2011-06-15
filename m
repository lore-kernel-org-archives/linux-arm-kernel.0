From: tony@atomide.com (Tony Lindgren)
Date: Wed, 15 Jun 2011 01:08:21 -0700
Subject: [PATCH 0/3] patches to allow DTB to be appended to the ARM zImage
In-Reply-To: <BANLkTim5C340ZB4Hu1xFQpHAkcWJEgKjMw@mail.gmail.com>
References: <1307858800-16712-1-git-send-email-nicolas.pitre@linaro.org>
	<201106142232.02217.arnd@arndb.de>
	<alpine.LFD.2.00.1106141650520.2142@xanadu.home>
	<201106142342.29405.arnd@arndb.de>
	<BANLkTim5C340ZB4Hu1xFQpHAkcWJEgKjMw@mail.gmail.com>
Message-ID: <20110615080821.GM23145@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grant Likely <grant.likely@secretlab.ca> [110614 15:02]:
> On Tue, Jun 14, 2011 at 3:42 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 14 June 2011 23:21:52 Nicolas Pitre wrote:
> >> Otherwise, if the revision number is effectively non probable, then I
> >> would guess it is the device tree's purpose to carry that information
> >> somehow, right? ?Maybe this can be appended to the board name string?
> >
> > That's what I meant with adding it to "compatible", which is a list of
> > strings with varying degrees of detailed information, e.g.
> >
> > ?ti,omap7
> > ?ti,omap7-squirrelboard
> > ?ti,omap7-squirrelboard-v3
> > ?ti,omap7-squirrelboard-v3.17b
> >
> > You can match the list against a specific revision or a less specific
> > identifier if you just want to know whether you are on a squirrelboard
> > or a hamsterboard.
> 
> Yes, that's generally the right way to handle it.  In practice I've
> not seen many cases where it is really required, but it doesn't hurt
> if somebody wants to include it in the DT for their board.

Appending the ATAG_REVISION to "compatible" and also setting system_rev
to ATAG_REVISION like we already do should work.

Just to clarify things abit: We just can't generate .dts files for all
existing hardware. It would require dumping out system_rev and other ATAGs
on tens or hundeds of pieces of hardware.

Regards,

Tony
