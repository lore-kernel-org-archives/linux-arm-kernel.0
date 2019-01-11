Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4424C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:31:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 898A020836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HnRr+o9a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 898A020836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ehQ7cr/7xXIY80rSYF7Gi54nYjTYz5C+5ZaPIteDk+Q=; b=HnRr+o9aUABIQp
	Nhy29wcqFK4XInDwpeBsBrqmNxC3j9VLYG2oyPPr6ClGcARLk89SgcJKoCQrYI4/R0xstFLlrHErU
	Dyo3lgL4StFCAPOLdqll6XAJbWR9u443epK5RAv4GHYustxqazUxSn5pzid9CyGJkX2NR1zBNk52B
	/6pnzKeEEtvRxD5HAgzE7tSmp7sZrW2WyemBxNtAYz1Kz8oYMr8PqAOQ9Ol361NA/QbbBMbR7bUTK
	5yuny9+dAaXI5UPJ8MAuv4oB8OeaKgT2NJjj6NesYigHvsCHC9ci7QfGRC3JZmyLXQ0yy6aB6jyAN
	KajVBIDDLwWNB9JCty/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi0eI-0008Tu-CS; Fri, 11 Jan 2019 17:31:14 +0000
Received: from mailoutvs19.siol.net ([185.57.226.210] helo=mail.siol.net)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi0dh-0007vn-Di
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 17:30:39 +0000
Received: from localhost (localhost [127.0.0.1])
 by mail.siol.net (Zimbra) with ESMTP id 098245225F3;
 Fri, 11 Jan 2019 18:30:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
 by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new,
 port 10032)
 with ESMTP id TCTNcfon3BNM; Fri, 11 Jan 2019 18:30:33 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
 by mail.siol.net (Zimbra) with ESMTPS id B8808522B33;
 Fri, 11 Jan 2019 18:30:33 +0100 (CET)
Received: from localhost.localdomain (cpe1-8-82.cable.triera.net
 [213.161.8.82]) (Authenticated sender: 031275009)
 by mail.siol.net (Zimbra) with ESMTPSA id 43E53522B21;
 Fri, 11 Jan 2019 18:30:31 +0100 (CET)
From: Jernej Skrabec <jernej.skrabec@siol.net>
To: maxime.ripard@bootlin.com,
	wens@csie.org
Subject: [PATCH 2/3] arm64: dts: allwinner: a64: Add IR node
Date: Fri, 11 Jan 2019 18:30:14 +0100
Message-Id: <20190111173015.12119-3-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111173015.12119-1-jernej.skrabec@siol.net>
References: <20190111173015.12119-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_093037_617991_2F6E36D3 
X-CRM114-Status: UNSURE (   8.33  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Igors Makejevs <git_bb@bwzone.com>,
 linux-sunxi@googlegroups.com, robh+dt@kernel.org, mchehab@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Igors Makejevs <git_bb@bwzone.com>

IR is similar to that in A13 and can use same driver.

Signed-off-by: Igors Makejevs <git_bb@bwzone.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 839b2ae88583..00827072376a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -1004,6 +1004,19 @@
 			status = "disabled";
 		};
 
+		r_ir: ir@1f02000 {
+			compatible = "allwinner,sun50i-a64-ir",
+				     "allwinner,sun5i-a13-ir";
+			reg = <0x01f02000 0x400>;
+			clocks = <&r_ccu CLK_APB0_IR>, <&r_ccu CLK_IR>;
+			clock-names = "apb", "ir";
+			resets = <&r_ccu RST_APB0_IR>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&r_ir_pin>;
+			status = "disabled";
+		};
+
 		r_i2c: i2c@1f02400 {
 			compatible = "allwinner,sun50i-a64-i2c",
 				     "allwinner,sun6i-a31-i2c";
@@ -1043,6 +1056,11 @@
 				function = "s_i2c";
 			};
 
+			r_ir_pin: ir {
+				pins = "PL11";
+				function = "s_cir_rx";
+			};
+
 			r_pwm_pin: pwm {
 				pins = "PL10";
 				function = "s_pwm";
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
