From: robherring2@gmail.com (Rob Herring)
Date: Wed, 27 Jul 2011 22:32:11 -0500
Subject: [RFC PATCH 0/3] ARM: Add default system.h and uncompress.h
Message-ID: <1311823934-29553-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This is a relatively simple way to remove the platform requirement for
some header files without making changes in every existing platform.
It's perhaps not a solution for the difficult cases, but can get the
simple cases out of the way making it clear what remains to be fixed.
I've done this for system.h and uncompress.h so far. timex.h and io.h
may be additional candidates.

One downside is you lose print capability in the decompressor. However,
I don't think the complexity that adds is worth the 1 line print. Perhaps
the include path ordering could be conditionalized on a config setting
for multi-platform kernels such that the platform's headers are used
on single machine kernels. There's already such a limitation on LL_DEBUG.

Rob

Rob Herring (3):
  ARM: include mach headers before common arm headers
  ARM: add a default mach/uncompress.h header
  ARM: add a default mach/system.h header

 arch/arm/Makefile                  |    4 ++--
 arch/arm/include/mach/system.h     |   13 +++++++++++++
 arch/arm/include/mach/uncompress.h |    9 +++++++++
 arch/arm/kernel/process.c          |    5 ++++-
 4 files changed, 28 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/include/mach/system.h
 create mode 100644 arch/arm/include/mach/uncompress.h

-- 
1.7.4.1
