From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 9 Dec 2013 11:08:56 -0800
Subject: Merge order in Armada 370/XP (mvebu) NAND support
In-Reply-To: <20131206221217.GC2458@localhost>
References: <20131206184544.GA14986@localhost>
 <20131206192540.GU29282@titan.lakedaemon.net>
 <20131206221217.GC2458@localhost>
Message-ID: <20131209190856.GQ27149@ld-irv-0074.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 06, 2013 at 07:12:18PM -0300, Ezequiel Garcia wrote:
> On Fri, Dec 06, 2013 at 02:25:40PM -0500, Jason Cooper wrote:
> > On Fri, Dec 06, 2013 at 03:45:45PM -0300, Ezequiel Garcia wrote:
> > > Jason/Brian: What do you think we can do?
> > 
> > Revert the change adding the compatible string in the first place?
> 
> Yes, that probably is the best thing to do.
> 
> Brian: what do you think? I can send you a revert of the
> "armada370-nand" compatible addition to be pushed for v3.13-rc4?

Yes, I think dropping the "armada370-nand" compatible string would be a
good solution for 3.13. Are there any use cases where "armada370-nand"
is needed and operational on 3.12? (e.g., is 2KB page support fine?)
Because if there are *no* valid use cases for compatible =
"armada370-nand" yet, then we might want this to go to 3.12.y stable as
well, right?

> The compatible can be added on top of l2-mtd.git, after all
> the needed support is in the driver.

Sure.

I'll take a look at your "revert" patch and see if we can get it
upstream for 3.13.

Thanks,
Brian
