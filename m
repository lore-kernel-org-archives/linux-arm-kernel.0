Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2635C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:13:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 946F520848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NxWnPOwM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 946F520848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=qP2S1l+Lg6tJ7lwWBPkPpZDV3aQn3BBVGdZS/4/OnlU=; b=NxWnPOwM1ZZuQq
	WJEIiqc2bOLVMXnfFJZrAJIIN4AUyYS9AgArZKdNMLzY2hi0s7CDitHp0FhU2aR0tkYPpm9IY4dHn
	IwW1B8h/MVHiddC+U3pHQn0rgmXZGAKPoJTZ+9pXFxczYcUjDlvE8AKgyJihjqp8+PJaSvak7bEUp
	hQBryIjQlSUxMFIkGrEh1BgyidAvTeyzVnz5QgmGLXIe3hrYdWJGg8sSZMYh6VAmwE32lRRHD3/7n
	MUDI2zwt4kddVEgEiTRrZn8/yn9/W5j/OhY5YuJLokjbfoNHAm7UoWo8uS8lezBtyuKkHLcI+Alxz
	i/gSwNxEU1hxLFAH30wg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTteT-0007Li-18; Mon, 03 Dec 2018 19:13:05 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTteP-0007Kk-Kd
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 19:13:03 +0000
Received: by mail-oi1-f196.google.com with SMTP id m6so11940477oig.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 11:12:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QbOFnvhZe3gfLOZmKzIKK9fE7VaSspuz5hn1yiZBxQ8=;
 b=qInrMdo57Dtk/EHHvMaiDRCgCPmeWhF7tjEtVeQhNGlS4PBPrpcjgO7shH7D/yZ+p7
 UCf1omTafDsIOXxgc/NJyDnvlV4bwB1ku3kGIP5zk5+LcxRNxh4XM4vQqL78gOhXL236
 swAyyVAecBP2rHkiInLsQTK18GsHdq26ozDX6Tw8W5S0KNvSbRAOG7LlJsBaeUGA188B
 +bVzoHxnLpCkaMySHdzUOBMpPl+qc6pwMQmWIg8D/WcL8uowpqN4rgzH3EsSjg507xjl
 rJ4mr9GzgCAgz6QEp2yr8HwPgKwFk/PsrwS0wh3BtIiZs/NgpSFpc/LTPO2KgpCTrPYe
 dIDg==
X-Gm-Message-State: AA+aEWacl4VGt4GR4oAISc/6pdr6JZdu4gMwXrCZnNBN3zVJ5rYIq1/X
 xyFp9BlQkm612hoWuJ6b2A==
X-Google-Smtp-Source: AFSGD/V9eudDLxsRM9BrBFQiRtO8nEXmo14McZJAJqAuS0Ubz0cjdU0DYJqM0CuEInYDVIVwE2b1ZQ==
X-Received: by 2002:aca:fcd7:: with SMTP id a206mr11472238oii.56.1543864370213; 
 Mon, 03 Dec 2018 11:12:50 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49]) by smtp.googlemail.com with ESMTPSA id
 g138sm10005431oib.26.2018.12.03.11.12.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 11:12:49 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>,
	arm@kernel.org
Subject: [PATCH] ARM: dts: realview: Fix some more duplicate regulator nodes
Date: Mon,  3 Dec 2018 13:12:48 -0600
Message-Id: <20181203191248.13067-1-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_111301_677145_B2819862 
X-CRM114-Status: GOOD (  13.55  )
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
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

There's a bug in dtc in checking for duplicate node names when there's
another section (e.g. "/ { };"). In this case, skeleton.dtsi provides
another section. Upon removal of skeleton.dtsi, the dtb fails to build
due to a duplicate node 'fixedregulator@0'. As both nodes were pretty
much the same 3.3V fixed regulator, it hasn't really mattered. Fix this
by renaming the nodes to something unique. In the process, drop the
unit-address which shouldn't be present wtihout reg property.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
Sigh, not sure what happened, but I missed these 2 cases.

 arch/arm/boot/dts/arm-realview-pb1176.dts | 4 ++--
 arch/arm/boot/dts/arm-realview-pb11mp.dts | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/arm-realview-pb1176.dts b/arch/arm/boot/dts/arm-realview-pb1176.dts
index cee2d7aab203..cbbb8878daa3 100644
--- a/arch/arm/boot/dts/arm-realview-pb1176.dts
+++ b/arch/arm/boot/dts/arm-realview-pb1176.dts
@@ -47,7 +47,7 @@
 	};
 
 	/* The voltage to the MMC card is hardwired at 3.3V */
-	vmmc: fixedregulator@0 {
+	vmmc: regulator-vmmc {
 		compatible = "regulator-fixed";
 		regulator-name = "vmmc";
 		regulator-min-microvolt = <3300000>;
@@ -55,7 +55,7 @@
 		regulator-boot-on;
         };
 
-	veth: fixedregulator@0 {
+	veth: regulator-veth {
 		compatible = "regulator-fixed";
 		regulator-name = "veth";
 		regulator-min-microvolt = <3300000>;
diff --git a/arch/arm/boot/dts/arm-realview-pb11mp.dts b/arch/arm/boot/dts/arm-realview-pb11mp.dts
index 63d71a1d8282..2015619ca22c 100644
--- a/arch/arm/boot/dts/arm-realview-pb11mp.dts
+++ b/arch/arm/boot/dts/arm-realview-pb11mp.dts
@@ -147,7 +147,7 @@
 	};
 
 	/* The voltage to the MMC card is hardwired at 3.3V */
-	vmmc: fixedregulator@0 {
+	vmmc: regulator-vmmc {
 		compatible = "regulator-fixed";
 		regulator-name = "vmmc";
 		regulator-min-microvolt = <3300000>;
@@ -155,7 +155,7 @@
 		regulator-boot-on;
         };
 
-	veth: fixedregulator@0 {
+	veth: regulator-veth {
 		compatible = "regulator-fixed";
 		regulator-name = "veth";
 		regulator-min-microvolt = <3300000>;
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
