Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F343C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:21:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B7A22087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VvkmZ6LR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cb4dQDda"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B7A22087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=afiKIcGKWKrNVsEgU7e5lFVxVAncjwlYfYuhbZ4KHJY=; b=Vvk
	mZ6LRPiHuHQT2K5Vx7ckMmpn1YJA4FicZ/hFfp3P6Im5ppl/+HALghBD7cgYONQf0DnxiKGp4GAUY
	u6J1w1tor03qc7TrUwxZlUBe07+ka0UOgh2L0N6hpp+meWu4yq0Vn3PC0NUvChLrd/g7krr83QJFi
	eFJYT3tvf78yGcBfxxt/AY5qB2xOLTCTDPJer/tkpNs7+UsPYz/pQ/kr+IX/o2v79p8rz+l2cmBao
	+mctVRMCZ2GZksCxKU/8Ylmw+PztqECRHV9jziXg6oVFxOvziZ0n7Us5hMvc82nM0q/RzXc6SEbgN
	xfxNkzlXui2l76ybMbwdSRVcra9vT+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp06V-0002mE-5I; Thu, 31 Jan 2019 00:21:15 +0000
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp06S-0002lh-BP
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 00:21:13 +0000
Received: by mail-qk1-x742.google.com with SMTP id z18so889348qkj.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 16:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=z6jbomTcGNYr8GK31Y5viWPelpWwK53klWRjBO3VrHY=;
 b=Cb4dQDdaEJBrnLTS3PrZ14YUxgByS2UfC40XUHIDrk/3xwXWmHKolhETkWWHkKYdyg
 KgJIIzInsLsRwVLHMmFUR6+4a3CGXuNP2UJdtDi5yJt3QXAwZxCl+uodBHf8e9L6wGEq
 oPObjiHdvvvVgxk02EVtXD4SqkXCU1vTlbrMqwELVY2zyfSUXRnoorfRcrgV7R09nw/+
 F8GhXxR+umErkXR19jvKccHrnGNUrXfC2JuESXE6JiVrkRcLlYu1EPCUaVyfoqoA3NGa
 w+o9Yu1uGzyDrULGI6yVtKOfzpMvP6eV9BW05nOjy+r6z9EArI/C9XNMOQyGMatS5v6b
 RDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=z6jbomTcGNYr8GK31Y5viWPelpWwK53klWRjBO3VrHY=;
 b=XqlFuk+JDRVf5Ob7nGhsLRYFrSAUxFxB4gFCHwsx7/bZz3ttABOqHORDtHMN2w1rwi
 A4emY7HAz61ycc5JeNrtMrJIMmEM9jK0D+EroDVoenZQda4z2TFsL9ubud+jeC+2seZS
 YUnLBRjvAOO6qwi6H1f23Q4QeqV5kiaVD2BfU2skAZZRxPfRrqXdmmoz2KskFiKyyoEi
 dGmwRnYc6DI53qZWvHYAo8vZ0TWU828wfqgtRBrv6Ca+jftl7Cwd9rLCJS4IL+V3FNuV
 otdgCONxBxHnk31fCTrgr2gHayubjNXtN3zIb60f4TQZt/FyXi2QGJOwHc6v0B7RxJhp
 5ufw==
X-Gm-Message-State: AJcUukdjgiUg+x8/rbNXY0Z+SmzKsVh2VxgkgFLC4hEOm2oBYG+lV8h4
 NkPme/pWCj28DU/nf3hfb1U=
X-Google-Smtp-Source: ALg8bN7g5tSHIRSapnBEWxjNyAViqqmc++eYHEr5PmNl0SR+Ychbqq26zdGeeVwCer/KY49LGHsDvQ==
X-Received: by 2002:a37:a391:: with SMTP id m139mr28963124qke.11.1548894067897; 
 Wed, 30 Jan 2019 16:21:07 -0800 (PST)
Received: from fabio-Latitude-E5450.nxp.com ([2804:14c:482:a73::1])
 by smtp.gmail.com with ESMTPSA id p42sm3366676qte.8.2019.01.30.16.21.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 16:21:07 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: sboyd@kernel.org
Subject: [PATCH] clk: imx8mq: Add support for the CLKO1 clock
Date: Wed, 30 Jan 2019 22:20:56 -0200
Message-Id: <20190131002056.12024-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_162112_417747_CC5CD17F 
X-CRM114-Status: GOOD (  10.94  )
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
Cc: shawnguo@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
 Fabio Estevam <festevam@gmail.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add the entry for the CLKO1 clock.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/clk/imx/clk-imx8mq.c             | 3 +++
 include/dt-bindings/clock/imx8mq-clock.h | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 63001bc891d4..a2f8a8d3585c 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -264,6 +264,8 @@ static const char * const imx8mq_ecspi3_sels[] = {"osc_25m", "sys2_pll_200m", "s
 					   "sys1_pll_800m", "sys3_pll2_out", "sys2_pll_250m", "audio_pll2_out", };
 static const char * const imx8mq_dram_core_sels[] = {"dram_pll_out", "dram_alt_root", };
 
+static const char * const imx8mq_clko1_sels[] = {"osc_25m", "sys1_pll_800m", "osc_27m", "sys1_pll_200m",
+					  "audio_pll2_out", "sys2_pll_500m", "vpu_pll_out", "sys1_pll_80m", };
 static const char * const imx8mq_clko2_sels[] = {"osc_25m", "sys2_pll_200m", "sys1_pll_400m", "sys2_pll_166m",
 					  "sys3_pll2_out", "audio_pll1_out", "video_pll1_out", "ckil", };
 
@@ -479,6 +481,7 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
 	clks[IMX8MQ_CLK_GPT1] = imx8m_clk_composite("gpt1", imx8mq_gpt1_sels, base + 0xb580);
 	clks[IMX8MQ_CLK_WDOG] = imx8m_clk_composite("wdog", imx8mq_wdog_sels, base + 0xb900);
 	clks[IMX8MQ_CLK_WRCLK] = imx8m_clk_composite("wrclk", imx8mq_wrclk_sels, base + 0xb980);
+	clks[IMX8MQ_CLK_CLKO1] = imx8m_clk_composite("clko1", imx8mq_clko1_sels, base + 0xba00);
 	clks[IMX8MQ_CLK_CLKO2] = imx8m_clk_composite("clko2", imx8mq_clko2_sels, base + 0xba80);
 	clks[IMX8MQ_CLK_DSI_CORE] = imx8m_clk_composite("dsi_core", imx8mq_dsi_core_sels, base + 0xbb00);
 	clks[IMX8MQ_CLK_DSI_PHY_REF] = imx8m_clk_composite("dsi_phy_ref", imx8mq_dsi_phy_sels, base + 0xbb80);
diff --git a/include/dt-bindings/clock/imx8mq-clock.h b/include/dt-bindings/clock/imx8mq-clock.h
index 04f7ac345984..74f80b26f679 100644
--- a/include/dt-bindings/clock/imx8mq-clock.h
+++ b/include/dt-bindings/clock/imx8mq-clock.h
@@ -391,5 +391,7 @@
 
 #define IMX8MQ_CLK_NAND_USDHC_BUS_RAWNAND_CLK	267
 
-#define IMX8MQ_CLK_END				268
+#define IMX8MQ_CLK_CLKO1			268
+
+#define IMX8MQ_CLK_END				269
 #endif /* __DT_BINDINGS_CLOCK_IMX8MQ_H */
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
