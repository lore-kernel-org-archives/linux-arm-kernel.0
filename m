From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 17 Sep 2012 19:20:05 +1000
Subject: linux-next: manual merge of the arm-soc tree with the staging tree
Message-ID: <20120917192005.ab08c24f98010107fa855edf@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/staging/tidspbridge/core/wdt.c between commit c37a1747acbf
("staging: tidspbridge: Prepare for irqs.h removal") from the  tree and
commit ec2c0825ca31 ("ARM: OMAP2+: Remove hardcoded IRQs and enable
SPARSE_IRQ") from the arm-soc tree.

I fixed it up (I guess - see below) and can carry the fix as necessary
(no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/staging/tidspbridge/core/wdt.c
index 1ed1474,453ef74..0000000
--- a/drivers/staging/tidspbridge/core/wdt.c
+++ b/drivers/staging/tidspbridge/core/wdt.c
@@@ -25,8 -25,7 +25,8 @@@
  #include <dspbridge/host_os.h>
  
  
 +#define OMAP34XX_WDT3_BASE 		(0x49000000 + 0x30000)
- #define INT_34XX_WDT3_IRQ 		36
+ #define INT_34XX_WDT3_IRQ 		(36 + NR_IRQS)
  
  static struct dsp_wdt_setting dsp_wdt;
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120917/5991381c/attachment.sig>
