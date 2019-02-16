Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F9DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 00:34:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A413222DF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 00:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pgLdUcZ1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuejumCF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A413222DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:References:Message-ID:Subject
	:In-Reply-To:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bp+5U5ij+ok+aanxSNJEW6ZLG/wkf2tQFfZgNVWYd1g=; b=pgLdUcZ1yhZl4u
	v3prF2RIJPYi57xS5dFtmgGSl/FwtCikBH5xkL1jlO2LGCREFBeHN9XBfyko+16QRDCVOLMGMilpy
	D1L96ERy165k3nT17DmvOHct1Bd7/so3DoqQ6iX43X3DpkuTQpX1zJeGyQ3dRU+N4FaczPwZ5/mKy
	DkinAXoynW0I0GFQZ8SwU086zgaN9a46ZFp+driBOsp6OHLH1yVjZStiPAVsns7Jh9c/of686TDef
	3yIMlaI/6QOipXeH4/wCHPNPl4eXcLdKQPGxrcyGCybc9EeQ8L9tQXi1BEdtzaArwPlzjCA0C9ex3
	ogjBPENsprY8MQ8TZzVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gunwS-0005tT-O7; Sat, 16 Feb 2019 00:34:52 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gunwP-0005t6-Ks
 for linux-arm-kernel@lists.infradead.org; Sat, 16 Feb 2019 00:34:50 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2D300222A1;
 Sat, 16 Feb 2019 00:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550277289;
 bh=SHAAVlBJeDON/otkufPWmGdDwhNYTy9ivi6Y24AuRIo=;
 h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
 b=kuejumCFShtSikelEQ2ReeQKqIMwNL7UXdvxSJXGGNjPLeBKqfydpIFj4oLzCTrNC
 IM81tHsLCcBwMCJZNlQZ5qLmiRjdjID5lVmXPO9PAedOIBlSChzina2+r+c4DgTA8z
 JiYkjuCYomxt+2Mq1yM4tq3FPWG09e675bytJrpo=
MIME-Version: 1.0
To: Kees Cook <keescook@chromium.org>, Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <CAGXu5jLMWrb4Dszv5YSyoGt5Lb3S1oE8EnKsTou7=7Nq1rEEVQ@mail.gmail.com>
User-Agent: alot/0.8
Subject: Re: [PATCH] clk: samsung: s3c2443: Mark expected switch fall-through
Message-ID: <155027728836.115909.11546859472583324712@swboyd.mtv.corp.google.com>
References: <20190211181531.GA3238@embeddedor>
 <CAJKOXPeHp7sKkZ+jXmTXk5GEF_7G5ujfm3Lw==G3T4thfD+F7Q@mail.gmail.com>
 <CAGXu5jLMWrb4Dszv5YSyoGt5Lb3S1oE8EnKsTou7=7Nq1rEEVQ@mail.gmail.com>
From: Stephen Boyd <sboyd@kernel.org>
Date: Fri, 15 Feb 2019 16:34:48 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_163449_703623_774FEAB2 
X-CRM114-Status: GOOD (  13.88  )
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
 Tomasz Figa <tomasz.figa@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 Chanwoo Choi <cw00.choi@samsung.com>, Kukjin Kim <kgene@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Kees Cook (2019-02-12 10:57:05)
> On Mon, Feb 11, 2019 at 11:41 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > It is just the GCC which has to be fixed not the code. You want to
> > adjust the code for specific version of GCC and what if GCC changes
> > its warning? For example GCC might require "fall through: "... or any
> > other syntax. Another point - what about clang's syntax?
> 
> -Wimplicit-fallthrough=3 is stricter and maps to -Wextra, hence its
> choice. GCC's levels were chosen based on the existing linters, static
> analyzers, etc. The patterns are unlikely to change (see the gcc
> man-page).
> 
> Clang doesn't recognize anything in C mode (hopefully this will be
> fixed in the future[1]).
> 
> As long as one of the compilers is able to check this, we'll avoid the
> bugs associated with this mis-pattern. Gustavo's efforts here have
> found kind of a lot of bugs, so I think it's worth a little churn to
> add these (and make minor adjustments to existing comments).

Just curious, what compilation phase does this check run in? Could we
gain a macro like FALLTHRU or even lowercase 'fallthru' that expanded to
whatever the compiler wants to see and then there would only be "one
way" to do this?  It would alleviate the above concerns, but maybe I'm
rehashing something that's already been proposed and rejected.

Of course, I'm happy to merge any of these patches that tweak things so
no worries either way.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
