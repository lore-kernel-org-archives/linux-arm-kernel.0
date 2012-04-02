From: stigge@antcom.de (Roland Stigge)
Date: Mon,  2 Apr 2012 14:56:03 +0200
Subject: [PATCH 6/7] i2c-pnx.c: Fix suspend
In-Reply-To: <1333371364-21347-1-git-send-email-stigge@antcom.de>
References: <1333371364-21347-1-git-send-email-stigge@antcom.de>
Message-ID: <1333371364-21347-7-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the driver's suspend function, clk_enable() was used instead of
clk_disable(). This is corrected with this patch.

Signed-off-by: Roland Stigge <stigge@antcom.de>
CC: stable at vger.kernel.org

---

 Applies to v3.4-rc1

 drivers/i2c/busses/i2c-pnx.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.orig/drivers/i2c/busses/i2c-pnx.c
+++ linux-2.6/drivers/i2c/busses/i2c-pnx.c
@@ -592,8 +592,7 @@ static int i2c_pnx_controller_suspend(st
 {
 	struct i2c_pnx_algo_data *alg_data = platform_get_drvdata(pdev);
 
-	/* FIXME: shouldn't this be clk_disable? */
-	clk_enable(alg_data->clk);
+	clk_disable(alg_data->clk);
 
 	return 0;
 }
