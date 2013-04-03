From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed, 3 Apr 2013 09:25:24 +0200
Subject: [PATCH 04/10] arm: zynq: Load scu baseaddress at run time
In-Reply-To: <CAHTX3dKD4G0E8qoxTR2HnJVdagoeOerM+TiZzkJUPjcGwYdX_Q@mail.gmail.com>
References: <1364219596-4954-1-git-send-email-michal.simek@xilinx.com>
 <1364219596-4954-4-git-send-email-michal.simek@xilinx.com>
 <515059D4.5070903@gmail.com>
 <CAHTX3dJfvFNNuyJC54fS=NCpRxovVsxHTss8wJd_QOB2PaxL7g@mail.gmail.com>
 <51506F31.2080709@gmail.com>
 <CAHTX3d+1auKVLko+LKAA+a4rh4Rfw19ggzmS7DhvYuuCAWUwHA@mail.gmail.com>
 <1364920809.3019.30.camel@hornet>
 <CAHTX3dKD4G0E8qoxTR2HnJVdagoeOerM+TiZzkJUPjcGwYdX_Q@mail.gmail.com>
Message-ID: <20130403072524.GC32161@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 03, 2013 at 08:33:19AM +0200, Michal Simek wrote:
> Hi
> 
> 2013/4/2 Pawel Moll <pawel.moll@arm.com>
> 
> > Greetings,
> >
> > Apologies about "slightly" delayed response.
> >
> > On Mon, 2013-03-25 at 16:07 +0000, Michal Simek wrote:
> > > Pawel: You are the author of this code in vexpress. Is there any
> > > particular reason
> > > to have there that ioremap?
> >
> > At the time there was no standard DT->platsmp solution and the
> > traditional way was using the SCU to work out the CPUs.
> >
> > If I was doing this today (and I'll re-do this code at some point) I'd
> > rely on the DT in the first place and maybe then have a SCU
> > "micro-driver" double-checking the DT data against the SCU information.
> > That way I could reduce the dependency on static mappings. And this is
> > what I want to get - if possible I don't want any static mapping at all.
> >
> 
> Sure. Currently I want to use that static mapping because I know that user
> DTSes are just wrong and relating on HW is better for me right now.
> 

Wouldn't we risk getting more faulty DTSes instead of stopping them?
If you stop the support starting with kernel 3.xx everyone has to fix
their *.dts and be done with it.

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
