From: yaojun8558363@gmail.com (Jun Yao)
Date: Wed, 20 Jun 2018 16:57:54 +0800
Subject: [PATCH 0/1] Move {idmap_pg_dir,tramp_pg_dir,swapper_pg_dir}
Message-ID: <20180620085755.20045-1-yaojun8558363@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves {idmap_pg_dir,tramp_pg_dir,swapper_pg_dir} to .rodata
section, which makes KSMA more difficult. At the same time, it is more
concise than the previous patches[1][2]. As James Morse suggested[2],
this patch updates swapper_pg_dir through the fixmap entry.

[1] http://www.openwall.com/lists/kernel-hardening/2018/05/31/1
[2] https://patchwork.kernel.org/patch/10449589/

Jun Yao (1):
  arm64/mm: move {idmap_pg_dir,tramp_pg_dir,swapper_pg_dir} to .rodata
    section

 arch/arm64/include/asm/pgalloc.h | 19 +++++++++++++++++++
 arch/arm64/kernel/vmlinux.lds.S  | 32 ++++++++++++++++++--------------
 arch/arm64/mm/mmu.c              | 23 +++++++++++++++++++----
 3 files changed, 56 insertions(+), 18 deletions(-)

-- 
2.17.1
