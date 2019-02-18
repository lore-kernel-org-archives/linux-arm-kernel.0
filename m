Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CECAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:26:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B42521848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JCdAHULc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="vSHv3Azy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B42521848
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cyhouMUEIXlouXW9UUriUMpOkTN3xXE5Bn6zcw/h3B8=; b=JCdAHULc04L0cB
	47Y0hqkGX/JV15wYD9xKQv2wzd26Lv+EQTcFKnXxu8VS3iA7Fxb6AFus8+i+Zi5AQp4dK01fAARnY
	+sTzUzcf1h67g+cW9lHQIzIE2rHFYOqwHeL57qIT1N8aGoXIm+R74qFqtj+vW/JQsEkBxjQpdpcPT
	Vv5yWsDmd9nz6gB2JOGkyTL1uE0COd1Klx5ni1VgUgM9dG45JXYBL+5i6i8+8vIFmAjAGuMNt8/4C
	LbGbnZOOsfiYYpDmb6fa3fY+74HQqXiUeOU8bNJX1wNVmoK5Pp8x9I0HLJeFhxPw5yAxMtIjfYYnN
	eE09gWbRBXNB7v4EShLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvknz-0005Sg-GG; Mon, 18 Feb 2019 15:26:03 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvknw-0005Rx-Fg
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 15:26:01 +0000
Received: by mail-pf1-x443.google.com with SMTP id s22so8742354pfh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 07:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jZM7ZiHVQG9OziFvs2AnUsvoK7AiW4q5xi1NxMlkl6g=;
 b=vSHv3AzyCbWSr589HtaNNKpur1UiY5+jPg8/vQQzllunLl/aDvzZK+Q5lq5iMCD3lk
 uYnjhCYIE3f3+guOw52YyDhPRUF5s+e1TEdMgmcFKjxaKfdv/EJpIg/WCBqtyFBlPIr0
 6g763Pd7QhyHS0zcTtyuVM89WL1po1l34Hxs+0w36MAp9B4TqSY8bACzWmXuRkNFd+5/
 GX/rC6AStlOkJJh/0HjqcslGd+B5Tr6t/9LR283Bg/qPh7lVc6kYEzGRk+1qFDaP3qJm
 r5uRlDmsTu2vxzN0xBHeDaW5SCd/9iYfCzSKdHFoFYEkKnM/yHrehoJF5/lEt2r2u7Lc
 pm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jZM7ZiHVQG9OziFvs2AnUsvoK7AiW4q5xi1NxMlkl6g=;
 b=ghXi5wQgSCpYDW+WXa1mXfbDeXEq+RRLjf0vbbIJySeZ+fFtDtKwFwSr8DAW0zIPgz
 bM0SHR9RLz5WNC9fd5EKuibL8MIO2v5iuA8gClM/kzcPOoqfEQ+uO0VLaS8wZquQr2AG
 yv1Ccd6kvaE1Q6JwXCbqYZFqr85Unzh9ApiWdAngoKBrrMz7QqAFiQjSsbwfAhhk8mQA
 sdhfpIoNOMElLizhp8EYcEFyi+GwVVqf/0E/MSXntSl9oXIPmKiUiIBgDecjnh7oOO07
 Z84eWikC2gwFDdiMlYq2xI6A/hFQ8+Sd9i437LHT1a1lB6lq5gWsA0+VdzVeLjMSYndu
 mKFw==
X-Gm-Message-State: AHQUAub9mQh1qySiGjRNEM/U6EGIqJ2+4F65DKTP0U7pIkbtwHoHGmcO
 W7lfgmpLTFlZZVD0OgEn0vvj2aHGLyDWtZjIKbnMgg==
X-Google-Smtp-Source: AHgI3IY3Y4pVRqsvmzgvBt01A6JRyNzrR6X8Dzlf1raJJfRx7vp4mMtvw/pULtIX4bcVD4+Xsnjy4WX7LSOWwwKdF/k=
X-Received: by 2002:a63:7f46:: with SMTP id p6mr23252259pgn.54.1550503556849; 
 Mon, 18 Feb 2019 07:25:56 -0800 (PST)
MIME-Version: 1.0
References: <20190217043434.46233-1-cai@lca.pw>
In-Reply-To: <20190217043434.46233-1-cai@lca.pw>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Mon, 18 Feb 2019 16:25:45 +0100
Message-ID: <CAAeHK+y8Xd1J2DppUMQLVhoc69wrqgNA=9hV45Jsd7V97CN6yw@mail.gmail.com>
Subject: Re: [PATCH] trace: skip hwasan
To: Qian Cai <cai@lca.pw>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_072600_548922_E2DD00CA 
X-CRM114-Status: GOOD (  13.98  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 kasan-dev <kasan-dev@googlegroups.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Feb 17, 2019 at 5:34 AM Qian Cai <cai@lca.pw> wrote:
>
> Enabling function tracer with CONFIG_KASAN_SW_TAGS=y (hwasan) tracer
> causes the whole system frozen on ThunderX2 systems with 256 CPUs,
> because there is a burst of too much pointer access, and then KASAN will
> dereference each byte of the shadow address for the tag checking which
> will kill all the CPUs.

Hi Qian,

Could you check if adding "CFLAGS_REMOVE_tags.o = -pg" into
mm/kasan/Makefile helps with that?

Thanks!

>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  kernel/trace/Makefile | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index c2b2148bb1d2..fdd547a68385 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -28,6 +28,11 @@ ifdef CONFIG_GCOV_PROFILE_FTRACE
>  GCOV_PROFILE := y
>  endif
>
> +# Too much pointer access will kill hwasan.
> +ifdef CONFIG_KASAN_SW_TAGS
> +KASAN_SANITIZE := n
> +endif
> +
>  CFLAGS_trace_benchmark.o := -I$(src)
>  CFLAGS_trace_events_filter.o := -I$(src)
>
> --
> 2.17.2 (Apple Git-113)
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
