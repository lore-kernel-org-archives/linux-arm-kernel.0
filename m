From: heechul@illinois.edu (heechul Yun)
Date: Wed, 6 Jul 2011 19:19:59 -0700
Subject: [PATCH] remove unnecessary cache flush on v6 copypage
Message-ID: <CAN_5kQDTweB2GLvwgjN+BQuqnhFUp+MOcQr=ZW=8C6XSsC8XtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: mm: remove unnecessary cache flush on v6 copypage

Signed-off-by: Heechul Yun <heechul@illinois.edu>
--
arch/arm/mm/copypage-v6.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/copypage-v6.c b/arch/arm/mm/copypage-v6.c
index bdba6c6..63cca00 100644
--- a/arch/arm/mm/copypage-v6.c
+++ b/arch/arm/mm/copypage-v6.c
@@ -41,7 +41,6 @@ static void v6_copy_user_highpage_nonaliasing(struct page *to,
       kfrom = kmap_atomic(from, KM_USER0);
       kto = kmap_atomic(to, KM_USER1);
       copy_page(kto, kfrom);
-       __cpuc_flush_dcache_area(kto, PAGE_SIZE);
       kunmap_atomic(kto, KM_USER1);
       kunmap_atomic(kfrom, KM_USER0);
 }

--

Heechul
