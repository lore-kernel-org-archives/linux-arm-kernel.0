Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07BEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:04:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B97C12080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bPJseNqI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNM5Vu7i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B97C12080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qLv4zS3GE7O2qwABf8ftM0XZhfNGMzPQZgrC7OJ5nwQ=; b=bPJseNqIyNEfaG
	wThUcqG/AQL6/2wX3574zqPbvw/n9b+fNEN0gYFkJIYurKaJqur/s4UhIqvf4PO4z69psMNh9VydA
	JlDlW/aG06/1yj1RKQC6aFtQqvdetrDX3rRDMD+dN0MWt43oW6kHDHeWtfe69kVdkzQeryo76dxZw
	3VpfygMdluYtvTHSJWOe2F6M7o916OUe7rp7bDXKHS+SJKHEUQ3sRk+X7ncKf9Y27lSR+6LSNcLRY
	Xl2VHJ7RPrZ+oeHt5uk5T1j0N8aCKz1qhQygJk26zrdw+ELj8YbvzwtchBAds9ookW/68TA87ChmE
	jbnQraiF2vP7XP/C98Vg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwvVp-0002Yc-I6; Thu, 21 Feb 2019 21:04:09 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwvVm-0002Y6-0i
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 21:04:08 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 26F302080F;
 Thu, 21 Feb 2019 21:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550783045;
 bh=LVNSGutw7y8qvRN3QsA20dH6WHZDVoufvm82CD+w6gQ=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=sNM5Vu7ilTa3f7UdkLZ1o5snZMvOqjji+L6HdMtkkmP6TTqkUZZOSiixzLW9zJKBZ
 9PO0Y6R/WSaipiUjz3rAqHfktSzW/Ik9uSnDfrF/jU1djkPZrzxJIvB1Wzh+MlKqic
 Q/niMtzbXMlMfO0th/FqlD/+EJMBTxl+ajtDAVNk=
MIME-Version: 1.0
Subject: Re: [RESEND] clk: imx: Refactor entire sccg pll clk
Message-ID: <155078304428.77512.12422358164048389195@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <1550481854-14338-1-git-send-email-abel.vesa@nxp.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1550481854-14338-1-git-send-email-abel.vesa@nxp.com>
To: Abel Vesa <abel.vesa@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>,
 Anson Huang <anson.huang@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Jacky Bai <ping.bai@nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>, Mike Turquette <mturquette@baylibre.com>,
 Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Date: Thu, 21 Feb 2019 13:04:04 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_130406_091926_414DCD20 
X-CRM114-Status: GOOD (  13.83  )
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Abel Vesa <abel.vesa@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Abel Vesa (2019-02-18 01:24:33)
> Make the entire combination of plls to be one single clock. The parents used
> for bypasses are specified each as an index in the parents list.
> The determine_rate does a lookup throughout all the possible combinations
> for all the divs and returns the best possible 'setup' which in turn is used
> by set_rate later to set up all the divs and bypasses.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Tested-by: Lucas Stach <l.stach@pengutronix.de>
> Acked-by: Lucas Stach <l.stach@pengutronix.de>
> ---
> 
> This is basically just a resend of the following:
> https://lkml.org/lkml/2019/1/29/874
> 
> There are no changes. Just added T-b and A-b tags from Lucas.
> 
> Waiting for review.

Spoke too soon. I've kicked this out of the tree. This doesn't compile
and spews a bunch of sparse warnings on arm32. Presumably because the
use of unsigned long was assuming 64 bits in size? Please write portable
code and fix these sparse warnings. Probably all the unsigned long usage
should be u64?

drivers/clk/imx/clk-sccg-pll.c:142:53: warning: decimal constant 2400000000 is between LONG_MAX and ULONG_MAX. For C99 that means long long, C90 compilers are very likely to produce unsigned long (and a warning) here
drivers/clk/imx/clk-sccg-pll.c:199:48: warning: decimal constant 2400000000 is between LONG_MAX and ULONG_MAX. For C99 that means long long, C90 compilers are very likely to produce unsigned long (and a warning) here
drivers/clk/imx/clk-sccg-pll.c:138:17: error: incompatible types in comparison expression (different type sizes)
drivers/clk/imx/clk-sccg-pll.c:144:25: error: incompatible types in comparison expression (different type sizes)
drivers/clk/imx/clk-sccg-pll.c:180:17: error: incompatible types in comparison expression (different type sizes)
drivers/clk/imx/clk-sccg-pll.c:217:17: error: incompatible types in comparison expression (different type sizes)
drivers/clk/imx/clk-sccg-pll.c:239:17: error: incompatible types in comparison expression (different type sizes)
drivers/clk/imx/clk-sccg-pll.c:138:17: warning: shift too big (32) for type unsigned long
drivers/clk/imx/clk-sccg-pll.c:144:25: warning: shift too big (32) for type unsigned long
drivers/clk/imx/clk-sccg-pll.c:180:17: warning: shift too big (32) for type unsigned long
drivers/clk/imx/clk-sccg-pll.c:217:17: warning: shift too big (32) for type long
drivers/clk/imx/clk-sccg-pll.c:239:17: warning: shift too big (32) for type unsigned long
In file included from arch/arm/include/asm/div64.h:127:0,
                 from include/linux/kernel.h:207,
                 from include/asm-generic/bug.h:18,
                 from arch/arm/include/asm/bug.h:60,
                 from include/linux/bug.h:5,
                 from include/linux/io.h:23,
                 from include/linux/clk-provider.h:9,
                 from drivers/clk/imx/clk-sccg-pll.c:11:
drivers/clk/imx/clk-sccg-pll.c: In function 'clk_sccg_divq_lookup':
include/asm-generic/div64.h:222:28: warning: comparison of distinct pointer types lacks a cast
  (void)(((typeof((n)) *)0) == ((uint64_t *)0)); \  
                            ^

> @@ -347,14 +319,12 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
>         clks[IMX8MQ_AUDIO_PLL2_BYPASS] = imx_clk_mux("audio_pll2_bypass", base + 0x8, 14, 1, audio_pll2_bypass_sels, ARRAY_SIZE(audio_pll2_bypass_sels));
>         clks[IMX8MQ_VIDEO_PLL1_BYPASS] = imx_clk_mux("video_pll1_bypass", base + 0x10, 14, 1, video_pll1_bypass_sels, ARRAY_SIZE(video_pll1_bypass_sels));
>  
> -       clks[IMX8MQ_SYS1_PLL1_OUT] = imx_clk_mux("sys1_pll1_out", base + 0x30, 5, 1, sys1_pll1_out_sels, ARRAY_SIZE(sys1_pll1_out_sels));
> -       clks[IMX8MQ_SYS2_PLL1_OUT] = imx_clk_mux("sys2_pll1_out", base + 0x3c, 5, 1, sys2_pll1_out_sels, ARRAY_SIZE(sys2_pll1_out_sels));
> -       clks[IMX8MQ_SYS3_PLL1_OUT] = imx_clk_mux("sys3_pll1_out", base + 0x48, 5, 1, sys3_pll1_out_sels, ARRAY_SIZE(sys3_pll1_out_sels));
> -       clks[IMX8MQ_DRAM_PLL1_OUT] = imx_clk_mux("dram_pll1_out", base + 0x60, 5, 1, dram_pll1_out_sels, ARRAY_SIZE(dram_pll1_out_sels));
> -       clks[IMX8MQ_SYS1_PLL2_OUT] = imx_clk_mux("sys1_pll2_out", base + 0x30, 4, 1, sys1_pll2_out_sels, ARRAY_SIZE(sys1_pll2_out_sels));
> -       clks[IMX8MQ_SYS2_PLL2_OUT] = imx_clk_mux("sys2_pll2_out", base + 0x3c, 4, 1, sys2_pll2_out_sels, ARRAY_SIZE(sys2_pll2_out_sels));
> -       clks[IMX8MQ_SYS3_PLL2_OUT] = imx_clk_mux("sys3_pll2_out", base + 0x48, 4, 1, sys3_pll2_out_sels, ARRAY_SIZE(sys3_pll2_out_sels));
> -       clks[IMX8MQ_DRAM_PLL2_OUT] = imx_clk_mux("dram_pll2_out", base + 0x60, 4, 1, dram_pll2_out_sels, ARRAY_SIZE(dram_pll2_out_sels));
> +       /* unbypass all the plls */
> +       clk_set_parent(clks[IMX8MQ_GPU_PLL_BYPASS], clks[IMX8MQ_GPU_PLL]);
> +       clk_set_parent(clks[IMX8MQ_VPU_PLL_BYPASS], clks[IMX8MQ_VPU_PLL]);
> +       clk_set_parent(clks[IMX8MQ_AUDIO_PLL1_BYPASS], clks[IMX8MQ_AUDIO_PLL1]);
> +       clk_set_parent(clks[IMX8MQ_AUDIO_PLL2_BYPASS], clks[IMX8MQ_AUDIO_PLL2]);
> +       clk_set_parent(clks[IMX8MQ_VIDEO_PLL1_BYPASS], clks[IMX8MQ_VIDEO_PLL1]);

Why? Can you just write the hardware registers directly instead of going
through the clk APIs during this clk registration routine? While it's
obviously easier to just call consumer APIs, it makes it weird because
this is a clk provider driver which 1) shouldn't use the consumer APIs
and 2) makes probe ordering and other things complicated to figure out.
Plus one more extra, it means that changing this code to use the clk_hw
APIs is harder.

>  
>         /* PLL OUT GATE */
>         clks[IMX8MQ_ARM_PLL_OUT] = imx_clk_gate("arm_pll_out", "arm_pll_bypass", base + 0x28, 21);

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
