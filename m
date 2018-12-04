Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03325C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:07:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBF2A2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gTi3e46V";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bbVhzyWI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF2A2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nEW2Pi1NmIWa5dlRYmFL44mB7LPM9oBVyyYD0sSvBXU=; b=gTi3e46VQKs0DQ
	T+6KNi+jTjFu+x9Sf/L+pv95Jn3vZkNqPplTvzzNLNZskSu/ROlETnKHprGyZ2elZg6HULKZM2mIp
	bx/XkftFK82KNWj4tj1h4DZXTkagPAOrLx9V2hETo6NSACxLOrcIurkc9enzeUySbc9CGR7Jr4jdB
	zoHMgaeIdI/Iy1YepxXPu8cR+S+HsHO2imrOaBXBXGYSAsZ4ix4NBI8o03Bn7R59FyUQgkj/Xv/hF
	efj1if3Pj0Ej7sOwm5i9/5bzCB+QiFgK/XcQ8tc9SxL9IzkFwgkaw8SDQW9Sb4IvztKdVBZWzfgT2
	lsXgXevCjW3+PXhdeKLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUF6k-0002WD-Hm; Tue, 04 Dec 2018 18:07:42 +0000
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUF6i-0002VQ-0o
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 18:07:41 +0000
Received: by mail-yw1-xc44.google.com with SMTP id i22so7035412ywa.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 10:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=P7Q+6Q7EQjFQY2Xk7dt5+mUPd/Z6udMs7VDUul38GiA=;
 b=bbVhzyWIY8kUQeSTevtql7ECZm5YFj1+oHdNuuaWPu2Lt4+YuwyCtXs+Y2yrkhCMtP
 g+Odg3xrPj27rE+JCE4oRyCyWMLQTxHckyX8Qvcjl+fqnlxi368OXyzD7PXymIqqc/CC
 Wu2m8CBfn9e5XP4Gt6lttWEpS3qBII1ntA8g8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P7Q+6Q7EQjFQY2Xk7dt5+mUPd/Z6udMs7VDUul38GiA=;
 b=pi1zYFCOB/wSgPFOBUJKTJ7aDlLQl0H0nZXGn7u4a/K4wBTGuIt6DdT3MTelJXDb59
 5zE4I8pjrw3opBmp+gPo4yHeum0oYWLqm+z+WNsgR2D3PIFlB/SAt40LRg71c4Eb7pLE
 LjagYiVbbsO22B1OyxgO/tuC9Yk1k+KyDpkYiM/Hgq+TN6BGat1IZghsmQokPxT4K5yL
 g+2mb1AcU407FaxsLHdE7B930OSNVTXKGTT5mwR7bDq6WwrXoPQwnGoyjdOf4+iIB+2/
 6MqA/LkJbLjWQ5lu5bQ40M1OBUF+3S49E7Ubx2mZv04ZLMp4sxz6A+9HwP7CQhfwUpA7
 ISGA==
X-Gm-Message-State: AA+aEWb7nZHCXdnzu/0uun1WEHaw+jESESyGe1qygyxxZOobH0Y3aQo8
 xNQX36QHR6GNGckemLaHk8jhzLEohSM0iroa4R4BRQ==
X-Google-Smtp-Source: AFSGD/X3ZJmtgoo/0zrkgdqIjthFj0b3FkfEkhHvcMS7KUaNUvJU82dTfaBIEhj0Pu1xoMDbfzIt433J+IntVoMk+SM=
X-Received: by 2002:a81:9b8e:: with SMTP id s136mr20423301ywg.85.1543946848163; 
 Tue, 04 Dec 2018 10:07:28 -0800 (PST)
MIME-Version: 1.0
References: <20181130150956.27620-1-anders.roxell@linaro.org>
 <20181203192228.GC29028@arm.com>
 <CAK8P3a2gekEqUuvsC-_+ijhiqqff2bK-s2wQfkjn7z-HtNnMDQ@mail.gmail.com>
 <20181204005012.11f73df9@vmware.local.home> <20181204111242.GA32596@arm.com>
 <20181204122627.225befaa@vmware.local.home>
In-Reply-To: <20181204122627.225befaa@vmware.local.home>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Tue, 4 Dec 2018 19:07:16 +0100
Message-ID: <CADYN=9K+On_Qbd_4a+C=59tffWiLF9YwACF4kXyTtDU1mazxjA@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: ftrace: add cond_resched() to func
 ftrace_make_(call|nop)
To: rostedt@goodmis.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_100740_060407_F62CDA8D 
X-CRM114-Status: GOOD (  18.06  )
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
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mingo@redhat.com,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 4 Dec 2018 at 18:26, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 4 Dec 2018 11:12:43 +0000
> Will Deacon <will.deacon@arm.com> wrote:
>
> > > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > > index 8ef9fc226037..42e89397778b 100644
> > > --- a/kernel/trace/ftrace.c
> > > +++ b/kernel/trace/ftrace.c
> > > @@ -2393,11 +2393,14 @@ void __weak ftrace_replace_code(int enable)
> > >  {
> > >     struct dyn_ftrace *rec;
> > >     struct ftrace_page *pg;
> > > +   bool schedulable;
> > >     int failed;
> > >
> > >     if (unlikely(ftrace_disabled))
> > >             return;
> > >
> > > +   schedulable = !irqs_disabled() & !preempt_count();
> >
> > Looks suspiciously like a bitwise preemptible() to me!
>
> Ah, thanks. Yeah, that should have been &&. But what did you expect.
> I didn't even compile this ;-)
>
> >
> > > +
> > >     do_for_each_ftrace_rec(pg, rec) {
> > >
> > >             if (rec->flags & FTRACE_FL_DISABLED)
> > > @@ -2409,6 +2412,8 @@ void __weak ftrace_replace_code(int enable)
> > >                     /* Stop processing */
> > >                     return;
> > >             }
> > > +           if (schedulable)
> > > +                   cond_resched();
> > >     } while_for_each_ftrace_rec();
> > >  }
> >
> > If this solves the problem in core code, them I'm all for it. Otherwise, I
> > was thinking of rolling our own ftrace_replace_code() for arm64, but that's
> > going to involve a fair amount of duplication.
> >
>
> If it does, then I'll add it. Or take a patch for it ;-)

I tested your patch. it worked.

I'll send a patch shortly.

Cheers,
Anders

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
