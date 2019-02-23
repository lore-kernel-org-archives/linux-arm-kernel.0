Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C7AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 01:13:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A90A206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 01:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="alii7ITb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WVm9856i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A90A206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ih3Z5h2O/+2af6GAi3HkLMfxoR42FoeIoIJRJwqLxjg=; b=alii7ITbJHwVDr
	OST9DCKuLtBz8LEHM0Qs1XgkIWApZ0RV7QSStTLfM0h5fiv6OpEYtviCCdHVCvqew5TGUHhE5+oWG
	9f26Jn4LbXfjimsbj4dCUTo5g73MCdbh3BjCuMw1tj6CS09+wwsf2+jM64eiZGaoAnJOKjs5ex9no
	1JaObxjDvolSknO7ja3AgJmCYM0UMaqB/bKCUTVRP5YMU9iq7YxS8OqkRSlL6bDzVDJTCOega2zz6
	osqQ2e6YAyapoHadvnFnAABVLiJ42mb6oph/Skmd8p5UOCAIRF+rAnZ6ooTx6Cr83nP6EB5Ic4pHp
	PzAkOWx0y7htfw8xEVAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxLs9-0003h7-MO; Sat, 23 Feb 2019 01:12:57 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxLs6-0003gR-F0
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 01:12:56 +0000
Received: by mail-lf1-x144.google.com with SMTP id t14so3073284lfk.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 17:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SrF0wAj7dLLrzXK+i7p6RrfT6SKt8c5sgU0eYY4Zpko=;
 b=WVm9856imts4jD1k/zbh6pE2bptk/+iv1lqmP/qSy70AGUp2jXyrAKtlHo7PQuKBXD
 vX2CCV6dEELzI4cftY2G0BK8Q9jBh46Nycldlpslpg/U8RnXoXAY85ObYjQ6zSk6q9Gv
 +VqvDH+RlKYmqbjBE0JCWTS2gTAMbQvCZ5ksg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SrF0wAj7dLLrzXK+i7p6RrfT6SKt8c5sgU0eYY4Zpko=;
 b=Ifeho4dglsYpp4xrOsR6UIeaqMx15ZqW5M9bq6b8PCCigMQYAHbxy//SIgJe5p/WRE
 Fbz2OyKd+vWb4IIbDl6mTJt2p33xIVMAoUuzLEtBOKi3T4/Xw3vYR42vugDCDG7n4mcy
 KQ3W6/1GinJSSz0B3wpBn2w5GmUiMIn2hZP0ynP0NCPcpIact+A19xBBJ7+uqWN3WOms
 TfVZVnXnAlPmdk09hDuaiH+gQ7jVC9FB2IR7iF2khCgG1BqmxGb8/6hkM7rXlNun1mI2
 joW19uf+zbFSmImYNl4l/4D+MKbbKj+aXdcc3Ol2J2TskDtegFD43SDSw2TLhu3RC1v5
 vWkg==
X-Gm-Message-State: AHQUAuaLTCCudKBoUncCovrm+Kd8wC4g36UmW3vQJF5HAaTBGHyfEqdZ
 3NKc4a7yvA3cIngI77lscn0p8VJyifY=
X-Google-Smtp-Source: AHgI3IbiXU+Gmi9e1H983BbxA1tPtlLUCK4mREk0f+/qozly6xX6rMfNnyBzBwLNVPLyEPZ6dT5MUA==
X-Received: by 2002:a19:e346:: with SMTP id c6mr3999707lfk.120.1550884371330; 
 Fri, 22 Feb 2019 17:12:51 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com.
 [209.85.167.48])
 by smtp.gmail.com with ESMTPSA id g13sm908890lfb.57.2019.02.22.17.12.49
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 17:12:50 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id n15so3077517lfe.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 17:12:49 -0800 (PST)
X-Received: by 2002:ac2:4433:: with SMTP id w19mr3968540lfl.67.1550884369572; 
 Fri, 22 Feb 2019 17:12:49 -0800 (PST)
MIME-Version: 1.0
References: <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com>
 <20190216103044.GR32494@hirez.programming.kicks-ass.net>
 <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
 <20190219090409.GW32494@hirez.programming.kicks-ass.net>
 <20190219124808.GG8501@fuggles.cambridge.arm.com>
 <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com>
 <cb221e71-243d-fdbd-1d18-b175bc88979b@arm.com>
 <alpine.DEB.2.21.1902212231490.1612@nanos.tec.linutronix.de>
 <CAHk-=wh1B9eRG=gj7wsFVC5XNEedk8Edive-2cQok6T2dNq2aQ@mail.gmail.com>
 <alpine.DEB.2.21.1902221853330.1666@nanos.tec.linutronix.de>
 <20190222222635.GK14054@worktop.programming.kicks-ass.net>
 <CALCETrVw18nHQGPqg_OF=pD7NePafYQ_c1MhfSm_OCQ-O3xzhQ@mail.gmail.com>
In-Reply-To: <CALCETrVw18nHQGPqg_OF=pD7NePafYQ_c1MhfSm_OCQ-O3xzhQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Feb 2019 17:12:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjmp0UugFnD2KaXyGO8RprfgULwMhseDhAxQQMqqL1Eiw@mail.gmail.com>
Message-ID: <CAHk-=wjmp0UugFnD2KaXyGO8RprfgULwMhseDhAxQQMqqL1Eiw@mail.gmail.com>
Subject: Re: [RFC][PATCH] objtool: STAC/CLAC validation
To: Andy Lutomirski <luto@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_171254_507519_B9EF88CC 
X-CRM114-Status: GOOD (  14.66  )
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
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Brian Gerst <brgerst@gmail.com>,
 Julien Thierry <julien.thierry@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Will Deacon <will.deacon@arm.com>,
 valentin.schneider@arm.com, Ingo Molnar <mingo@redhat.com>,
 James Morse <james.morse@arm.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>,
 "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 22, 2019 at 4:34 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> [mailing lists removed because this is a potentially large source of exploits]

I think you're overly worried.

AC doesn't protect against "large source of exploits". If it did, then
all CPU's before Broadwell would be insecure. They aren't. They'd
better not be, considering that there's a _lot_ of Xeon machines out
there based on older microarchitectures. I think some of them might
even be reasonably current (eg Xeon E7v3 isn't _that_ old, and is
Haswell-based, and doesn't have SMAP afaik).

SMAP is a great debugging and development aid, and makes sure that
developers - who hopefully run primarily on modern platforms - don't
write code that just accesses user space directly (because with SMAP,
it won't work).

And yes, SMAP can limit the effect of kernel bugs, and turn something
that would otherwise be a security issue into "just a bug".

But running with AC on isn't a security issue in itself - it just
makes SMAP slightly less powerful. The biggest issue of the whole "AC
doesn't get saved/redstored" is actually the *reverse* case, where a
preemption event could then cause a process that had AC on to be
scheduled away, then AC would stay on for some time, but then we might
schedule back with AC _clear_, and now you'd have a non-working user
access, and a possible DoS attack as a result because you returned
EFAULT to a system call that was perfectly fine.

See? It's not so much "AC stays on" that is a "sky is falling" issue,
it's actually "AC also gets turned off randomly" that actually has
real and immediate effects. "AC on" is unfortunate and not great,
don't get me wrong, but it's definitely not the end of the world.
Particularly not for short sequences.

That said:

> Um, wait a moment.  You didn't find an oddity in ptrace.c.  You found
> a giant freaking error in uaccess.h.

I agree that your patch is good, and should be applied. Mind writing
up a changelog and committing it to -tip?

> Am I missing something?  How are there not zillions of instances of
> this that your patch ought to catch?  Or is genregs_get() really the
> only example?

I really do think that it's very unusual to do "get/put_user()" with
complicated value arguments. So while your patch is obviously the
right thing to do, I really don't think this is a huge worry, or all
_that_ surprising that this issue apparently found just a single case
of a function call.

With all that said, I didn't even react to this part of PeterZ's
patch, but it's a good call, and I think it's also a great validation
of the objtool approach to validating AC. So cheers for that!

                Linus

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
