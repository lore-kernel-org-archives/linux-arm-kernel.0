Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2633C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:55:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C815218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M/fztqzz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QkKHeReb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C815218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=r4L3Feix08ZHSFe9x9TWzNJfLbzObKpJhCmk2a+fEFU=; b=M/fztqzzROxndB
	dDgIEsD+pM2bKOTGs8bTMLYGfocq4bmOHdytUHy8tvW7nUC6eXHfi6hKwLMipkjpmfdKfeyKunAwL
	2We2JlxOsIJLJ61G5TpLcnfZGexEMTLJgq5lDnQZtTnxEPize/IRelQOWcaxKkkxI9/KVd9nHOyYH
	ycf2YDWbDVPiW1M1LVABYv7pj4HtY7WfnJzPg3Ad27XCDWM4pW+Lz1HdLNHt4TXyDkjqP031V5qPh
	lBELhXconS79OkQBB+UCNdgYSuK9nRUgICV/lzlkLt58nWeExmPLgYFNr9Bw1OUwGS1+KOKHE2aBV
	fefJJBYmtMSA2JL5RnCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpHUX-0008K6-D6; Thu, 31 Jan 2019 18:55:13 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpHUT-0007Pc-7S
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 18:55:11 +0000
Received: by mail-wm1-x343.google.com with SMTP id y8so3690873wmi.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 10:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SYuVFTeInj08UKDELZ644S86vYuTL6rQEEarM/U8JqA=;
 b=QkKHeRebOAWTWLxDPecbuZU6w//T2+ZMdErcXbo07WPB6k+xrcI5fWqbmG619VyhRp
 U0xbghgrk0rkZjqFt0ItFqYIScG+mxgE5g0KfgZ6zPFYb+EUmQUjwpterHUbiBpV3hZy
 mfBugm1BLD1GRp5rqz4R6KGIPAox1AWV80KbBrbEZ4U6lrg8scaRUyrHJRvGgjRlLF5N
 6XKtA3B9qyKjfpuNZTv3cValFgnMLhjIYH+xLCCX/0IhLdEab3l0UNJTforlFWe5/Sp5
 kWRsmVTFYOqQlC7bsxOsa2XFv1TFKjMpq73Ld5vIviFWgWQ8Z9B7IBZPogBKF44ykkjw
 ZdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SYuVFTeInj08UKDELZ644S86vYuTL6rQEEarM/U8JqA=;
 b=LD/Y090xG7JsLWQnE7GjJwQ8e8Rm7RX7eY9gtSB9uG4THrsT2cbVuENj/vEmdZeIqw
 W0s1Xnkg7OuWIkbpbGAOWAD43d1gaQHohOPz/sKBt8nE3I9DToPXbrux3a6/rGfjETUi
 hAwLEj8tPsEVdVmGjRIUnV8di5tyjL08enQHzYq44V72FmaR8q6OiUE/IpqUW1kGiwH1
 uO6vTpjTpweNjW4gZHaLENTocYNQZQe/83mc7jssjqz5szvyn6fCfNhBQ+PJ91wsi53H
 7hkXruxESW8j22ceJi5me2KYTP+1ggNtI3PctSKOLK5YtqXI4/0Zcf55+ai9evZ7jB7t
 vtww==
X-Gm-Message-State: AJcUukdOEEQbEVdTOjhE2+E8exSNn9Y+M9Wm3+HUALBeHE9bjKw1LmJn
 MPdSPm/jQ1cC0W8mirZyPLqj4w==
X-Google-Smtp-Source: ALg8bN51zSoGQqQKAE0sRyQKAItimChy6BPqbQgU6b0U47mvvcTMWSzRvC44F0f+Vaz108FCdPaV5Q==
X-Received: by 2002:a1c:cc19:: with SMTP id h25mr30474141wmb.80.1548960907132; 
 Thu, 31 Jan 2019 10:55:07 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:f7a1:ce00:5105:4b7b:c922:7c6])
 by smtp.gmail.com with ESMTPSA id s16sm4883868wrt.77.2019.01.31.10.55.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 10:55:06 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
To: robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 linux-imx@nxp.com, l.stach@pengutronix.de, abel.vesa@nxp.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: dts: imx8mq: Add ARM PMU node
Date: Thu, 31 Jan 2019 18:54:22 +0000
Message-Id: <20190131185422.7813-1-ccaione@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_105509_277619_7C854C47 
X-CRM114-Status: UNSURE (   9.80  )
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
Cc: Carlo Caione <ccaione@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add the node for the ARM Performance Monitor Units.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index dbedc4a5e7fb..8b3107643ed4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -118,6 +118,13 @@
 		};
 	};
 
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+		interrupt-affinity = <&A53_0>, <&A53_1>, <&A53_2>, <&A53_3>;
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
