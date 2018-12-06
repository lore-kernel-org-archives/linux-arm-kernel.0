Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C109C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:11:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DF6121479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dXMkF8mV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF6121479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=30A8FqrRpC+1wlffMvYA98+OINk8/auNirq97HDBZJY=; b=dXMkF8mVvyKSO1
	9kKEsdOSp4s3JY1XIwU/u+gd6LumnBX8JASDcz5YI1rpR0y65SgYn1PMj5B1NLgM4ml8PBXjH2lOU
	iTZgTOShTrjpO6dPoANzVGtTvu9sYnj0j/Rv2EtX+gIloH9UEsZurlT+renIFnorCyMxXz/Z9gZh+
	P+qLBe/TX3z3RgijeL9mV63aZCECdHTExToclPYdt6pjHZWFwRTA+XLjDW7zEo43y5pOR0hChOK4c
	w1yq0s6UN6fovdUrAKO1hrnZy8xQyjOQsAVzeB4Wfa1NBMvJ3+HXJnN6JweXh1kYIJcuXie5y92x+
	pmPqOOD13MtcENnZ4G0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUqct-0003sP-HX; Thu, 06 Dec 2018 10:11:23 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUqbj-0001MB-Sx
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 10:10:24 +0000
Received: by mail-qt1-f195.google.com with SMTP id z16so25645081qtq.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 02:10:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:organization:content-transfer-encoding;
 bh=WKTKeeoPoovjmKjKShsP5moqkMz1DOw8oWN17x0M8e8=;
 b=Hg4Kr7ft8hSc2mIvPH9bQ2mv22KVaOcAiEy/pmed6kpJQP79BV+isOQFRuO2yv4am+
 0lytPC/s5Peq8n5Lo0vJZU+qVMLz3d0ajvhjywTAVgucY3TQ89064drhcfhzHeQOqrie
 u0Kb95BZFh7cXSuplg3ZH/CEBSCvedQtTLSvcHBcb0SqTMSjQJUdQ3MEe1Qi1LmpmsHD
 wjwvh0+xJ5Q2LbWitFrqiX1pCALRCNfnH/0aCc86P/gPjXFNyM/NzE4DSfyUgFHUIeMH
 EzPOaFaI2jIH6hyLcrzylUGjuCvRzy66SwyM8aefOV8yQIba/hYz5/7G3VPotpqfCpuo
 X5fQ==
X-Gm-Message-State: AA+aEWaIbR5M/XfpvQHjpqrwMd+oiIViSmyreze+uJt6U7n7Wcn402R8
 d1YyZtOXVyeyGTVhLuqtZHpLIXbo
X-Google-Smtp-Source: AFSGD/VmrVimEgdKdD+sPPVmytPqbMHUgsnGu5AHK3undpvWKcC1Q+bgEByHc6ZtPx7txc4VyEOndg==
X-Received: by 2002:ac8:498c:: with SMTP id f12mr26160102qtq.130.1544091000634; 
 Thu, 06 Dec 2018 02:10:00 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
 by smtp.gmail.com with ESMTPSA id t43sm14033213qtc.53.2018.12.06.02.09.55
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 02:09:59 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation);
 Thu, 06 Dec 2018 08:09:53 -0200
From: Otavio Salvador <otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 6/9] ARM: dts: imx7d-pico: Improve WiFi regulator name
Date: Thu,  6 Dec 2018 08:09:02 -0200
Message-Id: <20181206100905.15053-7-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206100905.15053-1-otavio@ossystems.com.br>
References: <20181206100905.15053-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_021012_588732_80A1DFB0 
X-CRM114-Status: GOOD (  15.46  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Otavio Salvador <otavio@ossystems.com.br>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

There are different models of WiFi being used in the SoM and the
handle name was too restrictive. This reworks it to a more generic and
meaningful name.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

Changes in v2: None

 arch/arm/boot/dts/imx7d-pico.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-pico.dtsi b/arch/arm/boot/dts/imx7d-pico.dtsi
index 35791a1adabf..417f034fb354 100644
--- a/arch/arm/boot/dts/imx7d-pico.dtsi
+++ b/arch/arm/boot/dts/imx7d-pico.dtsi
@@ -13,11 +13,11 @@
 		reg = <0x80000000 0>;
 	};
 
-	reg_ap6212: regulator-ap6212 {
+	reg_wlreg_on: regulator-wlreg_on {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_ap6212>;
-		regulator-name = "AP6212";
+		pinctrl-0 = <&pinctrl_reg_wlreg_on>;
+		regulator-name = "wlreg_on";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		gpio = <&gpio4 16 GPIO_ACTIVE_HIGH>;
@@ -241,7 +241,7 @@
 	non-removable;
 	keep-power-in-suspend;
 	wakeup-source;
-	vmmc-supply = <&reg_ap6212>;
+	vmmc-supply = <&reg_wlreg_on>;
 	mmc-pwrseq = <&usdhc2_pwrseq>;
 	status = "okay";
 };
@@ -302,7 +302,7 @@
 		>;
 	};
 
-	pinctrl_reg_ap6212: regap6212grp {
+	pinctrl_reg_wlreg_on: regregongrp {
 		fsl,pins = <
 			MX7D_PAD_ECSPI1_SCLK__GPIO4_IO16	0x59
 		>;
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
