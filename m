From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Wed, 22 Jul 2015 19:23:01 +0200
Subject: [GIT PULL]STi SoC changes for v4.3, round 1
Message-ID: <55AFD175.6030807@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Kevin,

Please consider this first round of STi SoC changes for v4.3:

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

   Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

   https://git.kernel.org/pub/scm/linux/kernel/git/mcoquelin/sti.git 
tags/sti-soc-for-v4.3-1

for you to fetch changes up to 50de4dd4bc6a6e378841a6705696d2c1f37ac038:

   ARM: STi: Remove platform call to trace_hardirqs_off() (2015-07-22 
11:15:30 +0200)

----------------------------------------------------------------
STi SoC updates for v4.3, round 1.

Highlights:
-----------
  - Add code to release secondary cores from holding pen.
  - Remove useless call to trace_hardirqs_off() in secondary core init 
function.

----------------------------------------------------------------
Peter Griffin (2):
       ARM: STi: Add code to release secondary cores from holding pen.
       ARM: STi: Remove platform call to trace_hardirqs_off()

  arch/arm/mach-sti/headsmp.S |  1 +
  arch/arm/mach-sti/platsmp.c | 57 
+++++++++++++++++++++++++++++++++++++++++----
  arch/arm/mach-sti/smp.h     |  2 ++
  3 files changed, 55 insertions(+), 5 deletions(-)
