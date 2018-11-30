Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121F9C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:22:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D262820868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ijyKBPNx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D262820868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b19JWerwcF9L9OG7k7IyRlS+/39pktFZrrxcf5hi2BY=; b=ijyKBPNxoYOc7N
	7JnWIREvhOyUsS9ZO+5VjaQZp1RylJz5s6MtBTHXim5qJ8YplCQU/wNDrwgjeHJVzZEq6Hr0DS2kO
	5c2DAV71h24yli4oKpeNHjdC33C89cBiEZo1yAwr52/vL7qUIPnYYYOIDj9nkDv4Fcg1wSzwtxc1u
	L+HrQFD+K2ZsLm1CFet8NrEaPDHSTGLCXiYRXj/kZub6SDbJMgxwVYX3BV8eQ1TkdAf14IelyuGva
	/OO3WoMb5NlPiYI1qEIk5WsVAKSi5XsqesmiS6/eJZJh0f1/0gJk2JU5DK0jZS7AlN1fGoNJfEH6q
	/gpAw4oU8VJyJKylY4pA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSkcf-0000UX-La; Fri, 30 Nov 2018 15:22:29 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSkcc-0000Rg-LD
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 15:22:28 +0000
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com
 [66.24.56.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8724C20868;
 Fri, 30 Nov 2018 15:22:15 +0000 (UTC)
Date: Fri, 30 Nov 2018 10:22:14 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH 2/3] tracing: instruct KCOV not to track tracing files
Message-ID: <20181130102214.21e1f8f6@gandalf.local.home>
In-Reply-To: <20181130150935.27493-1-anders.roxell@linaro.org>
References: <20181130150935.27493-1-anders.roxell@linaro.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_072226_718516_30DFF455 
X-CRM114-Status: GOOD (  16.19  )
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
Cc: keescook@chromium.org, Arnd Bergmann <arnd@arndb.de>,
 catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 mingo@redhat.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 30 Nov 2018 16:09:35 +0100
Anders Roxell <anders.roxell@linaro.org> wrote:

> When we have KCOV enabled and running ftrace startup tests we end up in
> a softlockup. Kcov and ftrace tracing each other makes it really slow:
> 
> [  275.141388] Testing tracer wakeup_dl:  PASSED
> [  304.738345] Testing tracer function_graph:
> [  716.236822] watchdog: BUG: soft lockup - CPU#0 stuck for 21s! [ksoftirqd/0:9]
> 
> Rework so that we don't let KCOV look at tracing files. Could probably
> be more selective here, but in in general letting KCOV and ftrace check
> each isn't the best idea.
> 
> Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  kernel/trace/Makefile | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index f81dadbc7c4a..c7c73b976103 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -6,6 +6,11 @@ ifdef CONFIG_FUNCTION_TRACER
>  ORIG_CFLAGS := $(KBUILD_CFLAGS)
>  KBUILD_CFLAGS = $(subst $(CC_FLAGS_FTRACE),,$(ORIG_CFLAGS))
>  
> +# If instrumentation of this dir is enabled, the function tracer gets really
> +# slow. Probably could be more selective here, but note that files related
> +# to tracing.shouldn't be traced anyway.
> +KCOV_INSTRUMENT		:= n
> +

The entire directory is also set to not be traced by function tracing,
which also is a bit overkill, as there's functions in this directory
that can (and probably should) be.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

>  ifdef CONFIG_FTRACE_SELFTEST
>  # selftest needs instrumentation
>  CFLAGS_trace_selftest_dynamic.o = $(CC_FLAGS_FTRACE)


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
