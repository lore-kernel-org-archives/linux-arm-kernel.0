Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CED6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:57:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD473218AD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eN6MHd28";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhNIF4rp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD473218AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=ICUV6P6l4QTz/4T4Uul06u6XlWN+tODPP6ubNNWf7MY=; b=eN6
	MHd28TZGC3Nydr+suvgvsjI0K5WOZ45tT+9VUh7XzJYtAioWgYdFTt+WMKOprhBpr4Mqz2dnFPa0k
	R0FujZBk6jKA1QiYsEpu6PmjrsX8T1mybDvmrYJD7TNYz1gqeKCm27ZZBXvtYmsLvpM0itB8XTPJV
	1hlxfOKEQ1zZdF8lqiRDTLliUFA/zE+Mlhq9ZAVOkGIsi0uw98rtXxJCuHlQfAzDYXf31POG1DCxA
	qJrau4+GFcsb+awjDBb6x93+EvYaxioszrFkavkmXUe+iaXdjA3ydba4dxTdmOrkQesoiXAZ5xagh
	sUPt9BIU6K++5N8G8C8eh2lmNSSSORg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gc9gh-0006VS-Ui; Wed, 26 Dec 2018 13:57:31 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gc9gf-0006UT-6G
 for linux-arm-kernel@lists.infradead.org; Wed, 26 Dec 2018 13:57:30 +0000
Received: by mail-pg1-x542.google.com with SMTP id s198so7611882pgs.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 26 Dec 2018 05:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=0zjUBEQEh5snP3G1eRJuUVP/KHq6PY84nTcAiiZvhfc=;
 b=YhNIF4rpij54/O8M5W0qNvFn7nH97HGdMxzRo07LoKT8c30TD3+fEciFf8llTgMWmx
 Wh5Rg9GLgY9HIXzsg/SY0fCg/thwiNDygTT7iGnyGaGVA8DII/m86GKNds9swd5sWs57
 y8dkRzHNyCzyb8mk8ADSU8kAZ/H5+N6YTAfOniDWd6wgvOrH8M11AzydF7ceIpiUY2jq
 22uBmA7zRGlGXBxxrnr8a+DfOmcR5OGpzo1lC1a3o1aI8pl6SRDHyQeEW6D5XcUJUp2R
 A5TicuiER5LGLO/vV+LpIgexg1bRBK/Pi2lTz5TpiyC59BpFd2YarlFHsjlLldj7qjwR
 raRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=0zjUBEQEh5snP3G1eRJuUVP/KHq6PY84nTcAiiZvhfc=;
 b=E+4I9xMmNi3ih3mpUaDMazCuo5q15cPHit3TwOeaI3HukuOzsj/WdnmR92BBPLQ2bT
 kqHcE/xVqKvnCCgFJcSPVZlGjv053HpMWHMzLoHSSNv2RGqhibKsfCNgVFJ+xB7XAgxf
 pWJspSdcyvcPTWMp28vEU9HkJ4xgF4aWKlUEb70UVqXst7kbGG7Z1UH42yAwGX6Tr75u
 DfK1Lk7vwn/6PDvSI60/NF6u9EY5X5NTGRAQGwM1DI36ad19we6B7Sn3aY4xjg1JVIKr
 IIIH8Ti/dNVTkZLLDnFBCDa8W9FeSQXRuczg5M7z9YqTFmGdgSTCSFZ9RsyGPs7NFjFX
 GdMQ==
X-Gm-Message-State: AA+aEWbjnk/jVp5LdFYkxp4xAaSnGSyATtdr0ql8RqjQCxcMhIGEraTQ
 Hix2QjB9LuqeQ1ea2+4WiqA=
X-Google-Smtp-Source: AFSGD/VMrIwUJoniQwhGyyJ6pklzASXjYJASA3y0MVZ8UC1mAw56EYYI0dOQoBcU6ZlfNv+VvYwBHg==
X-Received: by 2002:a62:2606:: with SMTP id m6mr19836522pfm.133.1545832638761; 
 Wed, 26 Dec 2018 05:57:18 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id d13sm39293459pfd.58.2018.12.26.05.57.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 26 Dec 2018 05:57:18 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 fabio.estevam@nxp.com, linux-imx@nxp.com, mturquette@baylibre.com,
 sboyd@kernel.org
Subject: [PATCH] clk: imx7d: fix refcount leak in imx7d_clocks_init()
Date: Wed, 26 Dec 2018 08:57:16 -0500
Message-Id: <20181226135716.5972-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_055729_234855_50740E49 
X-CRM114-Status: GOOD (  11.25  )
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
Cc: Yangtao Li <tiny.windzz@gmail.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The of_find_compatible_node() returns a node pointer with refcount
incremented, but there is the lack of use of the of_node_put() when
done. Add the missing of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/clk/imx/clk-imx7d.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index adb08f64c691..12e2e85bbe1c 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -404,6 +404,7 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx7d-anatop");
 	base = of_iomap(np, 0);
 	WARN_ON(!base);
+	of_node_put(np);
 
 	clks[IMX7D_PLL_ARM_MAIN_SRC]  = imx_clk_mux("pll_arm_main_src", base + 0x60, 14, 2, pll_bypass_src_sel, ARRAY_SIZE(pll_bypass_src_sel));
 	clks[IMX7D_PLL_DRAM_MAIN_SRC] = imx_clk_mux("pll_dram_main_src", base + 0x70, 14, 2, pll_bypass_src_sel, ARRAY_SIZE(pll_bypass_src_sel));
-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
