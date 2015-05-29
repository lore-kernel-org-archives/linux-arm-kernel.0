From: bp@alien8.de (Borislav Petkov)
Date: Fri, 29 May 2015 22:05:20 +0200
Subject: [PATCH] EDAC, edac_stub: Drop arch-specific include
In-Reply-To: <20150529185926.GP31435@pd.tnic>
References: <1432337580-3750-1-git-send-email-lho@apm.com>
 <20150529094654.GD31435@pd.tnic>
 <CAPw-ZTnLqx0KsQkmv++zQRQ7hroaKML1rWgVafisENam0J17Mg@mail.gmail.com>
 <20150529185926.GP31435@pd.tnic>
Message-ID: <20150529200520.GT31435@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 29, 2015 at 08:59:26PM +0200, Borislav Petkov wrote:
> Does it build when you remove it?

IOW, this should fix it:

---
From: Borislav Petkov <bp@suse.de>
Date: Fri, 29 May 2015 22:01:00 +0200
Subject: [PATCH] EDAC, edac_stub: Drop arch-specific include

<asm/edac.h> contains only the arch-specific scrubbing function and is
thus not needed in edac_stub.c. Kill it.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/edac/edac_stub.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/edac/edac_stub.c b/drivers/edac/edac_stub.c
index 9d9e18aefaaa..ff07aae5b7fb 100644
--- a/drivers/edac/edac_stub.c
+++ b/drivers/edac/edac_stub.c
@@ -16,7 +16,6 @@
 #include <linux/edac.h>
 #include <linux/atomic.h>
 #include <linux/device.h>
-#include <asm/edac.h>
 
 int edac_op_state = EDAC_OPSTATE_INVAL;
 EXPORT_SYMBOL_GPL(edac_op_state);
-- 
2.3.5

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
