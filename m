From: linfeng@cn.fujitsu.com (Lin Feng)
Date: Mon, 8 Apr 2013 17:56:38 +0800
Subject: [PATCH 0/2] mm: vmemmap: add vmemmap_verify check for hot-add
 node/memory case
Message-ID: <1365415000-10389-1-git-send-email-linfeng@cn.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In hot add node(memory) case, vmemmap pages are always allocated from other
node, but the current logic just skip vmemmap_verify check. 
So we should also issue "potential offnode page_structs" warning messages
if we are the case

Lin Feng (2):
  mm: vmemmap: x86: add vmemmap_verify check for hot-add node case
  mm: vmemmap: arm64: add vmemmap_verify check for hot-add node case

 arch/arm64/mm/mmu.c   | 4 ++--
 arch/x86/mm/init_64.c | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

-- 
1.8.0.1
