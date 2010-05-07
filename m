From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Fri, 7 May 2010 13:30:11 +0200 (CEST)
Subject: [GIT-PULL] ARM: Gemini: fix compiler error in copypage-fa.c
In-Reply-To: <20100504160522.GD30601@n2100.arm.linux.org.uk>
References: <1272983655-18408-1-git-send-email-ulli.kroll@googlemail.com>
	<20100504160522.GD30601@n2100.arm.linux.org.uk>
Message-ID: <alpine.LNX.2.00.1005071325450.7857@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here you call pull ...


Ulli

The following changes since commit 
352d4657b23fbd329efccc396000a549e0150907:
   Linus Torvalds (1):
         Merge branch 'for-linus' of 
git://git.kernel.org/.../mattst88/alpha-2.6

are available in the git repository at:

   git://git.berlios.de/gemini-board gemini_fix

Hans Ulli Kroll (1):
       ARM: Gemini: fix compiler error in copypage-fa.c

  arch/arm/mm/copypage-fa.c |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/copypage-fa.c b/arch/arm/mm/copypage-fa.c
index b2a6008..d2852e1 100644
--- a/arch/arm/mm/copypage-fa.c
+++ b/arch/arm/mm/copypage-fa.c
@@ -40,7 +40,7 @@ fa_copy_user_page(void *kto, const void *kfrom)
  }

  void fa_copy_user_highpage(struct page *to, struct page *from,
-       unsigned long vaddr)
+       unsigned long vaddr, struct vm_area_struct *vma)
  {
         void *kto, *kfrom;
