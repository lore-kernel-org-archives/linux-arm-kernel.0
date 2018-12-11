Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185D5C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:25:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA9BC205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VH+KH+Kb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjdeOLmq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA9BC205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u1sOhcpnIzWhs7dagYb32bnDNtsSdOgdOfoFr6wgfn0=; b=VH+KH+KbFDuIWO
	wfmwxA8cbmM7jdDjZK+mrzOQD0n3oSeRYf5wAFo/9u39C5Y/NtrJ/i5H6bwHhEOuHi65X/vTiqAJs
	DVz2ZZZ4WPSjZLTv2zTt829gl9/7fWVNBFA6rw2WZgIQ72No96kmCjzjmP4hOvjLqUhml4KsW7SZg
	y6mq0o9eAI7vT+1/2GIo5Nd4/9ditWbAOUmuaAIcdce1cQD3vmAed4uhE3enPpDhmdt9W8Pnpwypr
	8x/Hj+V1Rl9bPzPtTeblILsXiHJuw4BlBDy4S4YSiJ9OdlihAUC+O+CZc/bnaN5V/U8os5PoQQAPj
	RWts20E5wRuFavnkVLUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWVrr-0006ep-84; Tue, 11 Dec 2018 00:25:43 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWVrn-0006dv-M8
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 00:25:41 +0000
Received: by mail-wm1-x342.google.com with SMTP id a62so441811wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 16:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=G4OmV/lvcX0E5wDsLTOwegdQQwRmoI/WRDrorzA8PGc=;
 b=GjdeOLmq5TN9Ql8nsNY+HpjRip1iudHRxgxrFq4QVVsAZiu5RPLEtdfq+kryXR8KlO
 ECV95flpRGohzPbV/iagLQ62bO9gK8eHxuRUHWdq9WpHGu534Sjw+j8qCkkj8HuZKHxm
 8GMmRuqF9c2wXKGX/HombuNZ+6jmQrQ5FB4kR+hTEX/ob+z+bmQvrm2xFHGFCq36NAHD
 YBphAJL06qCbwSl5Hk2fOuO7gsxA6SV/r8yitefhZsAAkPWxY7N5+gniqm7jS+7uZ4tS
 RqbY8QbdKJDmmNVd9tB5dXEbrV+N4kx4/nDcVOFy+SG+P8iE3O8ssBcebB5jwH1wBhba
 0F4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=G4OmV/lvcX0E5wDsLTOwegdQQwRmoI/WRDrorzA8PGc=;
 b=PvTjsgpEYDAHR67hgHPCec9Cq0elHoLIp2gmGIM7xxe/azBbC0S8T2DyK0JoPWeCd5
 JW4i4IpBmLNlhQ6EtvSTWwBC/tny4ZjK0NwARPPh5ul5mV880klxrVJpFACj2TzU2BKW
 YtYYaXGeJ85E428LHmZtc34/bsMqnRKNOD+WAVBbeXwnEQSTa1BHOmMOJgTh30Lym4yZ
 /BWBPFzdYuJyIchDqCw1bYPjNjgcigVy0OWCfqzpD42D8+8DKm/JQQd899+8P5+JWhny
 R05GfujKbtEA2wQQ8kLLd8qNUB4n88OTWgDieOTve4Q43bWhFxmLPVgowA0vbuORllci
 6Wfw==
X-Gm-Message-State: AA+aEWZzxxlzqLBUER88JTmEEuL3xTjdXzvoBJA5eBTj9oGMDkSEDnTt
 Z6jtgMa6M9LxKzdf2I8l0ns=
X-Google-Smtp-Source: AFSGD/UvC0yldA5VpgOd+MLeODxPnEeTZmSZ4KM1XaSEWHPb26onz/GWqYIyJnkcz+RawTAd49Dc1Q==
X-Received: by 2002:a1c:2856:: with SMTP id o83mr417730wmo.45.1544487927267;
 Mon, 10 Dec 2018 16:25:27 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
 by smtp.gmail.com with ESMTPSA id c9sm510606wmh.27.2018.12.10.16.25.26
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Dec 2018 16:25:26 -0800 (PST)
Date: Mon, 10 Dec 2018 17:25:25 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH] pinctrl: aspeed: Wrap -Woverride-init with cc-option
Message-ID: <20181211002525.GA8468@flashbox>
References: <20181211000506.7559-1-natechancellor@gmail.com>
 <1544487006.3301683.1605247720.567E9685@webmail.messagingengine.com>
 <CACPK8XfxQxMqLo10FSRPHdUVt4vr5K32xB2C_SXLAPEza--v0w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACPK8XfxQxMqLo10FSRPHdUVt4vr5K32xB2C_SXLAPEza--v0w@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_162539_723918_2320BD0E 
X-CRM114-Status: GOOD (  15.64  )
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
Cc: linux-aspeed@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>,
 Linus Walleij <linus.walleij@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-gpio@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 10:46:26AM +1030, Joel Stanley wrote:
> On Tue, 11 Dec 2018 at 10:40, Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> >
> >
> > On Tue, 11 Dec 2018, at 10:35, Nathan Chancellor wrote:
> > > Clang does not support this option:
> > >
> > > warning: unknown warning option '-Woverride-init'; did you mean
> > > '-Woverride-module'? [-Wunknown-warning-option]
> > > 1 warning generated.
> > >
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> >
> > Acked-by: Andrew Jeffery <andrew@aj.id.au>
> 
> Thanks Nathan.
> 
> Andrew explained to me that this warning helps find bugs when
> developing the complicated (some would say crazy) set of macros that
> this pinctrl driver uses. It would be good to have this warning
> available in clang. Do we have a clang issue opened for that?
> 
> Acked-by: Joel Stanley <joel@jms.id.au>
> 
> Cheers,
> 
> Joel

Hi Joel,

I just opened https://github.com/ClangBuiltLinux/linux/issues/293.

I searched the LLVM issue tracker and haven't see any reference of this.
I can file an issue but if you are a little more familiar with this
warning, you are welcome to do it instead.

Thanks for the quick response,
Nathan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
