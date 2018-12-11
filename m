Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214BDC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:17:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4E3F2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NFeYfYuG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qVf9KPW7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E3F2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=k6X/6e6dR9QGAtp9F//6IsnkPkRDv+G7jASK+oDGuH8=; b=NFeYfYuGDeRxQk
	Hx7Q3tUPHZmx7XgauEmlHlCWI8SD8Oeketdy3steRgjEsvj/F5rv4os4c5iMuY8jKqs65pQaTEnIm
	doanQ+4uQZezJg/kk33oXON9MbG3cfDzSYCWg8h5A1y+A39LL9HcyroAwBEfQx2uxzCKwJzv2zykf
	AlVq/yvF8pVaTID1wPKVvOgedpJfkgGWdq8MmHqIOI8lvzaWz79IUH5h8UyLSZkQZdm02PnN2FK3Y
	c3Qni0RDlWHWVFhaDqPfJnU3ApyT1hwhRnSfaQaT51+bfwYM/r03yjeQe640Tk9JXyBUWf8EwH94e
	/BY61oxtwVHV4lYZAVSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWlek-00074d-It; Tue, 11 Dec 2018 17:17:14 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWleg-00072O-Ik
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 17:17:12 +0000
Received: by mail-wm1-x341.google.com with SMTP id y139so3010436wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 09:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=75yFl6t0VNl6aeKQPwOYA9vmVdauYThH+a/zVHyk1HY=;
 b=qVf9KPW7ufg1mhiOVOV9ukDNT606L4vnOvmwKM+QyODjR5A3W6N5wpNMAYWoTvR+iI
 tHiS7EshfrV7+f1kojxBTEWXa49X0DjW6usNLX9udJkP/t3Ob/Q0UHRoVgovXx61Q2tQ
 1QZ4SfCzjYyFN6DvJ/XsZPQvg7MUYDE3ln65pFD5YdqbdJgEa2Xq2wvDbyTG/j6V6jiC
 m7D/9LXfi+cNom5P6VNTno8LJ3yVilpH8TKKgOBnbO7oCQ1biwVUKQ7IMacabGOjaU8x
 eamOorEYgCvUJQ7CLtEGK1InCiGZUVzMMps2dru0LBWNlrkF0M5ptY/WCBtTkHJP5vSj
 Fqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=75yFl6t0VNl6aeKQPwOYA9vmVdauYThH+a/zVHyk1HY=;
 b=OxUFYCGWwcw6+nqr+DQfjyqivejnY/+1bAK8CuF33BGwo+U+QcnHhbl5Uu8Qn62PY7
 pcFeirZ9T/bgrq6elRjXKjNprj3MCzQZqJZ8DDfsMVVIPeFXE2NN/6KMLofNmapKE+Qn
 ePM9OeDDTC+Ts82b8IV2jBolzD+W+dJWnXIj3Sv2RwaBOn6q7rCpvWOH6axErZMo7DFI
 Zn1BCfkbPT83TZlF+JESD4+3QhC1YME7nTncpTc4XujZNXdGKZqsSIwdyMStK7CvBsc8
 h35bkApBWtYanxusY4fPzjB1dYHIXmmg03MBtowm5mgOfh7QyoyoE+NFKX+vE77j6vpM
 OhEQ==
X-Gm-Message-State: AA+aEWZO4veu6aVbsp3Hi1vg83af36sUd0lSax+rMgzGSnG9NYEAmHi1
 WOoa/rEsVftDjexl+RTHECwUaA==
X-Google-Smtp-Source: AFSGD/X23cOw1RneKhFub57TRd9Ur2MpdQD4WlwVOgAzARNURpNzd8lJUNxGbln5ZpRekOux8hFXFw==
X-Received: by 2002:a1c:91d1:: with SMTP id t200mr3109373wmd.111.1544548617073; 
 Tue, 11 Dec 2018 09:16:57 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
 by smtp.gmail.com with ESMTPSA id v4sm738924wme.6.2018.12.11.09.16.54
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 11 Dec 2018 09:16:56 -0800 (PST)
Message-ID: <4da764c237b8f752af1dc33a011e2a4b73068f02.camel@baylibre.com>
Subject: Re: [PATCH RESEND v7 4/4] clk: meson: add one based divider support
 for sclk divider
From: Jerome Brunet <jbrunet@baylibre.com>
To: Jianxin Pan <jianxin.pan@amlogic.com>, Neil Armstrong
 <narmstrong@baylibre.com>
Date: Tue, 11 Dec 2018 18:16:53 +0100
In-Reply-To: <1544457877-51301-5-git-send-email-jianxin.pan@amlogic.com>
References: <1544457877-51301-1-git-send-email-jianxin.pan@amlogic.com>
 <1544457877-51301-5-git-send-email-jianxin.pan@amlogic.com>
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_091710_622321_87D43CF6 
X-CRM114-Status: GOOD (  22.68  )
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
Cc: Rob Herring <robh@kernel.org>, Hanjie Lin <hanjie.lin@amlogic.com>,
 Victor Wan <victor.wan@amlogic.com>, Stephen Boyd <sboyd@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Yixun Lan <yixun.lan@amlogic.com>,
 linux-kernel@vger.kernel.org, Boris Brezillon <boris.brezillon@bootlin.com>,
 Liang Yang <liang.yang@amlogic.com>, Jian Hu <jian.hu@amlogic.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Carlo Caione <carlo@caione.org>,
 linux-amlogic@lists.infradead.org,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Qiufang Dai <qiufang.dai@amlogic.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2018-12-11 at 00:04 +0800, Jianxin Pan wrote:
> When CLK_DIVIDER_ONE_BASED flag is set, the sclk divider will be:
> one based divider (div = val), and zero value gates the clock
> 
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> ---
>  drivers/clk/meson/clkc-audio.h |  1 +
>  drivers/clk/meson/sclk-div.c   | 28 ++++++++++++++++++----------
>  2 files changed, 19 insertions(+), 10 deletions(-)

Such a patch should be done earlier in the series, at least before using sclk
in your controller, otherwise thing will be broken in between

In general, I would prefer if you had added two helper function to deal with
the translation between register value and divider value.

Only these function should care about CLK_DIVIDER_ONE_BASED, the rest should
just call them.

This, we will be able to deal the with HI (duty cycle) part as well, which you
completly skiped.

I know your device does not have this, but still the code has to make sense.

> 
> diff --git a/drivers/clk/meson/clkc-audio.h b/drivers/clk/meson/clkc-audio.h
> index 0a7c157..9bd6ced 100644
> --- a/drivers/clk/meson/clkc-audio.h
> +++ b/drivers/clk/meson/clkc-audio.h
> @@ -20,6 +20,7 @@ struct meson_sclk_div_data {
>  	struct parm hi;
>  	unsigned int cached_div;
>  	struct clk_duty cached_duty;
> +	u8	flags;
>  };
>  
>  extern const struct clk_ops meson_clk_triphase_ops;
> diff --git a/drivers/clk/meson/sclk-div.c b/drivers/clk/meson/sclk-div.c
> index bc64019..d98707b 100644
> --- a/drivers/clk/meson/sclk-div.c
> +++ b/drivers/clk/meson/sclk-div.c
> @@ -24,22 +24,23 @@
>  	return (struct meson_sclk_div_data *)clk->data;
>  }
>  
> -static int sclk_div_maxval(struct meson_sclk_div_data *sclk)
> -{
> -	return (1 << sclk->div.width) - 1;
> -}
> -
>  static int sclk_div_maxdiv(struct meson_sclk_div_data *sclk)
>  {
> -	return sclk_div_maxval(sclk) + 1;
> +	if (sclk->flags & CLK_DIVIDER_ONE_BASED)
> +		return clk_div_mask(sclk->div.width);
> +	else
> +		return clk_div_mask(sclk->div.width) + 1;

seems over complicated.
why no call clk_div_mask just once, and add 1 if necessary ?

>  }
>  
>  static int sclk_div_getdiv(struct clk_hw *hw, unsigned long rate,
>  			   unsigned long prate, int maxdiv)
>  {
>  	int div = DIV_ROUND_CLOSEST_ULL((u64)prate, rate);
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_sclk_div_data *sclk = meson_sclk_div_data(clk);
> +	int mindiv = (sclk->flags & CLK_DIVIDER_ONE_BASED) ? 1 : 2;

This is why I want helpers, don't like this above

>  
> -	return clamp(div, 2, maxdiv);
> +	return clamp(div, mindiv, maxdiv);
>  }
>  
>  static int sclk_div_bestdiv(struct clk_hw *hw, unsigned long rate,
> @@ -47,7 +48,7 @@ static int sclk_div_bestdiv(struct clk_hw *hw, unsigned
> long rate,
>  			    struct meson_sclk_div_data *sclk)
>  {
>  	struct clk_hw *parent = clk_hw_get_parent(hw);
> -	int bestdiv = 0, i;
> +	int bestdiv = 0, i, mindiv;
>  	unsigned long maxdiv, now, parent_now;
>  	unsigned long best = 0, best_parent = 0;
>  
> @@ -64,8 +65,9 @@ static int sclk_div_bestdiv(struct clk_hw *hw, unsigned
> long rate,
>  	 * unsigned long in rate * i below
>  	 */
>  	maxdiv = min(ULONG_MAX / rate, maxdiv);
> +	mindiv = (sclk->flags & CLK_DIVIDER_ONE_BASED) ? 1 : 2;
>  
> -	for (i = 2; i <= maxdiv; i++) {
> +	for (i = mindiv; i <= maxdiv; i++) {
>  		/*
>  		 * It's the most ideal case if the requested rate can be
>  		 * divided from parent clock without needing to change
> @@ -153,10 +155,14 @@ static int sclk_div_get_duty_cycle(struct clk_hw *hw,
>  static void sclk_apply_divider(struct clk_regmap *clk,
>  			       struct meson_sclk_div_data *sclk)
>  {
> +	unsigned int div;
> +
>  	if (MESON_PARM_APPLICABLE(&sclk->hi))
>  		sclk_apply_ratio(clk, sclk);
>  
> -	meson_parm_write(clk->map, &sclk->div, sclk->cached_div - 1);
> +	div = (sclk->flags & CLK_DIVIDER_ONE_BASED) ?
> +		sclk->cached_div : (sclk->cached_div - 1);

helpers again.

> +	meson_parm_write(clk->map, &sclk->div, div);
>  }
>  
>  static int sclk_div_set_rate(struct clk_hw *hw, unsigned long rate,
> @@ -223,6 +229,8 @@ static void sclk_div_init(struct clk_hw *hw)
>  	/* if the divider is initially disabled, assume max */
>  	if (!val)
>  		sclk->cached_div = sclk_div_maxdiv(sclk);
> +	else if (sclk->flags & CLK_DIVIDER_ONE_BASED)
> +		sclk->cached_div = val;
>  	else
>  		sclk->cached_div = val + 1;

same ...

>  



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
