Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E23C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:32:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A0A120878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P9uDE0sd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RqdhxaXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A0A120878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NJ0W9EhoHAV65gig2It31taeNoHGmD1eO2DmgKZkJqc=; b=P9uDE0sd14s4Ov
	OBD6+KsEhc/3uwmt1DsQbdjbl2rMKhTcg4AMwqH/IQ37aTgA63Pi++ilQqHgS/GaPSKLt8eozbslN
	XBkpQfeWwko6H0YqmOakQT/V4cCPpNQIk9EmxQhZuQjFKy6VoHwAC8j5ZJwR2fJivTzFYxcRJQo0/
	Azk8pD8CqVlcxbbGxqP2bTx5iTVz0BuCb+91ErPWEWMHJU7m8QjHVxrQfZ+MPOUq6UPpclgQdjj6z
	Y3b6Xz+rjF80kgtln/ZjQIgzO0h8maUxpDX8JPm59mTJftV/Zf75ii/QxxoFt4nqGgXZeMK3pjYsP
	Nt1VeFRVJR2rUD8g8BSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUuho-0001Y1-32; Thu, 06 Dec 2018 14:32:44 +0000
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUuhi-0001TW-Bb
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 14:32:41 +0000
Received: by mail-yb1-xb42.google.com with SMTP id c15so507420ybf.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 06:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8bt24wXJlB3M/lDvnWLoRBJfRvQJynIF1gj//D6t4kE=;
 b=RqdhxaXaklLfJhhFhrxdX9K5yq6mS2gD8V05fAbaHStZNCXxlBQj0Rba103nEt8lLG
 e6FNc9PVakXQAw3cGQGkqic+hVAuYUACuIYzVizlIiKfW3bOEPOxAnE1jHoa8Mqc2Wf/
 7dTcj3XHh6VeiuYOXlv+neq7XwNVb0aXT+O5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8bt24wXJlB3M/lDvnWLoRBJfRvQJynIF1gj//D6t4kE=;
 b=SlxSmtsfuxFY2Hf4/SvlQdVSEhHZleGnFT6YYPlZ2E+1fLuWIT6i03a2NLAt+nJC6P
 UZPriSz1qTmrMCXKZ2a3rpRvBP+nLj5gBBRdNcAPEVwWoGNju+akHdIT8MlziaoIuC/L
 SUoXLlC9Cf6BABkL5cx+yR49VjuX0o/sEpmlEPkpqotulEfhd6yvlkLA+dejry/eDv6w
 8aGuovPEOMnM9h+kMwjy2pd80Ei/ALL5Gg6F4y+9dKSQGY9pDabXl34y+6zP828WeA9/
 nqSjMdylbbUDoX5E1EIIyrHWXTSNG5wSRTE9zLTBRirsWHltWukLsdWdfJSBrIcvhR/d
 HLhQ==
X-Gm-Message-State: AA+aEWZ5hQgCl//fPmv92lAnxLSRrLvTrs7kJimRfyXITCbcPsN+zQ55
 6CouLdDQEyzolyjkWCiK7t2FGOdFxlROsePK5yp+yg==
X-Google-Smtp-Source: AFSGD/Um+cJmXOuxgR3+SYM1Jq+ZoIjCegGDQOkEqD82DXhVmW4upKUoiNAR1zOZCuOdSqKpeQp7CP3blnSKFj0FKXM=
X-Received: by 2002:a25:1e07:: with SMTP id e7mr460831ybe.195.1544106746892;
 Thu, 06 Dec 2018 06:32:26 -0800 (PST)
MIME-Version: 1.0
References: <20181205174852.435233070@goodmis.org>
 <20181205183303.828422192@goodmis.org>
In-Reply-To: <20181205183303.828422192@goodmis.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 6 Dec 2018 15:32:15 +0100
Message-ID: <CADYN=9LVL-FHvcoeXWvCVGCDvXmgT5mGtEdSm0JSzgeVCJ64qA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ftrace: Allow ftrace_replace_code() to be schedulable
To: rostedt@goodmis.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_063238_397205_ABD8A302 
X-CRM114-Status: GOOD (  24.22  )
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
Cc: Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mingo@kernel.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 5 Dec 2018 at 19:33, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
>
> The function ftrace_replace_code() is the ftrace engine that does the
> work to modify all the nops into the calls to the function callback in
> all the functions being traced.
>
> The generic version which is normally called from stop machine, but an
> architecture can implement a non stop machine version and still use the
> generic ftrace_replace_code(). When an architecture does this,
> ftrace_replace_code() may be called from a schedulable context, where
> it can allow the code to be preemptible, and schedule out.
>
> In order to allow an architecture to make ftrace_replace_code()
> schedulable, a new command flag is added called:
>
>  FTRACE_SCHEDULABLE
>
> Which can be or'd to the command that is passed to
> ftrace_modify_all_code() that calls ftrace_replace_code() and will have
> it call cond_resched() in the loop that modifies the nops into the
> calls to the ftrace trampolines.
>
> Link: http://lkml.kernel.org/r/20181204192903.8193-1-anders.roxell@linaro.org
>
> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Tested-by: Anders Roxell <anders.roxell@linaro.org>

Cheers,
Anders

> ---
>  include/linux/ftrace.h |  1 +
>  kernel/trace/ftrace.c  | 19 ++++++++++++++++---
>  2 files changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index dd16e8218db3..c281b16baef9 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -389,6 +389,7 @@ enum {
>         FTRACE_UPDATE_TRACE_FUNC        = (1 << 2),
>         FTRACE_START_FUNC_RET           = (1 << 3),
>         FTRACE_STOP_FUNC_RET            = (1 << 4),
> +       FTRACE_SCHEDULABLE              = (1 << 5),
>  };
>
>  /*
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 77734451cb05..74fdcacba514 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -77,6 +77,11 @@
>  #define ASSIGN_OPS_HASH(opsname, val)
>  #endif
>
> +enum {
> +       FTRACE_MODIFY_ENABLE_FL         = (1 << 0),
> +       FTRACE_MODIFY_SCHEDULABLE_FL    = (1 << 1),
> +};
> +
>  static struct ftrace_ops ftrace_list_end __read_mostly = {
>         .func           = ftrace_stub,
>         .flags          = FTRACE_OPS_FL_RECURSION_SAFE | FTRACE_OPS_FL_STUB,
> @@ -2415,10 +2420,12 @@ __ftrace_replace_code(struct dyn_ftrace *rec, int enable)
>         return -1; /* unknow ftrace bug */
>  }
>
> -void __weak ftrace_replace_code(int enable)
> +void __weak ftrace_replace_code(int mod_flags)
>  {
>         struct dyn_ftrace *rec;
>         struct ftrace_page *pg;
> +       int enable = mod_flags & FTRACE_MODIFY_ENABLE_FL;
> +       int schedulable = mod_flags & FTRACE_MODIFY_SCHEDULABLE_FL;
>         int failed;
>
>         if (unlikely(ftrace_disabled))
> @@ -2435,6 +2442,8 @@ void __weak ftrace_replace_code(int enable)
>                         /* Stop processing */
>                         return;
>                 }
> +               if (schedulable)
> +                       cond_resched();
>         } while_for_each_ftrace_rec();
>  }
>
> @@ -2548,8 +2557,12 @@ int __weak ftrace_arch_code_modify_post_process(void)
>  void ftrace_modify_all_code(int command)
>  {
>         int update = command & FTRACE_UPDATE_TRACE_FUNC;
> +       int mod_flags = 0;
>         int err = 0;
>
> +       if (command & FTRACE_SCHEDULABLE)
> +               mod_flags = FTRACE_MODIFY_SCHEDULABLE_FL;
> +
>         /*
>          * If the ftrace_caller calls a ftrace_ops func directly,
>          * we need to make sure that it only traces functions it
> @@ -2567,9 +2580,9 @@ void ftrace_modify_all_code(int command)
>         }
>
>         if (command & FTRACE_UPDATE_CALLS)
> -               ftrace_replace_code(1);
> +               ftrace_replace_code(mod_flags | FTRACE_MODIFY_ENABLE_FL);
>         else if (command & FTRACE_DISABLE_CALLS)
> -               ftrace_replace_code(0);
> +               ftrace_replace_code(mod_flags);
>
>         if (update && ftrace_trace_function != ftrace_ops_list_func) {
>                 function_trace_op = set_function_trace_op;
> --
> 2.19.1
>
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
