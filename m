Return-Path: <SRS0=5+Aw=QR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A15C4151A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 15:51:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F34E3217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 15:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lCCIz/w0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34E3217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4X6ue8PTpNVmXHv6DT2FOQKFnEw4GlMAJ+1MfhAv5rE=; b=lCCIz/w0+aHMfX
	ez6KGC/TKdBwJ9JaEbTaEbMbpNQtDMXy7IP3VWRIVqdTC0Y8pi8GqBktax7n1qQXoj91AKTH2Xyw2
	+0E1mSiX/v3nhLoe6etr4tn36lqZuZoqoYMdWvLgVoafjuPhXRwXW+KEQyWREEz5CIHFACW1mYruf
	0579tHW/YuSHLE+4O9IB9fbYKAENsq7+wobrUNx+sKZwbqiA56kAOp/1D6q5shj2BTr9m75DqRxu8
	kWs2vIJwSO2f81anafCwR9FjMlDXH24F6KpE3JQY5beoS1e9NpI9ZumMcaXa72LDh6bKkf6QA4b3V
	FT2ZLoIBgfCaiHfJjjbA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsrNi-0003B7-Ah; Sun, 10 Feb 2019 15:50:58 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsrNf-0003AE-2h
 for linux-arm-kernel@lists.infradead.org; Sun, 10 Feb 2019 15:50:57 +0000
Received: from p54b26fa7.dip0.t-ipconnect.de ([84.178.111.167]
 helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gsrNU-0000MQ-SP; Sun, 10 Feb 2019 16:50:44 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: Re: [PATCH v2] clk: fractional-divider: check parent rate only if
 flag is set
Date: Sun, 10 Feb 2019 16:50:10 +0100
Message-ID: <1772879.g6DUe2Ua28@phil>
In-Reply-To: <20190210153806.24201-1-katsuhiro@katsuster.net>
References: <20190210153806.24201-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_075055_270595_5C640B45 
X-CRM114-Status: GOOD (  27.01  )
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
Cc: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Sonntag, 10. Februar 2019, 16:38:06 CET schrieb Katsuhiro Suzuki:
> Custom approximation of fractional-divider may not need parent clock
> rate checking. For example Rockchip SoCs work fine using grand parent
> clock rate even if target rate is greater than parent.
> 
> This patch checks parent clock rate only if CLK_SET_RATE_PARENT flag
> is set.
> 
> For detailed example, clock tree of Rockchip I2S audio hardware.
>   - Clock rate of CPLL is 1.2GHz, GPLL is 491.52MHz.
>   - i2s1_div is integer divider can divide N (N is 1~128).
>     Input clock is CPLL or GPLL. Initial divider value is N = 1.
>     Ex) PLL = CPLL, N = 10, i2s1_div output rate is
>       CPLL / 10 = 1.2GHz / 10 = 120MHz
>   - i2s1_frac is fractional divider can divide input to x/y, x and
>     y are 16bit integer.
> 
> CPLL --> | selector | ---> i2s1_div -+--> | selector | --> I2S1 MCLK
> GPLL --> |          | ,--------------'    |          |
>                       `--> i2s1_frac ---> |          |
> 
> Clock mux system try to choose suitable one from i2s1_div and
> i2s1_frac for master clock (MCLK) of I2S1.
> 
> Bad scenario as follows:
>   - Try to set MCLK to 8.192MHz (32kHz audio replay)
>     Candidate setting is
>     - i2s1_div: GPLL / 60 = 8.192MHz
>     i2s1_div candidate is exactly same as target clock rate, so mux
>     choose this clock source. i2s1_div output rate is changed
>     491.52MHz -> 8.192MHz
> 
>   - After that try to set to 11.2896MHz (44.1kHz audio replay)
>     Candidate settings are
>     - i2s1_div : CPLL / 107 = 11.214945MHz
>     - i2s1_frac: i2s1_div   = 8.192MHz
>       This is because clk_fd_round_rate() thinks target rate
>       (11.2896MHz) is higher than parent rate (i2s1_div = 8.192MHz)
>       and returns parent clock rate.
> 
> Above is current upstreamed behavior. Clock mux system choose
> i2s1_div, but this clock rate is not acceptable for I2S driver, so
> users cannot replay audio.
> 
> Expected behavior is:
>   - Try to set master clock to 11.2896MHz (44.1kHz audio replay)
>     Candidate settings are
>     - i2s1_div : CPLL / 107          = 11.214945MHz
>     - i2s1_frac: i2s1_div * 147/6400 = 11.2896MHz
>                  Change i2s1_div to GPLL / 1 = 491.52MHz at same
>                  time.
> 
> If apply this commit, clk_fd_round_rate() calls custom approximate
> function of Rockchip even if target rate is higher than parent.
> Custom function changes both grand parent (i2s1_div) and parent
> (i2s_frac) settings at same time. Clock mux system can choose
> i2s1_frac and audio works fine.
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>

While it took me a bit to wrap my head around fractional dividers
again :-) ... this sounds definitly sensible to do, especially
as the clock driver should really take into account potentially
setting the parent rate if possible, so

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/clk/clk-fractional-divider.c | 2 +-
>  drivers/clk/clk.c                    | 8 ++++++++
>  include/linux/clk-provider.h         | 1 +
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
> index 545dceec0bbf..fdfe2e423d15 100644
> --- a/drivers/clk/clk-fractional-divider.c
> +++ b/drivers/clk/clk-fractional-divider.c
> @@ -79,7 +79,7 @@ static long clk_fd_round_rate(struct clk_hw *hw, unsigned long rate,
>  	unsigned long m, n;
>  	u64 ret;
>  
> -	if (!rate || rate >= *parent_rate)
> +	if (!rate || (!clk_hw_can_set_rate_parent(hw) && rate >= *parent_rate))
>  		return *parent_rate;
>  
>  	if (fd->approximation)
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index d2477a5058ac..070c0cb29ee8 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -518,6 +518,14 @@ void clk_hw_set_rate_range(struct clk_hw *hw, unsigned long min_rate,
>  }
>  EXPORT_SYMBOL_GPL(clk_hw_set_rate_range);
>  
> +bool clk_hw_can_set_rate_parent(struct clk_hw *hw)
> +{
> +	unsigned long flags = clk_hw_get_flags(hw);
> +
> +	return flags & CLK_SET_RATE_PARENT;
> +}
> +EXPORT_SYMBOL_GPL(clk_hw_can_set_rate_parent);
> +
>  /*
>   * Helper for finding best parent to provide a given frequency. This can be used
>   * directly as a determine_rate callback (e.g. for a mux), or from a more
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index e443fa9fa859..693a51937ded 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -808,6 +808,7 @@ int clk_mux_determine_rate_flags(struct clk_hw *hw,
>  void clk_hw_reparent(struct clk_hw *hw, struct clk_hw *new_parent);
>  void clk_hw_set_rate_range(struct clk_hw *hw, unsigned long min_rate,
>  			   unsigned long max_rate);
> +bool clk_hw_can_set_rate_parent(struct clk_hw *hw);
>  
>  static inline void __clk_hw_set_clk(struct clk_hw *dst, struct clk_hw *src)
>  {
> 





_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
