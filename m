Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2C6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:26:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6762F20859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="axERuWis";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gsOTKs4h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6762F20859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D5rH4lhU7u+QsSH/2IgGyVCd5v7vVVgLFeNjGN6f8fo=; b=axERuWis/EClQV
	CqB3JCJM6w/ziQ+59oaQb2MVwscIp8tdvMFg8AJQDFhZmmYUImSzmBCIWGJVxsHO572z8lW3ZwI2t
	eAsIcOf+s2v2KPleyylU0LA4Po6CGyI9U3ykwS/cewcoFGMRx2aHRFd7YkKyZVM6VKqmEyVRTWiy6
	r1QJxX0LIpK5+9ZHN1HapGng+gA0CL0mhnTny9FpPaCSOaeNPHuHAQt14V4nBJuKUiZt12jk1S41P
	Z0XTb7dt0/Z6d2WxqlVRzwYIjZDetm7OTkHzGh3fw2ZL4FjgebFfyy/JgGcbqVRb2bKcsT3Bl2OJT
	Pmza7DiWkzUvc7D9BgpA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwaKA-00070l-JD; Wed, 20 Feb 2019 22:26:42 +0000
Received: from mail-ua1-x944.google.com ([2607:f8b0:4864:20::944])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwaK6-0006ze-NO
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 22:26:40 +0000
Received: by mail-ua1-x944.google.com with SMTP id q17so8834040uam.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 14:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sDpL3gmbczax8ALdj7IVEn/cdMFCR2mdLaVqooKyfDU=;
 b=gsOTKs4hDJpCcYxXFAhd3Mw19bPjFasvElf6Yd9ikqATCYiclmkqOMIuNsxSoWBTPs
 cvv7KgIQk6dYFFcC6p6vp/e6zA3KSvygM6ZzD1xDWenkLj9Umc2pmNvwwnaR2e9iG5Eh
 /zlPXUrpCbDsPF9sQP3jSKppTz0LqL6aRU0M0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sDpL3gmbczax8ALdj7IVEn/cdMFCR2mdLaVqooKyfDU=;
 b=Z/mQ4nCijOhPYy7EKPW3JsO43phUC8WxBGa3W8U6ChZhlAxZLobYCqg9MlbQ81RTtY
 cALC9B28Ytm0j76u40cMjNQdPsW9CLtA0hSGk0CViYMCHAz01Ugu0l+YvZJD+0se0SHv
 Jk3svaEMTs+AWO+NeZzdNqyeuqQpHK5KjSxG64WMXyycpNZRKyL61hqefwcvBoO7U43q
 +K9mxc5YuQOrMdxxJcdbjBFxEy8c5Edu4FX5MCodvLqHI2dnHgHWnsmZKL8UPpt9eNjX
 WlQvjBZ36Jvn+t5uJRdEtwzn1tyWbeSD/RnugON0DptxlckH6myXst2DbDsHteR84rUh
 dxJA==
X-Gm-Message-State: AHQUAuadV0xmtSxx1fR694vjape7z25tUcwFxygTXTIWa+6TV+5zHMtc
 8KrYd2IHhl6Rj1g3FFWRX6spBMQ+iCA=
X-Google-Smtp-Source: AHgI3IY7fX88WnCtbXrhAM+MDrpU0yiXs5zrE/C7Fv6j9J40ohJ896llb2WUUBBJDDtmQQOaGK2frA==
X-Received: by 2002:ab0:6888:: with SMTP id t8mr18731916uar.87.1550701593989; 
 Wed, 20 Feb 2019 14:26:33 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com.
 [209.85.217.44])
 by smtp.gmail.com with ESMTPSA id l193sm7010762vka.19.2019.02.20.14.26.30
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 20 Feb 2019 14:26:30 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id u13so14062496vsk.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 14:26:30 -0800 (PST)
X-Received: by 2002:a67:ec81:: with SMTP id h1mr19076075vsp.188.1550701589790; 
 Wed, 20 Feb 2019 14:26:29 -0800 (PST)
MIME-Version: 1.0
References: <20190211181531.GA3238@embeddedor>
 <CAJKOXPeHp7sKkZ+jXmTXk5GEF_7G5ujfm3Lw==G3T4thfD+F7Q@mail.gmail.com>
 <CAGXu5jLMWrb4Dszv5YSyoGt5Lb3S1oE8EnKsTou7=7Nq1rEEVQ@mail.gmail.com>
 <155027728836.115909.11546859472583324712@swboyd.mtv.corp.google.com>
In-Reply-To: <155027728836.115909.11546859472583324712@swboyd.mtv.corp.google.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 20 Feb 2019 14:26:06 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJPfoYy20WrR5ghaSo88bsA75s-OyA4qt_3Vz0cJST_MQ@mail.gmail.com>
Message-ID: <CAGXu5jJPfoYy20WrR5ghaSo88bsA75s-OyA4qt_3Vz0cJST_MQ@mail.gmail.com>
Subject: Re: [PATCH] clk: samsung: s3c2443: Mark expected switch fall-through
To: Stephen Boyd <sboyd@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_142638_763856_19B6CB66 
X-CRM114-Status: GOOD (  21.31  )
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
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Tomasz Figa <tomasz.figa@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
 Kukjin Kim <kgene@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>,
 linux-clk@vger.kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 4:34 PM Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Kees Cook (2019-02-12 10:57:05)
> > On Mon, Feb 11, 2019 at 11:41 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > It is just the GCC which has to be fixed not the code. You want to
> > > adjust the code for specific version of GCC and what if GCC changes
> > > its warning? For example GCC might require "fall through: "... or any
> > > other syntax. Another point - what about clang's syntax?
> >
> > -Wimplicit-fallthrough=3 is stricter and maps to -Wextra, hence its
> > choice. GCC's levels were chosen based on the existing linters, static
> > analyzers, etc. The patterns are unlikely to change (see the gcc
> > man-page).
> >
> > Clang doesn't recognize anything in C mode (hopefully this will be
> > fixed in the future[1]).
> >
> > As long as one of the compilers is able to check this, we'll avoid the
> > bugs associated with this mis-pattern. Gustavo's efforts here have
> > found kind of a lot of bugs, so I think it's worth a little churn to
> > add these (and make minor adjustments to existing comments).
>
> Just curious, what compilation phase does this check run in? Could we
> gain a macro like FALLTHRU or even lowercase 'fallthru' that expanded to
> whatever the compiler wants to see and then there would only be "one
> way" to do this?  It would alleviate the above concerns, but maybe I'm
> rehashing something that's already been proposed and rejected.

When this got discussed a while back, the thinking was that since
we're also dealing with static analyzers (e.g. Coverity) and IDEs that
literally parse comments in the code, it was most sensible (at least
for now, prior to there being a formal C "fall through" statement --
there is for C++ but not yet for C), we'd stick to explicit comments.
In theory, we will be able to do a tree-wide change to add the C
statement once it exists.

> Of course, I'm happy to merge any of these patches that tweak things so
> no worries either way.

Thanks! :)

-- 
Kees Cook

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
