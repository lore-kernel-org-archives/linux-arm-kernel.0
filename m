From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 06 Jul 2011 11:23:10 +0100
Subject: [PATCH 1/7] ARM: ensure tag tables are const
In-Reply-To: <20110706102245.GO8286@n2100.arm.linux.org.uk>
References: <20110706102245.GO8286@n2100.arm.linux.org.uk>
Message-ID: <E1QePGA-0004zY-2l@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nothing should ever modify a tag table entry, so mark these const.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/setup.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/setup.h b/arch/arm/include/asm/setup.h
index ee2ad8a..c3b5c79 100644
--- a/arch/arm/include/asm/setup.h
+++ b/arch/arm/include/asm/setup.h
@@ -187,7 +187,7 @@ struct tagtable {
 
 #define __tag __used __attribute__((__section__(".taglist.init")))
 #define __tagtable(tag, fn) \
-static struct tagtable __tagtable_##fn __tag = { tag, fn }
+static const struct tagtable __tagtable_##fn __tag = { tag, fn }
 
 /*
  * Memory map description
-- 
1.7.4.4
