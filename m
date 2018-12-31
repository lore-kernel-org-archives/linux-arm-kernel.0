Return-Path: <SRS0=D6bT=PI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FE2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:57:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37FBE20B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 18:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KTRGMj0g";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DAfoUXX2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37FBE20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=0v0sPEJiPJ/B8g2p9Sok6mpEp1kExxcYWDh7EzBk7tw=; b=KTRGMj0gl7fwideUVkD8hUxovN
	iE3Lb3oKhI3Fepr3nL8U6/PR8a4etfhuVO3bIFEtKRH/++k12vn5BAZptE5VGJZPS4NJKWHLz07Sj
	Qgvd/6JZFjiU3AP/prfgATS9hS+UFXuYuBWTkPb/4Y2pQDVnQZYu0+ILKT2zQmuK/3hsWoe4oK7Ko
	1vFbQ909T4usmIdBE3ZVXlLjZ2gk9qOkmFn2xJlCZJzg9niHCGU+un2os113vc2gp/Hbvr6k0RlKK
	H0Ln+qTF/WeBSXaqgM0QlIZZazioOXKz/Em+1hEgnMzN7wykVQUB/lrmlcuN7cL0kzbNQERx98na/
	wTaKHPBg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ge2kn-0004MX-4B; Mon, 31 Dec 2018 18:57:33 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ge2jM-0003GA-CO
 for linux-arm-kernel@lists.infradead.org; Mon, 31 Dec 2018 18:56:11 +0000
Received: by mail-pl1-x644.google.com with SMTP id 101so12897614pld.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 31 Dec 2018 10:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=xnTFjl+GiCKiqWScUNzvjAlPROFJTsMxFZH/vteR13U=;
 b=DAfoUXX2Mm4QCjZqfBd/jHNgGDXixo8Idl2Ej2QqqP8eRoI+RjdqXc//NL6yfnGUki
 x96pi+g9+u6YtEP3M6799NXkX8CxIyuptrQkPatVQ/7t4Wpa9OBmKzf2ffLtp1crXjcD
 0onod/iPgWI3xVsGvCupVe1PmvzcKQWx74o8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=xnTFjl+GiCKiqWScUNzvjAlPROFJTsMxFZH/vteR13U=;
 b=PlznIqFewagnuHbL6bC1ghE9FOCcGnPcSnHXd1RbxFTxdtj1cX6DjRaQCBsdXnK5Je
 rIpVbRuQGbDKNZ0j9WFD6EwnIq8KZxEKswnmQlRlOEWUyKbFdA7fsBQK9z1+4M3PHL2X
 GT/CqLN4UE613V6g/q2RAWXMIzauSTVhM1mg05iRQ2l1eDjZDf/OrLrQ5/sMuzsNOqWC
 ZSkwBYWDMT18TxZg0jn/lNpXEag7CUMRkRuF56+nen1EYbJjp3ovsiWyjI2DZGqFNznG
 TABHYhgzFZB4mjcl6XnrVtCuw2oCso6I98SVj6Di7x/ZO4DIueCdXYlmcwEaxcx1Txzz
 caFw==
X-Gm-Message-State: AJcUuke9Obd7cwL4YsBEu91XJ2Gs4OsT2ViiY0ZjJX/C1VUXATVJFJIE
 MF0VqbK9W727DfTK9537FTnz
X-Google-Smtp-Source: ALg8bN5xgrandwk7kDkjOhlCJwLKw+AbtdnzuOLk8O3v+FGwxL+DJprDS/hJpaHyHyUJ8W9f/MztHw==
X-Received: by 2002:a17:902:3064:: with SMTP id
 u91mr37492748plb.325.1546282563704; 
 Mon, 31 Dec 2018 10:56:03 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7440:b882:8d58:e15f:9ff4:efc2])
 by smtp.gmail.com with ESMTPSA id s9sm66146224pgl.88.2018.12.31.10.55.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 31 Dec 2018 10:56:03 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: sboyd@kernel.org, mturquette@baylibre.com, afaerber@suse.de,
 robh+dt@kernel.org
Subject: [PATCH 4/6] ARM: dts: Remove fake UART clock for S500 based SBCs
Date: Tue,  1 Jan 2019 00:25:15 +0530
Message-Id: <20181231185517.18517-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
References: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_105605_217356_C8BCA659 
X-CRM114-Status: GOOD (  11.21  )
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
Cc: devicetree@vger.kernel.org, linux-actions@lists.infradead.org,
 linux-kernel@vger.kernel.org, Edgar Bernardi Righi <edgar.righi@lsitec.org.br>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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
