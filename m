Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5950C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:44:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6693620855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FZfKhn0p";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rsouicSG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6693620855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=gxaPHaAk6bsMyWvhHMpDHv6rXiVoHaT8Ctlmqh8UvqM=; b=FZfKhn0pyHaIDm
	Y2eGYAOL0FWyAZHxwgEdlqb7KAkYTV5JUoYynzrdDmQhm9TymwwG52l43YYPQJ4C+l8UgJqn417hV
	J/8pGrO3BdDyWG/Y4GnJYgpX3/0TP6mdgsSQXSUjaF/+NZthtAodOvw74dMRMR17gRm1ep+rpAhAN
	O9TSBB4kl15zMeaR7giedk2wG9JZZE3nsMwxUpsC7XqxsVjpcMkK///k5RAgJHAjEVFQe31zYYH8B
	cEOyRw6omb7AjMgRYXEipg3Fo9Ji7vM+tht10EK7rPiuiwz92lrWxOM6xPH7s1EwDydqahhyqAj7s
	efAblKn2QM5ktBHw7ldQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goCp7-0005Hq-EY; Mon, 28 Jan 2019 19:44:01 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goCp0-0005H5-8X
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 19:43:58 +0000
Received: by mail-wm1-x344.google.com with SMTP id p6so15213736wmc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 11:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=H+XnthQWagnzj/q4hWFPKWH7BJci8vJ0+v7wxhiREqM=;
 b=rsouicSG2Y4CtCwLDm3XbmIJ4ZoRrepfurp2AUh350R8Oiwx/Mg86lnXMUqajaSk2T
 kfMTJovX6hy0QtowbyTV7AoM7guTJ/BJ6eebo13Bt4Sba++6oC5NYbvK0uAzWKJS3JY3
 BIEqHv0jf9e2EncyqWS22KbNCc0MAvfaln2pfSYkgVmZc30HJ0GArmiMdA9X46uiLyb+
 fsUJ2P0YmdVX9q23ctQ1X12KKJLWUMWGypQ1RGdGiu1rMRBPFprwxISJ17bn+F4gL9zP
 u/wqictggTdT+lTE653cOViCVNZLZdO1R7XWptPscU/nrPs2b0KjlvYLq2Q73jolEtXE
 nW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=H+XnthQWagnzj/q4hWFPKWH7BJci8vJ0+v7wxhiREqM=;
 b=GjeYNn7hYy4JUrz1vL6K1npzhyAE/9vQYLfKAw9eyALkUIxOuNImxPhZLkiHItmb40
 xa9QpzNCWwVgmFbzcXpgE+/YAmNpyOQ78COeF14XywLlBBiUFoFG8SM4EfQl+r7QvzDx
 qaKbzSupBQumpAcyomnUYhpjsB/Youh/TWITQzvgkB/eaTwoTL9CxLlvzvr/8nm065vg
 QRrt5vQBx8BCIOIaqafPlelki2HVGaTZjZ2U3NpPNHS0siEWUNCq6F9NW/KU/SZDP1hF
 UiGpXTq1gcnB6YHi0bPyC74FH/3ROojU0rvWh+r4bcP7saWPcOoz97oDedQxxGzeIZZg
 5ESg==
X-Gm-Message-State: AJcUukfN4GgLZTRYjKN/2z9rW+PbGXasEUNI5i7VfYHTig1bBDwQJu6s
 M0Scq9k2VRmTB842h+eAriO6Vg==
X-Google-Smtp-Source: ALg8bN6D4Sy2lw1UhS/QQLBXyOWgFYgsbZ/coewDYmLF8pTOeaPnO3ky+J/s+WnP/rruDALZ3gA+oQ==
X-Received: by 2002:a1c:7719:: with SMTP id t25mr19499675wmi.7.1548704632583; 
 Mon, 28 Jan 2019 11:43:52 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:f7a1:ce00:5105:4b7b:c922:7c6])
 by smtp.gmail.com with ESMTPSA id m6sm89283529wrv.24.2019.01.28.11.43.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Jan 2019 11:43:51 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
To: robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 linux-imx@nxp.com, l.stach@pengutronix.de, abel.vesa@nxp.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: dts: imx8mq: Add on-chip OTP controller node
Date: Mon, 28 Jan 2019 19:43:43 +0000
Message-Id: <20190128194343.13713-1-ccaione@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_114356_990107_D5A6ED6B 
X-CRM114-Status: GOOD (  10.90  )
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
Cc: Carlo Caione <ccaione@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add the node for the OTP controller. The IP is the same as on the imx7d.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 892063a7c26c..9a5205f08f3a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -234,6 +234,14 @@
 				reg = <0x30340000 0x10000>;
 			};
 
+			ocotp: ocotp-ctrl@30350000 {
+				compatible = "fsl,imx7d-ocotp", "syscon";
+				reg = <0x30350000 0x10000>;
+				clocks = <&clk IMX8MQ_CLK_OCOTP_ROOT>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+			};
+
 			anatop: syscon@30360000 {
 				compatible = "fsl,imx8mq-anatop", "syscon";
 				reg = <0x30360000 0x10000>;
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
