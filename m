From: vaishali.thakkar@oracle.com (Vaishali Thakkar)
Date: Wed, 23 Mar 2016 17:37:18 +0530
Subject: [PATCH v2 0/6] mm/hugetlb: Fix commandline parsing behavior for
 invalid hugepagesize
Message-ID: <1458734844-14833-1-git-send-email-vaishali.thakkar@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current code fails to ignore the 'hugepages=' parameters when unsupported
hugepagesize is specified. With this patchset, introduce new architecture
independent routine hugetlb_bad_size to handle such command line options.
And then call it in architecture specific code.

Changes since v1:
	- Separated different architecture specific changes in different
	  patches
	- CC'ed all arch maintainers

Vaishali Thakkar (6):
  mm/hugetlb: Introduce hugetlb_bad_size
  arm64: mm: Use hugetlb_bad_size
  metag: mm: Use hugetlb_bad_size
  powerpc: mm: Use hugetlb_bad_size
  tile: mm: Use hugetlb_bad_size
  x86: mm: Use hugetlb_bad_size

 arch/arm64/mm/hugetlbpage.c   |  1 +
 arch/metag/mm/hugetlbpage.c   |  1 +
 arch/powerpc/mm/hugetlbpage.c |  6 ++++--
 arch/tile/mm/hugetlbpage.c    |  7 ++++++-
 arch/x86/mm/hugetlbpage.c     |  1 +
 include/linux/hugetlb.h       |  1 +
 mm/hugetlb.c                  | 14 +++++++++++++-
 7 files changed, 27 insertions(+), 4 deletions(-)

-- 
2.1.4
