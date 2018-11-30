Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA35C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:10:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FF0920834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ijZnJV85"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF0920834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g1eAsgQonPdxevxkyVIX2AZMDkJXmSM/vrp9SviZR8s=; b=ijZnJV85KuR1FK
	LpO8wgxRSL9VbRZIeJHhO7CHnoDraEnJ+gvtoyf3BPFLURuaR2kAyJNkq9bdyKnKQfcirD6FYv2Ua
	o2neWTbe/WIKi4efoF60mYfRwBzUAhEmk6XQqv37C6dN1wVRBt+it5n03GpIYmWNddv8n51JeL3rt
	gzvTxqUqWAE2MEjfghT/WNBxB1du6hWkMojpVP/GzMWCZGtRVbhXSE2DtcRSD9VO3vQ9sEfWmsI4B
	jxCMsLc3j8ZTpsk2JXS11OpTdtJ6idNn1QAsfIaQ3ON+f3es3owTsy377yR+tkv/9xPQlt+pMxcBA
	+Hp0CUgv+me25zMWn6tQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSnFE-0004Ay-UQ; Fri, 30 Nov 2018 18:10:28 +0000
Received: from mail.bugwerft.de ([46.23.86.59])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSn1W-0003FI-FF
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 17:56:25 +0000
Received: from localhost.localdomain (pD95EF9A6.dip0.t-ipconnect.de
 [217.94.249.166])
 by mail.bugwerft.de (Postfix) with ESMTPSA id CD71B2C459C;
 Fri, 30 Nov 2018 17:55:40 +0000 (UTC)
From: Daniel Mack <daniel@zonque.org>
To: robert.jarzmik@free.fr,
	haojian.zhuang@gmail.com
Subject: [PATCH 5/7] ARM: dts: pxa3xx: order timer and gcu nodes under /pxabus
Date: Fri, 30 Nov 2018 18:55:41 +0100
Message-Id: <20181130175543.32628-6-daniel@zonque.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181130175543.32628-1-daniel@zonque.org>
References: <20181130175543.32628-1-daniel@zonque.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_095619_362977_65D448D7 
X-CRM114-Status: UNSURE (   9.12  )
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
Cc: devicetree@vger.kernel.org, robh+dt@kernel.org,
 Daniel Mack <daniel@zonque.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

These are devices on the PXA bus, so make the device tree structure
reflect that.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 arch/arm/boot/dts/pxa3xx.dtsi | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/pxa3xx.dtsi b/arch/arm/boot/dts/pxa3xx.dtsi
index eb9443208578..de49e7f666c0 100644
--- a/arch/arm/boot/dts/pxa3xx.dtsi
+++ b/arch/arm/boot/dts/pxa3xx.dtsi
@@ -265,6 +265,22 @@
 			clocks = <&clks CLK_SSP4>;
 			status = "disabled";
 		};
+
+		timer@40a00000 {
+			compatible = "marvell,pxa-timer";
+			reg = <0x40a00000 0x20>;
+			interrupts = <26>;
+			clocks = <&clks CLK_OSTIMER>;
+			status = "okay";
+		};
+
+		gcu: display-controller@54000000 {
+			compatible = "marvell,pxa300-gcu";
+			reg = <0x54000000 0x1000>;
+			interrupts = <39>;
+			clocks = <&clks CLK_PXA300_GCU>;
+			status = "disabled";
+		};
 	};
 
 	clocks {
@@ -282,20 +298,4 @@
 			status = "okay";
 		};
 	};
-
-	timer@40a00000 {
-		compatible = "marvell,pxa-timer";
-		reg = <0x40a00000 0x20>;
-		interrupts = <26>;
-		clocks = <&clks CLK_OSTIMER>;
-		status = "okay";
-	};
-
-	gcu: display-controller@54000000 {
-		compatible = "marvell,pxa300-gcu";
-		reg = <0x54000000 0x1000>;
-		interrupts = <39>;
-		clocks = <&clks CLK_PXA300_GCU>;
-		status = "disabled";
-	};
 };
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
