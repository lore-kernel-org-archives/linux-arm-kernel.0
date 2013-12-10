From: tony@atomide.com (Tony Lindgren)
Date: Mon, 9 Dec 2013 19:28:00 -0800
Subject: [PATCH 1/4] wl1251: split wl251 platform data to a separate
 structure
In-Reply-To: <20131115143254.GA7079@tuxdriver.com>
References: <1382890469-25286-1-git-send-email-sre@debian.org>
 <1382890469-25286-2-git-send-email-sre@debian.org>
 <20131114185132.GQ10317@atomide.com>
 <20131114230330.GB6383@earth.universe>
 <20131114232217.GV10317@atomide.com>
 <20131115143254.GA7079@tuxdriver.com>
Message-ID: <20131210032800.GE13171@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* John W. Linville <linville@tuxdriver.com> [131115 06:46]:
> On Thu, Nov 14, 2013 at 03:22:18PM -0800, Tony Lindgren wrote:
> > * Sebastian Reichel <sre@debian.org> [131114 15:04]:
> > > On Thu, Nov 14, 2013 at 10:51:33AM -0800, Tony Lindgren wrote:
> > > > [...]
> > > >
> > > > If this is not going into v3.13, these will cause conflicts
> > > > with the mach-omap2/board-*.c files for v3.14.
> > > > 
> > > > So it might be best to do a minimal header patch first that
> > > > can be merged in by both linux-omap and wireless trees.
> > > 
> > > I guess this patch is pretty minimal. It also seems to be acked by
> > > the involved Maintainers, so maybe just merge Patch 1 without the
> > > other patches?
> > > 
> > > This does not solve the problem with the struct modification from
> > > the second patch, but I guess it's the more intrusive patch.
> > 
> > Once at least the first two patches are ready, how about I queue
> > them after -rc1 and set up an immutable branch that can be merged
> > in by linux-omap tree and the wireless tree?
> 
> That sounds reasonable to me.

OK sorry it took a while, I was chasing bugs and did not get around
to doing this until now. I've applied only the first two patches from
the v2 set of patches later on in this thread against v3.13-rc1 into
a signed tag wl1251-pdata-signed here:

http://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/tag/?id=wl1251-pdata-signed

John, please feel free to pull the branch above also into the wireless
tree so you can apply the remaining wl1251 patches from Sebastian.
This way things keep working without creating merge conflicts with the
linux-omap tree.

Regards,

Tony
