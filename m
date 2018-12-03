Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551F6C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:09:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ACD920850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E97YWv+9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="RUF6zoWB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ACD920850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=swTL+NEIb8KDSwZRjMNLwdC+Grkyzrzw6EVJZcNjOAw=; b=E97YWv+90bs+/V
	T2KnxdrFIE2A4ncV1/BjoCZgRF25Casdl4EM/7BYLl/2rgi9ju0gIVMH4HegNaSOtWNIeIt5f/7Nd
	8PVZEI3S3LL0wqkeJ8TElIOIDHgH21CZykqjbwdgiAF7GAnenTGjfq6ANSJwoRonXbs0n6t9OWiM2
	aYWwHI08BnTl5J+IHVDNGaWCDUM6bc7lbEeHFdhVuwHSR7dFtCWWw+y3iZQmMoUuP+J7AI76795aN
	yoORLLWJm1T63HCX/NYJ70I1fpy68sXs/IU/gptGIrxTBdhsKFApfNk2tG02REBgimY0XXJaYyaLZ
	WQ15RhCm/+mrtU6Nq4gg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTseY-0007Ki-Nr; Mon, 03 Dec 2018 18:09:06 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTscc-0004vd-Po
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 18:07:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PHMwcboEr5y8iZqZKXK4xq+yzNV3AdJh02+hNPX31+I=; b=RUF6zoWBOjvmjw4uODz8dePUo
 1RHgxJ7IzA0jEo7OlQQ8f8SdDtQcBr7nr8zYeYZYu2+sOsEARicXd4UtLjrZ8LBrpTe64+Sx/xgMW
 PSxJ4ccVaX1Rt0wyd6gnVPC2gMFZ0NsDcfN1Wc3CogN8VTArwamxaKu460VFkD3TRRZH8=;
Received: from n2100.armlinux.org.uk
 ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:54393)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gTsbp-0001Dr-8E; Mon, 03 Dec 2018 18:06:17 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gTsbm-0001r9-EF; Mon, 03 Dec 2018 18:06:14 +0000
Date: Mon, 3 Dec 2018 18:06:12 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v5 1/9] clkdev: add managed clkdev lookup registration
Message-ID: <20181203180612.GM30658@n2100.armlinux.org.uk>
References: <cover.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
 <b6c5c110c482ff6a6b2378ab3518bd31c6233872.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b6c5c110c482ff6a6b2378ab3518bd31c6233872.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_100707_812868_1FA54583 
X-CRM114-Status: GOOD (  15.75  )
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
Cc: david.brown@linaro.org, rafael.j.wysocki@intel.com,
 linux-clk@vger.kernel.org, b.zolnierkie@samsung.com, sboyd@kernel.org,
 mturquette@baylibre.com, mazziesaccount@gmail.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, krzk@kernel.org, akshu.agrawal@amd.com,
 cw00.choi@samsung.com, djkurtz@chromium.org, pavel@ucw.cz,
 pombredanne@nexb.com, andy.gross@linaro.org, andrew.smirnov@gmail.com,
 lee.jones@linaro.org, sjhuang@iluvatar.ai,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Mon, Dec 03, 2018 at 02:17:56PM +0200, Matti Vaittinen wrote:
> diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
> index 9ab3db8b3988..68a1e55a60d2 100644
> --- a/drivers/clk/clkdev.c
> +++ b/drivers/clk/clkdev.c
> @@ -401,6 +401,25 @@ static struct clk_lookup *__clk_register_clkdev(struct clk_hw *hw,
>  	return cl;
>  }
>  
> +static int do_clk_register_clkdev(struct clk_hw *hw,
> +	struct clk_lookup **cl, const char *con_id, const char *dev_id)
> +{
> +

No need for this blank line.

> +	if (IS_ERR(hw))
> +		return PTR_ERR(hw);
> +	/*
> +	 * Since dev_id can be NULL, and NULL is handled specially, we must
> +	 * pass it as either a NULL format string, or with "%s".
> +	 */
> +	if (dev_id)
> +		*cl = __clk_register_clkdev(hw, con_id, "%s",
> +					   dev_id);

Please move "dev_id);" onto the line above.

> @@ -420,20 +439,10 @@ int clk_register_clkdev(struct clk *clk, const char *con_id,
>  {
>  	struct clk_lookup *cl;
>  
> -	if (IS_ERR(clk))
> -		return PTR_ERR(clk);
> -
> -	/*
> -	 * Since dev_id can be NULL, and NULL is handled specially, we must
> -	 * pass it as either a NULL format string, or with "%s".
> -	 */
> -	if (dev_id)
> -		cl = __clk_register_clkdev(__clk_get_hw(clk), con_id, "%s",
> -					   dev_id);
> -	else
> -		cl = __clk_register_clkdev(__clk_get_hw(clk), con_id, NULL);
> -
> -	return cl ? 0 : -ENOMEM;
> +	if (!IS_ERR(clk))
> +		return do_clk_register_clkdev(__clk_get_hw(clk), &cl, con_id,
> +					      dev_id);
> +	return PTR_ERR(clk);

Please keep this as:

	if (IS_ERR(clk))
		return PTR_ERR(clk);

	return do_clk_register_clkdev(__clk_get_hw(clk), &cl, con_id,
				      dev_id);

rather than inverting it - it makes it more consistent with code elsewhere.

> +static int devm_clk_match_clkdev(struct device *dev, void *res, void *data)
> +{
> +	struct clk_lookup **l = res;
> +
> +	if (!l || !*l) {
> +		WARN_ON(!l || !*l);

How can "l" be NULL here?  How can *l be NULL?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
