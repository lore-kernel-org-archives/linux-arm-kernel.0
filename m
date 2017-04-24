From: david.daney@cavium.com (David Daney)
Date: Mon, 24 Apr 2017 11:42:48 -0700
Subject: [PATCH 0/2] arm64: Workaround for Thunder KVM hang issues.
Message-ID: <20170424184250.667-1-david.daney@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have discovered in rare circumstances, guest execution may result
in host not receiving one or more interrupts.  This does not otherwise
affect guest or host execution and/or isolation.


David Daney (2):
  arm64: Add MIDR values for Cavium cn83XX SoCs
  arm64: Add workaround for Cavium Thunder erratum 30115

 Documentation/arm64/silicon-errata.txt |  1 +
 arch/arm64/Kconfig                     | 11 +++++++++++
 arch/arm64/include/asm/cpucaps.h       |  3 ++-
 arch/arm64/include/asm/cputype.h       |  2 ++
 arch/arm64/kernel/cpu_errata.c         | 21 +++++++++++++++++++++
 arch/arm64/kvm/hyp/switch.c            |  9 +++++++++
 6 files changed, 46 insertions(+), 1 deletion(-)

-- 
2.7.4
