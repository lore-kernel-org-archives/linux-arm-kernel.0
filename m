From: Baohua.Song@csr.com (Barry Song)
Date: Thu, 4 Jul 2013 15:59:53 +0800
Subject: [PATCH 5/5] pinctrl: sirf: add freeze and restore entries for
 hibernation support
Message-ID: <1372924793-5579-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this patch adds hibernation entries so that the sirf platform can
support suspend-to-disk.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/pinctrl/sirf/pinctrl-sirf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/sirf/pinctrl-sirf.c b/drivers/pinctrl/sirf/pinctrl-sirf.c
index 7186b46..0792e8d 100644
--- a/drivers/pinctrl/sirf/pinctrl-sirf.c
+++ b/drivers/pinctrl/sirf/pinctrl-sirf.c
@@ -440,6 +440,8 @@ static int sirfsoc_pinmux_resume_noirq(struct device *dev)
 static const struct dev_pm_ops sirfsoc_pinmux_pm_ops = {
 	.suspend_noirq = sirfsoc_pinmux_suspend_noirq,
 	.resume_noirq = sirfsoc_pinmux_resume_noirq,
+	.freeze_noirq = sirfsoc_pinmux_suspend_noirq,
+	.restore_noirq = sirfsoc_pinmux_resume_noirq,
 };
 #endif
 
-- 
1.8.2.3



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
