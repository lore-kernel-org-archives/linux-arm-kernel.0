From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 31 Mar 2010 10:34:15 +0200
Subject: mx31 snd and mc13783 codec status
In-Reply-To: <4BB22576.1070108@epfl.ch>
References: <4BB22576.1070108@epfl.ch>
Message-ID: <20100331083415.GR2241@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Valentin,

On Tue, Mar 30, 2010 at 06:23:18PM +0200, Valentin Longchamp wrote:
> Hi Sascha,
>
> For one of our experiments where our robots need to produce sound, I  
> would need a sound driver for mx31moboard platform.
>
> I have quickly hacked something based on what you had done for pcm037  
> with the MC13783 codec in some of your first sound patches. I know that  
> this is not ready for mainline and I'm still struggling to debug my  
> code, but I would like to have results quite soon so that my colleague  
> could see what sounds (especially regarding to the volume) our system is  
> capable to produce.
>
> I would like to know if by any chance you have some updates on this code  
> ?

Find the latest version of my code here:

The following changes since commit 01e77706cdde7c0b47e5ca1f4284a795504c7c40:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://gitorious.org/linux-omap-dss2/linux

are available in the git repository at:

  git://git.pengutronix.de/git/sha/linux-2.6.git mc13783

Sascha Hauer (3):
      add a mc13783 codec driver
      add phycore-mc13783 sound support
      pcm038: add sound support

 arch/arm/mach-mx2/mach-pcm038.c |   23 ++-
 sound/soc/codecs/Kconfig        |    4 +
 sound/soc/codecs/Makefile       |    2 +
 sound/soc/codecs/mc13783.c      |  727 +++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/mc13783.h      |   32 ++
 sound/soc/imx/Kconfig           |    9 +
 sound/soc/imx/Makefile          |    3 +
 sound/soc/imx/phycore-mc13783.c |  160 +++++++++
 8 files changed, 959 insertions(+), 1 deletions(-)
 create mode 100644 sound/soc/codecs/mc13783.c
 create mode 100644 sound/soc/codecs/mc13783.h
 create mode 100644 sound/soc/imx/phycore-mc13783.c

> And do you know if your initial mc13783 codec support coupled with  
> mx31 had some limitations ? Our setup is quite straightforward, we have  
> direct connection from the mx31 to the mc13783 on a single SSI.

Our board uses both SSI channels of the MC13783 which we then mux into
one channel in the DAM unit. I don't know how this affects you.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
