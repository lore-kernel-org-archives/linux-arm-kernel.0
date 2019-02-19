Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F04C10F00
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:03:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B4BA2183F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S53Q1PGn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4BA2183F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g9SXtMfuwXh99XrhRa/4xBicojg/lvmW4HnTR4vmRvg=; b=S53Q1PGnYs2koD
	vMbUBz4y/4HpH+YFoFNPyiCSztgaT7iS8MlTXWAo7FaFY3Dp0F6e/sPG6MhrzDXP/vQn/RYKiGH9L
	YR61UrD3Yl3XWhE09wNPG4eb+8Bbn1l6h21rlggYlMLrrbjzXTHQZ1hXeKjpQebf2hgJc0IfKfpIx
	WGUwZagdVjFR14L+QnThqcqQygUYhXlLpxDX5bmOk9CmuTqtYnc5od3ToSyznBbeXv2D8JcN1VD00
	HhT1sLIgfc2Jo8BqEVoOn37FWf8ivoyQ6MM4MmHNd/j5W9AL0UEAJrGjOwkv14j5RPTgWecU+X6bc
	DXxzpeeMU+BTtKFIvWiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw8nN-0001cZ-UN; Tue, 19 Feb 2019 17:03:01 +0000
Received: from relay5-d.mail.gandi.net ([217.70.183.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw8md-0000eK-Ls
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 17:02:17 +0000
X-Originating-IP: 90.53.137.203
Received: from localhost (alyon-652-1-306-203.w90-53.abo.wanadoo.fr
 [90.53.137.203])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 0C73D1C0018;
 Tue, 19 Feb 2019 17:02:12 +0000 (UTC)
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 5/7] ARM: dts: at91: at91sam9g45: switch to new sckc bindings
Date: Tue, 19 Feb 2019 18:01:58 +0100
Message-Id: <20190219170200.3608-6-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190219170200.3608-1-alexandre.belloni@bootlin.com>
References: <20190219170200.3608-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_090215_857480_08B83E3D 
X-CRM114-Status: GOOD (  10.40  )
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
Cc: devicetree@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-kernel@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>,
 Claudiu Beznea <claudiu.beznea@microchip.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Remove the child nodes of the sckc as they are not necessary anymore.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/boot/dts/at91sam9g45.dtsi | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index d16db1fa7e15..74a011077d54 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -1257,30 +1257,11 @@
 				};
 			};
 
-			sckc@fffffd50 {
+			clk32k: sckc@fffffd50 {
 				compatible = "atmel,at91sam9x5-sckc";
 				reg = <0xfffffd50 0x4>;
-
-				slow_osc: slow_osc {
-					compatible = "atmel,at91sam9x5-clk-slow-osc";
-					#clock-cells = <0>;
-					atmel,startup-time-usec = <1200000>;
-					clocks = <&slow_xtal>;
-				};
-
-				slow_rc_osc: slow_rc_osc {
-					compatible = "atmel,at91sam9x5-clk-slow-rc-osc";
-					#clock-cells = <0>;
-					atmel,startup-time-usec = <75>;
-					clock-frequency = <32768>;
-					clock-accuracy = <50000000>;
-				};
-
-				clk32k: slck {
-					compatible = "atmel,at91sam9x5-clk-slow";
-					#clock-cells = <0>;
-					clocks = <&slow_rc_osc &slow_osc>;
-				};
+				clocks = <&slow_xtal>;
+				#clock-cells = <0>;
 			};
 
 			rtc@fffffd20 {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
