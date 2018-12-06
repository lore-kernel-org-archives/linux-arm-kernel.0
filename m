Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31ABC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:09:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF92E2146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZrMlvv+x";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="etcSboKn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF92E2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1r7ygRgx1ea6eCQRidWAr8bsKRgd61aEWT/b0flI7ps=; b=ZrMlvv+xepC/03
	8PNiWkECQRgZo9BGvy/aZC/Lt5Ejq7vQF1uLLTK/H6NGdeU9smaYcYRkCY/EQDgYynnhmoK05sJdw
	onnm33OXB58rrzBUBjZjllkjgYkzXPnUUw7GcG/eDz3ZVuaofWWQEQjG21s4bwMK8CdTuS87eYSkP
	LKOXTqWmLOLy1hhddG0UseJMqg0nsXmNHba+QXf0PnvvUY0yQPrCyKiGMafHrRT/M/EleIYjMHr/x
	7qT17FD5qZBJq4ON1LLoV/A2vZgA0ArWHWLJP13myD1OFu7OskIqJgmnQaaPobH9JCc9QBpy+pZDM
	4iKohkoGK3IqRWDgZYsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUiA5-0001Rq-5T; Thu, 06 Dec 2018 01:09:05 +0000
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUi9z-0001Qy-8J
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 01:09:03 +0000
Received: by mail-yb1-xb41.google.com with SMTP id s8so7661254ybe.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 17:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/jINOn+sc+LBZeMo1BY7lNtqrudJ8L4pImVfyYsvKio=;
 b=etcSboKnrSf3gjBausw5JNUVn6fOhTzKy8NbTJP0l8Sx8LBzfCRlcFEvFoBahKoCRU
 77CDRPgCmWT79f81oyAaivKXiWM0RwLYNKLieoI9uM7Wn1XVPF2VLJP+Wji4xSZf7lWt
 P/oUFq1ndWet0jsCIMciqfiPHDjHUj73ntpWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/jINOn+sc+LBZeMo1BY7lNtqrudJ8L4pImVfyYsvKio=;
 b=PRRNRrviIxKHjmFG5NfNyJHqxuLKbeALJYTzNj7hBc6/I7Fs0x/w+r6Exnl4AqkitQ
 tmdtzLFWZuMVXPK2DlV1y5amEMyak5fZAHl9Gapxy/cvP0tWr4J1QADk7nlAT98+tzQ7
 EyQEnbX+2iWjxpdLCfxZ+MPQhrD049ANI40gxqvA2FF9ofrwINsjfEtRmwiiNjpheqNw
 OpC5SVt1s7fC9bY8OqEvi/Ny+bTpVXzUQ+ucsw27OxSeiNuFfM6/wrADnXH6cmV2tKML
 A0Ce9Ky576j9R8yYe/rQXVJl05ppAsaUo2XRLuyMtGAywbrAwet0UDU/M7WhdoiWyr/R
 UhTw==
X-Gm-Message-State: AA+aEWatc7BmD6vvdslRTpO5uI6iwPvjyqRLyJcuMh1I55MOYakhSnST
 cduTbEN9Kk6m6lzuYB4wgvPKN/GcmPE=
X-Google-Smtp-Source: AFSGD/US/Lyzakc20Ujg88htLrswqTxYJEfrzbwkUDYtcbMVP8IaimyYNBOhD+qeL+bBPzmiKNpDKQ==
X-Received: by 2002:a81:210b:: with SMTP id h11mr26292441ywh.299.1544058527065; 
 Wed, 05 Dec 2018 17:08:47 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com.
 [209.85.219.173])
 by smtp.gmail.com with ESMTPSA id w2sm7894882ywe.62.2018.12.05.17.08.45
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 17:08:46 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id j145so4910014ybg.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 17:08:45 -0800 (PST)
X-Received: by 2002:a25:a22a:: with SMTP id
 b39-v6mr26098595ybi.209.1544058525402; 
 Wed, 05 Dec 2018 17:08:45 -0800 (PST)
MIME-Version: 1.0
References: <20181130150859.27366-1-anders.roxell@linaro.org>
In-Reply-To: <20181130150859.27366-1-anders.roxell@linaro.org>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 5 Dec 2018 17:08:34 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+-w1qh3Jg6u8jM0XxFS-X4qJpzOtf_HO3eEjohL1dj=w@mail.gmail.com>
Message-ID: <CAGXu5j+-w1qh3Jg6u8jM0XxFS-X4qJpzOtf_HO3eEjohL1dj=w@mail.gmail.com>
Subject: Re: [PATCH 1/3] stackleak: mark stackleak_track_stack() as notrace
To: Anders Roxell <anders.roxell@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_170859_295601_037D5C96 
X-CRM114-Status: GOOD (  17.40  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 30, 2018 at 7:09 AM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> Function graph tracing recurses into itself when stackleak is enabled,
> causing the ftrace graph selftest to run for up to 90 seconds and
> trigger the softlockup watchdog.
>
> Breakpoint 2, ftrace_graph_caller () at ../arch/arm64/kernel/entry-ftrace.S:200
> 200             mcount_get_lr_addr        x0    //     pointer to function's saved lr
> (gdb) bt
> \#0  ftrace_graph_caller () at ../arch/arm64/kernel/entry-ftrace.S:200
> \#1  0xffffff80081d5280 in ftrace_caller () at ../arch/arm64/kernel/entry-ftrace.S:153
> \#2  0xffffff8008555484 in stackleak_track_stack () at ../kernel/stackleak.c:106
> \#3  0xffffff8008421ff8 in ftrace_ops_test (ops=0xffffff8009eaa840 <graph_ops>, ip=18446743524091297036, regs=<optimized out>) at ../kernel/trace/ftrace.c:1507
> \#4  0xffffff8008428770 in __ftrace_ops_list_func (regs=<optimized out>, ignored=<optimized out>, parent_ip=<optimized out>, ip=<optimized out>) at ../kernel/trace/ftrace.c:6286
> \#5  ftrace_ops_no_ops (ip=18446743524091297036, parent_ip=18446743524091242824) at ../kernel/trace/ftrace.c:6321
> \#6  0xffffff80081d5280 in ftrace_caller () at ../arch/arm64/kernel/entry-ftrace.S:153
> \#7  0xffffff800832fd10 in irq_find_mapping (domain=0xffffffc03fc4bc80, hwirq=27) at ../kernel/irq/irqdomain.c:876
> \#8  0xffffff800832294c in __handle_domain_irq (domain=0xffffffc03fc4bc80, hwirq=27, lookup=true, regs=0xffffff800814b840) at ../kernel/irq/irqdesc.c:650
> \#9  0xffffff80081d52b4 in ftrace_graph_caller () at ../arch/arm64/kernel/entry-ftrace.S:205
>
> Rework so we mark stackleak_track_stack as notrace
>
> Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  kernel/stackleak.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/stackleak.c b/kernel/stackleak.c
> index e42892926244..5de3bf596dd7 100644
> --- a/kernel/stackleak.c
> +++ b/kernel/stackleak.c
> @@ -102,7 +102,7 @@ asmlinkage void stackleak_erase(void)
>         current->lowest_stack = current_top_of_stack() - THREAD_SIZE/64;
>  }
>
> -void __used stackleak_track_stack(void)
> +void __used notrace stackleak_track_stack(void)
>  {
>         /*
>          * N.B. stackleak_erase() fills the kernel stack with the poison value,
> --
> 2.19.2
>

Acked-by: Kees Cook <keescook@chromium.org>

Steven, I assume this series going via your tree?

-- 
Kees Cook

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
