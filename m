Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311B6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:21:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9355214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fhBasBxK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9355214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=7MLfm5uz5k5zgv4FFyK/VPnmqWxjXhJJCi/h10tEuxk=; b=fhBasBxKmntDew
	sQK+AJZH0SViPbmc08Sm05rLjoqXpiGvAbXI2C9S5E76iXKjNiCW+cj8AD3Ogk9lqBuAUciAvYzZL
	JX4vSBfCTtdaqS1GqNIUKTzRuYOAmD0EnzEI/0Ib/VR5Zq8LTrpCkV+ysNZPwJtMo4N2BpOXapbAL
	/kAhy4YuWypeeI753Voa2JYCiI3udU8GLuCF2mjQsE3/dmBEf5DpTpVW8tWJV4qQfe1yh0WEnFI8p
	XRp+FApzYRt/GsFRBH3vrVtX6B4fZO092zfNuJt6eY2Xf/2jEriemiFhrhtmq+q2y1jJ6++VgoBq3
	QVhltXntsD0QDxR5E8zQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggu88-000858-FI; Tue, 08 Jan 2019 16:21:28 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggu83-00084K-CW
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 16:21:27 +0000
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28]
 helo=dude02.pengutronix.de.)
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1ggu7x-0006Mm-3s; Tue, 08 Jan 2019 17:21:17 +0100
From: Lucas Stach <l.stach@pengutronix.de>
To: Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH] clk: imx5: add imx5_SCC2_IPG_GATE
Date: Tue,  8 Jan 2019 17:21:15 +0100
Message-Id: <20190108162115.1998-1-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_082123_700142_851ACDB4 
X-CRM114-Status: GOOD (  10.25  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Michael Turquette <mturquette@baylibre.com>, patchwork-lst@pengutronix.de,
 NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de,
 Shawn Guo <shawnguo@kernel.org>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Michael Grzeschik <m.grzeschik@pengutronix.de>

This adds the missing clock for the SCC2 peripheral unit.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/clk/imx/clk-imx51-imx53.c      | 1 +
 include/dt-bindings/clock/imx5-clock.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx51-imx53.c b/drivers/clk/imx/clk-imx51-imx53.c
index fc8e782d817b..e91c826bce70 100644
--- a/drivers/clk/imx/clk-imx51-imx53.c
+++ b/drivers/clk/imx/clk-imx51-imx53.c
@@ -428,6 +428,7 @@ static void __init mx51_clocks_init(struct device_node *np)
 	clk[IMX5_CLK_ESDHC4_PER_GATE]	= imx_clk_gate2("esdhc4_per_gate", "esdhc_d_sel", MXC_CCM_CCGR3, 14);
 	clk[IMX5_CLK_USB_PHY_GATE]	= imx_clk_gate2("usb_phy_gate", "usb_phy_sel", MXC_CCM_CCGR2, 0);
 	clk[IMX5_CLK_HSI2C_GATE]	= imx_clk_gate2("hsi2c_gate", "ipg", MXC_CCM_CCGR1, 22);
+	clk[IMX5_CLK_SCC2_IPG_GATE]	= imx_clk_gate2("scc2_gate", "ipg", MXC_CCM_CCGR1, 30);
 	clk[IMX5_CLK_MIPI_HSC1_GATE]	= imx_clk_gate2_flags("mipi_hsc1_gate", "ipg", MXC_CCM_CCGR4, 6, CLK_IS_CRITICAL);
 	clk[IMX5_CLK_MIPI_HSC2_GATE]	= imx_clk_gate2_flags("mipi_hsc2_gate", "ipg", MXC_CCM_CCGR4, 8, CLK_IS_CRITICAL);
 	clk[IMX5_CLK_MIPI_ESC_GATE]	= imx_clk_gate2_flags("mipi_esc_gate", "ipg", MXC_CCM_CCGR4, 10, CLK_IS_CRITICAL);
diff --git a/include/dt-bindings/clock/imx5-clock.h b/include/dt-bindings/clock/imx5-clock.h
index d382fc71aa83..a81be5be6700 100644
--- a/include/dt-bindings/clock/imx5-clock.h
+++ b/include/dt-bindings/clock/imx5-clock.h
@@ -214,6 +214,7 @@
 #define IMX5_CLK_IEEE1588_SEL		202
 #define IMX5_CLK_IEEE1588_PODF		203
 #define IMX5_CLK_IEEE1588_GATE		204
-#define IMX5_CLK_END			205
+#define IMX5_CLK_SCC2_IPG_GATE		205
+#define IMX5_CLK_END			206
 
 #endif /* __DT_BINDINGS_CLOCK_IMX5_H */
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
