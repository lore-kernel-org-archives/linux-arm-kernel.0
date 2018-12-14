Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C0DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:02:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E891B2080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ef1Dir4m";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXAfPIZs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E891B2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:Message-ID:References:To:
	Subject:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jzZsj8jKVdXpKcW7r97P7SAkU49NvsHQJXCKgcHi6fM=; b=ef1Dir4m0nVTiy
	fY+3rbhBjFn+ov+AYQMJ24GpZy0HZ3VOW6E3zlMtpEpabfxz7lpiJIioR3ktJosJ59j+RNX87jevX
	wMEEiiHLiCWvUHSVwJBUvinleHZoALoBmFNeGCc+nVpEcNapd6HlXgMhQ9QCKebsatyIPEfyUJhaP
	FNICzd7oYkzgeXh214dIyv+JKYWLPhy68hYs4UHZY48NtX1QaOHTxTJnck45ERhEAvndBuhnMJLut
	UEKa6FYZqA6SWxvXZCDn1tSU/PDr+zsdZnO25ne4SMQ64LX32XXhdPrRvTNoKg3qy6ObmmavB2rpf
	EQl7bONix+tbAWYM+dVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXvXb-0007En-Cd; Fri, 14 Dec 2018 22:02:39 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXvXY-0007DX-HF; Fri, 14 Dec 2018 22:02:37 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 95F02206C0;
 Fri, 14 Dec 2018 22:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544824946;
 bh=Xr+Lz27jUrQWOlcWPdqsznHh3qyhbXL1SkP3Xg/000g=;
 h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
 b=qXAfPIZseaaJUofwERvW1ix0T3TdYcqPRGjbWyscaN8J4h6xWPZHqO5vE0tWmP2Tv
 uHLg7XcRwZqLiBIloObhooZfSUgywQ5gO/RCNou8SIVy0s5Ygcu6o3TQogrjxaqoEo
 hCT6BjX9rEzdt7l6CE/zSFXgdx/J6YEPPXQ9nncw=
MIME-Version: 1.0
In-Reply-To: <20181210073240.32278-5-weiyi.lu@mediatek.com>
Subject: Re: [PATCH v3 03/12] clk: mediatek: add configurable pcwibits and
 fmin to mtk_pll_data
To: Matthias Brugger <matthias.bgg@gmail.com>,
 Nicolas Boichat <drinkcat@chromium.org>, Rob Herring <robh@kernel.org>,
 Stephen Boyd <sboyd@codeaurora.org>, Weiyi Lu <weiyi.lu@mediatek.com>
References: <20181210073240.32278-1-weiyi.lu@mediatek.com>
 <20181210073240.32278-5-weiyi.lu@mediatek.com>
Message-ID: <154482494548.19322.11090762587126084086@swboyd.mtv.corp.google.com>
From: Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Date: Fri, 14 Dec 2018 14:02:25 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_140236_587383_D136B066 
X-CRM114-Status: UNSURE (   9.98  )
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
Cc: James Liao <jamesjj.liao@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
 srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Fan Chen <fan.chen@mediatek.com>,
 linux-mediatek@lists.infradead.org, Owen Chen <owen.chen@mediatek.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Weiyi Lu (2018-12-09 23:32:31)
> diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
> index f0ff5f535c7e..81400601f107 100644
> --- a/drivers/clk/mediatek/clk-pll.c
> +++ b/drivers/clk/mediatek/clk-pll.c
> @@ -69,11 +71,13 @@ static unsigned long __mtk_pll_recalc_rate(struct mtk_clk_pll *pll, u32 fin,
>  {
>         int pcwbits = pll->data->pcwbits;
>         int pcwfbits;
> +       int ibits;
>         u64 vco;
>         u8 c = 0;
>  
>         /* The fractional part of the PLL divider. */
> -       pcwfbits = pcwbits > INTEGER_BITS ? pcwbits - INTEGER_BITS : 0;
> +       ibits = pll->data->pcwibits ? pll->data->pcwibits : INTEGER_BITS;
> +       pcwfbits = pcwbits > ibits ? pcwbits - ibits : 0;

This is practically unreadable. It should be changed to an if statement.

>  
>         vco = (u64)fin * pcw;
>  
> @@ -167,9 +171,10 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
>  static void mtk_pll_calc_values(struct mtk_clk_pll *pll, u32 *pcw, u32 *postdiv,
>                 u32 freq, u32 fin)
>  {
> -       unsigned long fmin = 1000 * MHZ;
> +       unsigned long fmin = pll->data->fmin ? pll->data->fmin : (1000 * MHZ);
>         const struct mtk_pll_div_table *div_table = pll->data->div_table;
>         u64 _pcw;
> +       int ibits;
>         u32 val;
>  
>         if (freq > pll->data->fmax)
> @@ -193,7 +198,8 @@ static void mtk_pll_calc_values(struct mtk_clk_pll *pll, u32 *pcw, u32 *postdiv,
>         }
>  
>         /* _pcw = freq * postdiv / fin * 2^pcwfbits */
> -       _pcw = ((u64)freq << val) << (pll->data->pcwbits - INTEGER_BITS);
> +       ibits = pll->data->pcwibits ? pll->data->pcwibits : INTEGER_BITS;
> +       _pcw = ((u64)freq << val) << (pll->data->pcwbits - ibits);

Similar comment. Readability is low here.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
