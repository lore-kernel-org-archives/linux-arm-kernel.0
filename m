From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 11 Aug 2011 10:41:04 +0800
Subject: [GIT PULL] pxa: fixes for v3.1-rc1
Message-ID: <CAMPhdO9JhjJVccSM-tk2hBfvVGUsHQPi1F_g4kxhRP+cHWp+gQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 322a8b034003c0d46d39af85bf24fee27b902f48:

  Linux 3.1-rc1 (2011-08-07 18:23:30 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git fix

Lennert Buytenhek (4):
      ARM: pxa: fix logic error in PJ4 iWMMXt handling
      ARM: mmp: Also start timer 1 on boot.
      ARM: mmp: Switch to using timer 1 as clocksource timer.
      ARM: mmp: Change the way we use timer 0 as clockevent timer.

Tanmay Upadhyay (2):
      ARM: pxa168/gplugd: get rid of mfp-gplugd.h
      ARM: pxa168/gplugd: free correct GPIO

 arch/arm/kernel/iwmmxt.S                    |    6 +-
 arch/arm/mach-mmp/gplugd.c                  |   22 ++++++---
 arch/arm/mach-mmp/include/mach/mfp-gplugd.h |   52 ----------------------
 arch/arm/mach-mmp/include/mach/mfp-pxa168.h |   37 ++++++++++++++--
 arch/arm/mach-mmp/time.c                    |   62 +++++++++++++++++++--------
 5 files changed, 94 insertions(+), 85 deletions(-)
 delete mode 100644 arch/arm/mach-mmp/include/mach/mfp-gplugd.h
