Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40D0C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:18:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9285E218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hN4TxwSf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtKXMVLX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9285E218D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PN4DGhdKeCMb/CWFwMf03yZoSrX8zEjcN3qk+jGs8R4=; b=hN4TxwSfzqVGM6
	IHgw6LoAY342aOFPAjwbLljUtCe1yOec1633fnsdfFrUTIWEPqlGaLwUpNwzKVDVLwzc5Ahg/6hTK
	BI2s4ZzyqEETKmta5TbjgBJ32RDAOgsFUR7FCBdA5hoLN6FKKPdupNXMdn/wb7Hg8+rvi9oVao/BD
	2YRSF1+DouQLiSjZeMS36TmVzoXWMsX+hYig3tQve0L6zBGVum+w6t+TQJhfZhxj80pvIctFrTSH2
	5omTWSCrVzYFnyh0aWgCemYiS0BRh84gov5mVxRoGj5NkempAiTypWEQ/eqNKU+U7/f+Iq1p2RB3v
	RmgDnTjJ1VFtjtY/fGYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn3F9-00012t-TZ; Fri, 25 Jan 2019 15:18:07 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn3F6-00012V-Fv; Fri, 25 Jan 2019 15:18:06 +0000
Received: by mail-pl1-x641.google.com with SMTP id w4so4717886plz.1;
 Fri, 25 Jan 2019 07:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=CQyVqyjAD0UyM5BgevkTZgjLaebiRunzdWd/bduHnnQ=;
 b=jtKXMVLXW2qJn51/uL/ymU0bcO1tV1zzF0r35YxSHcGlgNr1UKbE/mMoc1ztI+ABfP
 3QJQEbbwia0I7MO5AyOkoOZGX3GBHrLW+h4ZnxIKhUaQ6S8NeKfj7mGFtg90ZmRV9+zG
 1S005em1c9gjLWh+oR1FNNo0w2TbzemyhiBGBfGn4r8YZIyc9bpM5ChMBQF5OReokd8/
 VHZW3jQCPnuRBfhHq8yoE51DOl9FotuhP+hQfHn86vRlDw+y1JuFz2SMtoU2BJzV2jnU
 QxAuc6ecdXLmQ/gJBEvC0TQdkYNMevEeIfbN7nKN+nBg4bywqzvT1hDhKJORYG2f6ngP
 7Wqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=CQyVqyjAD0UyM5BgevkTZgjLaebiRunzdWd/bduHnnQ=;
 b=fxIuP+RYlzq2YZuQ6rbcjroF/dW2GhJb0jGNF1SiSHX86r9EkIOlsoSidLQW3ov/Ep
 CrdW2LYn9RhQ9ePqaaCe1unYySyZs4PaaP0tXzSKaYm0peWsA2B1088vlII6DUV8gero
 8g4yA6iMn4NfOkDakOY1calv5/A7eq7i6hu1cJycRLzb8ceAz0qL4IMyf3GGv3qDU2k8
 T17WkNoj0ISl2lWcaEKG61ePftgi6waPm6SYXnUP2QhNQkYq5hns4RTVs+b0yS7P3iKT
 rWH666BLPrUfzEuAWok34t6jBTJygZHQcYXJIOJ1uh//5tAyo7Xkz2yM6FnqNI08SVTv
 Ghww==
X-Gm-Message-State: AJcUukcMuVpHg5W7sDcZUWRz1LZFyg2f7S/ufVVyM0nbMeQf0NkRVmnP
 xsbbU8HKAJaAppsmo9XhVu8=
X-Google-Smtp-Source: ALg8bN6MKOggyl7HMhfHPyX378n0yRmmGyR6dm2Xe3Xu4d6ZoDMIgUjl8Oo0AAxgdca3Vpr6rr0yvQ==
X-Received: by 2002:a17:902:bb98:: with SMTP id
 m24mr11072502pls.71.1548429483040; 
 Fri, 25 Jan 2019 07:18:03 -0800 (PST)
Received: from nishad ([106.51.25.107])
 by smtp.gmail.com with ESMTPSA id b10sm36543837pfj.183.2019.01.25.07.17.58
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 25 Jan 2019 07:18:02 -0800 (PST)
Date: Fri, 25 Jan 2019 20:47:53 +0530
From: Nishad Kamdar <nishadkamdar@gmail.com>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] staging: mt7621-pinctrl: Remove space after cast
Message-ID: <20190125151751.GA11257@nishad>
References: <20190123163122.GA4807@nishad>
 <b51b1d3071aec95915d48159c1dd6e0a336cd9f4.camel@perches.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b51b1d3071aec95915d48159c1dd6e0a336cd9f4.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_071804_731217_520CDC19 
X-CRM114-Status: GOOD (  21.74  )
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
Cc: devel@driverdev.osuosl.org, Kees Cook <keescook@chromium.org>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org,
 NeilBrown <neil@brown.name>, linux-arm-kernel@lists.infradead.org,
 John Crispin <blogic@openwrt.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 23, 2019 at 09:45:53AM -0800, Joe Perches wrote:
> On Wed, 2019-01-23 at 22:01 +0530, Nishad Kamdar wrote:
> > This patch removes space after a cast as it
> > is not needed.
> > Issue found by checkpatch.
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> >  drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
> > index 80e7067cfb79..3e959fa73703 100644
> > --- a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
> > +++ b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
> > @@ -363,7 +363,7 @@ static int rt2880_pinmux_probe(struct platform_device *pdev)
> >  		}
> >  
> >  		range = devm_kzalloc(p->dev, sizeof(*range) + 4, GFP_KERNEL);
> > -		range->name = name = (char *) &range[1];
> > +		range->name = name = (char *)&range[1];
> >  		sprintf(name, "pio");
> 
> I find this code unsightly and fragile.
> It doesn't test the return of devm_kzalloc for failure.
> 
> This might as well be
> ---
>  drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
> index 80e7067cfb79..9b52d44abef1 100644
> --- a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
> +++ b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
> @@ -350,7 +350,6 @@ static int rt2880_pinmux_probe(struct platform_device *pdev)
>  	for_each_compatible_node(np, NULL, "ralink,rt2880-gpio") {
>  		const __be32 *ngpio, *gpiobase;
>  		struct pinctrl_gpio_range *range;
> -		char *name;
>  
>  		if (!of_device_is_available(np))
>  			continue;
> @@ -362,9 +361,10 @@ static int rt2880_pinmux_probe(struct platform_device *pdev)
>  			return -EINVAL;
>  		}
>  
> -		range = devm_kzalloc(p->dev, sizeof(*range) + 4, GFP_KERNEL);
> -		range->name = name = (char *) &range[1];
> -		sprintf(name, "pio");
> +		range = devm_kzalloc(p->dev, sizeof(*range), GFP_KERNEL);
> +		if (!range)
> +			return -ENOMEM;
> +		range->name = "pio";
>  		range->npins = __be32_to_cpu(*ngpio);
>  		range->base = __be32_to_cpu(*gpiobase);
>  		range->pin_base = range->base;
> 	
> 	
> 

Ok, I'll include it as a new patch as I think this one has already been
accepted.

Thanks for the review.

Regards,
Nishad

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
