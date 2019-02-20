Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD97C10F00
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:59:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37A962146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QxRSBoUx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tZaofClG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A962146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=03oksFCNuOAgn071jf30a6gljFxIlBuN4fp6eRpGwt8=; b=QxRSBoUxL5jv6z
	CxMssUyOOX7T/Ke7OH0ZHmWBCSwZjysVVM/qkXJZ7gOQ2YJu0bDdRJBZL9mwntmYNSPzNsgKIZZq5
	+QaTJhGfI2OOKS6Hg78Iz7Cn0rNl/BYJkh6PaqAmVTQb1HHQ6qgAto7I8EPckhRqv80TyI9J/SHS/
	HZXGiMnkutoL56jEE4MFMoqUMe733fNPugOQ/kv33GYNXrJwjY3fKqptvxb1BanJWv7S88kuDx0wS
	aX7XPMxOhuTKjYnuwlpj6YsedXkp1n1owgcM3GoK3om2T/RrBs3vq0arSkfm8DCfJaIeeJNtv5iJA
	liMqcc4eo5KT3A5woq+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwHAJ-0003om-Fz; Wed, 20 Feb 2019 01:59:15 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwHAF-0003mz-GA
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 01:59:12 +0000
Received: by mail-pf1-x442.google.com with SMTP id i20so681200pfo.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 17:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2SRxal34wQeNyZlTUmsGVAEJJg7Go7JQ/XIJK9SAQAA=;
 b=tZaofClGEBOOIov8h4JL9zYgGCgXM0EjZZOFg921jUIJUxrDjFqzrf9FafxlAPynuX
 MMtRP7GqZN7eNqNDvGSPczf+dYlWlh9EvjQz5adxa8Ch89jZZUUrPj8vqiSanM6vUXBF
 9wcLAhlue05bCoEJFwfq5qpqqs8IOilpojFCFXx4hqu0k8BFrO0hKS3hDOlyNKHQa8Mk
 4BL8y7ek4m1qGX1jlNe2Yc7XH27YHj0vtdkYVPov+1cPm7Hv4AtZeZxYVeF6n1cNUaPy
 tpCYciUyW+un931rWBivM3oBXbJ5BpFZDMkW3x84GvGdVSN71U4PppY00LRI1914y0dr
 iQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2SRxal34wQeNyZlTUmsGVAEJJg7Go7JQ/XIJK9SAQAA=;
 b=U11j8UMs19fdCtzCjTotuohGY5Ls1OD4XkX+WheJNgixHrtGSfoe2UDe44eT1bwQCU
 ityf3qlD64k5ivZWed2q7Ayufj2R63YXDV4sTz0/OzFWVnibPHzQ7QwlAwCH3A2tFnWK
 YHcNXGrlGOog9ejHNIUQjyeGGjfiYMqCBBRv0tUlSo9jU4U3NABMeQ1CS0tySDD4rKz6
 Ljx0HOZcDor+bZOIdnmoG4bn1r8Gb5G7hMRkDSbocRh2DnPBlq/oWTPi8Z/41WC0TWoV
 1PnQpGpSzpgf5Xz/uMV2rxE+jZyd0p9F9KpOI6LImGW1r2Iy++/vZOiN+aim/X4Pt2uk
 ruFA==
X-Gm-Message-State: AHQUAuYH/3iKN7KeBre75vFMtd6FxX420DnL1okqNJ/Rtcwl/r6QV234
 KEoSwZu+CrB3uLo8DptMdqg=
X-Google-Smtp-Source: AHgI3IZj30pfN8U9fiZ88V05TZS+7EDHUJVRGvotfAXk4QhdwEsS7cu/o7nEqxPLKyBCxH3COHl7uQ==
X-Received: by 2002:a63:5d5f:: with SMTP id o31mr26930331pgm.414.1550627949904; 
 Tue, 19 Feb 2019 17:59:09 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id h3sm2562525pgv.38.2019.02.19.17.59.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 19 Feb 2019 17:59:09 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v3 1/5] arm64: dts: imx8mq: Mark iomuxc_gpr as i.MX6Q
 compatible
Date: Tue, 19 Feb 2019 17:58:53 -0800
Message-Id: <20190220015857.7136-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220015857.7136-1-andrew.smirnov@gmail.com>
References: <20190220015857.7136-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_175911_537994_6FAE1353 
X-CRM114-Status: GOOD (  12.77  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 linux-arm-kernel@lists.infradead.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-imx@nxp.com, Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Chris Healy <cphealy@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Mark iomuxc_gpr as compatible with "fsl,imx6q-iomuxc-gpr" in order for
to allow i.MX6 PCIe driver to use it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Acked-by: Lucas Stach <l.stach@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 892063a7c26c..f6c37bf9cbce 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -230,7 +230,7 @@
 			};
 
 			iomuxc_gpr: syscon@30340000 {
-				compatible = "fsl,imx8mq-iomuxc-gpr", "syscon";
+				compatible = "fsl,imx8mq-iomuxc-gpr", "fsl,imx6q-iomuxc-gpr", "syscon";
 				reg = <0x30340000 0x10000>;
 			};
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
