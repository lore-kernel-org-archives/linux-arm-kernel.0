Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF10C282CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:33:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90AB620855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TIoN69Zz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="F+uqjAbn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90AB620855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=zG7p/0JuXyjH9QbMoGVq2+4j3Afy0UR9phpKrJcCiIE=; b=TIoN69ZzFAEWXFbl59hb6xHfMW
	GhXk53P6/Z7A9isJlg8uh/Qv5tZCY0773FWkXzqds0CVs/EJHVRKxRI1y2ySb25a0iuzFN5bKno9Q
	H3v89CV2j3oJMztThgczjcqKrFkBYha+t73qu90QwCzyX5VTNySxoDHgZG7T4oCofpYh/iaRe23jl
	kTX148zCjYZR3mVRNMlfTfP4PMsPstROD/s4skRxgrIji1uNiVrShE2pG88yster6o7Fd30bKkqgs
	WVcCL4TvW0f/vbUuhUsW3zNiPENTX9SuvOE8pR3UYTL+V1cn8vaI98f3+RHVN0ZxmuxWGlcXSJ8vO
	q38I4C4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goBj6-0005rb-6C; Mon, 28 Jan 2019 18:33:44 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goBih-0005Y7-9F
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 18:33:20 +0000
Received: by mail-wr1-x441.google.com with SMTP id r10so19194219wrs.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 10:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=g60ZjpL7981mWpyGrLVdtBfYDiHQgHKtcJ+DI6e0xyM=;
 b=F+uqjAbnKbzSB8lfWnOU2J3SGhkWEVCMLZC3sUtR3HXaCnr1T3kqZPUPHf/YumVdKC
 Sq6oGx60KrbI/cxgTud27xWXcH66R026zdPHMhZ40kP5o8pcYYEGX0Plh5TLzLpm/0pn
 y2E4NXreMTTrwKoHhHrk3QbTvRY2WfofqEXz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=g60ZjpL7981mWpyGrLVdtBfYDiHQgHKtcJ+DI6e0xyM=;
 b=hBkR+Zbp2FAA9WEjXXGyCrjL4veUxTr2EE6kfiSfyIVVILovZBJV1RK31Cfn+EV87A
 WUwitJl/ujCxaTfZB3TOHY6fDjKLBP0mdMvt4htTXblF5oBnJduypynU27sMPvOsks1J
 gFbMG9l4mSCumHChGxM5t6Hkoc9uGugIQR8V2Z5I3U1j+Fc7m9ybPp5YiJZHsxkNJJ39
 WXinorSv5pVMTj+xvHlljz6Ldq4qaJYeQXTA8/8LV1ZzrJ9/grOp1VE5lwUr2z6PNLbG
 kLgVsCdfUBosDEK98ifwgM5n2slc/MdMvJ7aKFrdq3VvInbmxtb0ORJNJZm8WocylFpd
 j4MA==
X-Gm-Message-State: AJcUukdHOv1l1Hpb/cgITAUslz/knUp4MD2xNB6J2BIhFEx/jeH2Sx2O
 2XEfM5rEfs+Qe6NYwkabCH9x1A==
X-Google-Smtp-Source: ALg8bN4SRXJFb7sF6JfwvIIY+PbZNdJ3774v6FxX3VzvIw1l7b+hlY9AIM0B9i5z3hedHzuDb8SXDQ==
X-Received: by 2002:adf:cd0e:: with SMTP id w14mr23694468wrm.218.1548700397788; 
 Mon, 28 Jan 2019 10:33:17 -0800 (PST)
Received: from localhost.localdomain (233.red-81-47-145.staticip.rima-tde.net.
 [81.47.145.233])
 by smtp.gmail.com with ESMTPSA id l19sm270082wme.21.2019.01.28.10.33.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 28 Jan 2019 10:33:17 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To: jorge.ramirez-ortiz@linaro.org, sboyd@kernel.org,
 bjorn.andersson@linaro.org, andy.gross@linaro.org, david.brown@linaro.org,
 jassisinghbrar@gmail.com, mark.rutland@arm.com, mturquette@baylibre.com,
 robh+dt@kernel.org, will.deacon@arm.com, arnd@arndb.de,
 horms+renesas@verge.net.au, heiko@sntech.de, sibis@codeaurora.org,
 enric.balletbo@collabora.com, jagan@amarulasolutions.com, olof@lixom.net
Subject: [PATCH v2 01/14] clk: qcom: gcc: limit GPLL0_AO_OUT operating
 frequency
Date: Mon, 28 Jan 2019 19:32:48 +0100
Message-Id: <1548700381-22376-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_103319_323121_3974EBC9 
X-CRM114-Status: GOOD (  13.65  )
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
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 khasim.mohammed@linaro.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, linux-clk@vger.kernel.org, vkoul@kernel.org,
 niklas.cassel@linaro.org, georgi.djakov@linaro.org,
 linux-arm-kernel@lists.infradead.org
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
 drivers/clk/qcom/clk-alpha-pll.c | 8 ++++++++
 drivers/clk/qcom/clk-alpha-pll.h | 1 +
 drivers/clk/qcom/gcc-qcs404.c    | 3 ++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 0ced4a5..ef51f30 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -730,6 +730,14 @@ static long alpha_pll_huayra_round_rate(struct clk_hw *hw, unsigned long rate,
 	return alpha_huayra_pll_round_rate(rate, *prate, &l, &a);
 }
 
+const struct clk_ops clk_alpha_pll_fixed_ops = {
+	.enable = clk_alpha_pll_enable,
+	.disable = clk_alpha_pll_disable,
+	.is_enabled = clk_alpha_pll_is_enabled,
+	.recalc_rate = clk_alpha_pll_recalc_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_fixed_ops);
+
 const struct clk_ops clk_alpha_pll_ops = {
 	.enable = clk_alpha_pll_enable,
 	.disable = clk_alpha_pll_disable,
diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
index 66755f0..6b4eb74 100644
--- a/drivers/clk/qcom/clk-alpha-pll.h
+++ b/drivers/clk/qcom/clk-alpha-pll.h
@@ -104,6 +104,7 @@ struct alpha_pll_config {
 };
 
 extern const struct clk_ops clk_alpha_pll_ops;
+extern const struct clk_ops clk_alpha_pll_fixed_ops;
 extern const struct clk_ops clk_alpha_pll_hwfsm_ops;
 extern const struct clk_ops clk_alpha_pll_postdiv_ops;
 extern const struct clk_ops clk_alpha_pll_huayra_ops;
diff --git a/drivers/clk/qcom/gcc-qcs404.c b/drivers/clk/qcom/gcc-qcs404.c
index 64da032..7de4fcf 100644
--- a/drivers/clk/qcom/gcc-qcs404.c
+++ b/drivers/clk/qcom/gcc-qcs404.c
@@ -304,6 +304,7 @@ static struct clk_alpha_pll gpll0_out_main = {
 	},
 };
 
+
 static struct clk_alpha_pll gpll0_ao_out_main = {
 	.offset = 0x21000,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
@@ -316,7 +317,7 @@ static struct clk_alpha_pll gpll0_ao_out_main = {
 			.parent_names = (const char *[]){ "cxo" },
 			.num_parents = 1,
 			.flags = CLK_IS_CRITICAL,
-			.ops = &clk_alpha_pll_ops,
+			.ops = &clk_alpha_pll_fixed_ops,
 		},
 	},
 };
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
