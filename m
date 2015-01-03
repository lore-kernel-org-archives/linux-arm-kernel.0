From: dev@lynxeye.de (Lucas Stach)
Date: Sat, 03 Jan 2015 20:50:24 +0100
Subject: Tegra 2 T20 NAND Flash Support
In-Reply-To: <1401903129.9454.2.camel@tellur>
References: <538E6FB5.5020806@ziswiler.com> <1401866283.2173.3.camel@tellur>
 <538EC96A.4050702@ziswiler.com> <20140604144134.GH28484@ulmo>
 <1401903129.9454.2.camel@tellur>
Message-ID: <1420314624.2169.6.camel@lynxeye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 04.06.2014, 19:32 +0200 schrieb Lucas Stach:
> Am Mittwoch, den 04.06.2014, 16:41 +0200 schrieb Thierry Reding:
> > On Wed, Jun 04, 2014 at 09:23:22AM +0200, Marcel Ziswiler wrote:
> > > On 06/04/2014 09:18 AM, Lucas Stach wrote:
> > > >I took the Linux Tegra NAND driver from Thierry and cleaned it up quite
> > > >a bit. It now works with both ONFI and non-ONFI NAND, at least for
> > > >reading. Writing doesn't quite work yet and I've got side-tracked with
> > > >other stuff.
> > > >
> > > >If you are interested in moving this forward I can put up my WIP patches
> > > >to some public location.
> > > 
> > > Sounds great, yes. That would be perfect, thanks.
> > > 
> > > We even once got an universal NAND test infrastructure from Micron based on
> > > a re-worked Colibri T20 which we could use to validate it with various NAND
> > > flash parts.
> > 
> > Excellent, I would've had a hard time digging up those patches. It's
> > really been quite a while.
> > 
> I've put up a rebased version of the patches at
> 
> git://git.pengutronix.de/git/lst/linux.git tegra-nand
> 
For those still interested:
I've continued to work on this for the last few days and pushed a new
version of my WIP to the above location.

It is now in a state where the in-kernel mtd tests seem to be happy with
it. Also creating/using a filesystem on top of the mtdblock device seems
to work properly.

I still need to validate that anything using the OOB areas is working
properly. The last missing feature is BCH ECC support, but that should
be easy to add.

I don't know if it still needs some performance tuning. 5MB/s write and
12,5MB/s read on a Colibri T20 seem pretty slow me, but I have nothing
to compare with ATM.
Marcel could you maybe dig out some benchmarks with L4T?

Regards,
Lucas
