From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 15 Aug 2012 10:02:23 -0400
Subject: [GIT PULL V2] orion/kirkwood fixes for v3.6
In-Reply-To: <201208151335.47964.arnd@arndb.de>
References: <20120814234442.GZ22226@titan.lakedaemon.net>
 <201208151237.56639.arnd@arndb.de>
 <20120815131317.GE22226@titan.lakedaemon.net>
 <201208151335.47964.arnd@arndb.de>
Message-ID: <20120815140223.GG22226@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 15, 2012 at 01:35:47PM +0000, Arnd Bergmann wrote:
> On Wednesday 15 August 2012, Jason Cooper wrote:
> > > The first patch in your series (ARM: Orion: Set eth packet size
> > > csum offload limit) looks like it should apply to older kernels
> > > as well. In those cases, please add "Cc: stable at vger.kernel.org"
> > > below the Signed-off-by lines (but not in the email submission)
> > > so it can get picked up by Greg for the longterm and stable
> > > releases.
> > 
> > Gah!  I missed that, sorry.  Did you forward it already or would you
> > like me to handle it?
> 
> I haven't forwarded it yet. I'll just add the tag myself if you
> don't mind your patches getting rebased.

I fixed it:

The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:

  Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)

are available in the git repository at:
  git://git.infradead.org/users/jcooper/linux.git fixes-for-v3.6

Arnaud Patard (3):
      ARM: Orion: Set eth packet size csum offload limit
      ARM: Kirkwood: Fix iconnect leds
      ARM: Kirkwood: fix Makefile.boot

 arch/arm/boot/dts/kirkwood-iconnect.dts   |    6 +++++-
 arch/arm/mach-dove/common.c               |    3 ++-
 arch/arm/mach-kirkwood/Makefile.boot      |    3 ++-
 arch/arm/mach-kirkwood/common.c           |    4 ++--
 arch/arm/mach-mv78xx0/common.c            |    6 ++++--
 arch/arm/mach-orion5x/common.c            |    3 ++-
 arch/arm/plat-orion/common.c              |    8 ++++++--
 arch/arm/plat-orion/include/plat/common.h |    6 ++++--
 include/linux/mv643xx_eth.h               |    2 ++
 9 files changed, 29 insertions(+), 12 deletions(-)
