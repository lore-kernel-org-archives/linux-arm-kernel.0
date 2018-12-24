Return-Path: <SRS0=tR0U=PB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB20C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 07:34:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BFFA21736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 07:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M/VCn35q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BFFA21736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AZtmaxIteT2zBGp6tvLYGgIbkloow0u95Gxil3suZD0=; b=M/VCn35qEV0t5M
	orq420/jIyzP7Z9uTJYt2QGbqsohut5YZo1fME/dEYJxnOzkb7myigGiVuy3lum9OZ46RdEKlLYl6
	H2dISt0vTnOMYLUkyOl4PI2wTlTVEIVfk1ia96YT3I2PuDbmxVuEp3QfDyDgGPBofy0ccOJVDf/Ue
	26UJDKgwJVPwakn4HLLCSrrPpa2EA+kO49Yl7WHxvRrvW0hb4xzVrR2GK413SbNW5P/4Rf6CrTHKx
	f0kYaxd0qxlh8JYx5EqNhLpkmjMZ2uatBHpJYtBHPynplM/ZOaJVMjkUSiRbAvJYJGBLKFHdgc460
	7qB/4Vfrkacej3O4Bs1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbKkz-0002tT-Bp; Mon, 24 Dec 2018 07:34:33 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbKku-0002qs-N7; Mon, 24 Dec 2018 07:34:30 +0000
Received: from [46.183.103.8] (helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gbKka-00036n-Gi; Mon, 24 Dec 2018 08:34:08 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Katsuhiro Suzuki <katsuhiro@katsuster.net>,
 Finley Xiao <finley.xiao@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>
Subject: Re: [PATCH] clk: rockchip: fix frac settings of GPLL clock for rk3328
Date: Mon, 24 Dec 2018 08:34:07 +0100
Message-ID: <1587344.DIk9eYpvKM@phil>
In-Reply-To: <20181222164249.25620-1-katsuhiro@katsuster.net>
References: <20181222164249.25620-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181223_233428_908917_93604A49 
X-CRM114-Status: GOOD (  17.86  )
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
Cc: linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

Am Samstag, 22. Dezember 2018, 17:42:49 CET schrieb Katsuhiro Suzuki:
> This patch fixes settings of GPLL frequency in fractional mode for
> rk3328. In this mode, FOUTVCO is calcurated by following formula:
>   FOUTVCO = FREF * FBDIV / REFDIV + ((FREF * FRAC / REFDIV) >> 24)
> 
> The problem is in FREF * FRAC >> 24 term. This result always lacks
> one from target value is specified by rate member. For example first
> itme of rk3328_pll_frac_rate originally has
>   - rate  : 1016064000
>   - refdiv: 3
>   - fbdiv : 127
>   - frac  : 134217
>   - FREF * FBDIV / REFDIV        = 1016000000
>   - (FREF * FRAC / REFDIV) >> 24 = 63999
> Thus calculated rate is 1016063999. It seems wrong.
> 
> If frac has 134218 (it is increased 1 from original value), second
> term is 64000. All other items have same situation. So this patch
> adds 1 to frac member in all items of rk3328_pll_frac_rate.
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>

so while this sounds all quite right to me, I've added some Rockchip
people that have clock experience to hopefully get an Ack on the
change :-)

@Elaine + Finley: does this explanation and the below change look right?


Thanks
Heiko

> ---
>  drivers/clk/rockchip/clk-rk3328.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3328.c b/drivers/clk/rockchip/clk-rk3328.c
> index faa94adb2a37..65ab5c2f48b0 100644
> --- a/drivers/clk/rockchip/clk-rk3328.c
> +++ b/drivers/clk/rockchip/clk-rk3328.c
> @@ -78,17 +78,17 @@ static struct rockchip_pll_rate_table rk3328_pll_rates[] = {
>  
>  static struct rockchip_pll_rate_table rk3328_pll_frac_rates[] = {
>  	/* _mhz, _refdiv, _fbdiv, _postdiv1, _postdiv2, _dsmpd, _frac */
> -	RK3036_PLL_RATE(1016064000, 3, 127, 1, 1, 0, 134217),
> +	RK3036_PLL_RATE(1016064000, 3, 127, 1, 1, 0, 134218),
>  	/* vco = 1016064000 */
> -	RK3036_PLL_RATE(983040000, 24, 983, 1, 1, 0, 671088),
> +	RK3036_PLL_RATE(983040000, 24, 983, 1, 1, 0, 671089),
>  	/* vco = 983040000 */
> -	RK3036_PLL_RATE(491520000, 24, 983, 2, 1, 0, 671088),
> +	RK3036_PLL_RATE(491520000, 24, 983, 2, 1, 0, 671089),
>  	/* vco = 983040000 */
> -	RK3036_PLL_RATE(61440000, 6, 215, 7, 2, 0, 671088),
> +	RK3036_PLL_RATE(61440000, 6, 215, 7, 2, 0, 671089),
>  	/* vco = 860156000 */
> -	RK3036_PLL_RATE(56448000, 12, 451, 4, 4, 0, 9797894),
> +	RK3036_PLL_RATE(56448000, 12, 451, 4, 4, 0, 9797895),
>  	/* vco = 903168000 */
> -	RK3036_PLL_RATE(40960000, 12, 409, 4, 5, 0, 10066329),
> +	RK3036_PLL_RATE(40960000, 12, 409, 4, 5, 0, 10066330),
>  	/* vco = 819200000 */
>  	{ /* sentinel */ },
>  };
> 





_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
