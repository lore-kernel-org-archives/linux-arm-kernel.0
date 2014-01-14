From: luis.henriques@canonical.com (Luis Henriques)
Date: Tue, 14 Jan 2014 16:20:07 +0000
Subject: [PATCH v2 0/3] Fix SATA disk hotplug for Armada 370/XP SoCs
In-Reply-To: <20140114155945.GQ19878@titan.lakedaemon.net>
References: <1389711007-7239-1-git-send-email-simon.guinot@sequanux.org>
 <20140114151404.GN19878@titan.lakedaemon.net>
 <20140114154834.GD32507@kw.sim.vm.gnt>
 <20140114155945.GQ19878@titan.lakedaemon.net>
Message-ID: <20140114162007.GD4637@hercules>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 10:59:45AM -0500, Jason Cooper wrote:
> Simon,
> 
> On Tue, Jan 14, 2014 at 04:48:34PM +0100, Simon Guinot wrote:
> > On Tue, Jan 14, 2014 at 10:14:04AM -0500, Jason Cooper wrote:
> > > Simon,
> > > 
> > > On Tue, Jan 14, 2014 at 03:50:04PM +0100, Simon Guinot wrote:
> > > > Hello,
> > > > 
> > > > This patch series fixes a SATA disk hotplug issue for the Armada 370/XP
> > > > SoCs: once a disk is removed from a SATA port, then the re-plug events
> > > > are not detected by the sata_mv driver.
> > > > 
> > > > This should be applied to the -stable kernels 3.10 and onwards. 
> > > 
> > > Please add a 'Fixes: <commit-hash> (oneline)' tag below the Cc: stable
> > > tags.  It looks like the sata_mv binding and the Armada 370 DT booting
> > > were both introduced in v3.6, so I would probably use:
> > > 
> > > Fixes: 9ae6f740b49f (arm: mach-mvebu: add support for Armada 370 and Armada XP with DT)
> > 
> > Hi Jason,
> > 
> > I am not comfortable with this "Fixes: commit_id" notation. It states
> > that the patch fixes a regression introduced by a given commit. This
> > hardly makes sense to me because obviously the hotplug issue has not
> > been introduced by:
> > 
> > "arm: mach-mvebu: add support for Armada 370 and Armada XP with DT".
> > 
> > I know that the purpose is purely administrative, but it is kind of
> > weird...
> 
> True, the wording may not be the best, but the goal is to make it easier
> to do a 'tag --contains' search.  We could call it
> 
> Repair-Something-Broken-Since-Introduced-by:
> 
> in this case ;-)
> 
> > > Is there a specific reason you say v3.10?
> > 
> > I could have said nothing as well.
> > 
> > As stable kernel older than 3.10 are no longer maintained, I think
> > we don't need to point out a specific commit as a -stable target.
> > Simply Cc'ing -stable without any extra informations should be good
> > enough.
> 
> The reason I ask is that I'd like to know if, in debugging this issue,
> you discovered that the fix was not needed before v3.10 (hypothetically,
> say because sata hotplug was added in v3.10).
> 
> The linux-stable team isn't the only people who find this information
> useful.  Distros maintaining older kernels would find it very helpful
> when going through -stable patches to know easily if a patch should be
> backported further, say to v3.8.

Obviously, I really appreciate when people add this sort of information
into a commit.  This additional information is quite useful for me as a
maintainer of extended (aka 'non-official') stable kernels.

Cheers,
--
Luis

> thx,
> 
> Jason.
> --
> To unsubscribe from this list: send the line "unsubscribe stable" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
