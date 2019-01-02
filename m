Return-Path: <SRS0=RmN+=PK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87224C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:45:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 546AA2171F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ae24S8Pf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 546AA2171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1nti7kXFYUMkJp6U33cgTwa0QZQUsv/nKR1HJh3iMDc=; b=Ae24S8PfMnAnWp
	9Yyyphhta1MO2imD58Zwbdf7Oic57BWK1eWDtlcqZ8/cZKkWZy5XB2QgmPruug9oP/uwsL7h8YO68
	gqXl9933bSmgOOkbCS6aCCE+vBPk9fH0XyecPSZsaOzsLZmEbz/cXUdz1sualmWCzwQqXwQHzXM1O
	V8SEs8m4SXry+HjeKHs8EaanBYDPo7u/91UHXKWRUZLkNF/L29uqhgPzbij01M+KtgImT0v0cM6Ci
	+44kCycr8D8SPf9dWSyjSWipdM/H6q64cVFCwkdgaV1E20UUStKXqNKWvovgEBeDsXqDQsJsVKo5n
	SjMYNyNeK77YaA42L8qw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gee26-0004IL-La; Wed, 02 Jan 2019 10:45:54 +0000
Received: from mail-vk1-f194.google.com ([209.85.221.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gee22-0004Hv-RE
 for linux-arm-kernel@lists.infradead.org; Wed, 02 Jan 2019 10:45:52 +0000
Received: by mail-vk1-f194.google.com with SMTP id d201so6494509vka.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 02 Jan 2019 02:45:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=awM+1MIONbir+czdxrqyS1TXHcOMBg4YF74JgvwZLX0=;
 b=MDXjntFIDfvF3LiS/DV9IfYQjkbAp5znajpv95gSmxrKrnVGEB/Rd8vrp5A9mjYHNa
 nEsUXA8WmM+7jeMNe/W9rGF2DhYsWLeIQyp13tiWMKO+4sysIGqh3jY9f4XcUrp0UEKD
 mCjGHlwus+QsqDMBt0JQh+gUlAWmvkt9OmyPruc5gAma7glw5Pjf0P6g2QE9N/KIC1AL
 56byLObTATqr4RxiIcVwJFyardrEGw0qABDc8XDbHxyY70kA5zvfSA1l4Uos/EAK+EKU
 7ngpyddHj9/cDOC38KhEQ/4jwiKt5AWmLt/nFCpZAIDZEqSkpJBT2JImVG4Wpb99kHq1
 TbiQ==
X-Gm-Message-State: AJcUukdjvOvy26p6J+Ksp098foC1msHyZRGCXMzLb1ANrtgIITlSVMrm
 1DqP9XXTyUandZ5KRnaBWIJQoJzqMrD5WRh0Rzw=
X-Google-Smtp-Source: ALg8bN7OYBwFPd/csy3iOCTMz/bPfbWowFS5jL1K5rqgOgdeAr+MHIVD3qEdYKeavL+RyehW7rtDanqr6WBskG/1AwU=
X-Received: by 2002:a1f:2ed7:: with SMTP id u206mr15186748vku.72.1546425949147; 
 Wed, 02 Jan 2019 02:45:49 -0800 (PST)
MIME-Version: 1.0
References: <20190102095154.25839-1-horms+renesas@verge.net.au>
In-Reply-To: <20190102095154.25839-1-horms+renesas@verge.net.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 2 Jan 2019 11:45:37 +0100
Message-ID: <CAMuHMdU=aR8mSwd876LV=DG_vh6Bx45zxRTfMXuX3BQpy0M=ow@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: defconfig: Enable R-Car thermal driver
To: Simon Horman <horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_024550_882505_068356DD 
X-CRM114-Status: GOOD (  11.72  )
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
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 2, 2019 at 10:53 AM Simon Horman <horms+renesas@verge.net.au> wrote:
> Enable the R-Car thermal driver as a built-in.
>
> This driver is used in conjunction with the R-Car V3M (r8a77970),
> E3 (r8a77990) and D3 (r8a77995) SoCs.

> [v2] Enable as a built-in rather than a module as this seems
>      safer from the point of view of protecting equipment from
>      overheating.

Shouldn't the above paragraph be moved below the ---?

> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
