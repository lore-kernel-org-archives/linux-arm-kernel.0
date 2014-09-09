From: yangyingliang@huawei.com (Yang Yingliang)
Date: Tue, 9 Sep 2014 11:59:45 +0800
Subject: [PATCH] arm64: add guard macro of unistd.h to prevent double inclusion
Message-ID: <1410235185-16652-1-git-send-email-yangyingliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add guard macros in both uapi/asm/unistd.h and asm/unistd.h.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 arch/arm64/include/asm/unistd.h      | 5 +++++
 arch/arm64/include/uapi/asm/unistd.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 6d2bf41..21a7dec 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -13,6 +13,9 @@
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
+#ifndef __ASM_ARM64_UNISTD_H
+#define __ASM_ARM64_UNISTD_H
+
 #ifdef CONFIG_COMPAT
 #define __ARCH_WANT_COMPAT_SYS_GETDENTS64
 #define __ARCH_WANT_COMPAT_STAT64
@@ -48,3 +51,5 @@
 #include <uapi/asm/unistd.h>
 
 #define NR_syscalls (__NR_syscalls)
+
+#endif /* __ASM_ARM64_UNISTD_H */
diff --git a/arch/arm64/include/uapi/asm/unistd.h b/arch/arm64/include/uapi/asm/unistd.h
index 1caadc2..ab72cac 100644
--- a/arch/arm64/include/uapi/asm/unistd.h
+++ b/arch/arm64/include/uapi/asm/unistd.h
@@ -13,4 +13,9 @@
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
+#ifndef _UAPI__ASM_ARM64_UNISTD_H
+#define _UAPI__ASM_ARM64_UNISTD_H
+
 #include <asm-generic/unistd.h>
+
+#endif /* _UAPI__ASM_ARM64_UNISTD_H */
-- 
1.8.0
