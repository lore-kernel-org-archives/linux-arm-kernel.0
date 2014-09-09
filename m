From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 9 Sep 2014 14:42:26 +0100
Subject: [PATCH V3 0/6] ARM64: Add support for FSL's LS2085A SoC
In-Reply-To: <04e8fff8fb044e8ea5ffe92bfe029d6c@BN1PR03MB220.namprd03.prod.outlook.com>
References: <1409757194-28155-1-git-send-email-bhupesh.sharma@freescale.com>
 <6499926.sQm3J8L764@wuerfel> <20140904091319.GA32228@leverpostej>
 <3563146.jh46O3eIbG@wuerfel>
 <04e8fff8fb044e8ea5ffe92bfe029d6c@BN1PR03MB220.namprd03.prod.outlook.com>
Message-ID: <20140909134226.GF29639@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 09, 2014 at 12:46:18PM +0100, bhupesh.sharma at freescale.com wrote:
> > On Thursday 04 September 2014 10:13:19 Mark Rutland wrote:
> > > On Wed, Sep 03, 2014 at 07:31:44PM +0100, Arnd Bergmann wrote:
> > > > On Wednesday 03 September 2014 17:31:30 Mark Rutland wrote:
> > > > >
> > > > > However, I'm not sure I follow the reasoning for making this
> > > > > significantly harder, and even ignoring that I don't think this
> > > > > does make things significantly harder. Especially so if we have a
> > > > > PSCI node but not an enable method -- in that case its trivial to
> > > > > patch in an unrelated enable-method anyhow.
> > > >
> > > > Right, it's not actually much harder. A better way to look at it is
> > > > probably that we document what which parts we expect to stay
> > > > constant and which parts are to be filled out by the boot loader.
> > > > Independent of what PSCI implementation the boot loader provides, we
> > > > would like to see enable-method="psci".
> > >
> > > So in the /cpus node, have a comment like:
> > >
> > > /*
> > >  * We expect the enable-method to be "psci", but this is dependent on
> > >  * the FW, which will fill this in.
> > >  */
> > 
> > I was thinking of leaving the enable-method in the cpus node, but having
> > an empty psci node with a similar comment.
> > 
> > > Or, should we put together a soc-guidance.txt with that, ensuring
> > > things are initialised correctly (CNTVOFF, CNTFREQ), etc?
> > 
> > I would very much welcome documentation like that!
> 
> Is this documentation planned (already being worked upon), or should I
> try to spin-out a RFC patch which tries to add this guidance
> documentation.

RFCs are welcome. We had such thing on the random to-do list of the day
but never got to write anything down. As Stuart mentioned, it would be
better to add it as part of the booting.txt document. A potential
soc.txt is more for DT, code structuring (spreading) throughout drivers/
etc. If you have time, that would be good as well ;).

-- 
Catalin
