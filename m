From: horms@verge.net.au (Simon Horman)
Date: Tue, 2 Apr 2013 11:24:34 +0900
Subject: [PATCH 3/3 v2] ARM: shmobile: bockw: add SMSC ethernet support
In-Reply-To: <87zjxh6b8t.wl%kuninori.morimoto.gx@renesas.com>
References: <87zjxvewko.wl%kuninori.morimoto.gx@renesas.com>
 <87fvzb56n3.wl%kuninori.morimoto.gx@renesas.com>
 <87bo9z56k8.wl%kuninori.morimoto.gx@renesas.com>
 <515982A8.3090307@cogentembedded.com>
 <87zjxh6b8t.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20130402022433.GA4469@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 01, 2013 at 05:13:10PM -0700, Kuninori Morimoto wrote:
> 
> Hi Sergei, Simon
> 
> > >   	chosen {
> > > -		bootargs = "console=ttySC0,115200 ignore_loglevel";
> > > +		bootargs = "console=ttySC0,115200 ignore_loglevel ip=dhcp root=/dev/nfs";
> > >   	};
> > >
> > >   	memory {
> > 
> >     In my opinion, modifying .dts file should be done in a separate patch.
> (snip)
> > >   # CONFIG_SCHED_DEBUG is not set
> > >   # CONFIG_DEBUG_BUGVERBOSE is not set
> > >   # CONFIG_FTRACE is not set
> > >   # CONFIG_ARM_UNWIND is not set
> > > -CONFIG_KEYS=y
> > > -CONFIG_CRYPTO=y
> > >   CONFIG_AVERAGE=y
> > 
> >     In my opinion, modifying bockw_defconfig should be done in a separate 
> > patch. Mixing everything up in a signle patch is a bad practice.
> 
> It depends on LTSI backport / upstreaming I believe.
> I need Simon's opinion

I have no strong opinions on this, but in general breaking up patches
makes my life easier. So long as the individual patches don't are useful
and don't break anything :^)
