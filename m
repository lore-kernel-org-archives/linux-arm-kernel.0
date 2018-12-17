Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D9AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:16:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B00321839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 06:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sW0jSRM0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aUBd9zzV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B00321839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tOnx65Tr+m2NfjQ9kMtmY+O4QSypM94oybNX4N9ndx0=; b=sW0jSRM05fMv3B
	hTC+kuUEUwZ8Tz96AgFEpOP81CVhO8k4JJSH12Rwo7siRwMdXnwK1E6QZx/ZpY1gKqRUQ/GOynSuZ
	+QMhyi5wS/hxFWLtBkUjpRnHjstHo6Sabq6ukp4QAdE9QZjr7TF+X1WAK5vh0n/AUih+FXglMAf7E
	wkuvc1Wf6vUHJXPRKWE8wBLbL5ib8pvqLkHk5GLhvvZMTx3S+lH++Umyac1N3h5C3ABAwZ2s1Hkis
	DDGj09dF7KpkDFtcqDu73gChpPR2A69tKIY1dreEJhPGGiZBb3WCydRBsTn9s9SQ52HEq0lMXe6Q2
	f1KJTmJiMSEqcxXx+POg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYmCZ-0008Gs-QX; Mon, 17 Dec 2018 06:16:27 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYmCV-0008GL-Kk
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 06:16:25 +0000
Received: by mail-pl1-x643.google.com with SMTP id p8so5623154plo.2
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 16 Dec 2018 22:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=AFpXFwHMVO/VpPcfAVPRAu1XtJGJYWGygCyS0HseBIs=;
 b=aUBd9zzVxe70o2CMwY1samH0vs0vIfuBZj0lpIQn1OdZjB+m76kdR0QEIaK3TPKxlS
 2poA4ElRgLx7BulLv1aI/FGclF0J80fo+/ZwGcUDsgy9JZWVIk2AY4xiRifjgVRQRRVs
 Q9u5CENsDLs9M5BJDchPE3sQPMyAiRnDBK3iQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=AFpXFwHMVO/VpPcfAVPRAu1XtJGJYWGygCyS0HseBIs=;
 b=KYOsWhE+J65O2Oj8lGmzXJATLbTKJ7hbEiwo6KUV8Yo3pI/OIXq/95iT5VbA2WM+2z
 9bwLQqOOXHr/S8piuJogjNl5q4ewJkfTMcJXwJyQEBa7C3QWqDzvMSVreIjOEWMX1FOh
 C+bKFc0duUUVwOHAHGxLqCFcAKgAEFLjuzTCXeOGgDp/qBUKPykJWJHH96qw0cAnSdE2
 mpaZA84wCsclqcrH5gS8kiQJshT/Yu8K+58gChEYWC5wnEsShl6gNi9Pyh//jwy10UaM
 X8lhGwSCR+dAXuVldhx1NLhQJLxGXzWrWoiz2XlDxgJ73mNJJSaQBMXQSnbbQ4LFgcGu
 74Sw==
X-Gm-Message-State: AA+aEWb7sJQO744uUa2kDyO3ipdgVv4ZofL2Dh17oKC2Ybkgr+paoCI5
 iAA8bdpjkSKRticUdnYA553stzYHJ84=
X-Google-Smtp-Source: AFSGD/V+k/wR80NnjlQgxjpnB+3Q5j9PbkMWzvuIT432n49WravvLY8fZCE61nhk0nLgqXwnsvvXGQ==
X-Received: by 2002:a17:902:9692:: with SMTP id
 n18mr11848766plp.333.1545027372246; 
 Sun, 16 Dec 2018 22:16:12 -0800 (PST)
Received: from localhost ([122.172.23.29])
 by smtp.gmail.com with ESMTPSA id b26sm24549336pfe.91.2018.12.16.22.16.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 16 Dec 2018 22:16:10 -0800 (PST)
Date: Mon, 17 Dec 2018 11:46:08 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 9/9] ARM: smp: remove arch-provided "pen_release"
Message-ID: <20181217061608.tlxl24xwfksadj4d@vireshk-i7>
References: <20181213175952.GC26090@n2100.armlinux.org.uk>
 <E1gXVIY-0008DI-MU@rmk-PC.armlinux.org.uk>
 <20181214043923.2gusomvei424vw7m@vireshk-i7>
 <20181214131200.GL9507@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181214131200.GL9507@n2100.armlinux.org.uk>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_221623_691713_C06F11E2 
X-CRM114-Status: GOOD (  20.51  )
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
Cc: Barry Song <baohua@kernel.org>, linux-samsung-soc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-oxnas@groups.io,
 Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
 Viresh Kumar <vireshk@kernel.org>, linux-omap@vger.kernel.org,
 linux-soc@vger.kernel.org, Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 14-12-18, 13:12, Russell King - ARM Linux wrote:
> On Fri, Dec 14, 2018 at 10:09:23AM +0530, Viresh Kumar wrote:
> > On 13-12-18, 18:01, Russell King wrote:
> > > diff --git a/arch/arm/mach-spear/generic.h b/arch/arm/mach-spear/generic.h
> > > index 909b97c0b237..815333fc320c 100644
> > > --- a/arch/arm/mach-spear/generic.h
> > > +++ b/arch/arm/mach-spear/generic.h
> > > @@ -20,6 +20,8 @@
> > >  
> > >  #include <asm/mach/time.h>
> > >  
> > > +extern volatile int prima2_pen_release;
> > 
> >                        prima2 ?
> > 
> > I haven't tried but this may cause build regressions as well, I am
> > surprised on how this passed for you.
> 
> Thanks.
> 
> These patches aren't all build tested -

Ah okay.

> I don't see the point of wasting
> hours build testing when these platforms /really/ need something better.

I was expecting it to be build tested at least, to be honest. But anyway, we
will see build failures from bots if any such cases exist.

> This is not supposed to be a finished patch, but a patch to get folk
> to do something about this issue.
> 
> Please fix this issue properly.  I can't give you a patch to do that,
> you need to sort it yourself, but failure to do anything _will_ result
> in an updated version of this patch being merged.

Yeah, I know. I have seen the thread and it was lack of knowledge in the
beginning which made us copy code from rest of ARM platforms. That was stupid
and there can't be any excuse for that.

Unfortunately, I don't have access to hardware to test this stuff and so
wouldn't be possible to send a patch as well.

Lets get your patch merged at least.

-- 
viresh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
