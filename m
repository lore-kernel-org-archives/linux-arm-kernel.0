Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93945C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:51:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 642C620850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c88h610f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642C620850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=USvZ8XwSQBLQSP4d/357kDw+k0RclZoSxXiPMFZZXXk=; b=c88h610fVPONDg
	kgkEwUb60sTzQAxxGTMg3KmkOnbDHk/ktr+CckoxgkCai2I/nVH2Enf1rj6uj3Gxq2IU65/cI/Zb6
	XV8wxI5AoVIDk5+Ua95lCDyInRyz5xcvmXzHlmgyO/UBZWRkTqi9ZV+ZlmD88zfFduKdui2eC2GDf
	zkobSWIVP3rsc0nY0E9YMvh8vZRCE3IR49944DCiQk+lzJvsD5V4u1SA/HBFetr3LFW4vIivBUnPj
	6DaOQLtW4GmlLHfv0nkSnqpnABvcoP74Fo1joZlP5koZb35Qi6RlvqVPBi3JXqYiGOhtqb9fd7H9Y
	urG6GVDK8ab8S++trRUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUdCR-00012a-GH; Wed, 05 Dec 2018 19:51:11 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUdCN-00010I-Nq
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 19:51:09 +0000
Received: by mail-ot1-f68.google.com with SMTP id u16so19816778otk.8
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 11:50:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qMf/8b8HPdVUaDDlxlxbmj1xfhA6XtWizfCJKwehYSU=;
 b=YJwlS0pGM7yYm+Xj8Sx1lECI2JtXLHLdZBRgSazGkoTheaOXYlfKfBXtOsPM1Vhw7c
 yR8o/BDvCY+FVeqQzyqXIU94JjY8Z/RihR9pRnereIhCfmjP+in7h7fyAE2Swk5OxHer
 T0mYPj+5Hsb876VhijaR8nEoxZ9xTMRc8CBrlfH7RkNjzFNDMi2ZpuJnXS/H8rZEoQMQ
 QmUCbJ/J4inntjYzoTph8Ts9UZDQHIf/JiMm1SHAAo1/zhIu9P4o5AjmVR/01GMuRMrS
 qo6x+8KwGDzMSXqoa2vH+CmhcjgnzqLgjSVu60RXNLokC2NFWlbGB+m2sJ9QnL0afr4S
 yBcw==
X-Gm-Message-State: AA+aEWa4Xx6HLQepqFBgv7fk/5AoDu7k7KqPWvdiGSVGy1d0FlSMvQVE
 ANTYskanwj+HWUY+i/3kVQ==
X-Google-Smtp-Source: AFSGD/Uto0OjqNOmEsHFK57ZDUo6dZJqoQDrNSvkN0UuQUlPmALMlrnVcywX5kxxgjKsaDeXw7i4cg==
X-Received: by 2002:a9d:5e0b:: with SMTP id d11mr15115452oti.145.1544039456498; 
 Wed, 05 Dec 2018 11:50:56 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.50.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 11:50:55 -0800 (PST)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] clk: Use of_node_name_eq for node name comparisons
Date: Wed,  5 Dec 2018 13:50:21 -0600
Message-Id: <20181205195050.4759-5-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_115107_776711_18885FA1 
X-CRM114-Status: GOOD (  13.17  )
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
Cc: linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Tero Kristo <t-kristo@ti.com>,
 linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

For instances using of_node_cmp, this has the side effect of now using
case sensitive comparisons. This should not matter for any FDT based
system which all of these are.

Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-renesas-soc@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Cc: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/clk/renesas/clk-mstp.c   |  2 +-
 drivers/clk/ti/clkctrl.c         |  2 +-
 drivers/clk/ti/dpll.c            |  2 +-
 drivers/clk/ux500/u8500_of_clk.c | 10 +++++-----
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/renesas/clk-mstp.c b/drivers/clk/renesas/clk-mstp.c
index 1c1768c2cc82..765175d1148a 100644
--- a/drivers/clk/renesas/clk-mstp.c
+++ b/drivers/clk/renesas/clk-mstp.c
@@ -280,7 +280,7 @@ int cpg_mstp_attach_dev(struct generic_pm_domain *unused, struct device *dev)
 			goto found;
 
 		/* BSC on r8a73a4/sh73a0 uses zb_clk instead of an mstp clock */
-		if (!strcmp(clkspec.np->name, "zb_clk"))
+		if (of_node_name_eq(clkspec.np, "zb_clk"))
 			goto found;
 
 		of_node_put(clkspec.np);
diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
index 469f560ae1cf..40630eb950fc 100644
--- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -448,7 +448,7 @@ static void __init _ti_omap4_clkctrl_setup(struct device_node *node)
 	char *c;
 
 	if (!(ti_clk_get_features()->flags & TI_CLK_CLKCTRL_COMPAT) &&
-	    !strcmp(node->name, "clk"))
+	    of_node_name_eq(node, "clk"))
 		ti_clk_features.flags |= TI_CLK_CLKCTRL_COMPAT;
 
 	addrp = of_get_address(node, 0, NULL, NULL);
diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
index 92e28af7afba..6c3329bc116f 100644
--- a/drivers/clk/ti/dpll.c
+++ b/drivers/clk/ti/dpll.c
@@ -410,7 +410,7 @@ static void __init of_ti_omap3_dpll_setup(struct device_node *node)
 
 	if ((of_machine_is_compatible("ti,omap3630") ||
 	     of_machine_is_compatible("ti,omap36xx")) &&
-	    !strcmp(node->name, "dpll5_ck"))
+	     of_node_name_eq(node, "dpll5_ck"))
 		of_ti_dpll_setup(node, &omap3_dpll5_ck_ops, &dd);
 	else
 		of_ti_dpll_setup(node, &omap3_dpll_ck_ops, &dd);
diff --git a/drivers/clk/ux500/u8500_of_clk.c b/drivers/clk/ux500/u8500_of_clk.c
index d5888591e1a9..18a3c4522831 100644
--- a/drivers/clk/ux500/u8500_of_clk.c
+++ b/drivers/clk/ux500/u8500_of_clk.c
@@ -545,21 +545,21 @@ static void u8500_clk_init(struct device_node *np)
 	for_each_child_of_node(np, child) {
 		static struct clk_onecell_data clk_data;
 
-		if (!of_node_cmp(child->name, "prcmu-clock")) {
+		if (of_node_name_eq(child, "prcmu-clock")) {
 			clk_data.clks = prcmu_clk;
 			clk_data.clk_num = ARRAY_SIZE(prcmu_clk);
 			of_clk_add_provider(child, of_clk_src_onecell_get, &clk_data);
 		}
-		if (!of_node_cmp(child->name, "prcc-periph-clock"))
+		if (of_node_name_eq(child, "prcc-periph-clock"))
 			of_clk_add_provider(child, ux500_twocell_get, prcc_pclk);
 
-		if (!of_node_cmp(child->name, "prcc-kernel-clock"))
+		if (of_node_name_eq(child, "prcc-kernel-clock"))
 			of_clk_add_provider(child, ux500_twocell_get, prcc_kclk);
 
-		if (!of_node_cmp(child->name, "rtc32k-clock"))
+		if (of_node_name_eq(child, "rtc32k-clock"))
 			of_clk_add_provider(child, of_clk_src_simple_get, rtc_clk);
 
-		if (!of_node_cmp(child->name, "smp-twd-clock"))
+		if (of_node_name_eq(child, "smp-twd-clock"))
 			of_clk_add_provider(child, of_clk_src_simple_get, twd_clk);
 	}
 }
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
