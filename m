From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 17 Sep 2012 05:54:27 -0700
Subject: [PATCH v7 0/11] KGDB/KDB FIQ (NMI) debugger
In-Reply-To: <50571ADF.3000406@windriver.com>
References: <20120913150133.GA16238@lizard> <20120917113750.GA28838@kroah.com>
 <50571ADF.3000406@windriver.com>
Message-ID: <20120917125427.GA23516@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2012 at 07:43:11AM -0500, Jason Wessel wrote:
> On 09/17/2012 06:37 AM, Greg Kroah-Hartman wrote:
> > On Thu, Sep 13, 2012 at 08:01:33AM -0700, Anton Vorontsov wrote:
> >> Hi all,
> >>
> >> Here comes the lucky v7:
> >>
> >> - Per Alan Cox's suggestion added hangup method and removed a small
> >>   leftover;
> >> - Per Colin Cross' suggestion moved IRQ quiescing logic into
> >>   poll_get_char routine. IIUC, Alan is less unhappy about it.  As a
> >>   result, clear_irq() callback dropped.
> >>
> >> These patches can be found in the following repo (based on tty-next):
> >>
> >> 	git://git.infradead.org/users/cbou/linux-nmi-kdb.git master
> >>
> >> Old changelogs and rationale for these patches can be found here:
> >>
> >> 	v1-v5, rationale: http://lkml.org/lkml/2012/9/10/2
> >> 	v6: http://lkml.org/lkml/2012/9/10/2
> > I have no objection to these patches, and as they are based on my
> > tty-next tree, should I be the ones accepting them?  If so, then I need
> > a bunch of acks from others involved in the kdb/kgdb code before I can
> > do so.
> >
> > To make it easier, can I just take the tty driver patches now?  Will
> > that break anything?
> 
> I have not made my way through the entire series yet, so I am not sure
> if you need the kdb header changes or not, but so far it looks like
> the tty pieces are separate.  If you add your ack Greg, I'll take the
> whole series and merge it into kgdb-next, or after I finish the review
> we could do it the other way around.

Your tree is fine:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Let me know if you have problems merging this due to any tty patches,
and if so, I'll be glad to take them through my tree.

greg k-h
