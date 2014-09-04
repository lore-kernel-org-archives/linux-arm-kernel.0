From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 04 Sep 2014 11:39:15 +0200
Subject: [PATCH V3 0/6] ARM64: Add support for FSL's LS2085A SoC
In-Reply-To: <20140904091319.GA32228@leverpostej>
References: <1409757194-28155-1-git-send-email-bhupesh.sharma@freescale.com>
 <6499926.sQm3J8L764@wuerfel> <20140904091319.GA32228@leverpostej>
Message-ID: <3563146.jh46O3eIbG@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 September 2014 10:13:19 Mark Rutland wrote:
> On Wed, Sep 03, 2014 at 07:31:44PM +0100, Arnd Bergmann wrote:
> > On Wednesday 03 September 2014 17:31:30 Mark Rutland wrote:
> > > 
> > > However, I'm not sure I follow the reasoning for making this
> > > significantly harder, and even ignoring that I don't think this does
> > > make things significantly harder. Especially so if we have a PSCI node
> > > but not an enable method -- in that case its trivial to patch in an
> > > unrelated enable-method anyhow.
> > 
> > Right, it's not actually much harder. A better way to look at it is
> > probably that we document what which parts we expect to stay constant
> > and which parts are to be filled out by the boot loader. Independent
> > of what PSCI implementation the boot loader provides, we would like
> > to see enable-method="psci".
> 
> So in the /cpus node, have a comment like:
> 
> /*
>  * We expect the enable-method to be "psci", but this is dependent on
>  * the FW, which will fill this in.
>  */

I was thinking of leaving the enable-method in the cpus node, but having
an empty psci node with a similar comment.

> Or, should we put together a soc-guidance.txt with that, ensuring things
> are initialised correctly (CNTVOFF, CNTFREQ), etc?

I would very much welcome documentation like that!

> > I just saw that Geoff had a related comment, and documenting this
> > would make it clearer to other reviewers, as well as people that
> > happen to look at this file as a base for new platforms.
> 
> I agree that having something to point people in the right direction is
> a good idea. The only point I disagree with is putitng something in the
> DT that can be trivially made false (and possibly with good reason).
> 
> I'm happy with having comments.

Right, but I see no good reason for having something else in the
enable-method, the only way I can see why that would be done is for
the boot loader or firmware implementer to be misinformed.

	Arnd
