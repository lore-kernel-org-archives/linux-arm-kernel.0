Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2838EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:16:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE414206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n5Nx+7ZB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="cFZhOccM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE414206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Gsaqoi2S2++2SjWITdBd/kXlNixtR60Lr6rpH19ZoEc=; b=n5Nx+7ZBSjhrgY
	+FuA0dsOLjK+fT9cKxMO9wYPg24EspJdsNffSR7WbA6grry4lu1aDUn/Ww8+wlNtRCoLOfV8gW7gM
	HiQYkywnR4WFsyueTvQFxiOtD5YvaDar4qK2ka+cjdJ7C6r1LTrrUm0d6V95xRpD/uGEUF4V9E9bP
	a5q0zUqr+Qm/3ndHrczpgGonM1eeJzHnCBBk7YMyPtMQ7C/eC96UpffcNUGPUBwckQwLq4y9clBqK
	BS8N1kmjK7SCOoyJ6eTajUDSOi8quoSOtZ9tWt7DqiCzw2RFW8dJp5avVfIbfv8mED+m3yJQrus/O
	sD72xWxr/tu8lV5TpzYA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghWRy-0006mV-FZ; Thu, 10 Jan 2019 09:16:30 +0000
Received: from plaes.org ([188.166.43.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghWRu-0006m3-1d
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 09:16:28 +0000
Received: from plaes.org (localhost [127.0.0.1])
 by plaes.org (Postfix) with ESMTPSA id 4BCE8402DF;
 Thu, 10 Jan 2019 09:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
 t=1547111749; bh=PrJ54k8gnhELd1dZtSEok5ub/GlZ7U39ptPcCg/GqZs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cFZhOccMoJrYTpjmjCw1rY0Hn1c9pL7mVFTkl2ZtKyxlLcuJaGSaQRWR6FX8gQkn9
 Z6aoAI0m8CAAQTm3h33LYdLQJ6JpIHSWuEI/qp2Gg02u1BM9p33mjOb861XeDS/zH4
 z35A3tpNdBemay0HQVoFnJPmWSgivtOwrrfa6Q+cj23ReMzRBYOxvRcW0S6E7V/0HK
 N256ic72EVUtDTGPuEHofeZnsoAnnLpS8tmsd3vWIaMJdhcvrYYdU3R0eh7wIl2TsN
 oBAJk3z5se9OPuRXqtMQo6oLPoRUNGxm1aDC1hZ+qvyyMB0KoPgMvofBcvaEh87jDT
 cXqV5z1ow4kdQ==
Date: Thu, 10 Jan 2019 09:15:48 +0000
From: Priit Laes <plaes@plaes.org>
To: Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [linux-sunxi] [PATCH v3 02/28] clk: sunxi-ng: Adjust MP clock
 parent rate when allowed
Message-ID: <20190110091548.e6btt2qofi7ttt6z@plaes.org>
References: <20181104182705.18047-1-jernej.skrabec@siol.net>
 <20181104182705.18047-3-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181104182705.18047-3-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_011626_366028_7111AF12 
X-CRM114-Status: GOOD (  28.07  )
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
Cc: linux-arm-kernel@lists.infradead.org, airlied@linux.ie,
 architt@codeaurora.org, a.hajda@samsung.com, maxime.ripard@bootlin.com,
 mturquette@baylibre.com, linux-sunxi@googlegroups.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 sboyd@kernel.org, wens@csie.org, robh+dt@kernel.org,
 Laurent.pinchart@ideasonboard.com, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Nov 04, 2018 at 07:26:39PM +0100, Jernej Skrabec wrote:
> Currently MP clocks don't consider adjusting parent rate even if they
> are allowed to do so. Such behaviour considerably lowers amount of
> possible rates, which is very inconvenient when such clock is used for
> pixel clock, for example.
> 
> In order to improve the situation, adjusting parent rate is considered
> when allowed.
> 
> This code is inspired by clk_divider_bestdiv() function, which does
> basically the same thing for different clock type.

This patch seems to break the eMMC support on Olinuxino-Lime2-eMMC boards:

EXT4-fs (mmcblk1p4): INFO: recovery required on readonly filesystem
EXT4-fs (mmcblk1p4): write access will be enabled during recovery
sunxi-mmc 1c11000.mmc: data error, sending stop command
sunxi-mmc 1c11000.mmc: send stop command failed


$ git bisect log
git bisect start
# good: [3df407b2a5346db1c48809706ece7a8616c79e0b] mmc: dw_mmc-bluefield: simplify the probe() function
git bisect good 3df407b2a5346db1c48809706ece7a8616c79e0b
# bad: [00d59fde8532b2d42e80909d2e58678755e04da9] Merge tag 'mmc-v4.21' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc
git bisect bad 00d59fde8532b2d42e80909d2e58678755e04da9
# good: [01e421feec0817bb3141eaae4c517410d193d440] Merge branch 'fixes' into next
git bisect good 01e421feec0817bb3141eaae4c517410d193d440
# bad: [1eefdec18eded41833401cfd64749643ff72e7da] Merge branch 'locking-core-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad 1eefdec18eded41833401cfd64749643ff72e7da
# good: [eaa76499711535fd64d747cc4ef0d78ab0fd41c6] Merge tag 'mtd/for-4.21' of git://git.infradead.org/linux-mtd
git bisect good eaa76499711535fd64d747cc4ef0d78ab0fd41c6
# good: [4e4390ad067a61ce4e7607bd0df31f19a4caa36a] Merge tag 'leds-for-4.21-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds
git bisect good 4e4390ad067a61ce4e7607bd0df31f19a4caa36a
# bad: [c2f1f3e0e17d94ab0c66d83e669492cb9e9a3698] Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc-next
git bisect bad c2f1f3e0e17d94ab0c66d83e669492cb9e9a3698
# bad: [e4b99d415c3908581d4703203e1e805f043a3e71] Merge branch 'irq-core-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad e4b99d415c3908581d4703203e1e805f043a3e71
# bad: [ffe05540d18013db62c43627836a3638e9a2c7aa] Merge branches 'clk-renesas', 'clk-allwinner', 'clk-tegra', 'clk-meson' and 'clk-rockchip' into clk-next
git bisect bad ffe05540d18013db62c43627836a3638e9a2c7aa
# good: [1a501c8defe950571316d5ddd917bf44f5ed7bd4] Merge branches 'clk-managed-registration', 'clk-spdx', 'clk-remove-basic' and 'clk-ops-const' into clk-next
git bisect good 1a501c8defe950571316d5ddd917bf44f5ed7bd4
# good: [e74581b79ddd9b49b8c61e2791fc4dffc0245afb] Merge tag 'meson-clk-4.21-2' of https://github.com/BayLibre/clk-meson into clk-meson
git bisect good e74581b79ddd9b49b8c61e2791fc4dffc0245afb
# good: [60baf75e3f5b76043c25328ac0c5320aaef5ea41] Merge tag 'clk-renesas-for-v4.21-tag2' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-renesas
git bisect good 60baf75e3f5b76043c25328ac0c5320aaef5ea41
# bad: [a41f85b6017ee20952a60e4330bcae2527fe2c2a] Merge tag 'sunxi-clk-for-4.21' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into clk-allwinner
git bisect bad a41f85b6017ee20952a60e4330bcae2527fe2c2a
# bad: [ee678706e46d0d185c27cc214ad97828e0643159] clk: sunxi-ng: a64: Fix gate bit of DSI DPHY
git bisect bad ee678706e46d0d185c27cc214ad97828e0643159
# bad: [65b6657672388b72822e0367f06d41c1e3ffb5bb] clk: sunxi-ng: Use u64 for calculation of NM rate
git bisect bad 65b6657672388b72822e0367f06d41c1e3ffb5bb
# good: [db7548934603d9eda12649dff97ea5c29884405d] clk: sunxi-ng: sun50i: h6: Fix MMC clock mux width
git bisect good db7548934603d9eda12649dff97ea5c29884405d
# bad: [3f790433c3cb27ecaf2ca0e07ac25964e4fd9f15] clk: sunxi-ng: Adjust MP clock parent rate when allowed
git bisect bad 3f790433c3cb27ecaf2ca0e07ac25964e4fd9f15
# first bad commit: [3f790433c3cb27ecaf2ca0e07ac25964e4fd9f15] clk: sunxi-ng: Adjust MP clock parent rate when allowed


> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/clk/sunxi-ng/ccu_mp.c | 64 +++++++++++++++++++++++++++++++++--
>  1 file changed, 62 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu_mp.c b/drivers/clk/sunxi-ng/ccu_mp.c
> index 5d0af4051737..0357349eb767 100644
> --- a/drivers/clk/sunxi-ng/ccu_mp.c
> +++ b/drivers/clk/sunxi-ng/ccu_mp.c
> @@ -40,6 +40,61 @@ static void ccu_mp_find_best(unsigned long parent, unsigned long rate,
>  	*p = best_p;
>  }
>  
> +static unsigned long ccu_mp_find_best_with_parent_adj(struct clk_hw *hw,
> +						      unsigned long *parent,
> +						      unsigned long rate,
> +						      unsigned int max_m,
> +						      unsigned int max_p)
> +{
> +	unsigned long parent_rate_saved;
> +	unsigned long parent_rate, now;
> +	unsigned long best_rate = 0;
> +	unsigned int _m, _p, div;
> +	unsigned long maxdiv;
> +
> +	parent_rate_saved = *parent;
> +
> +	/*
> +	 * The maximum divider we can use without overflowing
> +	 * unsigned long in rate * m * p below
> +	 */
> +	maxdiv = max_m * max_p;
> +	maxdiv = min(ULONG_MAX / rate, maxdiv);
> +
> +	for (_p = 1; _p <= max_p; _p <<= 1) {
> +		for (_m = 1; _m <= max_m; _m++) {
> +			div = _m * _p;
> +
> +			if (div > maxdiv)
> +				break;
> +
> +			if (rate * div == parent_rate_saved) {
> +				/*
> +				 * It's the most ideal case if the requested
> +				 * rate can be divided from parent clock without
> +				 * needing to change parent rate, so return the
> +				 * divider immediately.
> +				 */
> +				*parent = parent_rate_saved;
> +				return rate;
> +			}
> +
> +			parent_rate = clk_hw_round_rate(hw, rate * div);
> +			now = parent_rate / div;
> +
> +			if (now <= rate && now > best_rate) {
> +				best_rate = now;
> +				*parent = parent_rate;
> +
> +				if (now == rate)
> +					return rate;
> +			}
> +		}
> +	}
> +
> +	return best_rate;
> +}
> +
>  static unsigned long ccu_mp_round_rate(struct ccu_mux_internal *mux,
>  				       struct clk_hw *hw,
>  				       unsigned long *parent_rate,
> @@ -56,8 +111,13 @@ static unsigned long ccu_mp_round_rate(struct ccu_mux_internal *mux,
>  	max_m = cmp->m.max ?: 1 << cmp->m.width;
>  	max_p = cmp->p.max ?: 1 << ((1 << cmp->p.width) - 1);
>  
> -	ccu_mp_find_best(*parent_rate, rate, max_m, max_p, &m, &p);
> -	rate = *parent_rate / p / m;
> +	if (!(clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT)) {
> +		ccu_mp_find_best(*parent_rate, rate, max_m, max_p, &m, &p);
> +		rate = *parent_rate / p / m;
> +	} else {
> +		rate = ccu_mp_find_best_with_parent_adj(hw, parent_rate, rate,
> +							max_m, max_p);
> +	}
>  
>  	if (cmp->common.features & CCU_FEATURE_FIXED_POSTDIV)
>  		rate /= cmp->fixed_post_div;
> -- 
> 2.19.1
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
