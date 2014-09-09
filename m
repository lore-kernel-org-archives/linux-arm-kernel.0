From: bhupesh.sharma@freescale.com (bhupesh.sharma at freescale.com)
Date: Tue, 9 Sep 2014 11:46:18 +0000
Subject: [PATCH V3 0/6] ARM64: Add support for FSL's LS2085A SoC
In-Reply-To: <3563146.jh46O3eIbG@wuerfel>
References: <1409757194-28155-1-git-send-email-bhupesh.sharma@freescale.com>
 <6499926.sQm3J8L764@wuerfel> <20140904091319.GA32228@leverpostej>
 <3563146.jh46O3eIbG@wuerfel>
Message-ID: <04e8fff8fb044e8ea5ffe92bfe029d6c@BN1PR03MB220.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark, Arnd

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Thursday, September 04, 2014 3:09 PM
> To: Mark Rutland
> Cc: linux-arm-kernel at lists.infradead.org; rob.herring at linaro.org; Sharma
> Bhupesh-B45370; Catalin Marinas; Will Deacon; Yoder Stuart-B08248;
> grant.likely at secretlab.ca; Marc Zyngier; Basu Arnab-B45036; Geoff Levand
> Subject: Re: [PATCH V3 0/6] ARM64: Add support for FSL's LS2085A SoC
> 
> On Thursday 04 September 2014 10:13:19 Mark Rutland wrote:
> > On Wed, Sep 03, 2014 at 07:31:44PM +0100, Arnd Bergmann wrote:
> > > On Wednesday 03 September 2014 17:31:30 Mark Rutland wrote:
> > > >
> > > > However, I'm not sure I follow the reasoning for making this
> > > > significantly harder, and even ignoring that I don't think this
> > > > does make things significantly harder. Especially so if we have a
> > > > PSCI node but not an enable method -- in that case its trivial to
> > > > patch in an unrelated enable-method anyhow.
> > >
> > > Right, it's not actually much harder. A better way to look at it is
> > > probably that we document what which parts we expect to stay
> > > constant and which parts are to be filled out by the boot loader.
> > > Independent of what PSCI implementation the boot loader provides, we
> > > would like to see enable-method="psci".
> >
> > So in the /cpus node, have a comment like:
> >
> > /*
> >  * We expect the enable-method to be "psci", but this is dependent on
> >  * the FW, which will fill this in.
> >  */
> 
> I was thinking of leaving the enable-method in the cpus node, but having
> an empty psci node with a similar comment.
> 
> > Or, should we put together a soc-guidance.txt with that, ensuring
> > things are initialised correctly (CNTVOFF, CNTFREQ), etc?
> 
> I would very much welcome documentation like that!

Is this documentation planned (already being worked upon), or should I try to spin-out a RFC patch
which tries to add this guidance documentation.

Regards,
Bhupesh

> 
> > > I just saw that Geoff had a related comment, and documenting this
> > > would make it clearer to other reviewers, as well as people that
> > > happen to look at this file as a base for new platforms.
> >
> > I agree that having something to point people in the right direction
> > is a good idea. The only point I disagree with is putitng something in
> > the DT that can be trivially made false (and possibly with good
> reason).
> >
> > I'm happy with having comments.
> 
> Right, but I see no good reason for having something else in the enable-
> method, the only way I can see why that would be done is for the boot
> loader or firmware implementer to be misinformed.
> 
> 	Arnd
