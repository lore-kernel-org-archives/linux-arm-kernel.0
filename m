From: jason@lakedaemon.net (Jason)
Date: Thu, 8 Mar 2012 13:07:12 -0500
Subject: [GIT PULL v4] ARM: kirkwood: fdt conversion progress
In-Reply-To: <CAOesGMikpxMd+MtnjKix7D0KiHD+e8s2YFjB3j9a=7i7S9J+0g@mail.gmail.com>
References: <20120307221012.GH5050@titan.lakedaemon.net>
 <201203081610.21493.arnd@arndb.de>
 <CAOesGMh2etdQSOjktDGcWGfnsMhyFnVuebWRQeYuR6fvm1_DSA@mail.gmail.com>
 <20120308173029.GK5050@titan.lakedaemon.net>
 <CAOesGMikpxMd+MtnjKix7D0KiHD+e8s2YFjB3j9a=7i7S9J+0g@mail.gmail.com>
Message-ID: <20120308180712.GL5050@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 08, 2012 at 09:53:06AM -0800, Olof Johansson wrote:
> On Thu, Mar 8, 2012 at 9:30 AM, Jason <jason@lakedaemon.net> wrote:
> > The following patches should be fine to merge into stable (for 3.4):
> >
> > af42511 ARM: orion: spi: remove enable_clock_fix which is not used
> > d93b2ca ARM: Kirkwood: Remove tclk from kirkwood_asoc_platform_data.
> > 2bb9207 ARM: kirkwood: fdt: use mrvl ticker symbol
> > ec0ec68 ARM: kirkwood: fdt: absorb kirkwood_init()
> > ...
> > b5c25c3 ARM: kirkwood: rtc-mv devicetree bindings
> > 5e40593 ARM: kirkwood: use devicetree for rtc-mv
> > ...
> 
> Excellent. Can you build up one or more stable branches that I can
> pull those from?

Here's the pull request for stable:

The following changes since commit d65b4e98d7ea3038b767b70fe8be959b2913f16d:

  Linux 3.3-rc3 (2012-02-08 19:21:53 -0800)

are available in the git repository at:
  git://git.infradead.org/users/jcooper/linux-kirkwood.git kirkwood_dt_stable

Andrew Lunn (2):
      ARM: orion: spi: remove enable_clock_fix which is not used
      ARM: Kirkwood: Remove tclk from kirkwood_asoc_platform_data.

Jason Cooper (6):
      ARM: kirkwood: add dreamplug (fdt) support.
      ARM: kirkwood: convert uart0 to devicetree.
      ARM: kirkwood: fdt: use mrvl ticker symbol
      ARM: kirkwood: fdt: absorb kirkwood_init()
      ARM: kirkwood: rtc-mv devicetree bindings
      ARM: kirkwood: use devicetree for rtc-mv

 arch/arm/boot/dts/kirkwood-dreamplug.dts |   25 ++++
 arch/arm/boot/dts/kirkwood.dtsi          |   12 ++
 arch/arm/mach-kirkwood/Kconfig           |   14 ++
 arch/arm/mach-kirkwood/Makefile          |    1 +
 arch/arm/mach-kirkwood/Makefile.boot     |    2 +
 arch/arm/mach-kirkwood/board-dt.c        |  206 ++++++++++++++++++++++++++++++
 arch/arm/mach-kirkwood/common.c          |   11 +-
 arch/arm/mach-kirkwood/common.h          |    7 +
 arch/arm/plat-orion/include/plat/audio.h |    1 -
 drivers/rtc/rtc-mv.c                     |    9 ++
 drivers/spi/spi-orion.c                  |    5 -
 include/linux/spi/orion_spi.h            |    1 -
 12 files changed, 281 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-dreamplug.dts
 create mode 100644 arch/arm/boot/dts/kirkwood.dtsi
 create mode 100644 arch/arm/mach-kirkwood/board-dt.c

thx,

Jason.
