From: labbott@fedoraproject.org (Laura Abbott)
Date: Fri, 29 Jan 2016 15:46:55 -0800
Subject: [PATCHv2 0/3] ARCH_SUPPORTS_DEBUG_PAGEALLOC for arm64
Message-ID: <1454111218-3461-1-git-send-email-labbott@fedoraproject.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is v2 of the series to add proper debug pagealloc support for arm64.

Changes since v1:
- Dropped the config for forcing pages and changed it to runtime detection.
  This now matches better with how x86 and other arches are being updated.
  That patch is now dropped completely and folded in to the actual patch
  for ARCH_SUPPORTS_DEBUG_PAGEALLOC
- Took Mark's suggestion to rename create_mapping -> create_mapping_noalloc
- The only way to get all PAGE_SIZE mappings right now is to enable
  debug_pagealloc. This is the only actual use case right now. It is fairly
  simple to add the code to let this happen for other uses. If that
  time comes someone can plead their case to the court of ARM to accept such
  a patch.

This series now depends on the patch to let debug_pagealloc_enabled()
be used when !CONFIG_DEBUG_PAGEALLOC
(http://article.gmane.org/gmane.linux.kernel.mm/145208)
I can either take acks and submit this to the MM tree or we can wait for that
patch to show up in something I can rebase to.

Thanks,
Laura

Laura Abbott (3):
  arm64: Drop alloc function from create_mapping
  arm64: Add support for ARCH_SUPPORTS_DEBUG_PAGEALLOC
  arm64: ptdump: Indicate whether memory should be faulting

 arch/arm64/Kconfig       |  3 +++
 arch/arm64/mm/dump.c     |  5 +++++
 arch/arm64/mm/mmu.c      | 37 +++++++++++++++++++++++++------------
 arch/arm64/mm/pageattr.c | 40 +++++++++++++++++++++++++++++++++-------
 4 files changed, 66 insertions(+), 19 deletions(-)

-- 
2.5.0
