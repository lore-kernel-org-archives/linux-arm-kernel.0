Return-Path: <SRS0=AzG1=P3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98FBC61CE4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 21:18:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ED6A2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 21:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DT3wV1/W";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFLdKf8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED6A2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=JsXZdTYBf5sHlwFZHIlwBnsJ2OzZXfduXbWQZ7KyOak=; b=DT3wV1/WI2jyWz37s+g7q4sL+J
	2YVw5POquMSa423mGhX8FNqvUmMrPnyIHPpNaA6oAuW9GUCos6qO9QSqdE5fb49YEABFiYtHrLlHe
	0sO5ZyjMVfocYYdEXLaszF4Xy5gUUARqsRSIJSdAJFYsvJ9oMt3rzjCZuMXw94kVkf26s++k1Z6UL
	9PheXcs5vVVk56kxtWDWILjaT0QOtLgxgJaoL3K85gZ3moEluGaw3j/PBp2+L/FWMuBKh0bN0mkOs
	IlyULWy3VmcuEDTTt8ie+jJ6H3hG93cHFGziOM/qPoyeo2NwmLJvKYaa5cmVjGMoX25LNrhZP8gl1
	pFV7og0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gky0h-0004gz-OT; Sat, 19 Jan 2019 21:18:35 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gky0e-0004gK-Bg
 for linux-arm-kernel@lists.infradead.org; Sat, 19 Jan 2019 21:18:33 +0000
Received: by mail-wr1-x441.google.com with SMTP id z5so19026334wrt.11
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 19 Jan 2019 13:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=kzKu7Jt1TFcQEeir/0gTQijTxqpN5Q5WlzTbs2XKl40=;
 b=eFLdKf8TOu+KeffqOrW+53a48hHnn5nN9vOXmi86HUg4BxhpjVof5SYY7D7NQlc+ey
 KGJWExX9qNrZhQH6tywUOZNgcCI/HFjdMMzNNSKpBNHOY3ZITjUDjgMlAfH6c0Hq9ma5
 pubuYYhTvOPTZvNs0dHR9VJI68mj8UAeSdciPWQr+4ivccRDcvHwY6QKTIeq7+RqwsLd
 2RtwNGWbpGT+4zaIX9wCNXHkWbZdsPCk3++En4fg87S7fIvBlVNuVrNmDaspFLjtWQrQ
 4m1EOrTBmM4pzV1igiK/XCS3rIj8/eqWAhuuNgKK39Ef+0CaOPvoZUi58IzJMP70jJNu
 jL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=kzKu7Jt1TFcQEeir/0gTQijTxqpN5Q5WlzTbs2XKl40=;
 b=ZX1Whob9sVZnkY3bwlU7ZRwlrtag0CnSkS1SgPZCBKt4SowC4GypTWtmfwbA9jx69q
 S8U6ujM0k0oOqY66Os8iWZIWqfm1Uo93rHCUrXPAgwapLJvDLI9PmM+vgswApNKPtABl
 Xd50+X20qAyj3WtXQ082btFmzscXTYl7S36iMVzCuH5dzqYfVscE2pX+7ny57fecTyjN
 xySeigLcn6axP/7IsZc5WO6h1kCdYwsbb9c3P9LPsSn5pBYeLRzSDbxV+ZlyJ1VL8ipZ
 bCqIavlx8g5Nkeb0VCpTxVHSt2pv7bJ3bHIUG4M3FwdwyWhkPwSGO8eWIS3yRbb8+8p5
 6J1w==
X-Gm-Message-State: AJcUukfm8EozaUNCXYYIxl5VclzPmpc+oNinxQl4RUd3aigU2jPWSTxy
 xFpqSEj+MfhaBNmEdz8P44w=
X-Google-Smtp-Source: ALg8bN6OvbXLv3U3GBXlnrvPTl84iGuAuMi5p6T+A/s4qTw1lOOLiYdbcSpmaNyx/WIRo1FppYLQbg==
X-Received: by 2002:adf:80a9:: with SMTP id 38mr20402991wrl.137.1547932709686; 
 Sat, 19 Jan 2019 13:18:29 -0800 (PST)
Received: from mappy.world.mentorg.com (sjewanfw1-nat.mentorg.com.
 [139.181.7.34])
 by smtp.gmail.com with ESMTPSA id v6sm55737019wrd.88.2019.01.19.13.18.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 19 Jan 2019 13:18:29 -0800 (PST)
From: Steve Longerbeam <slongerbeam@gmail.com>
To: devicetree@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: imx53: Add capture-subsystem device
Date: Sat, 19 Jan 2019 13:18:14 -0800
Message-Id: <20190119211815.25101-2-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190119211815.25101-1-slongerbeam@gmail.com>
References: <20190119211815.25101-1-slongerbeam@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190119_131832_431880_1BC1DC48 
X-CRM114-Status: GOOD (  11.69  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 open list <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Steve Longerbeam <slongerbeam@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add video capture_subsystem device node, and include both CSI ports.
Prepare for adding sensors by adding the parallel sensor anchor endpoints
to the CSI ports.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
 arch/arm/boot/dts/imx53.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index b3300300aabe..a78a447c4b4d 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -31,6 +31,7 @@
 		i2c0 = &i2c1;
 		i2c1 = &i2c2;
 		i2c2 = &i2c3;
+		ipu0 = &ipu;
 		mmc0 = &esdhc1;
 		mmc1 = &esdhc2;
 		mmc2 = &esdhc3;
@@ -71,6 +72,11 @@
 		ports = <&ipu_di0>, <&ipu_di1>;
 	};
 
+	capture_subsystem {
+		compatible = "fsl,imx-capture-subsystem";
+		ports = <&ipu_csi0>, <&ipu_csi1>;
+	};
+
 	tzic: tz-interrupt-controller@fffc000 {
 		compatible = "fsl,imx53-tzic", "fsl,tzic";
 		interrupt-controller;
@@ -158,10 +164,16 @@
 
 			ipu_csi0: port@0 {
 				reg = <0>;
+
+				ipu_csi0_from_parallel_sensor: endpoint {
+				};
 			};
 
 			ipu_csi1: port@1 {
 				reg = <1>;
+
+				ipu_csi1_from_parallel_sensor: endpoint {
+				};
 			};
 
 			ipu_di0: port@2 {
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
