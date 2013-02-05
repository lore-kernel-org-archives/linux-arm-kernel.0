From: olof@lixom.net (Olof Johansson)
Date: Tue, 5 Feb 2013 15:26:04 -0800
Subject: [GIT PULL  3/4] ARM: mvebu: boards for v3.9
In-Reply-To: <20130205183050.GZ14746@titan.lakedaemon.net>
References: <pull-1359733919-342140> <1359733919.c3D01c3.22262@triton>
 <20130205071010.GD13049@quad.lixom.net>
 <20130205112104.GP14746@titan.lakedaemon.net>
 <20130205182333.GA21051@quad.lixom.net>
 <20130205183050.GZ14746@titan.lakedaemon.net>
Message-ID: <20130205232604.GB14851@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 01:30:50PM -0500, Jason Cooper wrote:
> On Tue, Feb 05, 2013 at 10:23:33AM -0800, Olof Johansson wrote:
> > On Tue, Feb 05, 2013 at 06:21:04AM -0500, Jason Cooper wrote:
> > > On Mon, Feb 04, 2013 at 11:10:10PM -0800, Olof Johansson wrote:
> > > > Hi,
> > > > 
> > > > On Fri, Feb 01, 2013 at 03:51:59PM +0000, Jason Cooper wrote:
> > > > > The following changes since commit 949db153b6466c6f7cad5a427ecea94985927311:
> > > > > 
> > > > >   Linux 3.8-rc5
> > > > > 
> > > > > are available in the git repository at:
> > > > > 
> > > > >   git://git.infradead.org/users/jcooper/linux.git tags/boards_for_v3.9
> > > > > 
> > > > > for you to fetch changes up to c7064904895f69b2e33117b450a05746f75abf3a:
> > > > > 
> > > > >   ARM: kirkwood: convert Guruplug Server Plus to use the device tree
> > > > > 
> > > > > ----------------------------------------------------------------
> > > > > mvebu boards for v3.9
> > > > >      - Guruplug Server Plus DT board
> > > > >      - RD-A370-A1 board
> > > > >      - mvebu improved SMP support in interrupt controller
> > > > >      - update defconfigs
> > > > >      - split legacy and DT setup for dove
> > > > >      - remove some redundant clock aliases
> > > > >     
> > > > >     depends on:
> > > > >      - tags/mvebu_fixes_for_v3.8-rc6
> > > > >      - tags/cleanup_for_v3.9_round2
> > > > >      - tags/drivers_for_v3.9
> > > > >      - mmc/mmc-next up to:
> > > > >         d293875 mmc: mvsdio: add pinctrl integration
> > > > 
> > > > Hm. What do you need the mmc branch for? Is it just the removal of the
> > > > redundant SDIO clock alias?
> > > 
> > > No, it's the four patches of Thomas' to the mvsdio driver:
> > > 
> > > d293875 mmc: mvsdio: add pinctrl integration
> > > 182ce21 mmc: mvsdio: implement a Device Tree binding
> > > aa3738e mmc: mvsdio: use slot-gpio for card detect gpio
> > > 9d8b28e5 mmc: mvsdio: use slot-gpio infrastructure for write protect gpio
> > > 
> > > which mvebu/boards needs before we can activate defconfig options.
> > 
> > Yeah, those are the patches you need to bring in. What I was wondering is why
> > you need to bring them in? If it's just for defconfig updates and a couple of
> > tiny cleanups, then I would say it's not worth the overhead of adding the
> > dependency branch to do those -- defconfig updates can go in anyway and the
> > cleanups can happen in the next release.
> 
> Well, I brought them in to mvebu/boards because of defconfig, but I
> need them in mvebu/dt (which depends on mvebu/boards) because we remove
> the legacy mvsdio init calls, and add the mvsdio dt blocks to the dts
> files.
> 
> Would you prefer I put all the defconfig changes into /dt since it's at
> the end of the dependency chain?

The defconfig changes can go in either branch. They end up selecting
new options that will be silently turned off unless the driver change
is also in the same tree, but that's not a big deal since things will
eventually converge.

What makes sense is to hold off the patches that adds dts entries and
removes the platform device registrations to the next release to avoid
this dependency.


-Olof
