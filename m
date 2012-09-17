From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Mon, 17 Sep 2012 08:39:43 -0700
Subject: [PATCH v7 0/11] KGDB/KDB FIQ (NMI) debugger
In-Reply-To: <20120917125427.GA23516@kroah.com>
References: <20120913150133.GA16238@lizard> <20120917113750.GA28838@kroah.com>
 <50571ADF.3000406@windriver.com> <20120917125427.GA23516@kroah.com>
Message-ID: <20120917153943.GA7510@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2012 at 05:54:27AM -0700, Greg Kroah-Hartman wrote:
[...]
> > > To make it easier, can I just take the tty driver patches now?  Will
> > > that break anything?
> > 
> > I have not made my way through the entire series yet, so I am not sure
> > if you need the kdb header changes or not, but so far it looks like
> > the tty pieces are separate.  If you add your ack Greg, I'll take the
> > whole series and merge it into kgdb-next, or after I finish the review
> > we could do it the other way around.
> 
> Your tree is fine:
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Let me know if you have problems merging this due to any tty patches,
> and if so, I'll be glad to take them through my tree.

Guys, thanks for taking a look into this!

The patch that adds nmi console driver (i.e. tty/serial/kgdb_nmi.c)
depends on the first KDB patches in these series, and it depends on
amba-pl1011 and tty_port work, which is in tty-next.

So, the series have to go via tty-next; I believe Jason won't able
to take it via his tree.

Thanks,

Anton.
