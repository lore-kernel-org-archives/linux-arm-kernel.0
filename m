Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E593C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:21:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5960218AE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dKloAjBm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGqaOnhS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5960218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=w7gn4E7ZjALGyk9mgyzjP8bGimyudcirwaUEmkaVVto=; b=dKl
	oAjBm8Iq0vMxUb1i/hlvazaB0+j8eRBmOe0Lvf/3ubAz/fYwC6WvuSsiKV9yWwAv8pb3PJn6S0plq
	MXEOwXsNCtIM2pAIUDLaxTHF0YHNUbMihsRYo4HpKXctMUegR4jJCIgY3RkBHze9yQWgk6cuClhUy
	RrAwwlDG4f9c6YClc+X5UxrdFtaFiDpP7evSA/ApNdwOePauUdQBPLmdHO+aJDkcQrZnK3pvd2jX9
	8j/cSFmkWqG8bH5vjclPoG1WNeDCsfZl0Als1QzfLErPbEMFxZwg/b4VDCCFQ/pYMLfNcIShnwXkK
	ufjzkswb0ml1aBmAzdMap/eFRHh2amA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1govQO-00045b-DL; Wed, 30 Jan 2019 19:21:28 +0000
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1govQG-00044w-Pv
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 19:21:26 +0000
Received: by mail-qt1-x842.google.com with SMTP id t13so840911qtn.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 11:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=Mk61zDWO2rvng3ldRiuYr9AGIieZwSLJylIjdFkyVUk=;
 b=EGqaOnhSGpp1MlChw7SgI7j/RK0eaCHvVySBt8KQZgq9Z1hK5IslH0NddJEbV/+rjf
 6AbrkvGCrsGF1NS3D4xhc7jfZGHfYbexmyekApWpTNl1BzFwNnKOR0JUrNoIzjnlq1NX
 rX4NPlCF1mwbc5+YckE/E5XccuVn00Vi+dD0yFaIfMAwufMdurog2qNS28uOPRwdnXdq
 uTwKqnsOO5IzjKxkCE7uso2pGgqiVZ0JV9UzR738vE6n4JLI7EbH4MJjm3cTTwoEj0tG
 CCVR8EVUWYbJ8PrCXo14Y7x+Q6QPiqauk2pSycdD0mVDyKy67vUmlZtuvU4LMhJVeJgs
 1Vcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Mk61zDWO2rvng3ldRiuYr9AGIieZwSLJylIjdFkyVUk=;
 b=PrXAN+P1H6sWzyE7RAR+9Z6YfR/xU9KMmx0JNv5yI6/osOgO+QiMSD3lDP8QSPzvFW
 pibqX+zYTN+FwDHOsFURIgP4o+WMZp716AkxUsfXmcQwHyPcjocgLYrJ2RIazN9GNTY+
 ioAL27e1XwNYsR/5aKBuGuVP7Se9Mtd4vPRMvvabiALkzKKHHzpOz08ukw1EL8RS0+Y6
 je6j8OS1+/EcA7W6C94qsizfXNm+63CgcbfUoLPWjZU6UMVIzLMTKGm9VZJ1qJ/K2bks
 Z0jF8vBkpYDAx/c92o/npKql4PFIFg84S8Za8cScv3Ib2godqAAcH4vq04h0M/t1it8x
 YkpQ==
X-Gm-Message-State: AJcUukfSu0CzpgmJZDlHJvA4ASqWWiMJlwrIuepqe3wKDlRHssGtKXkk
 1VRLDdQgNnq+hw8ZjQAyXXc=
X-Google-Smtp-Source: ALg8bN7LibS16BiFY7knoDAJcdbQjGjmEDdhOXa8n5XGevRvSnYoYz2Wbv2qUmCftEYv4384xjagkQ==
X-Received: by 2002:a0c:95e8:: with SMTP id t37mr29847126qvt.163.1548876079085; 
 Wed, 30 Jan 2019 11:21:19 -0800 (PST)
Received: from fabio-Latitude-E5450.nxp.com ([2804:14c:482:a73::1])
 by smtp.gmail.com with ESMTPSA id u4sm1775456qkk.51.2019.01.30.11.21.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Jan 2019 11:21:18 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: sboyd@kernel.org
Subject: [PATCH] clk: imx8mq: Fix the CLKO2 source select list
Date: Wed, 30 Jan 2019 17:21:02 -0200
Message-Id: <20190130192102.7065-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_112124_698140_59FC62F1 
X-CRM114-Status: GOOD (  10.81  )
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
Cc: Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com,
 kernel@pengutronix.de, rogerio.silva@nxp.com, shawnguo@kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The CLKO2 clock source select list is the following as per the i.MX8M
Reference Manual:

000 - 25M_REF_CLK
001 - SYSTEM_PLL2_DIV5
010 - SYSTEM_PLL1_DIV2
011 - SYSTEM_PLL2_DIV6
100 - SYSTEM_PLL3_CLK
101 - AUDIO_PLL1_CLK
110 - VIDEO_PLL1_CLK
111 - 32K_REF_CLK

However, in imx8mq_clko2_sels[] only the first four entries are correct.

Fix it by adding the missing "sys3_pll2_out" entry in order to match
the description from the manual.

Fixes: b80522040cd3f ("clk: imx: Add clock driver for i.MX8MQ CCM")
Reported-by: Rogerio Pimentel <rogerio.silva@nxp.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/clk/imx/clk-imx8mq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 398ab0bcd9de..63001bc891d4 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -264,8 +264,8 @@ static const char * const imx8mq_ecspi3_sels[] = {"osc_25m", "sys2_pll_200m", "s
 					   "sys1_pll_800m", "sys3_pll2_out", "sys2_pll_250m", "audio_pll2_out", };
 static const char * const imx8mq_dram_core_sels[] = {"dram_pll_out", "dram_alt_root", };
 
-static const char * const imx8mq_clko2_sels[] = {"osc_25m", "sys2_pll_200m", "sys1_pll_400m", "sys2_pll_166m", "audio_pll1_out",
-					 "video_pll1_out", "ckil", };
+static const char * const imx8mq_clko2_sels[] = {"osc_25m", "sys2_pll_200m", "sys1_pll_400m", "sys2_pll_166m",
+					  "sys3_pll2_out", "audio_pll1_out", "video_pll1_out", "ckil", };
 
 static struct clk_onecell_data clk_data;
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
