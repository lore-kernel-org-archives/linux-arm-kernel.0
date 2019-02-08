Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AE3C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:30:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 115AD2080D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LPfDZpSG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcdaY8Aq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 115AD2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Yk9XgFBqUirpdGcb8GYJ8TLmdDOhqiOmiBp2knBiNbI=; b=LPfDZpSGjLPcuW
	kOk0uumr9Tr1Y2WlSfvnj3bQ5gHLfjlN1PNq7+qghsFsTaz4ADUZB+BgPUXH0LGMbvSANjgDzOTBR
	BSt3u0qEqbXgoI6fcgMfZbu7gQOKdN5H6fJ+mZIvY6Ie83i49V9uG+ysp85Bt+F35WpH1Ku3DhCjF
	Isi0lIipgwM19Vz88THwyTWLUzDTvISVp2JdNDIYccNpqBvvoygwwVSfQTbP3vFLVNF92DZQ0S5pc
	ioRtxQJOWiXQNKhL2JHIeBdp9llbLYtFqMbYPPHJ1DB1IoLalzrunB1ZBdmVgTG5IuQtQPp1pICmg
	0CX2plwqWoWQ6DKPgakw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gru3w-00016N-GE; Fri, 08 Feb 2019 00:30:36 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gru3L-0007lh-DV
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 00:30:01 +0000
Received: by mail-pl1-x643.google.com with SMTP id s1so807661plp.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 16:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pfG5fkUaRj/fht/6ipkewqnaacFZ9IZoXIVJQq92s6U=;
 b=jcdaY8AqHvODsk+ZBnTKQxzEI22PRT68VQ3vqIsb2AeYrp5K5EMgqBbYFkr9iVKaHd
 BkLxPkhD83V4JcfFHG/JzGsfCiHBU6AVYqZqcgJplFB6mWn+K1H1UZRHosEj3TeC+Sse
 afDxEtmmB6w73+NwpasY6XIhBa5hXMJXUTMtFzfvFFYjnESv0Q09tXwt2cQoLc3Q+YMp
 pUzc+F0L+yGSb3sRHoIJwD1/1koNQPgy+BazHAvMomcykvhp2YOFM47M6sk1ATHuWIZt
 V1vOYRkp4rRbnHuynJ1UCqBfbQBxTH/QxaIvg6Cl9ghH4HhH29JbKVrUlpzcL7Hc2Czq
 YvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pfG5fkUaRj/fht/6ipkewqnaacFZ9IZoXIVJQq92s6U=;
 b=fz5b8QtFZRJJgYCBQqEDZuVxV9bFVaKYS7FEjp68GH4zFnyDWdnX7eFmIsgCNfaGYH
 xEuC9tIz4wLrxSf8VC2EJPRpUwMib0IYPVE+GGolCThA3r4JCO7LfMgaKM7IJEnO8XOf
 u2Q1aq+EYBupKAky/0byYdgTKnvjA9u9jXqG0DmI8hBZx+tZaQenGttBitEme6ptCcwJ
 XAQOLEAmV7eENqzC6F45bHG1q2Jj7tsFxnvJLj8+4/bvSF16lTYKn2AC8neMOp57eMnp
 r9S3xcIsyVfbEzx3QltFRz8swGf2AFGedcAHggwRcCoqY1+a8uO+l2Y3oxSu8XkloClt
 wujw==
X-Gm-Message-State: AHQUAuaBpbmpBHb5IZ8+9cnEnNQAc6UNRevQSLxQe4jQgvtZQmFG7Hlx
 opy+Hh9CarAiN/cF8OnnEaI=
X-Google-Smtp-Source: AHgI3IY4QfQR1y0LrqJhJ2idCASFmSgjoYddZo9Kb+syvJFTCcwr+x0SBR2LRxgM5QHd9qSrOMTrFg==
X-Received: by 2002:a17:902:29ab:: with SMTP id
 h40mr19423173plb.238.1549585798704; 
 Thu, 07 Feb 2019 16:29:58 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id p81sm380835pfa.107.2019.02.07.16.29.57
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Feb 2019 16:29:57 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>
Subject: [RFC v2 2/5] arm64: dts: imx8mq: Add a node for SRC IP block
Date: Thu,  7 Feb 2019 16:29:38 -0800
Message-Id: <20190208002941.30343-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208002941.30343-1-andrew.smirnov@gmail.com>
References: <20190208002941.30343-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_162959_451223_BE1D5B7B 
X-CRM114-Status: GOOD (  10.88  )
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
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-imx@nxp.com, Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Chris Healy <cphealy@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add a node for reset controller IP block found on i.MX8MQ.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
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
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index f6c37bf9cbce..50436bd393ed 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -254,6 +254,12 @@
 				              "clk_ext3", "clk_ext4";
 			};
 
+			src: src@30390000 {
+				compatible = "fsl,imx8mq-src", "syscon";
+				reg = <0x30390000 0x10000>;
+				#reset-cells = <1>;
+			};
+
 			gpc: gpc@303a0000 {
 				compatible = "fsl,imx8mq-gpc";
 				reg = <0x303a0000 0x10000>;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
