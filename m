Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E364C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:42:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E38120879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ukzFBNgp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDY7y0CN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E38120879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GmeBDG0FDDxtDqgP39Ff1zMEUT3vUzWa3z7NNggsumo=; b=ukzFBNgpw3dN/M
	F72fqRu0QUJ/omBm5UGpVGfywSCjEk1QQNC6pmCfi2/j8+CWZxjZtGCShfIL5xV7C8rYu3UXgBG5m
	0T2LP1C2QMJLlfeIA8d+EIiRMBbS6jPk9itzD+gHEwm8loJhLbWPV7GUxeb5OW41yFNj6YsfkZeev
	nXJK1Lo/LbZ6WMi6WLOyKmpgGcStzt/ZKWmBm980OypLOGOT1MNgQeJquXycv7J28XvXktq6YJ7GS
	qMlBqI6NdvBJDh9MZzT8GcIRWEcxmsOWVZ21K48PsCjxhtKei21tY3ngxwcZm+QkFQr1Z3SDae9UZ
	E7B/F7HxI0zSlepfNJcQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUewS-0006ge-6m; Wed, 05 Dec 2018 21:42:48 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUewO-00069y-K9
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 21:42:46 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1A68420879;
 Wed,  5 Dec 2018 21:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544046154;
 bh=MgnwmwdYfJixQAF6HDPIj+Fb5hH53DfTpjPdswBr7GU=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=KDY7y0CNGBvsOt+7HxotDHM/KV8QuDaRFmvxe5Rkjy5P+bnRXlIv8JSgC/Fi4xLjf
 ccuz1enNa1ThH1luXSartgOuACfeNVcoQox6w2wiS7WHL9XMzLtufYAnPv9fux25NO
 Fjjg75btVki353saZhCteKBPvz2rG4JuD3mcyRAQ=
MIME-Version: 1.0
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
 Jeffrey Hugo <jhugo@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
X-Patchwork-Hint: ignore
In-Reply-To: <14cad8f0-7388-16a0-b1ba-4cd5a469a17e@codeaurora.org>
References: <1542314695-24071-1-git-send-email-jhugo@codeaurora.org>
 <1542314695-24071-2-git-send-email-jhugo@codeaurora.org>
 <b50bc3d4-f80b-6adb-c28b-1be254eb7e16@free.fr>
 <0ba54ffd-1d47-5ae9-ae9c-4a03d57e6ff3@codeaurora.org>
 <20181205164843.GB1492@tuxbook-pro>
 <05b9ee40-d51e-3f80-8ca4-217fa6fbd51c@codeaurora.org>
 <154404384283.88331.2522037578224950651@swboyd.mtv.corp.google.com>
 <14cad8f0-7388-16a0-b1ba-4cd5a469a17e@codeaurora.org>
Message-ID: <154404615332.88331.10043835293734703587@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: msm8998: correct xo clock name
Date: Wed, 05 Dec 2018 13:42:33 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_134244_699758_2BFAF041 
X-CRM114-Status: GOOD (  20.84  )
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
Cc: Andy Gross <andy.gross@linaro.org>, MSM <linux-arm-msm@vger.kernel.org>,
 Georgi Djakov <georgi.djakov@linaro.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Marc Gonzalez <marc.w.gonzalez@free.fr>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Jeffrey Hugo (2018-12-05 13:20:07)
> On 12/5/2018 2:04 PM, Stephen Boyd wrote:
> > Quoting Jeffrey Hugo (2018-12-05 09:03:54)
> > 
> > I don't quite understand the patch in general. The xo_board clk should
> > always exist in DT and the fixed factor clk in GCC is there until the
> > rpm clk driver can control the XO clk state vote for the kernel.
> 
> Sorry, this wasn't apparent.  It doesn't seem like this "requirement" is 
> captured anywhere.

Agreed!

> 
> As far as the SD clocks are concerned, they are defined in GCC, and 
> eventually have a root parent called "xo".  "xo" isn't defined anywhere, 
> so the SD clocks can't really be used, and the hardware doesn't come up. 
>   This patch "fixed" that, but I missed the link to the rpm driver that 
> Marc pointed out.

Hmm ok. The SD DT node should just point to the xo_board clk for now and
later on it can be changed to use the rpm clk when the rpm node is
created.

> 
> 
> > 
> > If anything, change the DT node to be named xo-board instead of xo_board
> > because that matches DT naming schemes and then add a clock-output-names
> > = "xo_board" property to it so that we keep the underscore.
> 
> I see this now, and I agree with it, but then SD goes back to a broken 
> state because there is "xo" clock for GCC.  Its not quite clear to me 
> how to make GCC (and thus SD) happy again with this change reverted/fixed.
> 
> Bjorn mentioned offline he is going to take a look, but he has a few 
> other things on his plate first.
> 

There is an XO clk created in drivers/clk/qcom/gcc-msm8996.c, we should
do the same here until rpm can handle this. I'll pack this patch up and
merge it to clk-next soon.

----8<----
diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
index c3bb9fffd040..d72b908137e2 100644
--- a/drivers/clk/qcom/gcc-msm8998.c
+++ b/drivers/clk/qcom/gcc-msm8998.c
@@ -117,6 +117,17 @@ static const char * const gcc_parent_names_5[] = {
 	"core_bi_pll_test_se",
 };
 
+static struct clk_fixed_factor xo = {
+	.mult = 1,
+	.div = 1,
+	.hw.init = &(struct clk_init_data){
+		.name = "xo",
+		.parent_names = (const char *[]){ "xo_board" },
+		.num_parents = 1,
+		.ops = &clk_fixed_factor_ops,
+	},
+};
+
 static struct pll_vco fabia_vco[] = {
 	{ 250000000, 2000000000, 0 },
 	{ 125000000, 1000000000, 1 },
@@ -2798,6 +2809,10 @@ static int gcc_msm8998_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = devm_clk_hw_register(&pdev->dev, &xo.hw);
+	if (ret)
+		return ret;
+
 	return qcom_cc_really_probe(pdev, &gcc_msm8998_desc, regmap);
 }
 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
