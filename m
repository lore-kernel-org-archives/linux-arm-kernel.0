Return-Path: <SRS0=jr7z=PG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC9CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 13:35:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFF3020828
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 13:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LNbidKGf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+DdWSYT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF3020828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=G/R/kADQ8PwbXhHL9UErQELTpTHe1JjJ4GeKgR1OlM0=; b=LNbidKGfVoLirVxYqXRuBk2VPr
	sCnflHh2aMPyDSmCyj94krv1x+1PHcmp/i9fL6XTtlax0HjggG0RypvAwi98qSM7N2jhxVdiDrhDI
	jCUECe7ZxHekpCE7Ux6jLqFHPJvnvaWBXlf/Kcp1+RWBgmGFm0VOk0BfeDHQh+3jFQ4VCFzeU2oP7
	dur0ryXBtodKseET6Myc8F2o7d2aYLDA6lwaDSwgSXwwRwCATLtzdiL04fx9BdE5yFEpO6y0J/XWX
	sV2oYhKUQDKs0p9gvksoJRMcivcfFqewj+8K+mpE9IuE8Xn2qlu2OkiLJOtnDYwOIT93BM++wNXor
	8LdPD5Ew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gdElq-0007Mx-52; Sat, 29 Dec 2018 13:35:18 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gdEkM-0005P7-Ku; Sat, 29 Dec 2018 13:33:48 +0000
Received: by mail-ed1-x544.google.com with SMTP id f9so19436063eds.10;
 Sat, 29 Dec 2018 05:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=k13CwrRPNYtJ7lsBiqAPPxCzsrGsqSruGobJNVs9boI=;
 b=p+DdWSYTbMvZE4LFQPsS6oE3GVU6PQDwjPmWN+PrO/Iz4TH85TuBV+m7hxMxUpuDJc
 ePPxDJVifCgfZmmIrGbg6t5oEJaWi1mcjktZJ9KHA1APIeWvQBBp588sUn4CXl7d7zJ2
 qWyQns6xOycA53X4BJCGVUru4e4KA3JXy/h4Y/N4FfQQWTiUvTRfH0DxKZDaVd7EL0Rx
 qGbPCEOg6dvmFvcuJc09+fsSQPcXFHHLBibUalcQjelIz7RakmFrS52tPMnu2RoNrXCR
 vvVJTzDtRbT3yCm6vHBOfgJEEpk0yDfypVW/Y3po6/KReXNK5OHGAvRQ6/CMma4ljBt4
 r4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=k13CwrRPNYtJ7lsBiqAPPxCzsrGsqSruGobJNVs9boI=;
 b=DNvU5ant/dv8HSClAYSQchbOPYwioGZeBMvGFzNq3qIpm8k8habai22bYnnDWVhBUC
 Xncr7f+Bavzqr/mbxs6Xi53bbGSXL19ptv8aGfhBdRoehdIu5euMOyTP5vb3ukHcFqI0
 jAAW/n/mAxCdxEC6kqss5qy2dZdin55mEhLbv+JU6hnKi3IJzp5MfCrk4ZnY/c0kqVQi
 d+9bc1ujIhb3WtYAPgKZpDdJ5xyu23fCUlkxIqeEaF8Jj2Q0nr+aUOLXvzTTddp+LgNQ
 Be7Fm+xJTZXyUdx35D4bIBzDls87LT687diTpSw8OYURhKCMZk14G7xdGeC0lyEUso/i
 AU9Q==
X-Gm-Message-State: AA+aEWbQcjb3NPmKHAzTEdS3+dqrJ9x9vlSKnHJmJHfRwCxd2crXqMG3
 vM8NxsogEZ/v+Uf6B3qc6FU=
X-Google-Smtp-Source: AFSGD/US03gx33a/c6v1zDMgPDz3TADuJ8aHK0/wmFr4DQq1NGUzn6qTteSs59fkUtLoGtj5t6/hJA==
X-Received: by 2002:aa7:d29a:: with SMTP id w26mr26300545edq.30.1546090414971; 
 Sat, 29 Dec 2018 05:33:34 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id d7-v6sm8023063ejx.68.2018.12.29.05.33.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 29 Dec 2018 05:33:34 -0800 (PST)
From: Johan Jonker <jbx6244@gmail.com>
To: heiko@sntech.de
Subject: [PATCH v2 2/7] clk: rockchip: rk3188: add CLK_SET_RATE_PARENT for
 lcdc dclk
Date: Sat, 29 Dec 2018 14:33:13 +0100
Message-Id: <20181229133318.18128-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181229133318.18128-1-jbx6244@gmail.com>
References: <20181229133318.18128-1-jbx6244@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181229_053346_755546_C0EF550E 
X-CRM114-Status: GOOD (  13.28  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, airlied@linux.ie, mturquette@baylibre.com,
 hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, sboyd@kernel.org, robh+dt@kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Finley Xiao <finley.xiao@rock-chips.com>

Add CLK_SET_RATE_PARENT for lcdc dclk.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/clk/rockchip/clk-rk3188.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index 7ea20341e..5ecf28854 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -586,12 +586,12 @@ static struct rockchip_clk_branch rk3066a_clk_branches[] __initdata = {
 	COMPOSITE(0, "dclk_lcdc0_src", mux_pll_src_cpll_gpll_p, 0,
 			RK2928_CLKSEL_CON(27), 0, 1, MFLAGS, 8, 8, DFLAGS,
 			RK2928_CLKGATE_CON(3), 1, GFLAGS),
-	MUX(DCLK_LCDC0, "dclk_lcdc0", mux_rk3066_lcdc0_p, 0,
+	MUX(DCLK_LCDC0, "dclk_lcdc0", mux_rk3066_lcdc0_p, CLK_SET_RATE_PARENT,
 			RK2928_CLKSEL_CON(27), 4, 1, MFLAGS),
 	COMPOSITE(0, "dclk_lcdc1_src", mux_pll_src_cpll_gpll_p, 0,
 			RK2928_CLKSEL_CON(28), 0, 1, MFLAGS, 8, 8, DFLAGS,
 			RK2928_CLKGATE_CON(3), 2, GFLAGS),
-	MUX(DCLK_LCDC1, "dclk_lcdc1", mux_rk3066_lcdc1_p, 0,
+	MUX(DCLK_LCDC1, "dclk_lcdc1", mux_rk3066_lcdc1_p, CLK_SET_RATE_PARENT,
 			RK2928_CLKSEL_CON(28), 4, 1, MFLAGS),
 
 	COMPOSITE_NOMUX(0, "cif1_pre", "cif_src", 0,
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
