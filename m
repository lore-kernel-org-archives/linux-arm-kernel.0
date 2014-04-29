From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 29 Apr 2014 16:22:08 -0300
Subject: [PATCH 1/5] ARM: defconfigs: add MTD_SPI_NOR (new dependency for
 M25P80)
In-Reply-To: <20140429190603.GB9418@norris-Latitude-E6410>
References: <1397719309-2022-1-git-send-email-computersforpeace@gmail.com>
 <1397719309-2022-2-git-send-email-computersforpeace@gmail.com>
 <535A8FC9.8040707@wwwdotorg.org>
 <20140429190603.GB9418@norris-Latitude-E6410>
Message-ID: <20140429192208.GA28668@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Apr 29, Brian Norris wrote:
> Hi Stephen,
> 
> On Fri, Apr 25, 2014 at 10:39:37AM -0600, Stephen Warren wrote:
> > On 04/17/2014 01:21 AM, Brian Norris wrote:
> > > These defconfigs contain the CONFIG_M25P80 symbol, which is now
> > > dependent on the MTD_SPI_NOR symbol. Add CONFIG_MTD_SPI_NOR to the
> > > relevant defconfigs.
> > > 
> > > At the same time, drop the now-nonexistent CONFIG_MTD_CHAR symbol.
> > 
> > I hadn't realized that the problem this patch solves was already present
> > in the code, so this patch is simply catching up the defconfigs rather
> > than part of a series which changed the code to cause the problem.
> 
> Yes, this is "catching up the defconfigs." The SPI_NOR framework is new,
> and I didn't want to generate defconfig noise until a few things
> stabilized (particularly, its Kconfig symbol name).
> 
> > So, this needs to be applied ASAP.
> > 
> > I think this should be split it up so that each defconfig can go through
> > the tree that owns it to avoid conflicts. If you repost split up, I can
> > apply the tegra_defconfig change to the Tegra tree.
> 
> OK, I'll try to split it up. Is ARM unique in tracking defconfigs in
> separate trees? I assume MIPS, PowerPC, and Blackfin won't require the
> same splitting? I'd like to avoid 31 patches when <20 could suffice.
> 
> I'll also rebase on linux-next. I think there may be a few conflicts.
> 

FWIW, I can take care of the patch for mvebu. Just drop it from your set
and I'll prepare one for Jason.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
