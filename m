From: manu@bidouilliste.com (Emmanuel Vadot)
Date: Thu, 1 Dec 2016 11:24:14 +0100
Subject: [PATCH] ARM: dts: sunxi: Add num-cs for A20 spi nodes
In-Reply-To: <20161201092150.rlo5skxd6elovlgq@lukather>
References: <20161122170616.29557-1-manu@bidouilliste.com>
 <20161124195517.qrq7briu3pwjnp4n@lukather>
 <20161124210509.be743aae84c26c6c2e666c6e@bidouilliste.com>
 <20161125152047.oadxi2xbgm4kdd7q@lukather>
 <20161125220752.c989c85e01ed202be0485c78@bidouilliste.com>
 <20161201092150.rlo5skxd6elovlgq@lukather>
Message-ID: <20161201112414.62f9b351186115f62c8998a9@bidouilliste.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


 Hi Maxime,

On Thu, 1 Dec 2016 10:21:50 +0100
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> Hi Emmanuel,
> 
> On Fri, Nov 25, 2016 at 10:07:52PM +0100, Emmanuel Vadot wrote:
> > On Fri, 25 Nov 2016 16:20:47 +0100
> > Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> > 
> > > On Thu, Nov 24, 2016 at 09:05:09PM +0100, Emmanuel Vadot wrote:
> > > > On Thu, 24 Nov 2016 20:55:17 +0100
> > > > Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> > > > 
> > > > > On Tue, Nov 22, 2016 at 06:06:16PM +0100, Emmanuel Vadot wrote:
> > > > > > The spi0 controller on the A20 have up to 4 CS (Chip Select) while the
> > > > > > others three only have 1.
> > > > > > Add the num-cs property to each node.
> > > > > > 
> > > > > > Signed-off-by: Emmanuel Vadot <manu@bidouilliste.com>
> > > > > 
> > > > > I don't think we have any code that uses it at the moment. What is the
> > > > > rationale behind this patch?
> > > > > 
> > > > > Thanks!
> > > > > Maxime
> > > > > 
> > > > > -- 
> > > > > Maxime Ripard, Free Electrons
> > > > > Embedded Linux and Kernel engineering
> > > > > http://free-electrons.com
> > > > 
> > > >  Hi Maxime,
> > > > 
> > > >  If num-cs isn't present nothing prevent to start a transfer with a
> > > > non-valid CS pin, resulting in an error.
> > > >  num-cs are default property especially made for this and a SPI driver
> > > > should try to get the property at probe/attach time.
> > > 
> > > Yes, but as far as I know, our driver doesn't. I'm all in for having
> > > support for that in our driver, but without it, that patch is kind of
> > > useless.
> > 
> >  Yes the Linux driver doesn't use it but my upcoming one for FreeBSD
> > uses it. So it is not useless for downstream user of DTS.
> 
> Ah, I didn't know this was for FreeBSD. So you started to use our DTs,
> or do you have some modifications to it? How does that work?

 Yes we use the DTS from linux from quite some times now. We're
currently synced with 4.7-ish.
 We either use them directly or modify them according to our needs and
driver support.

> Anyway, the fact that it isn't used by our driver at the moment and
> that it's meant for other OSes should be mentionned in the commit log.

 Yeah I understand, I'll send a v2 with this in the commit log.

> Thanks!
> Maxime
> 
> -- 
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com


-- 
Emmanuel Vadot <manu@bidouilliste.com> <manu@freebsd.org>
