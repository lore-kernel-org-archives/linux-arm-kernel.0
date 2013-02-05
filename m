From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 5 Feb 2013 07:18:32 -0500
Subject: [GIT PULL  0/4] ARM: mvebu: changes for v3.9
In-Reply-To: <20130205062909.GC13049@quad.lixom.net>
References: <510be4a4.4cf8dc0a.6acf.ffffcbc6SMTPIN_ADDED_BROKEN@mx.google.com>
 <20130205062909.GC13049@quad.lixom.net>
Message-ID: <20130205121832.GQ14746@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 04, 2013 at 10:29:09PM -0800, Olof Johansson wrote:
> Hi,
> 
> On Fri, Feb 01, 2013 at 03:51:58PM +0000, Jason Cooper wrote:
> > The following changes since commit 19d23dac1b8f95e4a960fcbbb5687c33b9a2cd01:
> > 
> >   Merge branch 'fixes' into for-next
> > 
> > are available in the git repository at:
> > 
> >   git://git.infradead.org/users/jcooper/linux.git mvebu/for-next
> > 
> > for you to fetch changes up to 7d8a7dce24f76242daf1c469878597b8acc4f78f:
> > 
> >   Merge tag 'tags/dt_for_v3.9' into mvebu/for-next
> > 
> > Jason Cooper (5):
> >       Merge tag 'tags/mvebu_fixes_for_v3.8-rc6' into mvebu/for-next
> >       Merge tag 'tags/cleanup_for_v3.9_round2' into mvebu/for-next
> >       Merge tag 'tags/drivers_for_v3.9' into mvebu/for-next
> >       Merge tag 'tags/boards_for_v3.9' into mvebu/for-next
> >       Merge tag 'tags/dt_for_v3.9' into mvebu/for-next
> > 
> >  274 files changed, 3501 insertions(+), 1617 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhci.txt
> >  create mode 100644 Documentation/devicetree/bindings/mmc/orion-sdio.txt
> >  create mode 100644 arch/arm/boot/dts/armada-370-rd.dts
> >  create mode 100644 arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
> >  create mode 100644 arch/arm/mach-dove/board-dt.c
> >  create mode 100644 arch/arm/mach-kirkwood/board-guruplug.c
> >  rename arch/arm/mach-kirkwood/cpuidle.c => drivers/cpuidle/cpuidle-kirkwood.c (61%)
> >  create mode 100644 drivers/mmc/host/sdhci-bcm2835.c
> 
> Surely that diffstat is not correct, it includes changes to fs/btrfs and
> a bunch of other directories?
> 
> No need to regenerate as long as the individual pull requests are accurate, but
> you might want to check up on your scripts.

Yes, that's a work in progress.  I managed to clean up the real pull
requests (1 to 4) with --first-parent and --no-merges.  However,
dependency branches (eg mmc/mmc-next) are giving me a little trouble.

I think I'm going to add a special function just for cover-letters to
built the diffstat the way you recommended (I already do the merge-test
branch).

It may be because I'm following LinusW's suggestion of pulling just up
to the commit needed.  I'm not pulling a whole branch and that may be
confusing --first-parent.

I'll look into it more for round two.  Once I get it nailed down I'll
post a patch to add my script (based on Tony Lindgren's script) to
scripts/

thx,

Jason.
