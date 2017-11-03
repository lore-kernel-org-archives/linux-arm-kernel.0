From: pasha.tatashin@oracle.com (Pavel Tatashin)
Date: Fri,  3 Nov 2017 14:51:45 -0400
Subject: [PATCH v1 0/2] don't use vmemmap_populate() to initialize shadow
Message-ID: <20171103185147.2688-1-pasha.tatashin@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrey Ryabinin asked to replace the three patches in my series:

x86-kasan-add-and-use-kasan_map_populate.patch
arm64-kasan-add-and-use-kasan_map_populate.patch
arm64-kasan-avoid-using-vmemmap_populate-to-initialise-shadow.patch

With two patches in this thread:

x86/mm/kasan: don't use vmemmap_populate() to initialize shadow
arm64/mm/kasan: don't use vmemmap_populate() to initialize shadow

Pavel Tatashin (2):
  x86/mm/kasan: don't use vmemmap_populate() to initialize shadow
  arm64/mm/kasan: don't use vmemmap_populate() to initialize shadow

 arch/arm64/Kconfig          |   2 +-
 arch/arm64/mm/kasan_init.c  | 130 ++++++++++++++++++++++++----------------
 arch/x86/Kconfig            |   2 +-
 arch/x86/mm/kasan_init_64.c | 143 +++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 218 insertions(+), 59 deletions(-)

-- 
2.15.0
