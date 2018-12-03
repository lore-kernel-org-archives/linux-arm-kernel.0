Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5529EC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:41:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 283E120850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tT5eZiZ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 283E120850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ujO7eKT3teE4vxdMjVgUrj4U4gp6/SmkxZGVudq1jG8=; b=tT5eZiZ+Rzjt/k
	rNrdpQ48VmjQwADkogcPqCaHz7hZ+QhHHfJ+KuvbwFE7o8QrGvP3KyJRgKydnR6c6IHfrC96dyPEY
	97VoatNTNgcHJbIsDGCmcVqN3UjOcdmSaEQzdOvobJ1r3Gzt+1/v0pdE/XElPMYR8dKAXRaAv65nQ
	SuJb7b7Nzwecwv3ir//u0zL0MZbE53BivA3P98A3J1TseSq+eR8BZthV9iv0zxH9dO6moC3gi5xPL
	lHjXXmr+oPHK4u3KsQ22RyXgsI1wBclwVEKoe2X4yGFnG4E4Szir6qmYJk7MVqdfGpzXvlqN79KVo
	OFeeINRhsn74aq0McFGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTqLm-0004TM-St; Mon, 03 Dec 2018 15:41:35 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTqLS-0004AG-KW
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 15:41:18 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id DCA0B5FD54; Mon,  3 Dec 2018 23:41:00 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Linus Walleij <linus.walleij@linaro.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 2/2] pinctrl: sunxi: a64: Rename function ts0 to ts
Date: Mon,  3 Dec 2018 23:41:00 +0800
Message-Id: <20181203154100.4280-3-wens@csie.org>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181203154100.4280-1-wens@csie.org>
References: <20181203154100.4280-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_074114_952494_E9245E8A 
X-CRM114-Status: UNSURE (   9.92  )
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

The A64 only has one TS (transport stream) controller. The datasheet
also lists the function as TS_XXX instead of TS0_XXX.

Rename the function names now before any there are any users.

Fixes: 96851d391d02 ("drivers: pinctrl: add driver for Allwinner A64 SoC")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c | 24 +++++++++++-----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c
index 8b974b2a2486..7b83d3755a0e 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c
@@ -324,62 +324,62 @@ static const struct sunxi_desc_pin a64_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "csi"),		/* PCK */
-		  SUNXI_FUNCTION(0x4, "ts0")),		/* CLK */
+		  SUNXI_FUNCTION(0x4, "ts")),		/* CLK */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 1),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "csi"),		/* CK */
-		  SUNXI_FUNCTION(0x4, "ts0")),		/* ERR */
+		  SUNXI_FUNCTION(0x4, "ts")),		/* ERR */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 2),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "csi"),		/* HSYNC */
-		  SUNXI_FUNCTION(0x4, "ts0")),		/* SYNC */
+		  SUNXI_FUNCTION(0x4, "ts")),		/* SYNC */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 3),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "csi"),		/* VSYNC */
-		  SUNXI_FUNCTION(0x4, "ts0")),		/* DVLD */
+		  SUNXI_FUNCTION(0x4, "ts")),		/* DVLD */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 4),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "csi"),		/* D0 */
-		  SUNXI_FUNCTION(0x4, "ts0")),		/* D0 */
+		  SUNXI_FUNCTION(0x4, "ts")),		/* D0 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 5),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "csi"),		/* D1 */
-		  SUNXI_FUNCTION(0x4, "ts0")),		/* D1 */
+		  SUNXI_FUNCTION(0x4, "ts")),		/* D1 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 6),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "csi"),		/* D2 */
-		  SUNXI_FUNCTION(0x4, "ts0")),		/* D2 */
+		  SUNXI_FUNCTION(0x4, "ts")),		/* D2 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 7),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "csi"),		/* D3 */
-		  SUNXI_FUNCTION(0x4, "ts0")),		/* D3 */
+		  SUNXI_FUNCTION(0x4, "ts")),		/* D3 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 8),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "csi"),		/* D4 */
-		  SUNXI_FUNCTION(0x4, "ts0")),		/* D4 */
+		  SUNXI_FUNCTION(0x4, "ts")),		/* D4 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 9),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "csi"),		/* D5 */
-		  SUNXI_FUNCTION(0x4, "ts0")),		/* D5 */
+		  SUNXI_FUNCTION(0x4, "ts")),		/* D5 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 10),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "csi"),		/* D6 */
-		  SUNXI_FUNCTION(0x4, "ts0")),		/* D6 */
+		  SUNXI_FUNCTION(0x4, "ts")),		/* D6 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 11),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "csi"),		/* D7 */
-		  SUNXI_FUNCTION(0x4, "ts0")),		/* D7 */
+		  SUNXI_FUNCTION(0x4, "ts")),		/* D7 */
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(E, 12),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
-- 
2.20.0.rc1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
