From: horms@verge.net.au (Simon Horman)
Date: Sun, 1 Mar 2015 10:52:31 +0900
Subject: [PATCH 4/5] ARM: shmobile: Add support SOC_BUS to R-Car Gen2
In-Reply-To: <2088679.zVJXCDlFW0@wuerfel>
References: <cover.1424931398.git.horms+renesas@verge.net.au>
 <8723510.YP2sm4Z5UY@wuerfel> <20150227005223.GA24717@verge.net.au>
 <2088679.zVJXCDlFW0@wuerfel>
Message-ID: <20150301015227.GA21781@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 27, 2015 at 10:00:04AM +0100, Arnd Bergmann wrote:
> On Friday 27 February 2015 09:52:23 Simon Horman wrote:
> > 
> > On Thu, Feb 26, 2015 at 04:53:39PM +0100, Arnd Bergmann wrote:
> > > On Thursday 26 February 2015 15:22:44 Simon Horman wrote:
> > > > From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> > > > 
> > > > This provides information through SOC_BUS to sysfs.
> > > > And this moves all on-SoC devices from /sys/devices/platform to
> > > > /sys/devices/socX/.
> > > > 
> > > > Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> > > > Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > > > ---
> > > >  arch/arm/mach-shmobile/Kconfig           |  1 +
> > > >  arch/arm/mach-shmobile/setup-rcar-gen2.c | 38 ++++++++++++++++++++++++++++----
> > > >  2 files changed, 35 insertions(+), 4 deletions(-)
> > > 
> > > I think this would be better done as a standalone driver in drivers/soc,
> > > to avoid having to add the init_machine callbacks in patch 3.
> > 
> > Could we handle this as follow-up work?
> 
> That was my first idea when I looked at patch 3, but then I had the other
> comment below:
> 
> > I would not duplicate that information here. Can you find out the SoC
> > name from registers and put it here?
> 
> We must not introduce the user interface in one kernel and then change
> it in the next one, so I'm cautious about taking the pull request in
> the current form. Once we have agreed on what the contents of the sysfs
> files should be, I can take the patches, and then we are free to move
> the implementation later.

Thanks for the clarification. Accordingly I'd like to withdraw this pull
request: I will drop these patches.
