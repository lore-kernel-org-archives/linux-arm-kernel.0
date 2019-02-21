Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5225CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:43:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F9FA20836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VhvtK1YT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0V8xyxYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9FA20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:To:In-Reply-To:From:References:
	Message-ID:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+M8+NKZcDHwQLrkOPKvVAdq9czUvTnj9DHMSvm2wOhk=; b=VhvtK1YT0nFQ2j
	cwjcVaohcPAAAR+BpBl+k20LumN9oWLEpZD0j+hbgmBVogX+QbkdubZjAD4qaAgYisNjZAEpCzrHU
	mP3mP4RyY3/SWHWwO3eIiKZKEUO4n/VoP9UfSA/ip8gmNqZAa/He6MwZt3vR6S1ZfzJGyV3bIais0
	HbWcJavkCidIifym4V8JgHDaiu0o/RYhJ5/rN6v3158RXeLjAyY18K/pAioqdqfDC8KBxbDJegedB
	FNZXsZRZjhScZMtYFTemiGNRHQrU14D1FLuM2K8rBsgCW1borygSkeJTUdOR4rLD+/R8MPqyRNuAO
	3w4kdTPprL3EAKPoiwUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gww81-0008Dj-7E; Thu, 21 Feb 2019 21:43:37 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gww7y-0008DP-8K
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 21:43:35 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BE1372080F;
 Thu, 21 Feb 2019 21:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550785413;
 bh=1V1fa89HRlAZLgQ1xiUDViIqteCgMYcMAxRF6LJf0Sc=;
 h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
 b=0V8xyxYIpdrwrT/l137iDJ7ZvYdrbofQpFPP104vwYKJvlcyEMtcABdWGq8EAauIW
 mXXvmlsk3XMj/7921WXXe3hR7wlreFpLhIwK5zpRCMVgE7EcZSMEyp/x0eb79aI8Tj
 e3zmK+LW8ZztW8nQGRsKIdXXKIWwgXYuQYaV3dxA=
MIME-Version: 1.0
Subject: Re: [PATCH] clk: samsung: s3c2443: Mark expected switch fall-through
Message-ID: <155078541292.77512.12594007340364187685@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190211181531.GA3238@embeddedor>
 <CAJKOXPeHp7sKkZ+jXmTXk5GEF_7G5ujfm3Lw==G3T4thfD+F7Q@mail.gmail.com>
 <CAGXu5jLMWrb4Dszv5YSyoGt5Lb3S1oE8EnKsTou7=7Nq1rEEVQ@mail.gmail.com>
 <155027728836.115909.11546859472583324712@swboyd.mtv.corp.google.com>
 <CAGXu5jJPfoYy20WrR5ghaSo88bsA75s-OyA4qt_3Vz0cJST_MQ@mail.gmail.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <CAGXu5jJPfoYy20WrR5ghaSo88bsA75s-OyA4qt_3Vz0cJST_MQ@mail.gmail.com>
To: Kees Cook <keescook@chromium.org>
Date: Thu, 21 Feb 2019 13:43:32 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_134334_340936_7CAC1186 
X-CRM114-Status: GOOD (  22.18  )
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

Quoting Kees Cook (2019-02-20 14:26:06)
> On Fri, Feb 15, 2019 at 4:34 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > Quoting Kees Cook (2019-02-12 10:57:05)
> > > On Mon, Feb 11, 2019 at 11:41 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > >
> > > > It is just the GCC which has to be fixed not the code. You want to
> > > > adjust the code for specific version of GCC and what if GCC changes
> > > > its warning? For example GCC might require "fall through: "... or any
> > > > other syntax. Another point - what about clang's syntax?
> > >
> > > -Wimplicit-fallthrough=3 is stricter and maps to -Wextra, hence its
> > > choice. GCC's levels were chosen based on the existing linters, static
> > > analyzers, etc. The patterns are unlikely to change (see the gcc
> > > man-page).
> > >
> > > Clang doesn't recognize anything in C mode (hopefully this will be
> > > fixed in the future[1]).
> > >
> > > As long as one of the compilers is able to check this, we'll avoid the
> > > bugs associated with this mis-pattern. Gustavo's efforts here have
> > > found kind of a lot of bugs, so I think it's worth a little churn to
> > > add these (and make minor adjustments to existing comments).
> >
> > Just curious, what compilation phase does this check run in? Could we
> > gain a macro like FALLTHRU or even lowercase 'fallthru' that expanded to
> > whatever the compiler wants to see and then there would only be "one
> > way" to do this?  It would alleviate the above concerns, but maybe I'm
> > rehashing something that's already been proposed and rejected.
> 
> When this got discussed a while back, the thinking was that since
> we're also dealing with static analyzers (e.g. Coverity) and IDEs that
> literally parse comments in the code, it was most sensible (at least
> for now, prior to there being a formal C "fall through" statement --
> there is for C++ but not yet for C), we'd stick to explicit comments.
> In theory, we will be able to do a tree-wide change to add the C
> statement once it exists.

Ok, thanks for the background. Looks like the perf tool already
introduced the #define __fallthrough that they use for this purpose.
Maybe they're hoping that it will be formalized.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
