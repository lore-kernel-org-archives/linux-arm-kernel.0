Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EB1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:25:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25F4A2087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="faUFAHzQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25F4A2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=tWPB8a5itYmHqTMcpQ0auocBQ4Xi3+fKh/hRwBR5h2M=; b=faUFAHzQJEyYv9
	1ZlWUYoYOQ9qd6lluz7rbEmjgtZJXf3VhScgftkw+E3WZ1F0eNmVmHozAOZkuPQuIZcXNl3nCsvKF
	/Vp/q0i3zp3FIRkhmm26AuPJGOiCC/rbBF1cRVEJXyHclgGv/UQehRyjawl1tk2CO/E9Pha5pWRnX
	/dwqkHxrI0Cv8DaPfq+PJcdh9vYsh0MRxYkkfNbMUCI8Yc45/hSf9J09r4kdzndBnwRIWpeOLeGRV
	eeWe17xjk5YYVJrYC1v8XihQ7yXRye09I8P0BznUSumgwoQWF5sXJjqRKt5gDxJO2PtidML1CxsnD
	Kjw7mXT5TxGTEBHx/eUg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggllY-00066U-CS; Tue, 08 Jan 2019 07:25:36 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggllU-00065v-Un
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 07:25:34 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 7A3DB5FBC8; Tue,  8 Jan 2019 15:25:27 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH] ARM: dts: sun6i: Add clock-output-names to osc24M clock
Date: Tue,  8 Jan 2019 15:25:26 +0800
Message-Id: <20190108072526.2621-1-wens@csie.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_232533_132873_A5EA519B 
X-CRM114-Status: GOOD (  12.68  )
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
Cc: devicetree@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The osc24M clock does not have a "clock-output-names" property, which
means that the clock name is derived from the node name in Linux. The
node name was changed in commit acfd5bbe2641 ("ARM: dts: sun6i: Change
clock node names to avoid warnings"). This breaks Linux as the sunxi-ng
clock driver implicitly depends on the external clock being named
"osc24M".

Add a "clock-output-names" property to restore the previous behavior.

Fixes: acfd5bbe2641 ("ARM: dts: sun6i: Change clock node names to avoid
		      warnings")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
This is a critical fix for v5.0-rc. Without it the A31 boots up to the
UART failing to get its clock rate, and thus failing to setup a console.

Also the timer-sun5i init code hits a divide by zero exception. I'll
send a separate patch to make this one fail gracefully.
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 353d90f99b40..13304b8c5139 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -216,6 +216,7 @@
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <24000000>;
+			clock-output-names = "osc24M";
 		};
 
 		osc32k: clk-32k {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
