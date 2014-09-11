From: yangyingliang@huawei.com (Yang Yingliang)
Date: Thu, 11 Sep 2014 17:21:18 +0800
Subject: [PATCH v2] arm64: add guard macros of unistd.h to prevent double
 inclusion
In-Reply-To: <54115583.8080306@huawei.com>
References: <1410235185-16652-1-git-send-email-yangyingliang@huawei.com>
 <20140909123938.GL1754@arm.com> <54115583.8080306@huawei.com>
Message-ID: <5411698E.3000402@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yang Yingliang <yangyingliang@huawei.com>

Add guard macros for uapi/asm/unistd.h, asm/unistd.h and
asm/unistd32.h.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 arch/arm64/include/asm/unistd.h      | 5 +++++
 arch/arm64/include/asm/unistd32.h    | 4 ++++
 arch/arm64/include/uapi/asm/unistd.h | 5 +++++
 3 files changed, 14 insertions(+)

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
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index da1f06b..8f5e78e 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -16,6 +16,8 @@
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
+#ifndef __ASM_ARM64_UNISTD32_H
+#define __ASM_ARM64_UNISTD32_H
 
 #ifndef __SYSCALL
 #define __SYSCALL(x, y)
@@ -792,3 +794,5 @@ __SYSCALL(__NR_renameat2, sys_renameat2)
 __SYSCALL(__NR_getrandom, sys_getrandom)
 #define __NR_memfd_create 385
 __SYSCALL(__NR_memfd_create, sys_memfd_create)
+
+#endif /* __ASM_ARM64_UNISTD32_H */
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
