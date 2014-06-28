From: bhelgaas@google.com (Bjorn Helgaas)
Date: Fri, 27 Jun 2014 19:11:58 -0600
Subject: [PATCH 0/2] arm64: clean up /proc/cpuinfo
Message-ID: <20140628010440.9839.9366.stgit@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On arm64, /proc/cpuinfo currently looks like:

    Processor       : AArch64 Processor rev 0 (aarch64)
    processor       : 0
    processor       : 1
    ...
    Features        : ...

Compared to most other architectures (including arm), this has an extra
"Processor" header, and the "Features" and other bits only appear once,
so there's no way to have per-CPU features, variants, etc.

These patches make arm64 more consistent with the other architectures
by removing the extra header and printing the CPU ID information for
each CPU.

---

Bjorn Helgaas (2):
      arm64: add MIDR to per-CPU information
      arm64: kernel: update cpuinfo to print all online CPUs features


 arch/arm64/kernel/setup.c |   46 +++++++++++++++++++++++----------------------
 arch/arm64/kernel/smp.c   |    5 +++++
 2 files changed, 28 insertions(+), 23 deletions(-)
