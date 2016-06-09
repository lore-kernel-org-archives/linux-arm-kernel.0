From: zlim.lnx@gmail.com (Zi Shen Lim)
Date: Wed,  8 Jun 2016 21:18:46 -0700
Subject: [PATCH net-next v3 0/4] arm64 BPF JIT updates
Message-ID: <1465445930-3960-1-git-send-email-zlim.lnx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Updates for arm64 eBPF JIT.
The main addition here is implementation of bpf_tail_call.

#1: Fix missing header inclusion in linux/bpf.h.
#2: Add bpf_tail_call for arm64.
#3,4: Optimizations to reduce instruction count for jitted code.

Changes since v2:
 - None. Resubmit per David Miller.

Changes since v1:
 - Added patch #1 to address build error due to missing header inclusion
   in linux/bpf.h. (Thanks to suggestion and ack by Daniel Borkmann)
   Ordered it ahead of bpf_tail_call patch #2 so build error is not
   triggered.

Zi Shen Lim (4):
  bpf: fix missing header inclusion
  arm64: bpf: implement bpf_tail_call() helper
  arm64: bpf: optimize JMP_CALL
  arm64: bpf: optimize LD_ABS, LD_IND

 arch/arm64/net/bpf_jit.h      |   3 +-
 arch/arm64/net/bpf_jit_comp.c | 111 ++++++++++++++++++++++++++++++++++++------
 include/linux/bpf.h           |   1 +
 3 files changed, 99 insertions(+), 16 deletions(-)

-- 
1.9.1
