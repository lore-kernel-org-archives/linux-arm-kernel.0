From: daniel@caiaq.de (Daniel Mack)
Date: Fri, 27 Nov 2009 11:16:54 +0100
Subject: USB support on i.MX27
In-Reply-To: <eedb5540911242252w62f0a1cfo3a3f24dfa060957b@mail.gmail.com>
References: <37367b3a0911240343u58e3b3d2le5d48e638348a3ad@mail.gmail.com>
	<eedb5540911242252w62f0a1cfo3a3f24dfa060957b@mail.gmail.com>
Message-ID: <20091127101654.GP14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2009 at 07:52:08AM +0100, javier Martin wrote:
> 2009/11/24 Alan Carvalho de Assis <acassis@gmail.com>
> 
> > Hi Javier,
> >
> > I am trying to add USB support to i.MX27 on mainline linux kernel, I
> > am following your modifications as in this post:
> >
> > "Re: Comment to "[PATCH 7/8] Add EHCI support for MX27 and MX31 based
> > boards"
> >
> > I can't find xcvr.h and isp1504_xcvr.h then I copied fsl_xcvr.h from
> > FSL kernel to mainline:
> >
> > alan at metropolis:~/ltib-patches/ltib/rpm/BUILD/linux$ cp
> > include/linux/usb/fsl_xcvr.h
> > ~/linux/pengutronix/linux-2.6/include/linux/usb/xcvr.h
> >
> > But I can't to figure out where to find isp1504_xcvr.h.
> >
> > Could you please help me to get USB working on iMX27ADS?
> >
> 
> Hum, normally the only thing you must be careful with is about enabling
> isp1504 transceiver through a GPIO.
> Also note that tests were issued with an early version of Daniel Mack's
> patches which AFAIK have been slightly modified since then, specially the
> part regarding to generic xcvr framework.

As I pointed out, the ISP1504 driver turned into a generic ULPI
transceiver driver eventually. And the code got some cleanup, but apart
from that, things are still like they used to be.

Daniel
