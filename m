Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8612C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:41:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B90E20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VwHJHhqJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B90E20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0S0DhKQtiHvKwGo44j9oQN131UEW2U7pHUhVaU0f1to=; b=VwHJHhqJjJTbaY
	4OG1EArq8a/MAErnnqzaHxySDzjIw2iguj//1WuQSgc0z1mphXYBebElxvbqXzomiCroK9nUBW+je
	DPYjxW3/VKPOooLlzGxW9AELPdiEDwgndPjaEkECAWRNhXUa45nEleJXhhNjrCdMRS6X+EZ9TmRhK
	Kn5G8GaToefGG9HQGxjVHS3xfnt8UtQUiz5rXtiq7eDaOYr64072b+LBDJLzhItQ5F/qtM6jJyEez
	JQ+ca50MdHdfnyTlonYgD/r+OcB+n33LdmuLX4L+Bm5LAPIjoXZQbuXwykwecrwGIGf5fMYCHRtyn
	rRFKtJ+njXcCRN4ld0KQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTqLX-0004Cc-30; Mon, 03 Dec 2018 15:41:19 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTqLS-0004AF-KT
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 15:41:16 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id D79FA5FA01; Mon,  3 Dec 2018 23:41:00 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Linus Walleij <linus.walleij@linaro.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 1/2] pinctrl: sunxi: a64: Rename function csi0 to csi
Date: Mon,  3 Dec 2018 23:40:59 +0800
Message-Id: <20181203154100.4280-2-wens@csie.org>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181203154100.4280-1-wens@csie.org>
References: <20181203154100.4280-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_074114_930658_BB6AE786 
X-CRM114-Status: UNSURE (   9.71  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 Jagan Teki <jagan@amarulasolutions.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The A64 only has one CSI (camera sensor interface) controller. The
datasheet also lists the function as CSI_XXX instead of CSI0_XXX.

Rename the function names now before any there are any users.

Fixes: 96851d391d02 ("drivers: pinctrl: add driver for Allwinner A64 SoC")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c | 28 +++++++++++-----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c
index f5f77432ce6f..8b974b2a2486 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c
@@ -323,71 +323,71 @@ static const struct sunxi_desc_pin a64_pins[] = {
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 0),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "csi0"),		/* PCK */
+		  SUNXI_FUNCTION(0x2, "csi"),		/* PCK */
 		  SUNXI_FUNCTION(0x4, "ts0")),		/* CLK */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 1),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "csi0"),		/* CK */
+		  SUNXI_FUNCTION(0x2, "csi"),		/* CK */
 		  SUNXI_FUNCTION(0x4, "ts0")),		/* ERR */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 2),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "csi0"),		/* HSYNC */
+		  SUNXI_FUNCTION(0x2, "csi"),		/* HSYNC */
 		  SUNXI_FUNCTION(0x4, "ts0")),		/* SYNC */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 3),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "csi0"),		/* VSYNC */
+		  SUNXI_FUNCTION(0x2, "csi"),		/* VSYNC */
 		  SUNXI_FUNCTION(0x4, "ts0")),		/* DVLD */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 4),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "csi0"),		/* D0 */
+		  SUNXI_FUNCTION(0x2, "csi"),		/* D0 */
 		  SUNXI_FUNCTION(0x4, "ts0")),		/* D0 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 5),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "csi0"),		/* D1 */
+		  SUNXI_FUNCTION(0x2, "csi"),		/* D1 */
 		  SUNXI_FUNCTION(0x4, "ts0")),		/* D1 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 6),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "csi0"),		/* D2 */
+		  SUNXI_FUNCTION(0x2, "csi"),		/* D2 */
 		  SUNXI_FUNCTION(0x4, "ts0")),		/* D2 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 7),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "csi0"),		/* D3 */
+		  SUNXI_FUNCTION(0x2, "csi"),		/* D3 */
 		  SUNXI_FUNCTION(0x4, "ts0")),		/* D3 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 8),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "csi0"),		/* D4 */
+		  SUNXI_FUNCTION(0x2, "csi"),		/* D4 */
 		  SUNXI_FUNCTION(0x4, "ts0")),		/* D4 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 9),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "csi0"),		/* D5 */
+		  SUNXI_FUNCTION(0x2, "csi"),		/* D5 */
 		  SUNXI_FUNCTION(0x4, "ts0")),		/* D5 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 10),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "csi0"),		/* D6 */
+		  SUNXI_FUNCTION(0x2, "csi"),		/* D6 */
 		  SUNXI_FUNCTION(0x4, "ts0")),		/* D6 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 11),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "csi0"),		/* D7 */
+		  SUNXI_FUNCTION(0x2, "csi"),		/* D7 */
 		  SUNXI_FUNCTION(0x4, "ts0")),		/* D7 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 12),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "csi0")),		/* SCK */
+		  SUNXI_FUNCTION(0x2, "csi")),		/* SCK */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 13),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-		  SUNXI_FUNCTION(0x2, "csi0")),		/* SDA */
+		  SUNXI_FUNCTION(0x2, "csi")),		/* SDA */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 14),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-- 
2.20.0.rc1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
