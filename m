Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CC6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:07:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 395672070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UWAO/1RE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4BBI0l6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 395672070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Lme+ZX0FmpuZC9c1zS/vi/qC8GsLb3lQCXCLmccddxU=; b=UWAO/1REIkFwUV
	2mQ1zJl2BkGCAm9FK4XlWSfUwM2huM5bjSc7IuOPW+2d5dTg/N4/SQDYb/3N9TuEgSXb6As5H5uxN
	IoMOXQZLIqJTQFAgGilVRZww/BYNoUWtacUlY2Fk/r5VvZ+PVxYIRk00uj5G3wqlXtgan2nBhiihE
	QBrKcBtUURCn2inCtiiHgwoCcycHP8hznaHFz0rxRtJWQ0ubHXw9qpqW61geDyVfOQaWadWH1uI2q
	ckeNXJeuBUofxQL0+UX2UMCrOeQYYN/1Yk2TnwgW9qmhJvQY0SD5FNF2JknYdWtZVgV8fZhjOcYaw
	npV2mR2qm+ZY1s7wgD2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxFEX-0002Is-Bd; Fri, 22 Feb 2019 18:07:37 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxFET-0002Ib-Qu
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 18:07:35 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 72D5F2070D;
 Fri, 22 Feb 2019 18:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550858853;
 bh=lVBDw95zHZa7dGOBQdWkGmMDmy8OWapPmrDb+KHaBOk=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=k4BBI0l6kg0D10PoOHO+xaFm6akiflggRnImUDKHvPV5OoggLuhgE6qHOqzzLrWjl
 CPB0gwalGaiqiXeIiOaevcX74ws7QLezLjvqlDKiUNLH/gAhZNAU3Mu4NXksVKaHIM
 dH+SuyNmqHR+80n4iFjdLEkiw9uV0SYkiCAZ1+gw=
MIME-Version: 1.0
Subject: Re: [PATCH v2 01/14] clk: qcom: gcc: limit GPLL0_AO_OUT operating
 frequency
Message-ID: <155085885277.77512.880525447229804781@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1548700381-22376-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1548700381-22376-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
To: andy.gross@linaro.org, arnd@arndb.de, bjorn.andersson@linaro.org,
 david.brown@linaro.org, enric.balletbo@collabora.com, heiko@sntech.de,
 horms+renesas@verge.net.au, jagan@amarulasolutions.com,
 jassisinghbrar@gmail.com, jorge.ramirez-ortiz@linaro.org, mark.rutland@arm.com,
 mturquette@baylibre.com, olof@lixom.net, robh+dt@kernel.org,
 sibis@codeaurora.org, will.deacon@arm.com
Date: Fri, 22 Feb 2019 10:07:32 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_100733_880850_4407F10A 
X-CRM114-Status: UNSURE (   9.22  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Jorge Ramirez-Ortiz (2019-01-28 10:32:48)
> Limit the GPLL0_AO_OUT_MAIN operating frequency as per its hardware
> specifications.
> 
> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

Acked-by: Stephen Boyd <sboyd@kernel.org>

> diff --git a/drivers/clk/qcom/gcc-qcs404.c b/drivers/clk/qcom/gcc-qcs404.c
> index 64da032..7de4fcf 100644
> --- a/drivers/clk/qcom/gcc-qcs404.c
> +++ b/drivers/clk/qcom/gcc-qcs404.c
> @@ -304,6 +304,7 @@ static struct clk_alpha_pll gpll0_out_main = {
>         },
>  };
>  
> +

Please remove this stray hunk though.

>  static struct clk_alpha_pll gpll0_ao_out_main = {
>         .offset = 0x21000,
>         .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
