Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C01C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:41:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 976342146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dgX/H2PY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qy8y2ied"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 976342146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=xJSLi/4y0hvku41GzLIoyQx2Hx21Jeja46jED7PtHpY=; b=dgX/H2PYpopd3O
	IM+q00wSiRSu4y6DYNheN9uPX6FUxSOsoEx1d49YWgamJc5GLtlSDVeX687p3BOfuif4QuUa7iJBF
	IJGG1lWYAhB0HU+EHbI4/noLmMPIrtnqhD/o0YNP4URFSuSGxXX2w4udAjut3FIWpmlRvYwZrGRG7
	PskeOAeD9Faoi5pCzVsw6DxAQHhoyUJqam062MDOxU/W0T0H8iGh/rH7jTOqaSiRB/aNf0YU+/Hrl
	55SxZjyGGgApHFb95mbuFIsrVzlVOskF0tdxub/lzrH9EiGrQANW21MeG8Ji9VgDQaeSk1X1XKpNp
	jDSxt6Ir7yhMx3SrSZqA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSeMP-0003CH-IM; Fri, 30 Nov 2018 08:41:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSeMM-0003BU-KV
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 08:41:16 +0000
Received: from mail.kernel.org (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EC57420863;
 Fri, 30 Nov 2018 08:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543567264;
 bh=lBfAH6Fdv6pt5aSgWvZeYjgK4PN/vTj7oibEqhT6GZA=;
 h=From:To:Cc:Subject:Date:From;
 b=Qy8y2iedhZeqsToWz+uC5mWVklUSj0QMZgnc7+Ztljrt9yyRuT4tR/URd5NUr28Sr
 f5I04e0ZD5g0c0dNz4YOhFhUj9tc8MU7DmRmugYjqOJXPTXo7Sh1dA8HyMp9Sf+KQQ
 5HrfUe4oYeMlPsWHOFF98oSYCBtwmT7FmPjPVckY=
From: Stephen Boyd <sboyd@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 1/2] clk: mediatek: Drop __init from
 mtk_clk_register_cpumuxes()
Date: Fri, 30 Nov 2018 00:41:02 -0800
Message-Id: <20181130084103.64722-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_004114_699079_312BDAF2 
X-CRM114-Status: GOOD (  10.48  )
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

This function is used from more places than just __init code. Removing
__init silences a section mismatch warning here.

Cc: Sean Wang <sean.wang@mediatek.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Wenzhen Yu <wenzhen.yu@mediatek.com>
Cc: Weiyi Lu <weiyi.lu@mediatek.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/mediatek/clk-cpumux.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mediatek/clk-cpumux.c b/drivers/clk/mediatek/clk-cpumux.c
index 16e56772d280..6c7eaa21e662 100644
--- a/drivers/clk/mediatek/clk-cpumux.c
+++ b/drivers/clk/mediatek/clk-cpumux.c
@@ -53,7 +53,7 @@ static const struct clk_ops clk_cpumux_ops = {
 	.set_parent = clk_cpumux_set_parent,
 };
 
-static struct clk __init *
+static struct clk *
 mtk_clk_register_cpumux(const struct mtk_composite *mux,
 			struct regmap *regmap)
 {
@@ -84,9 +84,9 @@ mtk_clk_register_cpumux(const struct mtk_composite *mux,
 	return clk;
 }
 
-int __init mtk_clk_register_cpumuxes(struct device_node *node,
-				     const struct mtk_composite *clks, int num,
-				     struct clk_onecell_data *clk_data)
+int mtk_clk_register_cpumuxes(struct device_node *node,
+			      const struct mtk_composite *clks, int num,
+			      struct clk_onecell_data *clk_data)
 {
 	int i;
 	struct clk *clk;
-- 
Sent by a computer through tubes


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
