Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6793DC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:51:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 382A8204FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TbmyQLvR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VbYn6OOM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 382A8204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0VOH/s8+hy4L2ucHkXA3O9pZW7AFO8Wh8Cj2/1M1VWI=; b=TbmyQLvRawDwEb
	troSZFkZw6MDGPeKfA4Cj0c8IhEc4lfG790J/TalxlOxWiZC2hP8//yIUDZC+rySkLwhIeqrZEwkS
	QiUkPLq+U9rspjQUB/unO64V15XuNHHB1R+7yA3QHw4IkoGRvX3mo9BTetjUWCtf3akN8r5+qDgVq
	ilEyVDEqeeLrg9pKvCbuL2X2YzD8Xwk3ULJ1CkgVFJ9lchO/vmEq95SxlwmmMdTFR9YqDl068E/A8
	tWD+oGDlQtFil2z0n8CGRVy3koV0Quti7EvMoedG3qkXYi5P9VfwUCdJ8sX3kEsd3u5tEwCgY+mVE
	26DTTGG2E1dyhOCBQBpg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUUlm-0000Gj-06; Wed, 05 Dec 2018 10:51:06 +0000
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUUli-0000Fj-OD
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 10:51:04 +0000
Received: by mail-yb1-xb44.google.com with SMTP id x144so4036668ybg.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 02:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PMF0bAzTBxyCkjK+bptI9nByQiftSOTnZNCdXVQwIUE=;
 b=VbYn6OOMANHGd9NLXCgfWGN8LiC6/Hc5e8pfcuOR7Tcv28w3jcd0ZsAHxU13ohXU9k
 6QmEi2cT7AG/YXWTDSLogpBHsh5cgsoChHAwYcPkchXpKGqnyqASrhYd/E+dCRm2eVpN
 jJrcP3LlQV900grS6OjawLv8jhEeTyXTpTtY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PMF0bAzTBxyCkjK+bptI9nByQiftSOTnZNCdXVQwIUE=;
 b=sMoyCg5kcBc7wr5XPdxu77S1XyUt7lwpwcD5tyujB7pYbvd/hm7rn7vuUA1Qmw9Nu8
 fjBlD2wEZUcfQZaAHy8Mk63luc9WVUSkzrNKYrzdzY8XqZj4sbJ13uzybVefh7cBfImR
 il/WH5JHhuBuDxUhpAWkwvZHR3rkXOk6kTrfw2ck03bQrpBZAQsHo5hJuxqQJMhVAPa5
 vf2R8alUWkysl2pP+yhiVR7hIJxcSxw5ulcPEt37IzDUqJh0NCgvfgNs1o2JNfdiiDGg
 oXmANYJWegN8i8H1aMNT7dplOo+ZhgqAhG+gAy8BrFaLURcKxcUt/IEYVWrLx3dbO/h4
 cx/g==
X-Gm-Message-State: AA+aEWa2idjmpYm5f55FJ9XrAr8FSB4yIjCATmesR24YQEi/p0ekpcMV
 diV8kPsaO9J+QkTXjWQxyTocibzv0/6VIuULNe7etg==
X-Google-Smtp-Source: AFSGD/UEhroe4SxxFb753u7dU/rk+gMhi2coWefX1lqAmAmzT+wXfSDdIO7/7mBsQm0pFnjBp2HeCt+T3uL7qtaV4tg=
X-Received: by 2002:a25:2157:: with SMTP id
 h84-v6mr21892011ybh.198.1544007051334; 
 Wed, 05 Dec 2018 02:50:51 -0800 (PST)
MIME-Version: 1.0
References: <20181204194044.9506-1-anders.roxell@linaro.org>
 <20181204173258.6de70c66@vmware.local.home>
In-Reply-To: <20181204173258.6de70c66@vmware.local.home>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 5 Dec 2018 11:50:40 +0100
Message-ID: <CADYN=9JVZ0vRbon9DkxuUx4sYNMuCYyoYL1gydCLrdjRJGS4+g@mail.gmail.com>
Subject: Re: [PATCH v3] tracing: add cond_resched to ftrace_replace_code()
To: rostedt@goodmis.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_025102_788148_871A0CB7 
X-CRM114-Status: GOOD (  14.89  )
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

On Tue, 4 Dec 2018 at 23:33, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue,  4 Dec 2018 20:40:44 +0100
> Anders Roxell <anders.roxell@linaro.org> wrote:
>
> > When running in qemu on an kernel built with allmodconfig and debug
> > options (in particular kcov and ubsan) enabled, ftrace_replace_code
> > function call take minutes. The ftrace selftest calls
> > ftrace_replace_code to look >40000 through
> > ftrace_make_call/ftrace_make_nop, and these end up calling
> > __aarch64_insn_write/aarch64_insn_patch_text_nosync.
> >
> > Microseconds add up because this is called in a loop for each dyn_ftrace
> > record, and this triggers the softlockup watchdog unless we let it sleep
> > occasionally.
> >
> > Rework so that we call cond_resched() if !irqs_disabled() && !preempt_count().
>
> This isn't urgent is it?

No, it is not urgent. I'm trying to get allmodconfig to boot on arm64.

> That is, it doesn't need a stable tag?

Also I don't think its a regression, since clearly nobody has ever been
able to boot an arm64 allmodconfig kernel or anything close to that.

Cheers,
Anders

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
