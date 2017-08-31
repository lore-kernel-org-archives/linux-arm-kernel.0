From: brendanhiggins@google.com (Brendan Higgins)
Date: Thu, 31 Aug 2017 15:53:57 -0700
Subject: [PATCH v2 0/3] arm: npcm: add basic support for Nuvoton BMCs
Message-ID: <20170831225400.19756-1-brendanhiggins@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Addressed comments from:
  - Rob: http://www.spinics.net/lists/devicetree/msg192130.html
  - kbuild test robot: http://www.spinics.net/lists/devicetree/msg191902.html
  - kbuild test robot: http://www.spinics.net/lists/devicetree/msg191902.html

Changes since previous update:
  - Added dependency for !CPU_V6 and !CPU_V6K since headsmp.S depends on v7
    instructions
  - Dropped errata that depend on !ARCH_MULTIPLATFORM
  - Removed custom smp_init_cpus from smp_operations
  - Numerous changes to device tree support

Changes have been tested on the NPCM750 evaluation board.
