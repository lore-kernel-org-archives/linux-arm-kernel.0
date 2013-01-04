From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  4 Jan 2013 17:44:13 +0000
Subject: [PATCH 0/2] HYP boot mode fixes
Message-ID: <1357321455-9264-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's a couple of patches fixing issues that have been recently
brought to my attention.

The first patch only affects configurations that are already broken
(CPUs entering the kernel with different modes). The second one is a
bit more serious, and potentially affects setups where the secondary
core is brought up using an interrupt that is still pending when the
kernel is entered.

Both patches have been tested on TC2, and are based on v3.8-rc2.

Marc Zyngier (2):
  ARM: hyp: boot secondary CPUs through the right entry point
  ARM: hyp: simplify __hyp_stub_install epilog

 arch/arm/kernel/head.S     |  2 +-
 arch/arm/kernel/hyp-stub.S | 12 +++---------
 2 files changed, 4 insertions(+), 10 deletions(-)

-- 
1.8.1
