Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1E5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:23:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 178BD20818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZbhGxzVk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jribNhnq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 178BD20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Vjt11+pljqRC/IaZKOQQaK4MwrW+jGxUfUu4n+F/vhY=; b=ZbhGxzVkJ/Y+dT
	T7kaGgh1PjTjjHP4+s58Gyx1Jf8xnKwHWw/VLmA6S8RPr1jrBO6LGdjJs8TC87YKrA5S05ZyUzoO+
	Jk7HYxUBZ2b4b1VQqtFh3wNiI0XjsyNViOh+HhPeTrjS7/D149RU2kNbBMBSjn2b3T6kT0qXQ5w+W
	WyoXvnf/JZxu1CyUvMfP/5IvKK57XcDGqog5poThQbfTbjeUi6KPpdOiW3DlTpzfMKqrwFAwlzZ75
	TUt1X/V2pyko7E+1Kr/+Rrqb0lXOF0NctVMcO5X8tLHO6YV4Z31+dNzWdhySl0oeqX4iWHXfpbmfJ
	a2NxCE21sAfGYgoRgo4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwwkv-0007Vs-5l; Thu, 21 Feb 2019 22:23:49 +0000
Received: from mail-ua1-x942.google.com ([2607:f8b0:4864:20::942])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwwkj-0007US-6M
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 22:23:47 +0000
Received: by mail-ua1-x942.google.com with SMTP id z11so170935uaa.10
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 14:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0Tho6tIvUAYXamApnhuj/cUi3XD+QjFAtPYIAiUbXtI=;
 b=jribNhnqegu9qG91m4As5lZqDEGL7Duow2YEhm51aIDUM1n4ejizLIN230nxNTGUV3
 WNuBmGxc0U3zfJ5RqfH+qscO5StQmvwdbWrsa/KQAspcpRnNAlk5itPT2kac+7RiylfP
 WmFlHD8fQWl+q+blAKtgBaE/bTqgrjEEfBUME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0Tho6tIvUAYXamApnhuj/cUi3XD+QjFAtPYIAiUbXtI=;
 b=OMQDQZiJjq9Wf5AM4lEZqVcmAfmrJ0IR4ndbQfr/IfnNNosOqG0SjQCFYQNvmELBNO
 82ruteFbdgO4vBbCVege/Gzq89GtmVYd347v6mOA2zp60M+KbgLDFyd6RQ+ZwI5M5+KV
 T9L/TeDTXpPfe09NT0mML9jfosFyVD46JNG28SmX4T6yB7lKSvia3h8oVYUjfvbnbxG5
 SXyDhKmfiv9sqhJR9Z0jSSrJxYIARmLbQfIbf9B8axUSJ53bFwgQjUS7xsjN6yqI93Uu
 KgS2J3OG/Ioo/5UNTemibPgN9tqNySw2nz15yqJEgVed2gKHlGjjh9gEAoe52S0B3/Mk
 GhCQ==
X-Gm-Message-State: AHQUAuZPECZ3urKk6ycLcLMm5+/PMYUcgrU2UTl+AFAivih3bSnm+mwh
 GY3gOmC+Ya7i6RcY1xnAyAh1UlXhC6k=
X-Google-Smtp-Source: AHgI3IYM7+KvQcv29S13N3x/9GtEvF01ldU7kbyVZxA+omD/2O8eXXkR9Jt2uDK4z34hTpiSioIiUQ==
X-Received: by 2002:a67:8106:: with SMTP id c6mr419880vsd.99.1550787813651;
 Thu, 21 Feb 2019 14:23:33 -0800 (PST)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com.
 [209.85.221.173])
 by smtp.gmail.com with ESMTPSA id i69sm132456vsd.16.2019.02.21.14.23.30
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 Feb 2019 14:23:30 -0800 (PST)
Received: by mail-vk1-f173.google.com with SMTP id b6so51469vkf.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 14:23:30 -0800 (PST)
X-Received: by 2002:a1f:58d:: with SMTP id 135mr582859vkf.4.1550787809973;
 Thu, 21 Feb 2019 14:23:29 -0800 (PST)
MIME-Version: 1.0
References: <20190211181531.GA3238@embeddedor>
 <CAJKOXPeHp7sKkZ+jXmTXk5GEF_7G5ujfm3Lw==G3T4thfD+F7Q@mail.gmail.com>
 <CAGXu5jLMWrb4Dszv5YSyoGt5Lb3S1oE8EnKsTou7=7Nq1rEEVQ@mail.gmail.com>
 <155027728836.115909.11546859472583324712@swboyd.mtv.corp.google.com>
 <CAGXu5jJPfoYy20WrR5ghaSo88bsA75s-OyA4qt_3Vz0cJST_MQ@mail.gmail.com>
 <155078541292.77512.12594007340364187685@swboyd.mtv.corp.google.com>
In-Reply-To: <155078541292.77512.12594007340364187685@swboyd.mtv.corp.google.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 21 Feb 2019 14:23:18 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+_bm+usH+hK9Pz1hAS9qhmndhmt9Ue3T3Kdta3kk1LHg@mail.gmail.com>
Message-ID: <CAGXu5j+_bm+usH+hK9Pz1hAS9qhmndhmt9Ue3T3Kdta3kk1LHg@mail.gmail.com>
Subject: Re: [PATCH] clk: samsung: s3c2443: Mark expected switch fall-through
To: Stephen Boyd <sboyd@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_142346_166174_71B8676A 
X-CRM114-Status: GOOD (  14.15  )
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

On Thu, Feb 21, 2019 at 1:43 PM Stephen Boyd <sboyd@kernel.org> wrote:
> Ok, thanks for the background. Looks like the perf tool already
> introduced the #define __fallthrough that they use for this purpose.
> Maybe they're hoping that it will be formalized.

Yeah, GCC has an extension for it (but it's not yet part of the C
standard -- though there are open bugs against Clang to support it).
Our adoption of the markings, thanks to Gustavo's work, has rapidly
increased lately too (we started with something like 2400 instances
and we were gaining about as many each cycle as we removed). 5.1,
though, is closing in on _0_ instances. My thinking is that once we're
to the point where we can globally enable -Wimplicit-fallthrough, then
we can depend on the compiler to enforce this (instead continuing to
depend on external tracking in Coverity and the like). It was a bit of
a chicken-and-egg and I was afraid we were going to be left with this
"partial adoption" for a long time. But we're nearly to the point
where I would be happy doing a tree-wide replacement to __fallthrough
(which should be mechanically easy).

-- 
Kees Cook

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
