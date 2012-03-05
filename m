From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Mon,  5 Mar 2012 17:41:47 -0500
Subject: [PATCH 0/3] arm: fix build breakage in omap2plus_defconfig
 (linux-next)
Message-ID: <1330987310-8108-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I decided to look at why this thing was dying in linux-next for
over two weeks now:

http://kisskb.ellerman.id.au/kisskb/target/5581/

The git bisect led me to sfr's merge (661a40a5c8 in March5th tree)
of 'arm-soc/for-next' but there was nothing suspicious there, and
the fix (commit #1) was reasonably obvious, so I didn't investigate
the root cause further.  But that wasn't where the breakage ended...

Commit #2, and especially commit #3 need to be looked at by those
who know the platform.  It looks like some sort of conversion to
better share code was done, but the omap4panda part didn't get
the full attention it needed.  I did what I think looks right,
based on what was done for the other board, but I've no knowledge
of the platform whatsoever, and hence no confidence it would
work as desired.  I've hopefully put the right people on the CC
list for those.

Paul.
---

Paul Gortmaker (3):
  arm: anticipate build breakages due in pending merge
  arm: fix compile error in mach-omap2/board-omap4panda.c
  arm: more fallout from i2c conversions in board-omap4panda.c

 arch/arm/mach-omap2/board-omap4panda.c |    7 +++----
 arch/arm/mach-omap2/cm2xxx_3xxx.c      |    2 ++
 arch/arm/mach-omap2/common.c           |    1 +
 arch/arm/mach-omap2/control.c          |    1 +
 arch/arm/mach-omap2/sdrc2xxx.c         |    1 +
 5 files changed, 8 insertions(+), 4 deletions(-)

-- 
1.7.9.1
