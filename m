Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869CAC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:09:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5860620868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sbVcFlQ7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dteVGgIS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5860620868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YkEYfZVqUm9CNmA85oIc0TXy4fraa4WGXUZiX8pk2VY=; b=sbVcFlQ7ov1Aze
	hZEzLdpFs0kmzCbEdyIpmO+rolycDeT+B7WFB3WCS1+5vpVOwHqlLiJ4A5Cr4O13kRC8VphLUR87L
	WeBbylS+m0cwK67tMoTX1adEeW7E061O1C3zuZ+TCeJSuOaNwmo4Z4Hd6EasnZTMOb8tQN64UzjAh
	mwcd4iYL71pwA+YHcpQX4/yPaS6quDDQsEfcepOBDHQOJ9xIv0RRlN95qYHHr6fW0Z70wf4MTzw66
	mnM/vgfbXPnc2JEMR6PwMvhLJdyXxgAakU4jB8XDbEXk2FQSMJVHmAshiSkSqdKhMOD+UiYIT1pBg
	H0DP7HklkL9rC155LP4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSenT-0005LQ-8n; Fri, 30 Nov 2018 09:09:15 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSenQ-0005Kg-Q6
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 09:09:14 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 384BD20868;
 Fri, 30 Nov 2018 09:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543568942;
 bh=c4z90kPgWBsUx4oXIOj7WmhJSMKbWcc9L+/YrgUV8Aw=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=dteVGgIS93aRuEtZ8dwFG6HMPIaYdQhz1BNT7FKtwuJVZA/JLYFnbqR39Fo7k1u8U
 dIOv4VQImvxFn8WCEOoeL2mE6hRkt3njIa6qaXrD0s1/WjP+K2squu0QZVomPvpjNA
 vIEdCHyp0CLpKVOpadFV4OlxtiTAnl9VqLEUHugo=
MIME-Version: 1.0
To: Michael Turquette <mturquette@baylibre.com>,
 Phil Edworthy <phil.edworthy@renesas.com>,
 Russell King <linux@armlinux.org.uk>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181120141445.21378-1-phil.edworthy@renesas.com>
References: <20181120141445.21378-1-phil.edworthy@renesas.com>
Message-ID: <154356894146.88331.4169293505438588293@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v8] clk: Add (devm_)clk_get_optional() functions
Date: Fri, 30 Nov 2018 01:09:01 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_010912_893772_B93EAB24 
X-CRM114-Status: GOOD (  15.10  )
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
Cc: Phil Edworthy <phil.edworthy@renesas.com>, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Phil Edworthy (2018-11-20 06:14:45)
> This adds clk_get_optional() and devm_clk_get_optional() functions to get
> optional clocks.
> They behave the same as (devm_)clk_get except where there is no clock
> producer. In this case, instead of returning -ENOENT, the function
> returns NULL. This makes error checking simpler and allows
> clk_prepare_enable, etc to be called on the returned reference
> without additional checks.

Ok. I guess that works by virtue of how -ENOENT is returned by various
functions that are called deeper in the clk_get() path? I'm cautiously
optimistic. So cautious, we should probably add a comment to these
optional functions that indicate they rely on the functions they call to
return -ENOENT under the various conditions that make a clk optional.

> 
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index a7773b5c0b9f..3ea3c78f62dd 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -383,6 +383,17 @@ int __must_check devm_clk_bulk_get_all(struct device *dev,
>   */
>  struct clk *devm_clk_get(struct device *dev, const char *id);
>  
> +/**
> + * devm_clk_get_optional - lookup and obtain a managed reference to an optional
> + *                        clock producer.
> + * @dev: device for clock "consumer"
> + * @id: clock consumer ID
> + *
> + * Behaves the same as devm_clk_get except where there is no clock producer. In

Please add () around devm_clk_get() so we know it's a function.

> + * this case, instead of returning -ENOENT, the function returns NULL.
> + */
> +struct clk *devm_clk_get_optional(struct device *dev, const char *id);
> +
>  /**
>   * devm_get_clk_from_child - lookup and obtain a managed reference to a
>   *                          clock producer from child node.
> @@ -718,6 +729,12 @@ static inline struct clk *devm_clk_get(struct device *dev, const char *id)
>         return NULL;
>  }
>  
> +static inline struct clk *devm_clk_get_optional(struct device *dev,
> +                                               const char *id)
> +{
> +       return NULL;
> +}
> +
>  static inline int __must_check devm_clk_bulk_get(struct device *dev, int num_clks,
>                                                  struct clk_bulk_data *clks)
>  {
> @@ -862,6 +879,16 @@ static inline void clk_bulk_disable_unprepare(int num_clks,
>         clk_bulk_unprepare(num_clks, clks);
>  }
>  
> +static inline struct clk *clk_get_optional(struct device *dev, const char *id)

Any kernel doc for this function?

> +{
> +       struct clk *clk = clk_get(dev, id);
> +
> +       if (clk == ERR_PTR(-ENOENT))
> +               clk = NULL;
> +
> +       return clk;
> +}
> +

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
