From: joe@perches.com (Joe Perches)
Date: Tue, 03 Jul 2012 13:02:11 -0700
Subject: [PATCH 2 2/4] net ethernet introduce mac_la_ap helper
In-Reply-To: <1341246931.6578.10.camel@gandalf.stny.rr.com>
References: <20120702063545.26782.98908.stgit@build.warmcat.com>
 <20120702064054.26782.79849.stgit@build.warmcat.com>
 <201207021612.57028.arnd@arndb.de>
 <1341246931.6578.10.camel@gandalf.stny.rr.com>
Message-ID: <1341345731.2012.19.camel@joe2Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-07-02 at 12:35 -0400, Steven Rostedt wrote:
> On Mon, 2012-07-02 at 16:12 +0000, Arnd Bergmann wrote:
> 
> > >  include/net/mac-la-ap.h  |   28 ++++++++
> > >  net/Kconfig              |   14 ++++
> > >  net/ethernet/Makefile    |    2 +
> > >  net/ethernet/mac-la-ap.c |  165 ++++++++++++++++++++++++++++++++++++++++++++++
> > >  4 files changed, 209 insertions(+)
> > >  create mode 100644 include/net/mac-la-ap.h
> > >  create mode 100644 net/ethernet/mac-la-ap.c
> > > diff --git a/include/net/mac-la-ap.h b/include/net/mac-la-ap.h
> > > new file mode 100644
> > > index 0000000..d5189b5
> > > --- /dev/null
> > > +++ b/include/net/mac-la-ap.h
> > > @@ -0,0 +1,28 @@
> > > +/*
> > > + * mac-la-ap.h:  Locally Administered MAC address for Async probed devices
> > > + */
> > 
> > I find the name a bit non-obvious, not sure if we can come up with the
> > perfect one.
> > 
> > How about mac-platform?
> 
> I really find it unfortunate that 'mac' for ethernet has the same name
> as the Apple box as well. 'mac' in other contexts can usually
> differentiate these two, but saying 'mac-platform' just screams of
> forbidden fruit.
> 
> mac-probe.h ?

Maybe eth_mac_addr.h?

underscore filenames outnumber dash filenames ~2:1

$ git ls-files "*_*" | while read file ; do basename $file; done | grep "_" | wc -l
11185
$ git ls-files "*-*" | while read file ; do basename $file; done | grep "-" | wc -l
6624
