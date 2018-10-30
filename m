From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 30 Oct 2018 16:07:16 -0700
Subject: [PATCH v2 1/6] nds32: Remove phys_initrd_start and phys_initrd_size
In-Reply-To: <20181030230721.28429-1-f.fainelli@gmail.com>
References: <20181030230721.28429-1-f.fainelli@gmail.com>
Message-ID: <20181030230721.28429-2-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will conflict with a subsequent change making phys_initrd_start and
phys_initrd_size global variables. nds32 does not make use of those nor
provides a suitable declarations so just get rid of them.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/nds32/mm/init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/nds32/mm/init.c b/arch/nds32/mm/init.c
index c713d2ad55dc..32f55a24ccbb 100644
--- a/arch/nds32/mm/init.c
+++ b/arch/nds32/mm/init.c
@@ -22,8 +22,6 @@
 DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 DEFINE_SPINLOCK(anon_alias_lock);
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
-extern unsigned long phys_initrd_start;
-extern unsigned long phys_initrd_size;
 
 /*
  * empty_zero_page is a special page that is used for
-- 
2.17.1
