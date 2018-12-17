Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B51CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:47:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D18B20675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MlZkaYCe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ju0aYP9T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D18B20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=7YqL5vK/6RygV55Wrm/aLo4YHQd+DG/6pSE5ID7C5no=; b=MlZkaYCeak8QpnksWS4Z+FFm+y
	WEOjAkLM5BYyh8tSEeh44Ji7g+SLAQ09AZr7USBuaMfy7sqW4jhPWSSXem42nRQi1IPyStVD9sLaz
	W834enzyhtpWD23XylasE4wfRNzf9tKIN9K8mS0d28ex8jr0L/JDXb86tH34kDonV9YrVgd+9oFB/
	8iztLzxCLcSkIUoFY3GsA2g9xmqwxaNeDOnJLnBvUEmyJQepSZiB8vnmdcki5t90M93S7WOHQqWKc
	fN+I2TAezWwS/GJaN6m6lsCyQYm0gAZpY5KSDWj+2U5ka+CjWlSQ2n7LBD+aj5qM4RMKTPSg1bx1Z
	QaR+iwJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYpUk-0006Rv-Nj; Mon, 17 Dec 2018 09:47:26 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYpU8-0005qT-Ua
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 09:46:54 +0000
Received: by mail-wr1-x444.google.com with SMTP id s12so11099639wrt.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 01:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=MAoZVGyUyqIgBFjZmHlB19eSlto0aZoSbTGaZ+uSfto=;
 b=ju0aYP9TwSWXr86I68EvqHSMfznus+2y4taD626AEyJQ8pivkVBFmqA1lZo0dF3+8n
 oMhIBEWw3Ak98UO+qQLaGCcj8vlMp1u0qie8op4+DYKI/rgoSKEXaTxUS0NvD52uSCJt
 EMU5uAVjdn/0rTOdtAPD4+qBGXiDqhE8eN8Mk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=MAoZVGyUyqIgBFjZmHlB19eSlto0aZoSbTGaZ+uSfto=;
 b=SK+UjwUAqB99e7rNDzKMYAmE+MXeOEqMewlDbH1Xdc91M2OHJgXWeZXVDOjLwgjxSv
 cLlat2/gc6e2p93KnvZZealDRAzhCvVK5KcjrEM0Dd385kIaq3ef0OvqB5I63mpDBqAa
 SI63rpMKgwAoZXhH2P/xrSSiNpL7/6eUqi0KKmpLqa+LmqoOGBOSqmwttBdFiabqA1AT
 5MIrxwYeE0t1B3FnyoLts57Vras1zcxZekAtkHT8RsLHu6nT2eYhNyIzUSX5cIUNG9Xt
 BSqwsT6DcDj2qPKgD30NkDwQiDsUbh7clzKGxgDh6RIYlXo1R7F8DOlVW5iecoxgP9Wc
 gD2g==
X-Gm-Message-State: AA+aEWa+T/2FtwdaSXPxWVaJFuNOiaXsyVimCk6ZjLlFP7zUnGwg9ex5
 WOlUppdp1f6fx9GAXd9JHqFhKw==
X-Google-Smtp-Source: AFSGD/Xrh7uK6Mu8+N9b9d9Pgvt1vtXG0aJhPLLByVmwbg+okG7Sa8pkk44ta/5GWQAwOEg8cCvHBw==
X-Received: by 2002:a5d:418b:: with SMTP id m11mr8959307wrp.8.1545039997185;
 Mon, 17 Dec 2018 01:46:37 -0800 (PST)
Received: from localhost.localdomain (58.red-81-47-145.staticip.rima-tde.net.
 [81.47.145.58])
 by smtp.gmail.com with ESMTPSA id h12sm28878113wma.48.2018.12.17.01.46.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 17 Dec 2018 01:46:36 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To: jorge.ramirez-ortiz@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
 andy.gross@linaro.org, david.brown@linaro.org, sboyd@kernel.org,
 will.deacon@arm.com, mturquette@baylibre.com, jassisinghbrar@gmail.com
Subject: [PATCH 01/13] clk: qcom: gcc: limit GPLL0_AO_OUT operating frequency
Date: Mon, 17 Dec 2018 10:46:18 +0100
Message-Id: <1545039990-19984-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_014649_149673_3D9B4E68 
X-CRM114-Status: GOOD (  11.64  )
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
Cc: devicetree@vger.kernel.org, heiko@sntech.de, arnd@arndb.de, olof@lixom.net,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, bjorn.andersson@linaro.org,
 enric.balletbo@collabora.com, vkoul@kernel.org, sibis@codeaurora.org,
 niklas.cassel@linaro.org, horms+renesas@verge.net.au, georgi.djakov@linaro.org,
 linux-arm-kernel@lists.infradead.org, jagan@amarulasolutions.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Limit the GPLL0_AO_OUT_MAIN operating frequency as per its hardware
specifications.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/clk/qcom/gcc-qcs404.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/qcom/gcc-qcs404.c b/drivers/clk/qcom/gcc-qcs404.c
index 64da032..833436a 100644
--- a/drivers/clk/qcom/gcc-qcs404.c
+++ b/drivers/clk/qcom/gcc-qcs404.c
@@ -304,10 +304,16 @@ static struct clk_alpha_pll gpll0_out_main = {
 	},
 };
 
+static const struct pll_vco gpll0_ao_out_vco[] = {
+	{ 800000000, 800000000, 0 },
+};
+
 static struct clk_alpha_pll gpll0_ao_out_main = {
 	.offset = 0x21000,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
 	.flags = SUPPORTS_FSM_MODE,
+	.vco_table = gpll0_ao_out_vco,
+	.num_vco = ARRAY_SIZE(gpll0_ao_out_vco),
 	.clkr = {
 		.enable_reg = 0x45000,
 		.enable_mask = BIT(0),
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
