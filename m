From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 2 Dec 2015 13:35:22 +0300
Subject: [PATCH v6 14/19] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <1712431.VUth4NvudT@wuerfel>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <12844690.Yr8y3jA010@wuerfel> <20151201233503.GA23156@yury-N73SV>
 <1712431.VUth4NvudT@wuerfel>
Message-ID: <20151202103522.GB21461@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2015 at 09:37:05AM +0100, Arnd Bergmann wrote:
> The 4*PAGE_SIZE on ARM is an architecture specific oddity, I believe
> to work around aliasing caches on ARMv6. As no other architecture does
> this, we're probably better off not duplicating it for aarch64-ilp32
> and just use sys_shmat as your v6 patch does.
> 	Arnd

If you feel ARMv6 fix for caches will come soon, just ignore it.
Otherwise, please pull it because compat_sys_shmat is broken now
for 64K pages.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/include/asm/shmparam.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/shmparam.h b/arch/arm64/include/asm/shmparam.h
index 4df608a..e368a55 100644
--- a/arch/arm64/include/asm/shmparam.h
+++ b/arch/arm64/include/asm/shmparam.h
@@ -21,7 +21,7 @@
  * alignment value. Since we don't have aliasing D-caches, the rest of
  * the time we can safely use PAGE_SIZE.
  */
-#define COMPAT_SHMLBA	0x4000
+#define COMPAT_SHMLBA	(4 * PAGE_SIZE)
 
 #include <asm-generic/shmparam.h>
 
-- 
2.5.0
