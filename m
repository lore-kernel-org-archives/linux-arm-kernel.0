From: luisbg@kernel.org (Luis de Bethencourt)
Date: Tue, 23 Jan 2018 15:08:55 +0000
Subject: [PATCH] ARM: sched_clock: Fix trailing semicolon
Message-ID: <20180123150855.17148-1-luisbg@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The trailing semicolon is an empty statement that does no operation.
Removing it since it doesn't do anything.

Signed-off-by: Luis de Bethencourt <luisbg@kernel.org>
---

Hi,

After fixing the same thing in drivers/staging/rtl8723bs/, Joe Perches
suggested I fix it treewide [0].

Best regards 
Luis


[0] http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-January/115410.html
[1] http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-January/115390.html

 arch/arm/kernel/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
index 629f8e9981f1..cf2701cb0de8 100644
--- a/arch/arm/kernel/time.c
+++ b/arch/arm/kernel/time.c
@@ -83,7 +83,7 @@ static void dummy_clock_access(struct timespec64 *ts)
 }
 
 static clock_access_fn __read_persistent_clock = dummy_clock_access;
-static clock_access_fn __read_boot_clock = dummy_clock_access;;
+static clock_access_fn __read_boot_clock = dummy_clock_access;
 
 void read_persistent_clock64(struct timespec64 *ts)
 {
-- 
2.15.1
