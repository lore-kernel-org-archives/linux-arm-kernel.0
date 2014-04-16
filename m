From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 16 Apr 2014 13:07:05 -0400
Subject: [PATCH v2 0/5] Support for Marvell AHCI interface on Armada 38x
In-Reply-To: <20140414204455.5d83513d@skate>
References: <1397486055-16303-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <16639486.i0jTGsaDYr@amdc1032> <20140414180142.0dd63a1f@skate>
 <10589751.qhi630WAFs@amdc1032> <20140414181920.1e309019@skate>
 <20140414174606.GB10416@htj.dyndns.org>
 <20140414204455.5d83513d@skate>
Message-ID: <20140416170705.GK28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 14, 2014 at 08:44:55PM +0200, Thomas Petazzoni wrote:
> On Mon, 14 Apr 2014 13:46:06 -0400, Tejun Heo wrote:
> > Also, how do you want the patches to be routed?  Can all go through libata?
> 
> As written in the cover letter, I'd expect patches 1 and 2 to go
> through libata, and then patches 3, 4 and 5 to go through arm-soc. The
> reason is that patches 3, 4 and 5 modifies the Device Tree files and
> the ARM defconfigs, which are likely to also be changed by other
> commits in the same cycle. However, the DT binding documentation change
> and the driver change are independent, so they can go through libata.
> 
> I guess Jason Cooper, who handles the patch merging for mvebu
> platforms, can confirm (or not?) this proposal.

Yep, this is how we do it.  The only caveat is if there are going to be
changes during this window that depend on the driver changes in this
series.  Then we would ask to set up a topic branch.

That happens a little more frequently now that we have boards in the
boot farm testing linux-next and other trees.  It means we also care
about boot-time dependencies as well as build deps.

I'll take a closer look at this series in the next few days and let you
know.

thx,

Jason.
