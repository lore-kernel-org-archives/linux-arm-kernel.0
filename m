Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C43AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:35:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEEE520656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MvNnRVL+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KSJYPPQH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEEE520656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=0v0sPEJiPJ/B8g2p9Sok6mpEp1kExxcYWDh7EzBk7tw=; b=MvNnRVL+1SgX/0sAguT/R5DlOi
	Fz0GVklG1b9htuhitc4t3+ms6DS7suuqUXIteJkjdIsOckULVZ3UrZ5Ic25UTcMHzzuY+XE7YHCKx
	HcANPraUWn2U9+vo0jwh/60/T51lDkt8S/ttHwJljej6PJwGZXaNykVU1FnILIJfQkvIQeWaPt56N
	d3NkkZ/xDO9buj1rpY04Vuxyof8GIWDsq7MjNblR0fk3xOjA9/GDU9GsKw9PLQDjaq2K9TjiRYsZw
	jT+4aTCidMOprS/9+cJEYzWVx10WkjjG+PpvK2ctuIgukVF5v8x63wMj365f+Tn85rlTMFBzX4u/2
	yWyFWvxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjFVQ-0001p2-7n; Tue, 15 Jan 2019 03:35:12 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjFUa-0000mu-Q4
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 03:34:35 +0000
Received: by mail-pg1-x543.google.com with SMTP id d72so592394pga.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 19:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=xnTFjl+GiCKiqWScUNzvjAlPROFJTsMxFZH/vteR13U=;
 b=KSJYPPQHYCKO/l2r4rZBK4OAdG04CVUdVDmoYcG7ST+tf+myncWW+OHrcD5mY7CuX2
 sT/s3qNmsbYtBTUWh+QzEosgr2c5GmOwDqEWij8yVx9KjN6u5USyPNUG9AEtX8yRrPCT
 wwPOWt59DLPBlsV9v8i//MAD42zuOUgs/tAPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=xnTFjl+GiCKiqWScUNzvjAlPROFJTsMxFZH/vteR13U=;
 b=J5X2YiEZwgtpT1UOcLZeiP32YG+v3qpV2E3L9DvlxJDhJo1dwDQwRrSsp8m829qik9
 6O7HeaDO/uUMUlWTNYFZpfpUOfN0M4l7tWrv37MEjJXF5gIk86RXo8EdLxFRiqMWhFJe
 qvTdblk6hcFgMlT+ur0AGgFonK/dRxe9p3QCkb6q/fic8qLCtogAQqGutQCupxPmY8u6
 CnTQhan5vZgJWtLVG3BlXJ0LzqtyEvTMy9t75zkqnGoa+An188w+fNc2/2UPFCTJ6bMi
 /b1KE8nJUHr0nd/si3or0MRYc+JaZ2JmCSsmcztbBAUKzm4HtQLUmk6z5OjD56q4yfOT
 35DQ==
X-Gm-Message-State: AJcUukcmVcfamIySU5largOX26/N1KF8sU43XDK0tut4eosnWXfLpQ1g
 tOsOtmYLzto/CCkAWjFrTUEZ
X-Google-Smtp-Source: ALg8bN6/ddsnp8BrTIrA0u520y91d7bXcRebBkdnn3X/OPNHe1f7i66C9FyPxEf7x8JmchG3Id+Xug==
X-Received: by 2002:a63:9712:: with SMTP id n18mr1777491pge.295.1547523260000; 
 Mon, 14 Jan 2019 19:34:20 -0800 (PST)
Received: from localhost.localdomain
 ([2409:4072:6084:4813:7cd6:42d1:f14c:3e90])
 by smtp.gmail.com with ESMTPSA id s9sm2137023pgl.88.2019.01.14.19.34.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Jan 2019 19:34:19 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: sboyd@kernel.org, mturquette@baylibre.com, afaerber@suse.de,
 robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-actions@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 4/6] ARM: dts: Remove fake UART clock for S500 based SBCs
Date: Tue, 15 Jan 2019 09:03:38 +0530
Message-Id: <20190115033340.25016-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190115033340.25016-1-manivannan.sadhasivam@linaro.org>
References: <20190115033340.25016-1-manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_193421_478114_F5ADD45B 
X-CRM114-Status: GOOD (  11.26  )
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
Cc: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Since Actions Semi S500 SoC has gained support for Clock Management Unit
in kernel, let's remove the fake UART clocks from Cubieboard6, Guitar and
Sparky SBCs.

Signed-off-by: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/owl-s500-cubieboard6.dts     | 7 -------
 arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts | 7 -------
 arch/arm/boot/dts/owl-s500-sparky.dts          | 7 -------
 3 files changed, 21 deletions(-)

diff --git a/arch/arm/boot/dts/owl-s500-cubieboard6.dts b/arch/arm/boot/dts/owl-s500-cubieboard6.dts
index 7c96c59b610d..c2b02895910c 100644
--- a/arch/arm/boot/dts/owl-s500-cubieboard6.dts
+++ b/arch/arm/boot/dts/owl-s500-cubieboard6.dts
@@ -25,12 +25,6 @@
 		device_type = "memory";
 		reg = <0x0 0x80000000>;
 	};
-
-	uart3_clk: uart3-clk {
-		compatible = "fixed-clock";
-		clock-frequency = <921600>;
-		#clock-cells = <0>;
-	};
 };
 
 &timer {
@@ -39,5 +33,4 @@
 
 &uart3 {
 	status = "okay";
-	clocks = <&uart3_clk>;
 };
diff --git a/arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts b/arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts
index e610d49395d2..7ae34a23e320 100644
--- a/arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts
+++ b/arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts
@@ -18,15 +18,8 @@
 	chosen {
 		stdout-path = "serial3:115200n8";
 	};
-
-	uart3_clk: uart3-clk {
-		compatible = "fixed-clock";
-		clock-frequency = <921600>;
-		#clock-cells = <0>;
-	};
 };
 
 &uart3 {
 	status = "okay";
-	clocks = <&uart3_clk>;
 };
diff --git a/arch/arm/boot/dts/owl-s500-sparky.dts b/arch/arm/boot/dts/owl-s500-sparky.dts
index c665ce8b88b4..9d8f7336bec0 100644
--- a/arch/arm/boot/dts/owl-s500-sparky.dts
+++ b/arch/arm/boot/dts/owl-s500-sparky.dts
@@ -25,12 +25,6 @@
 		device_type = "memory";
 		reg = <0x0 0x40000000>; /* 1 or 2 GiB */
 	};
-
-	uart3_clk: uart3-clk {
-		compatible = "fixed-clock";
-		clock-frequency = <921600>;
-		#clock-cells = <0>;
-	};
 };
 
 &timer {
@@ -39,5 +33,4 @@
 
 &uart3 {
 	status = "okay";
-	clocks = <&uart3_clk>;
 };
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
