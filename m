Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB7FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 11:20:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A18A4218FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 11:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CoDXCVon";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kncOjfiN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="m5UG2fOj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A18A4218FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2c/acgGuwCPvzJLS+vePLqh0djUm4MVL9SgoO8VwM8Q=; b=CoDXCVonFnaACXJIoC/s7LyqL
	htvWWnsdt64d/mA/enB3UB++VBrQ0IRIxCliQ6THDo3C/b6hUG7/aRkbF5zmm3ypwZVzknENMfpNB
	nsoaYhGlx86A8WsygRQ0YmpNLDfsbCuDpci7Md8jt757gJrCxxgIBwLmtVCtx10tsd4VErLIL5PFt
	37y939UV2nRvdpuA2LxQ14JAoXpvj11HBpLywcXHbEHqGqkSYvDhiI+fgE01M8zgSUmCKTuwfLt9F
	PCbQdacM71qU6PvIFMDOWdITmmwowQ2zaHiXMKacfl7wuRpd63nv3i0II6xP004gn9GyBsJciPvPJ
	nP4SGFejQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaIqU-0004Ej-DJ; Fri, 21 Dec 2018 11:19:58 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaIqR-0004Da-AB
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 11:19:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 6E133608C5; Fri, 21 Dec 2018 11:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1545391183;
 bh=EoRquBr4Hj2je3Da64uLThh3DoJ/cG7aKPuvTCCA/KQ=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=kncOjfiNBgQz7n39Z8c9gAzngtx1pi/3vudJ1p9KewXkW8+iDXthf1QC148dRpsW0
 a9mTrQWX2hZ2AaLCqpDNdmJdNx9em163TWv5ZXJmbcG8qFKFWduHEx9qykLzkSsWOF
 mAk34WPJMRGOUDnt6IQG6Q/WS6WtvX9tAR/V3wJA=
Received: from [192.168.225.247] (unknown [49.32.154.203])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: tdas@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 20E5360208;
 Fri, 21 Dec 2018 11:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1545391182;
 bh=EoRquBr4Hj2je3Da64uLThh3DoJ/cG7aKPuvTCCA/KQ=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=m5UG2fOjzR2K5QntPkAGuknOl7Ye0fV8uYoaCvcivDenci76IdrMHgkIMVH8a8rql
 +cS5ot6V4/sxbfauUOe/dni8FIFvA4kM9/vcPj9SxPp/MlaLbhdf7QfHsKqv+6l78g
 moA6sE1BYXC+fOne/mnJImufSIM5RogxK1fvrSmo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 20E5360208
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH 01/13] clk: qcom: gcc: limit GPLL0_AO_OUT operating
 frequency
To: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>, robh+dt@kernel.org, 
 mark.rutland@arm.com, andy.gross@linaro.org, david.brown@linaro.org,
 sboyd@kernel.org, will.deacon@arm.com, mturquette@baylibre.com,
 jassisinghbrar@gmail.com
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
From: Taniya Das <tdas@codeaurora.org>
Message-ID: <e97d9050-effc-56d7-0f9b-768df90dd73a@codeaurora.org>
Date: Fri, 21 Dec 2018 16:49:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <1545039990-19984-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_031955_418370_C0D0FEF8 
X-CRM114-Status: GOOD (  16.74  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 12/17/2018 3:16 PM, Jorge Ramirez-Ortiz wrote:
> Limit the GPLL0_AO_OUT_MAIN operating frequency as per its hardware
> specifications.
> 
> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>   drivers/clk/qcom/gcc-qcs404.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/clk/qcom/gcc-qcs404.c b/drivers/clk/qcom/gcc-qcs404.c
> index 64da032..833436a 100644
> --- a/drivers/clk/qcom/gcc-qcs404.c
> +++ b/drivers/clk/qcom/gcc-qcs404.c
> @@ -304,10 +304,16 @@ static struct clk_alpha_pll gpll0_out_main = {
>   	},
>   };
>   
> +static const struct pll_vco gpll0_ao_out_vco[] = {
> +	{ 800000000, 800000000, 0 },
> +};
> +
>   static struct clk_alpha_pll gpll0_ao_out_main = {
>   	.offset = 0x21000,
>   	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
>   	.flags = SUPPORTS_FSM_MODE,
> +	.vco_table = gpll0_ao_out_vco,
> +	.num_vco = ARRAY_SIZE(gpll0_ao_out_vco),

Could you please help as to why this is required? This is a fixed PLL 
and we do not require a VCO table for it.

>   	.clkr = {
>   		.enable_reg = 0x45000,
>   		.enable_mask = BIT(0),
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
