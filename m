From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 22 May 2014 14:47:58 +0200
Subject: [PATCH 0/4] ARM: mvebu: Minor fixes and improvements to coherency_ll.S
Message-ID: <1400762882-10116-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason, Andrew, Gregory, Sebastian,

Here is a small set of patches making fixes and improvements to the
coherency_ll.S code.

The first patch is really important and fixes big endian booting in
-next. The regression was introduced by the cpuidle changes, which are
currently in -next.

The other three patches are only improvements, mainly cosmetic, but I
believe they clarify a few things that took me a bit of time to
re-understand this morning.

The patches are based on top of mvebu/soc.

Thanks,

Thomas

Thomas Petazzoni (4):
  ARM: mvebu: fix big endian booting after coherency code rework
  ARM: mvebu: fix indentation of assembly instructions in coherency_ll.S
  ARM: mvebu: improve comments in coherency_ll.S
  ARM: mvebu: returns ll_get_cpuid() to ll_get_coherency_cpumask()

 arch/arm/mach-mvebu/coherency_ll.S | 77 ++++++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 28 deletions(-)

-- 
1.9.3
