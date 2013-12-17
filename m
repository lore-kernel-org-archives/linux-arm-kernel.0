From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 17 Dec 2013 22:47:34 +0100
Subject: [PATCH 1/5] pinctrl: r7s72100: add riic groups
In-Reply-To: <1387316678-10174-2-git-send-email-wsa@the-dreams.de>
References: <1387316678-10174-1-git-send-email-wsa@the-dreams.de>
 <1387316678-10174-2-git-send-email-wsa@the-dreams.de>
Message-ID: <20131217214734.GC1196@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 10:44:34PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa@sang-engineering.com>
> 
> Tested RIIC2 on a genmai board. Other riic groups are untested but seem
> trivial enough to be added.
> 
> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
> Acked-by: Magnus Damm <damm@opensource.se>
> ---
> 
> Note: With the current PFC driver as posted by Magnus, it needs another patch
> to work. Yet, I think this is a seperate PFC issue which needs to be sorted out
> seperately and shouldn't affect these declarations. I'll add the needed patch
> as a response to this mail.

Here it goes...

From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] HACK: make magnus new driver work

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/pinctrl/sh-pfc/pfc-r7s72100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r7s72100.c b/drivers/pinctrl/sh-pfc/pfc-r7s72100.c
index 00f67e8..a662876 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r7s72100.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r7s72100.c
@@ -68,11 +68,11 @@ enum {
 #define _P_GPIO(bank, _pin, _name, sfx) _GP_GPIO(16, bank, _pin, _name, sfx)
 
 #define _P_DATA(bank, pin, name, sfx)					\
-	PINMUX_DATA(name##_DATA, name##_PMC_0, name##_PIPC_0,		\
+	PINMUX_DATA(name##_DATA, name##_PMC_0,		\
 		    name##_PIBC_1, name##_PBDC_1)
 
 #define _P_FN(n, fn, pfcae, pfce, pfc)					\
-	PINMUX_DATA(n##_MARK_FN##fn, n##_PMC_1,	n##_PIPC_1,		\
+	PINMUX_DATA(n##_MARK_FN##fn, n##_PMC_1,		\
 		    n##_PFCAE_##pfcae, n##_PFCE_##pfce, n##_PFC_##pfc)
 
 #define _P_MARK_FN1(bank, pin, name, sfx) _P_FN(name, 1, 0, 0, 0)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131217/81673620/attachment.sig>
