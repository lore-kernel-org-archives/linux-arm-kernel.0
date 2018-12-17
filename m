Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1309BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:17:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D58F62133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PewTKgte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58F62133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=yKq+xLLbsCfkvEbU5v/F8qGYydtn3jxB5mnysx51mGc=; b=PewTKgtegp0WCd
	H0um8Jo2vyCBTIaJCPpwP2eIAglU2q5VAtT1tk6YnEK4kilaUlznp/SeA35d5fNCrb/0daadWMNlt
	TdPsdpSvnDmeaxyqYy/pMpM0IcN7/Z5TJq3wlezK/zGGYz3huw/39+t1WJ76DPhGOPBEqxiZTzVTZ
	OxZ+hkA8PaGLcCfrB+JRY9oIpSJJsq2lzP4q0bE4ITXxGH1wCSkeOrx4Fa6atIa5brL3B2rGPWS/f
	BE3ONxFmcSufb3RlQk67UAU4KkChW7xcnfKVabGpspYL9UG2Jvc8AQuqQRXpKywrXRMM87AdkW0T+
	TBmGVqrhIjKfcUPaHzKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYslU-0006Uu-U4; Mon, 17 Dec 2018 13:16:56 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYslQ-0006UP-In
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 13:16:54 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 9064120510; Mon, 17 Dec 2018 14:16:39 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr
 [90.88.30.7])
 by mail.bootlin.com (Postfix) with ESMTPSA id 61D622072F;
 Mon, 17 Dec 2018 14:16:29 +0100 (CET)
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>,
 Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] dt-bindings: pinctrl: sunxi: Add supply properties
Date: Mon, 17 Dec 2018 14:16:26 +0100
Message-Id: <20181217131626.17098-1-maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_051652_755427_F98539CE 
X-CRM114-Status: UNSURE (   8.66  )
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
Cc: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The pinctrl node can have multiple regulators for each of its GPIO banks.
Add the property descriptions.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt    | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
index 258a4648ab81..1d898490f346 100644
--- a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
@@ -43,6 +43,19 @@ Note: For backward compatibility reasons, the hosc and losc clocks are only
 required if you need to use the optional input-debounce property. Any new
 device tree should set them.
 
+Each pin bank, depending on the SoC, can have an associated regulator:
+
+- vcc-pa-supply: for the A10, A20, A31, A31s, A80 and R40 SoCs
+- vcc-pb-supply: for the A31, A31s, A80 and V3s SoCs
+- vcc-pc-supply: for the A10, A20, A31, A31s, A64, A80, H5, R40 and V3s SoCs
+- vcc-pd-supply: for the A23, A31, A31s, A64, A80, A83t, H3, H5 and R40 SoCs
+- vcc-pe-supply: for the A10, A20, A31, A31s, A64, A80, R40 and V3s SoCs
+- vcc-pf-supply: for the A10, A20, A31, A31s, A80, R40 and V3s SoCs
+- vcc-pg-supply: for the A10, A20, A31, A31s, A64, A80, H3, H5, R40 and V3s SoCs
+- vcc-ph-supply: for the A31, A31s and A80 SoCs
+- vcc-pl-supply: for the r-pinctrl of the A64, A80 and A83t SoCs
+- vcc-pm-supply: for the r-pinctrl of the A31, A31s and A80 SoCs
+
 Optional properties:
   - input-debounce: Array of debouncing periods in microseconds. One period per
     irq bank found in the controller. 0 if no setup required.
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
