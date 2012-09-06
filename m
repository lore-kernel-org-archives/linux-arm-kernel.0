From: horms@verge.net.au (Simon Horman)
Date: Thu, 6 Sep 2012 09:02:43 +0900
Subject: [GIT PULL v3] Renesas ARM-based SoC: Marzen and r8a7779 for 3.7
In-Reply-To: <20120905231357.GF32084@quad.lixom.net>
References: <1346833244-30432-1-git-send-email-horms@verge.net.au>
 <20120905231357.GF32084@quad.lixom.net>
Message-ID: <20120906000240.GA31810@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2012 at 04:13:57PM -0700, Olof Johansson wrote:
> On Wed, Sep 05, 2012 at 05:20:39PM +0900, Simon Horman wrote:
> > Hi Olof, Hi Arnd,
> > 
> > please consider the following enhancements to the Marzen board
> > and r8a7779 SoC by Phil Edworthy, Morimoto-san and myself for 3.7.
> > 
> > This pull-request differs from v2 in that USB-related changes
> > have been omitted and the pull-request is no longer based on usb-next.
> > 
> > ----------------------------------------------------------------------
> > The following changes since commit fea7a08acb13524b47711625eebea40a0ede69a0:
> > 
> >   Linux 3.6-rc3 (2012-08-22 13:29:06 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git marzen
> > 
> > for you to fetch changes up to 978792e04b58985eda62aa8cc97c6d46433103f2:
> > 
> >   ARM: shmobile: marzen: enable thermal sensor (2012-09-05 10:22:48 +0900)
> > 
> Hi,
> 
> This is the first pull request that has a few patches on the same branch,
> so while it's something I was thinking about on previous pull request,
> for this one it's more obvious. So here we go :-)
> 
> For background, we tend to organize the arm-soc tree a little different from
> how some other maintainer trees are organized, to aggregate work across vendor
> branches and make it more obvious which kind of patches are adding and removing
> cod ein the tree.
> 
> Our organization of the arm-soc tree is in a few broad topics that cut across
> all platforms. They tend to be, in rough order:
> 
> * Fixes that weren't critical for the previous release (fixes-non-critical)
> * Cleanups that removes or refactors code
> * New SoC support or major updates
> * SoC drivers updates
> * board support / changes
> * defconfigs
> * device tree
> 
> + sometimes other special topic branches depending on what's going on that
> merge window, like pinctrl updates (SoC side) or clock updates.
> 
> You can have one branch depend/build on top of another, we can normally resolve
> those dependencies. We prefer them in the same rough order as above to avoid
> cyclical dependencies between different vendors though.
> 
> 
> So, on your branch:
> 
> You seem to be organizing your branches more along the topics of which chip
> they relate to, for example Marzen and r8a7779 above. That worked out well when
> there were only one or two patches per branch since we could just file them
> into the area where we consider they fit (i.e. see my replies to those emails
> about where they fit in).
> 
> This is the first larger branch, and I think you should split it up to:
> 
> 
> > ----------------------------------------------------------------
> > Kuninori Morimoto (2):
> >       ARM: shmobile: marzen: fixup regulator id for smsc911x
> >       ARM: shmobile: marzen: enable thermal sensor
> 
> Those are board updates
> 
> > 
> > Phil Edworthy (2):
> >       r8a7779: add SDHI clock support
> 
> SoC update since it seems to mostly be clock related.
> 
> >       marzen: add SDHI0 support
> 
> defconfig for part of the change, board for the other. Why was I/DNOTIFY
> updated in the defconfig, by the way?
> 
> 
> > Simon Horman (1):
> >       ARM: mach-shmobile: marzen: defconfig update
> 
> This would fit on a defconfig branch as well.
> 
> 
> For future pull request as well, feel free to think about how the patches
> would fit into similar topics to above as well and organize them as such
> at your level too. If you want several branches of the same kind, that's
> no problem, but it's by far preferrably if they're organized along the
> rouch topics above.

Hi Olof,

thanks for the advice. I'll split up this series as you suggest and
try to align my branches with those in the arm-soc tree.
