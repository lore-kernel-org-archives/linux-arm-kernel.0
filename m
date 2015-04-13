From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Mon, 13 Apr 2015 06:49:30 -0700
Subject: [Xen-devel] "tcp: refine TSO autosizing" causes performance
 regression on Xen
In-Reply-To: <CAFLBxZaVjFHh4UBnksGZS4waBr4jLdO8aJegyKvsU1-TvVt2Dg@mail.gmail.com>
References: <alpine.DEB.2.02.1504091344260.7690@kaball.uk.xensource.com>
 <1428596218.25985.263.camel@edumazet-glaptop2.roam.corp.google.com>
 <alpine.DEB.2.02.1504091729160.7690@kaball.uk.xensource.com>
 <CAFLBxZaVjFHh4UBnksGZS4waBr4jLdO8aJegyKvsU1-TvVt2Dg@mail.gmail.com>
Message-ID: <1428932970.3834.4.camel@edumazet-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-04-13 at 11:56 +0100, George Dunlap wrote:

> Is the problem perhaps that netback/netfront delays TX completion?
> Would it be better to see if that can be addressed properly, so that
> the original purpose of the patch (fighting bufferbloat) can be
> achieved while not degrading performance for Xen?  Or at least, so
> that people get decent perfomance out of the box without having to
> tweak TCP parameters?

Sure, please provide a patch, that does not break back pressure.

But just in case, if Xen performance relied on bufferbloat, it might be
very difficult to reach a stable equilibrium : Any small change in stack
or scheduling might introduce a significant difference in 'raw
performance'.
