From: Barry.Song@csr.com (Barry Song)
Date: Thu, 27 Sep 2012 17:53:39 +0800
Subject: [PATCH 1/6] pinctrl: sirf: fix a typo in sirfsoc_gpio_probe
Message-ID: <1348739619-21070-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

Return 0 while probing success.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/pinctrl/pinctrl-sirf.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-sirf.c b/drivers/pinctrl/pinctrl-sirf.c
index 304360c..45a756f 100644
--- a/drivers/pinctrl/pinctrl-sirf.c
+++ b/drivers/pinctrl/pinctrl-sirf.c
@@ -1726,6 +1726,8 @@ static int __devinit sirfsoc_gpio_probe(struct device_node *np)
 		irq_set_handler_data(bank->parent_irq, bank);
 	}
 
+	return 0;
+
 out:
 	iounmap(regs);
 	return err;
-- 
1.7.0.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
