From: nschichan@freebox.fr (Nicolas Schichan)
Date: Tue, 21 Jul 2015 14:14:11 +0200
Subject: [PATCH V2 net 0/3] BPF JIT fixes for ARM
Message-ID: <1437480854-22684-1-git-send-email-nschichan@freebox.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

These patches are fixing bugs in the ARM JIT and should probably find
their way to a stable kernel. All 60 test_bpf tests in Linux 4.1 release
are now passing OK (was 54 out of 60 before).

Regards,

Changes from original submission:
* split fixes and features in separate patch series.

Nicolas Schichan (3):
  ARM: net: fix condition for load_order > 0 when translating load
    instructions.
  ARM: net: handle negative offsets in BPF JIT.
  ARM: net: fix vlan access instructions in ARM JIT.

 arch/arm/net/bpf_jit_32.c | 57 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 13 deletions(-)

-- 
1.9.1
