Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8D3C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:34:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDB46206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ubc8nowQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HJDIZrSs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB46206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Log42oGtk5sbagCiih2a/cf2AD2rJzmbQ+fpFxbaMpk=; b=Ubc8nowQX0j57J
	+gobdl4BC7+BYT+7bhGVQKnhW4pGkobfUQFyv9vAMavJt134LVsp77pSDpUyZABzgvWP7vXk9WVo7
	E/4Jh0SzN8xLKFH8M8LZEXWopJL8Q4UvFbqrfUKNuFCBb/d4o0wInk8J2Am21KP5wg2J66DB3izol
	7OgB8S7+UehqX9yPcUJ7tFVhIsFRL3uokphJIfsyDj8ippaqgXsAiRKy4lU6Zl1S/Ij/gB/D+G4TP
	WOWfF1VApAkwm+KwWFJCGzM/kAu338YeBC5r3XroS4pZl+JrHYGFdQ+KzNlnEyNS0JpkcyS1tuzEg
	Hcrkr7F/HKz9HMI9zeTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUGSu-0004NB-Km; Tue, 04 Dec 2018 19:34:40 +0000
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUGSr-0004MM-2k
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 19:34:38 +0000
Received: by mail-yb1-xb41.google.com with SMTP id s8so5193760ybe.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 11:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/1NIxcvk+5AFzgbsHZc73ZPCu1R9fyAveUbRPuyWU1Q=;
 b=HJDIZrSsR8+cB+eJxgq9K3WS3iocAgz9teSga4gMdwUnTxG2uub0niriPVyGehWq1M
 pCx+FzxMfXN6vWdDpGb0DiXQAugaDcGAt88830qdXcaBDtdiXs7/Xu0BRxct0+BjqXiQ
 o5rjTJNLv30ULCOE7zK+jaA8PQ7+va1SiwDuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/1NIxcvk+5AFzgbsHZc73ZPCu1R9fyAveUbRPuyWU1Q=;
 b=kl/vdG1USQ/vQaf5Dkp/XUn06oq1HFu8NMkfwGEr4Nm670IbPfWLFE9e5rbePKlKwU
 6D/68GgXKKr4nsw5D8MQZfOJXeze3dp6iThczt78ZMse8TC+4ZqeSgan2BD4RTb+Jpbz
 gBnF2IRl8DUXF/Ctyy0q6qsl3UFZs9cLeT0h+tCKIxaukvaTkSKKmQJgfjSeReUs43Pi
 0RCsGhg8T+JjXpJT3bLQKrXnuYYXH4FbIPvfLxmbJyL+HGOM9g1AemLQjiE2a2U8suSM
 0qsZ3ji8JWyk3NCm4K0TMfdKoJtNiPDeFKg5Ad6csoJBbU0IFCEqvkEF4RIuCv+fuqnc
 6wHw==
X-Gm-Message-State: AA+aEWbrIjqv2FMTRvjjR/tAQpVoN7sYL8ZKvnXRQ7fik6Wt0X4u+fcf
 Y9sjzUHLc0dvtl7qAvYPgqJoW/zh+kC8rIMuxKglmQ==
X-Google-Smtp-Source: AFSGD/X86gGQs4FVxgdf1qPKKOMfnf871bCehwhOPV9NbCQCXMTVCtFm/GczHTTBTB3ptR+qOD/4dyvsSWOh1dDOj78=
X-Received: by 2002:a25:2157:: with SMTP id
 h84-v6mr19869453ybh.198.1543952063778; 
 Tue, 04 Dec 2018 11:34:23 -0800 (PST)
MIME-Version: 1.0
References: <20181204191229.6851-1-anders.roxell@linaro.org>
 <20181204141908.76e7afa5@vmware.local.home>
 <20181204142142.4e2e2169@vmware.local.home>
 <CADYN=9LNunVkSTzg1fri7Mu7mbu8gFPpgnFfCRQk4T61JXt1_A@mail.gmail.com>
 <20181204142918.12c087b4@vmware.local.home>
In-Reply-To: <20181204142918.12c087b4@vmware.local.home>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Tue, 4 Dec 2018 20:34:12 +0100
Message-ID: <CADYN=9LiHspkqWHho6UqD=AEznZ4McgExQoAWttNmWzh-NBh-g@mail.gmail.com>
Subject: Re: [PATCH] tracing: add cond_resched to ftrace_replace_code()
To: rostedt@goodmis.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_113437_123192_CD96F2E6 
X-CRM114-Status: GOOD (  14.05  )
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

On Tue, 4 Dec 2018 at 20:29, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 4 Dec 2018 20:25:31 +0100
> Anders Roxell <anders.roxell@linaro.org> wrote:
>
> > On Tue, 4 Dec 2018 at 20:21, Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > On Tue, 4 Dec 2018 14:19:08 -0500
> > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > > > @@ -2435,6 +2438,13 @@ void __weak ftrace_replace_code(int enable)
> > > > >                     /* Stop processing */
> > > > >                     return;
> > > > >             }
> > > > > +           /*
> > > > > +            * Some archs calls this function with interrupts or preemption
> > > > > +            * disabled. Howeve, other archs don't and this can cause a
> > >
> > > typo "However". But could you write it this way:
> > >
> > >         "However, for other archs that can preempt, this can cause an
> > >         tremendous unneeded latency."
> > >
> >
> > I'll fix this and move it up (where I added it in the first place but
> > moved it) =)
> >
>
> I also noticed a grammar issue:
>
>         "Some archs call this function .."

I will fix that.

Cheers,
Anders

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
