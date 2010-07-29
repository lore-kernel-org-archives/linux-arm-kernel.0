From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 29 Jul 2010 04:51:52 +0200
Subject: [PULL] Various xscale fixes
In-Reply-To: <AANLkTimPuGN-gmpr6MORScejOQJ90tLFJQ1ALtau2pYK@mail.gmail.com>
References: <201007262204.39318.marek.vasut@gmail.com>
	<AANLkTimPuGN-gmpr6MORScejOQJ90tLFJQ1ALtau2pYK@mail.gmail.com>
Message-ID: <201007290451.52535.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne St 28. ?ervence 2010 03:24:03 Eric Miao napsal(a):
> On Tue, Jul 27, 2010 at 4:04 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> > Eric, can you please pull these changes into your -devel? Thanks!
> > 
> > The following changes since commit
> > 9f5f3423ac0d786ff87ee80e7c5292b43fe0b4f9:
> > 
> >  Merge branch 'devel' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6 into
> > devel (2010-07-22 17:14:02 +0200)
> 
> For a simpler history, could you please either rebase on my -devel tip
> or rebase on a certain -rcN tagline?

Ok, this should be it:

The following changes since commit 9d89308d8166a5588e49a3e3303995ccf101e9c0:

  [ARM] pxa: removed mostly unused and confusing two sharpsl.h (2010-07-05 
00:06:25 +0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/marex/pxa-linux-2.6.git for-
eric-devel

Marek Vasut (13):
      [ARM] pxa/palm: Introduce Palm27x
      [ARM] pxa/palm: Flip Palm LD,TX,T5,Z72 to Palm27x
      [ARM] pxa/palm: Add core pmic support for Palm27x
      [ARM] pxa/palm: Modularize rest of code in Palms
      [ARM] pxa/spitz: Rework spitz
      [ARM] pxa/spitz: Formating and naming fixes
      [ARM] pxa/z2: Fix flash layout typo
      [ARM] pxa/balloon3: Machine file cleanup
      [ARM] pxa/balloon3: Machine file cleanup
      [ARM] pxa/balloon3: PCMCIA Support
      [ARM] pxa/balloon3: PCF857x GPIO expander and LEDs
      [ARM] pxa/balloon3: Add NAND driver
      [ARM] pxa/balloon3: Add MAX1586 PMIC support

 arch/arm/mach-pxa/Kconfig                 |    7 +
 arch/arm/mach-pxa/Makefile                |    1 +
 arch/arm/mach-pxa/balloon3.c              |  777 +++++++++++++++++++++++------
 arch/arm/mach-pxa/include/mach/balloon3.h |   31 +-
 arch/arm/mach-pxa/include/mach/palm27x.h  |   48 ++
 arch/arm/mach-pxa/include/mach/spitz.h    |    6 +
 arch/arm/mach-pxa/palm27x.c               |  532 ++++++++++++++++++++
 arch/arm/mach-pxa/palmld.c                |  301 +++---------
 arch/arm/mach-pxa/palmt5.c                |  289 ++----------
 arch/arm/mach-pxa/palmtreo.c              |  371 +++-----------
 arch/arm/mach-pxa/palmtx.c                |  307 ++----------
 arch/arm/mach-pxa/palmz72.c               |  269 +---------
 arch/arm/mach-pxa/spitz.c                 |  724 ++++++++++++++++-----------
 arch/arm/mach-pxa/z2.c                    |    2 +-
 drivers/pcmcia/Kconfig                    |    2 +-
 drivers/pcmcia/Makefile                   |    1 +
 drivers/pcmcia/pxa2xx_balloon3.c          |  199 ++++++++
 17 files changed, 2107 insertions(+), 1760 deletions(-)
 create mode 100644 arch/arm/mach-pxa/include/mach/palm27x.h
 create mode 100644 arch/arm/mach-pxa/palm27x.c
 create mode 100644 drivers/pcmcia/pxa2xx_balloon3.c
