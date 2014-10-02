From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 02 Oct 2014 16:44:20 +0200
Subject: [PATCH 0/3] ARM: Meson6: enable SMP
In-Reply-To: <20140930204538.GA6985@carlo-MacBookPro>
References: <1412066635-5298-1-git-send-email-carlo@caione.org>
 <2970330.BJMVixgoJ1@wuerfel> <20140930204538.GA6985@carlo-MacBookPro>
Message-ID: <3418275.THTV4FmaIz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 September 2014 22:45:38 Carlo Caione wrote:
> On mar, set 30, 2014 at 12:22:21 +0200, Arnd Bergmann wrote:
> > On Tuesday 30 September 2014 10:46:46 Carlo Caione wrote:
> > > On mar, set 30, 2014 at 10:43:52 +0200, Carlo Caione wrote:
> > > > Amlogic Meson6 is a dual-core Cortex-A9. This patchset adds all the necessary
> > > > pieces to boot the secondary CPU.
> > > 
> > > Sorry for the double sending.
> > > Forgot to CC LAKML.
> > 
> > Looks good to me in principle, but I wonder about the CPU enable method.
> > Are you able to implement PSCI in u-boot like it was done for allwinner?
> > 
> > This is mostly a question of whether the system comes up in secure mode
> > or non-secure mode.
> 
> I would be able if I had the u-boot source code or the possibility to
> flash the board I'm using. Unfortunately at this moment I don't have
> either. Probably in the near future I'll be able to implement PSCI in
> u-boot since Amlogic is kindly starting to provide documentation but now
> this is the best I can do.

Ok, I see. Let's give Amlogic some more time then. I think it's better
to merge other parts of the platform first when we can reasonably assume
that we don't have to change the binding any more.

It would be a shame to merge this now and then make it obsolete by
implementing PSCI but still having to carry around the original code
for compatibility reasons.

	Arnd
