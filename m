From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue,  9 Feb 2010 11:25:30 +0100
Subject: sound related i.MX patches
Message-ID: <1265711133-7587-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The following patches add sound support for the Phytec pca100 and
pcm043 boards. The first patch adds the ssi header file in
include/mach which Marc has - intentionally or not - dropped from
my i.MX sound driver. Anyway, adding this file along with the
users prevents compile breakage.

Sascha

The following changes since commit cb2dc111b156eb41f61ed4e5b3a3a5df90526d9d:
  Sascha Hauer (1):
        i.MX27 pca100: Add USB support

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git mxc-pu

Sascha Hauer (3):
      add ssi header file
      pca100: add sound support
      i.MX pcm043: Add AC97 sound support

 arch/arm/mach-mx2/mach-pca100.c      |   48 ++++++++++++++++
 arch/arm/mach-mx3/mach-pcm043.c      |  101 ++++++++++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/ssi.h |   18 ++++++
 3 files changed, 167 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-mxc/include/mach/ssi.h
