From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 29 Apr 2014 13:48:49 -0400
Subject: [PATCH 1/5] ARM: defconfigs: add MTD_SPI_NOR (new dependency
 for M25P80)
In-Reply-To: <20140429172227.GB11657@arch.cereza>
References: <1397719309-2022-1-git-send-email-computersforpeace@gmail.com>
 <1397719309-2022-2-git-send-email-computersforpeace@gmail.com>
 <535A8FC9.8040707@wwwdotorg.org>
 <20140429172227.GB11657@arch.cereza>
Message-ID: <20140429174849.GO28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 29, 2014 at 02:22:27PM -0300, Ezequiel Garcia wrote:
> On Apr 25, Stephen Warren wrote:
> > On 04/17/2014 01:21 AM, Brian Norris wrote:
> > > These defconfigs contain the CONFIG_M25P80 symbol, which is now
> > > dependent on the MTD_SPI_NOR symbol. Add CONFIG_MTD_SPI_NOR to the
> > > relevant defconfigs.
> > > 
> > > At the same time, drop the now-nonexistent CONFIG_MTD_CHAR symbol.

Excuse my ignorance of the history of this bug, but shouldn't this be
solved in the Kconfig logic?  Since when do we solve config symbol
dependency bugs in the defconfigs?

> > I hadn't realized that the problem this patch solves was already present
> > in the code, so this patch is simply catching up the defconfigs rather
> > than part of a series which changed the code to cause the problem.
> > 
> > So, this needs to be applied ASAP.
> > 
> 
> What's the status of this?
> 
> > I think this should be split it up so that each defconfig can go through
> > the tree that owns it to avoid conflicts. If you repost split up, I can
> > apply the tegra_defconfig change to the Tegra tree.
> > 
> 
> Probably the same for mvebu (Ccing Jason).

confused.

Jason.
