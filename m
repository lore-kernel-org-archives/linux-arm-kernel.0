From: manu@bidouilliste.com (Emmanuel Vadot)
Date: Mon, 5 Dec 2016 10:39:06 +0100
Subject: [PATCH] ARM: dts: sunxi: Add num-cs for A20 spi nodes
In-Reply-To: <20161205092821.m2fmqxnzalcignly@lukather>
References: <20161122170616.29557-1-manu@bidouilliste.com>
 <20161124195517.qrq7briu3pwjnp4n@lukather>
 <20161124210509.be743aae84c26c6c2e666c6e@bidouilliste.com>
 <20161125152047.oadxi2xbgm4kdd7q@lukather>
 <20161125220752.c989c85e01ed202be0485c78@bidouilliste.com>
 <20161201092150.rlo5skxd6elovlgq@lukather>
 <20161201112414.62f9b351186115f62c8998a9@bidouilliste.com>
 <20161205092821.m2fmqxnzalcignly@lukather>
Message-ID: <20161205103906.3f7ffc1c86a49825a9a1cbb1@bidouilliste.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 5 Dec 2016 10:28:21 +0100
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> On Thu, Dec 01, 2016 at 11:24:14AM +0100, Emmanuel Vadot wrote:
> > > > > >  If num-cs isn't present nothing prevent to start a transfer
> > > > > > with a non-valid CS pin, resulting in an error.  num-cs are
> > > > > > default property especially made for this and a SPI driver
> > > > > > should try to get the property at probe/attach time.
> > > > > 
> > > > > Yes, but as far as I know, our driver doesn't. I'm all in for
> > > > > having support for that in our driver, but without it, that
> > > > > patch is kind of useless.
> > > > 
> > > >  Yes the Linux driver doesn't use it but my upcoming one for FreeBSD
> > > > uses it. So it is not useless for downstream user of DTS.
> > > 
> > > Ah, I didn't know this was for FreeBSD. So you started to use our DTs,
> > > or do you have some modifications to it? How does that work?
> > 
> > Yes we use the DTS from linux from quite some times now. We're
> > currently synced with 4.7-ish.  We either use them directly or
> > modify them according to our needs and driver support.
> 
> Do you have a link to those modifications?
> 
> Thanks,
> Maxime
> 
> -- 
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com

 Sure,

 https://svnweb.freebsd.org/base/head/sys/boot/fdt/dts/arm/

-- 
Emmanuel Vadot <manu@bidouilliste.com> <manu@freebsd.org>
