Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC634C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:56:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C8D920848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lgFIlo2l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8D920848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bTMSfnmrZSvJc3JFdRONPlcJ8SmtgPliXyF1sBxcfQA=; b=lgFIlo2lZmaYB8
	B3t/dIkg9wpbvC2L0rG0q3Nc9/zQqp3uzUe3TbrFv1nxo2isMzS/VOt+U4motcR2jOX3hxXGY++be
	FZfmWk1J33pPAiHjIH6x72EXc9ZSCwSQ5bOUg7CFdU58UVTT4qw2Qh2brPTUIPvTutgQAiq72tj9W
	p77aKaGjiDoxXv+9hdjwmr39nBQv1/ulT410WXPRpzqnaSV/qS8OKBX53UHMwF4w8YxIfK5eZXa13
	WvxqMxbZDNv0QmxoUhwgQyAI5r9ferfCJ91pwtBWL/k6N+O65SgkHNPZOO0Fk/s+TeowWftq7dJiA
	kmGN3iA0gMnklXrkG1qA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTqa0-00066O-68; Mon, 03 Dec 2018 15:56:16 +0000
Received: from mail-ed1-f47.google.com ([209.85.208.47])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTqZx-00065U-7s
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 15:56:14 +0000
Received: by mail-ed1-f47.google.com with SMTP id h15so11182946edb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 07:56:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OAnxLB+TJ6bHatdarlSwB2K3TfkjfM4vuOINtj6TAao=;
 b=aNLnR6RPxrHK3iI3q93wFIjLfd5XTHSpC+9n5RrWOKIsVLt3f+F1q7heDwzVZ93euE
 8qoC7QzizQjcIWCpeyViHrC9lwyFYhvfLB79p1C3S4j3q6iFJawZJm/w33pJZdYvInQ+
 PVrRk8tmCRDPQoDidnZBDeUKNIvFrm3zNvi7nxIioLoaC4fz6QsHlfuV1eSAIIrAwbHX
 Wx9Dj6Roe0lPKFoFb+/Lnr3mhukzjaB0KXnmULN0wffU72eQdJ5jOKl1zYrN4iNlsOuA
 +KuMWC3QAuJj9AmbdvpYPyYNsnILX01QAn3B1Q8IH/dWAZeUJvANxpFbBwqZLof/1qHE
 4e6Q==
X-Gm-Message-State: AA+aEWY05Ich+rlUo+iemV7IQoxpwP3EsMyHiURU4TqZYv5JCQXYLEv4
 nyb/PT7CNEqYzEMPwQacdLlj+MHnAnlPgQ==
X-Google-Smtp-Source: AFSGD/WI2X/n6ERiZlEhg21rnUsrr7bnEshH3f8meqKawE14YUEuL35nRaeRjVo88wWzCn/ide9v2A==
X-Received: by 2002:a17:906:2083:: with SMTP id
 3-v6mr13492007ejq.145.1543852561449; 
 Mon, 03 Dec 2018 07:56:01 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com.
 [209.85.128.44])
 by smtp.gmail.com with ESMTPSA id x10sm3836852edb.58.2018.12.03.07.56.00
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 07:56:01 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id y139so6378457wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 07:56:00 -0800 (PST)
X-Received: by 2002:a1c:2382:: with SMTP id j124mr8653160wmj.14.1543852560391; 
 Mon, 03 Dec 2018 07:56:00 -0800 (PST)
MIME-Version: 1.0
References: <20181130053328.24183-1-wens@csie.org>
 <154356169535.88331.6559008649310425840@swboyd.mtv.corp.google.com>
In-Reply-To: <154356169535.88331.6559008649310425840@swboyd.mtv.corp.google.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 3 Dec 2018 23:55:49 +0800
X-Gmail-Original-Message-ID: <CAGb2v6507htA6HGn2HXgSHyWLp-Ny+XZiGQ1XFHU_CYyHhNYYw@mail.gmail.com>
Message-ID: <CAGb2v6507htA6HGn2HXgSHyWLp-Ny+XZiGQ1XFHU_CYyHhNYYw@mail.gmail.com>
Subject: Re: [PATCH] clk: sunxi-ng: h3/h5: Fix CSI_MCLK parent
To: Stephen Boyd <sboyd@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_075613_275071_E2D28863 
X-CRM114-Status: GOOD (  10.64  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
 Mike Turquette <mturquette@baylibre.com>,
 linux-clk <linux-clk@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 30, 2018 at 3:08 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Chen-Yu Tsai (2018-11-29 21:33:28)
> > The third parent of CSI_MCLK is PLL_PERIPH1, not PLL_PERIPH0.
> > Fix it.
> >
> > Fixes: 0577e4853bfb ("clk: sunxi-ng: Add H3 clocks")
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
>
> Acked-by: Stephen Boyd <sboyd@kernel.org>

Merged for 4.21. Thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
