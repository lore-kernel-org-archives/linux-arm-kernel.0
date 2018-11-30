Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3025C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:41:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B671A2146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SRkVAlUi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZKU5b3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B671A2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8RA7oKhgQL4WwBZKXCdd9Ko+YPHHSQBbqXeRQhtTtdE=; b=SRkVAlUiG4PZ85
	v2utipjHcxJAWLZojaWmbcE342a0HacwIN63igJcSTO4J/JrNiprZVQrzde5WEO4tyCi3a/PnFFNL
	XTfi4Bq5ker2lxoEbhEFqez+/vqSudtS7CaFByfwsOkMeMT8DoxQSP1rIbF8wIIXXaxMpGwcVaThA
	+q8lpmzDdFAXxncppJKFXfkveQs6rUdtP4Fm71r9BPGZXoiC2Su+/s0WvRcO1GMsTNGGpyvUWUWpB
	KOqhZiZ3AFqSB+Bohusz01zV0Fb/kEpXTVWHaT1lnOlIPL8awwNIiQAFokDKHZAq0qf1oGtXdTk9F
	ZJ6r9hcFSmdosiIUvkmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSeMd-0003O1-Vt; Fri, 30 Nov 2018 08:41:32 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSeMM-0003BV-KX
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 08:41:16 +0000
Received: from mail.kernel.org (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6ADC321473;
 Fri, 30 Nov 2018 08:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543567264;
 bh=tEX3EIp9v0zv12Hz6PhdBRbJ//jFE2EqCELQvbFhDpA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jZKU5b3Xp68rcrCLh008e6TYIWtQDKOU2s3QCQZApw5+VvQHdNxaPK8e/rhRZls33
 5nWsHEdvhjV6HaktcJVaEg2tm7as2jCDmXPo7RuicEVyTZgZX3udljelPp78Hvg445
 MxIKNTfPpULQUZgollMWms+p5rxZ4zYjc/21ZGLo=
From: Stephen Boyd <sboyd@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 2/2] clk: mediatek: Drop more __init markings for driver probe
Date: Fri, 30 Nov 2018 00:41:03 -0800
Message-Id: <20181130084103.64722-2-sboyd@kernel.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <20181130084103.64722-1-sboyd@kernel.org>
References: <20181130084103.64722-1-sboyd@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_004114_743038_688C242E 
X-CRM114-Status: GOOD (  12.24  )
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
Cc: Rob Herring <robh@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
 Weiyi Lu <weiyi.lu@mediatek.com>, Wenzhen Yu <wenzhen.yu@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This function is called from driver probe, which isn't the same as
__init code because driver probe can happen later. Drop the __init
marking here to fix this potential problem.

Cc: Sean Wang <sean.wang@mediatek.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Wenzhen Yu <wenzhen.yu@mediatek.com>
Cc: Weiyi Lu <weiyi.lu@mediatek.com>
Fixes: 2fc0a509e4ee ("clk: mediatek: add clock support for MT7622 SoC")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/mediatek/clk-mt7622.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 92f7e32770c6..a8aecef1ba89 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -513,7 +513,7 @@ static const struct mtk_gate peri_clks[] = {
 	GATE_PERI1(CLK_PERI_IRTX_PD, "peri_irtx_pd", "irtx_sel", 2),
 };
 
-static struct mtk_composite infra_muxes[] __initdata = {
+static struct mtk_composite infra_muxes[] = {
 	MUX(CLK_INFRA_MUX1_SEL, "infra_mux1_sel", infra_mux1_parents,
 	    0x000, 2, 2),
 };
@@ -652,7 +652,7 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
 }
 
-static int __init mtk_infrasys_init(struct platform_device *pdev)
+static int mtk_infrasys_init(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct clk_onecell_data *clk_data;
-- 
Sent by a computer through tubes


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
