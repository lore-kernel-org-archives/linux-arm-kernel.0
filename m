Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C901C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:11:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F229620989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Rmi0jtTu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mIp0uOku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F229620989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MWUrnipR1alWic3CHqVbzxfjAKL3xZDIPSzhwZjH+Po=; b=Rmi0jtTuqXpWNv
	i1jf5irC8tis8AOpcPSd+ML6wLxoI0Gy060V4w3z93S81OTbaDih3rE90AqX55B7VjJ1DvEmn8JWi
	ylT8dMZThyy42SjYG+LDuy8ipCOXe0VkN6t1TjiZ+5XJuoXvyfehOoOCSWWI9BkmLNVihCF+4jkB8
	+a09jsmUGxY9EkvQUnD+oK7YHk3qWj53Fwzbutar8RLi1nWcdo8RKda055mUOUzOX6Y3ZLjXbf35h
	ANX0cfwOhT9N0WT1HKI0Zbthv/S/PJkZgMZ9es1NIj0AI22XPkr8bK4pQheO27zm4n3hY2Y+Vxkmj
	/9Wp4FjITxr5UGgEKBsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go2xB-0002dw-Ik; Mon, 28 Jan 2019 09:11:41 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go2x8-0002da-4H
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 09:11:39 +0000
Received: by mail-it1-x144.google.com with SMTP id i145so19478003ita.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 01:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=er9/I+TyhaggJajko2FO0SWawCUPwizjJ0agacJS0Pk=;
 b=mIp0uOkuyPs9FBNfudGyqmnrOZcJ6xYYS0pLHOz5eFRNaEYAE1M+MyzJ2LYAmqB2Nn
 NMsIzzOC9Ql5OE4IPThfq/Q3neXkAFDvJcb0hBck7hPd522Ddx4ym5GqOLija2grJhSR
 wnQi7k3wm431IY72t5zH/wlm1IfCw3qCiVQfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=er9/I+TyhaggJajko2FO0SWawCUPwizjJ0agacJS0Pk=;
 b=V8GhMuA2D9sGd00OCBqy8g9KS2hl0EnbFQ+UR9ozhrHkrPPvjvTvcBJqcWCJhAH1Ow
 z4Ii+fhSUE7yRbhLWokt5rNio45DLt/z+1e8sr9bkIGKuUFVNpGpZUqdLN4P5PH7nbBD
 W6XaoF//MlwnB/XncCdhW3taWyPcsJ8dqb3hTQIK+cBhD5pa59pQE+XNrUaLrFt07P+q
 dTAsWgs/RIuOCVpLjzz0Xlc5qGJ6tHF9hbc2bmQ/Zk5/Zbr/LIfv0+bEjkpnESbNjW3o
 puIe9jEQ2o4V+AhXey/9G7CFr6f5Zc+Ssqw00KMp+Pc5N25/V0JGBTDywMlcVtcP6L4t
 hv9g==
X-Gm-Message-State: AJcUukcNQ5B6QtzYZ3+rVb+urPn8rvOROEJTDgYIYVUkl6csk3bIpqgb
 rlmMcQ9I/efgDDaeY0Op/8vbMsf8NmoQcRA6ntZHBA==
X-Google-Smtp-Source: ALg8bN7L6MXqfpULu9ND2ngnThuAu7s7vqf/t98FgrqZEuAOpvXA46hxZ3oPCapa8ePZHHhoOsRsQ6/yEnP0PsKF5xk=
X-Received: by 2002:a24:385:: with SMTP id e127mr9201443ite.32.1548666697022; 
 Mon, 28 Jan 2019 01:11:37 -0800 (PST)
MIME-Version: 1.0
References: <20190125032314.20915-1-wens@csie.org>
 <20190125032314.20915-2-wens@csie.org>
In-Reply-To: <20190125032314.20915-2-wens@csie.org>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 28 Jan 2019 14:41:25 +0530
Message-ID: <CAMty3ZAB99yMQj33XkBV-EXDN7RkapbOTaO0chYwaz=aFYto=w@mail.gmail.com>
Subject: Re: [PATCH 01/11] clk: sunxi-ng: sun8i-a23: Enable PLL-MIPI LDOs when
 ungating it
To: Chen-Yu Tsai <wens@csie.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_011138_319071_525F709D 
X-CRM114-Status: GOOD (  16.08  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, David Airlie <airlied@linux.ie>,
 devicetree <devicetree@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, Stephen Boyd <sboyd@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 linux-clk <linux-clk@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 25, 2019 at 8:54 AM Chen-Yu Tsai <wens@csie.org> wrote:
>
> The PLL-MIPI clock is somewhat special as it has its own LDOs which
> need to be turned on for this PLL to actually work and output a clock
> signal.
>
> Add the 2 LDO enable bits to the gate bits.
>
> Fixes: 5690879d93e8 ("clk: sunxi-ng: Add A23 CCU")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/clk/sunxi-ng/ccu-sun8i-a23.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a23.c b/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
> index a4fa2945f230..4b5f8f4e4ab8 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
> @@ -144,7 +144,7 @@ static SUNXI_CCU_NKM_WITH_GATE_LOCK(pll_mipi_clk, "pll-mipi",
>                                     8, 4,               /* N */
>                                     4, 2,               /* K */
>                                     0, 4,               /* M */
> -                                   BIT(31),            /* gate */
> +                                   BIT(31) | BIT(23) | BIT(22), /* gate */

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
