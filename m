From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 08 Jan 2014 23:43:24 +0100
Subject: [GIT PULL] Samsung Clock changes for v3.14
In-Reply-To: <20140108220749.6098.18052@quantum>
References: <3518820.nAXoIq2LQG@amdc1227> <20140108220749.6098.18052@quantum>
Message-ID: <2008892.PW38q65uR0@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 of January 2014 14:07:49 Mike Turquette wrote:
> Quoting Tomasz Figa (2014-01-08 11:13:38)
> > Hi Mike,
> > 
> > Please consider pulling following Samsung Clock changes for v3.14.
> > 
> > The following changes since commit 2bb00c68e094271b79deac993893461cc051b721:
> 
> Hi Tomasz,
> 
> Commit 2bb00c68 is the tip of the Samsung clk fixes that I'm about to
> send out. Can you rebase this request onto the tip of clk-next?

I guess I can do it, but wouldn't this introduce merge conflicts, since
some of the fixes are changing the same parts of the code?

I based my samsung-next branch on top of your clk-next with my fixes
branch merged, since that's what will end up in Linus' tree anyway. Was it
not the right thing to do?

Best regards,
Tomasz

> 
> Thanks!
> Mike
> 
> > 
> >   Merge branch 'samsung-fixes' into samsung-next-base (2013-12-30 18:15:23 +0100)
> > 
> > are available in the git repository at:
> > 
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tfiga/samsung-clk.git tags/for_3.14/samsung-clk
> > 
> > for you to fetch changes up to 59d711e9ddd2f68822a2a99fc939e11a9288b73e:
> > 
> >   ARM: dts: exynos5420: add input clocks to audss clock controller (2014-01-08 18:02:43 +0100)
> > 
> > ----------------------------------------------------------------
> > (A bit late) first round of Samsung clock patches for v3.14.
> > 
> > ----------------------------------------------------------------
> > Andrew Bresticker (7):
> >       clk: exynos5250: register APLL rate table
> >       clk: exynos-audss: convert to platform device
> >       clk: exynos-audss: allow input clocks to be specified in device tree
> >       clk: exynos5250: add clock ID for div_pcm0
> >       ARM: dts: exynos5250: add input clocks to audss clock controller
> >       clk: exynos-audss: add support for Exynos 5420
> >       ARM: dts: exynos5420: add input clocks to audss clock controller
> > 
> > Andrzej Hajda (8):
> >       ARM: exynos4: create a DT header defining CLK IDs
> >       clk: exynos4: replace clock ID private enums with IDs from DT header
> >       ARM: exynos5250: create a DT header defining CLK IDs
> >       clk: exynos5250: replace clock ID private enums with IDs from DT header
> >       ARM: exynos5420: create a DT header defining CLK IDs
> >       clk: exynos5420: replace clock ID private enums with IDs from DT header
> >       ARM: exynos5440: create a DT header defining CLK IDs
> >       clk: exynos5440: replace clock ID private enums with IDs from DT header
> > 
> > Sachin Kamat (1):
> >       clk: exynos5250: Add CLK_SET_RATE_PARENT flag to mout_apll
> > 
> > Tomasz Figa (7):
> >       clk: samsung: exynos5250: Sort definitions by registers and bitfield
> >       clk: samsung: exynos5250: Make names of mux and div clocks consistent
> >       clk: samsung: exynos5250: Fix parents of gate clocks from GSCL domain
> >       clk: samsung: exynos5250: Fix parent of gate clocks from DISP1 domain
> >       clk: samsung: exynos5250: Add missing unpopulated mux parents
> >       clk: samsung: exynos5250: Correct parent list of audio muxes
> >       clk: samsung: exynos5250: Fix parents of gate clocks from MFC domain
> > 
> >  .../devicetree/bindings/clock/clk-exynos-audss.txt |  39 +-
> >  .../devicetree/bindings/clock/exynos5250-clock.txt |   1 +
> >  arch/arm/boot/dts/exynos5250.dtsi                  |   2 +
> >  arch/arm/boot/dts/exynos5420.dtsi                  |   4 +-
> >  drivers/clk/samsung/clk-exynos-audss.c             | 159 +++-
> >  drivers/clk/samsung/clk-exynos4.c                  | 857 ++++++++++-----------
> >  drivers/clk/samsung/clk-exynos5250.c               | 699 ++++++++++-------
> >  drivers/clk/samsung/clk-exynos5420.c               | 648 ++++++++--------
> >  drivers/clk/samsung/clk-exynos5440.c               |  81 +-
> >  include/dt-bindings/clk/exynos-audss-clk.h         |   3 +-
> >  include/dt-bindings/clock/exynos4.h                | 244 ++++++
> >  include/dt-bindings/clock/exynos5250.h             | 160 ++++
> >  include/dt-bindings/clock/exynos5420.h             | 188 +++++
> >  include/dt-bindings/clock/exynos5440.h             |  42 +
> >  14 files changed, 1957 insertions(+), 1170 deletions(-)
> >  create mode 100644 include/dt-bindings/clock/exynos4.h
> >  create mode 100644 include/dt-bindings/clock/exynos5250.h
> >  create mode 100644 include/dt-bindings/clock/exynos5420.h
> >  create mode 100644 include/dt-bindings/clock/exynos5440.h
> > 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
