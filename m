Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E867C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 07:30:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D66B21B69
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 07:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HKmPJWEg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="IpScjLrT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D66B21B69
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=38FNiD+lBjBYUdnA0KLIq4Udh/e7u4PBR8V9KfI0G5Y=; b=HKmPJWEgwpJaDA
	SeVHqv3xWnc03h8P5a0u7kur6YFdDyfvewicF+ttHyIAkzfqOvhbaJy8uS0J+Mkj0I8iGCaz2VhVH
	WztXw5aMl26J26RgBfWArKNPJDZsNHxuwhPrX32NyHX2VSSl0J+VEte5nkRgnCxGCDCzJ55cxghZs
	z5xNHb43viY1e0fml9gvcKocVIIrQ3U+FLuUy375XF7mfmIV7SoEaGo97YJ4fJ7aO0gLesE1mj9dn
	rUio9xfSJGUFOKh6H7EPKvEz1T/J78RT6653Tw+nBgt+omCcr1uvNB2aUvqlQtGP6jRmzr6JR4ZJP
	SCNBFzDkrIpESkyMgC3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvGuT-0006Ws-KG; Sun, 17 Feb 2019 07:30:45 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvGuQ-0006WZ-4V
 for linux-arm-kernel@lists.infradead.org; Sun, 17 Feb 2019 07:30:43 +0000
Received: by mail-it1-x141.google.com with SMTP id d125so8920059ith.1
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 16 Feb 2019 23:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nB8m/G/yjJJ5tRJEh/5vp8eT+5HSD9oX2DbxFowzUq0=;
 b=IpScjLrTWaIKybjutJv/qZutcf7GeOJ4wdG44uFSpR9ZvywHEiKPM77HVvndjrkPqa
 Bl9H/MDGFJq2Cae4tElfomB5ShsOCpU/bNbT6Z55lGwLniUaIfRaxvfMJz1x+/MgWFVh
 w719tOL26PCZST5CVDi0XSQNlm/gEUyaqVklE/kID5STHsYY0KUX1jJFYGH1asGWZLjc
 8F9K5uDP0xNp1vbZKspRISycpyicihKJGYDe7s6GHKcZ9EZzWDJfw5tkZZNUafvo+CSM
 /t/U8877Bzwnf6blEXtMtZdEUl+ccXuxx/NqoOrosmTaHCVkmtViGlDscK177ap6NOpz
 swHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nB8m/G/yjJJ5tRJEh/5vp8eT+5HSD9oX2DbxFowzUq0=;
 b=Ip2dW2US7Sw3C4QJekeaOGdwZQdwrSI/rHpquIeA1FixqWdGBcWJrVUCMXbtcCRq+U
 blp6LDohTWCdjtf7Rbs/jR4Q1dHO6h34YPCXOc5EkQfPpQzLu45dhjB8pBxJuF+R5zcZ
 7YEQ/ROpWlyhgUw31zZFRuGZFdIHEy6bR0oTOJBtZLaP4LSvHfdfb9gQYU8JX2tFtfJ9
 Qd6da5EUzvXzAhuF6BYapZb6bKkR5ZVCUNWznbjCjAJ2n8OSw4axh++Ckg0kzFAjpnNQ
 n6QQy7lxFnrGqkJm+CdD5p/ZWYpSuqWEOer02ui/2JX/Z2zLujYLplfhT159afxKs0T7
 VKUA==
X-Gm-Message-State: AHQUAuaFnZEaAB3g25qXDY1Wg9EqCQ8dB5LlHR9cyOqw0OZ1Z0t4VOb3
 PvfAPYxgBdSYpW+10TEKHL5TLPblapzjvUivSq69cw==
X-Google-Smtp-Source: AHgI3IZz3NiMhZ6+RJejFNWSPS04S4qmtJR0hLYMDQfWhvtgILLIS1ZNbRcZIxb881FrmQ0uevlc9V4wyOpbBWAUrZk=
X-Received: by 2002:a6b:6b18:: with SMTP id g24mr9180689ioc.282.1550388637986; 
 Sat, 16 Feb 2019 23:30:37 -0800 (PST)
MIME-Version: 1.0
References: <20190217043434.46233-1-cai@lca.pw>
In-Reply-To: <20190217043434.46233-1-cai@lca.pw>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Sun, 17 Feb 2019 08:30:25 +0100
Message-ID: <CACT4Y+ZYd0LFLJTwBbPRXpS1SorgPjN6c6woUB+25Vd6GuStsw@mail.gmail.com>
Subject: Re: [PATCH] trace: skip hwasan
To: Qian Cai <cai@lca.pw>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190216_233042_202732_612F3218 
X-CRM114-Status: GOOD (  22.73  )
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
 Andrey Konovalov <andreyknvl@google.com>,
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

Could you please elaborate what exactly happens and who/why kills
CPUs? Number of memory accesses should not make any difference.
With hardware support (MTE) it won't be possible to disable
instrumentation (loads and stores check tags themselves), so it would
be useful to keep track of exact reasons we disable instrumentation to
know how to deal with them with hardware support.
It would be useful to keep this info in the comment in the Makefile.

Thanks

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
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To post to this group, send email to kasan-dev@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20190217043434.46233-1-cai%40lca.pw.
> For more options, visit https://groups.google.com/d/optout.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
