From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 10 May 2013 18:43:44 +0100
Subject: [PATCH V2] ARM: bcm281xx: Add L2 support for Rev A2 chips
In-Reply-To: <20130509204434.GA16724@quad.lixom.net>
References: <1367542653-955-1-git-send-email-csd@broadcom.com>
 <20130509204434.GA16724@quad.lixom.net>
Message-ID: <20130510174344.GX18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 09, 2013 at 01:44:34PM -0700, Olof Johansson wrote:
> On Thu, May 02, 2013 at 05:57:33PM -0700, Christian Daudt wrote:
> > Rev A2 SoCs have an unorthodox memory re-mapping and this needs
> > to be reflected in the cache operations.
> > This patch adds new outer cache functions for the l2x0 driver
> > to support this SoC revision. It also adds a new compatible
> > value for the cache to enable this functionality.
> > 
> > Updates from V1:
> > - remove section 1 altogether and note that in comments
> > - simplify section selection caused by section 1 removal
> > - BUG_ON just in case section 1 shows up
> > 
> > Signed-off-by: Christian Daudt <csd@broadcom.com>
> 
> This patch mostly covers code that is on Russells plate, so please feed
> this to his tracker to be picked up by him. Feel free to add:

Yes, but there's a problem.  I don't have bcm11351.dtsi to apply this
patch to.  This is one of the problems of splitting the SoC stuff
from core stuff - either I start doing cross-merges (which cause Linus
and everyone else pain as we've seen this time around) or we have to
stuff everything through a single tree.

Not happy.

Not applying until after -rc1.
