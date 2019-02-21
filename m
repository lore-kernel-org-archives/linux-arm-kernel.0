Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53297C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:08:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2229E207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mtYanTK0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YofCyqny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2229E207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DkkL4mVXewvO3sK2eTDE++H+5kmz+ETMKdwrt+L9j0I=; b=mtYanTK0FaYgPE
	Ok80ZgijnKLtX8faRouRRNTIDskeJtt+c+/FS+MV+66Uds6btqEHX7Ngs5VnW83QgnSUiM+iOwoAy
	S/bRyjP0IRMFlZdd2AZj854EFYAA0ATA/3XOP68z1Tg7bJziGs0waosW7mf/VEvNJFqvZkWzfpBAo
	dDlSlew14btaB3rBW7uwBtA9mUrZMgz6dQ8gfdXqjzxIUpSKHeYOwOFcvvxNeZGp9Q4WeViQgEybE
	++h+fLLWBexpVgpesLf7GS5FiC6q9p4OxHB9L+6sRgYUzFclxHH/OwAHEPSt3Kck6NBEpGuqn2EFk
	iE57VAyilLbESDfJKK8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwwWC-0000ar-Ql; Thu, 21 Feb 2019 22:08:36 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwwW9-0000aT-Ax
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 22:08:34 +0000
Received: by mail-lf1-x143.google.com with SMTP id u21so150451lfu.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 14:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9wFanjEpOf9wRJE/2TXoK6Nd5+iJk15E6QWBJw3RQRU=;
 b=YofCyqnyqCvzjrckbWI7xD8xUmCj7TZt4GsSTSNeSg0nUfbYeXjn+h+PhzPsJZV2mq
 OvvggXO0wPkTaWdmzlqP+59NSsvMir0i9WOZQ7PsXq2CUg7ebP5NFmPux8RN55+nWKfh
 8oHEOCzEnxHx80nVEf6yUgeuL6gfxWfgoFV7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9wFanjEpOf9wRJE/2TXoK6Nd5+iJk15E6QWBJw3RQRU=;
 b=ZfxORQIU9LAzPP0FoK+L/4NIMCgC86HMXrJTlddiUzZu0fwWgjotf642MyJviiX0zO
 WBm32byhK7ocPUHaGSEDXNQ4ekZj20N5bynMD0mY2P2AyoiM0Gzfqb9rtmFi0Uw+KvyB
 E5wnfv2RMZ7LUVTOmHMK7NTiJ8VmgdI8LKfupWHmpGL0p6NCHxe1AOLz0JiK9U/yQA4A
 zo2s9f6N005djfhaH8uAsIxqgpYGA62Z5DhiaBsang+nRD8VOtJQF5BgvSX23yuvATne
 gZSRSmTW8aMSyU1eau3fSJNucRhtGR1cF/nWtY/2LMgfM1krwGjOyI632zxHqCtL06ec
 oGhQ==
X-Gm-Message-State: AHQUAuYLSW2kUgP4iiDULB7hf2pNLT4F/tDtnbjpmnFeqjkt8yc3CI2Y
 2biOVi8PMJPtbluoHP6XKw9Nc84BIdo=
X-Google-Smtp-Source: AHgI3IYQL0S+cV5XimjHCtfTsuW0Szbg9sn0wkj/fcFqBZaqoEukCYtxmVL8zg+hbkQ9yBX6R8NkVQ==
X-Received: by 2002:ac2:52ad:: with SMTP id r13mr398171lfm.50.1550786909831;
 Thu, 21 Feb 2019 14:08:29 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com.
 [209.85.167.47])
 by smtp.gmail.com with ESMTPSA id q123-v6sm10941ljb.60.2019.02.21.14.08.28
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 Feb 2019 14:08:28 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id q12so151869lfm.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 14:08:28 -0800 (PST)
X-Received: by 2002:a19:24d5:: with SMTP id k204mr405084lfk.88.1550786907565; 
 Thu, 21 Feb 2019 14:08:27 -0800 (PST)
MIME-Version: 1.0
References: <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
 <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net>
 <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net>
 <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com>
 <20190216103044.GR32494@hirez.programming.kicks-ass.net>
 <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
 <20190219090409.GW32494@hirez.programming.kicks-ass.net>
 <20190219124808.GG8501@fuggles.cambridge.arm.com>
 <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com>
 <cb221e71-243d-fdbd-1d18-b175bc88979b@arm.com>
 <alpine.DEB.2.21.1902212231490.1612@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1902212231490.1612@nanos.tec.linutronix.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 Feb 2019 14:08:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh1B9eRG=gj7wsFVC5XNEedk8Edive-2cQok6T2dNq2aQ@mail.gmail.com>
Message-ID: <CAHk-=wh1B9eRG=gj7wsFVC5XNEedk8Edive-2cQok6T2dNq2aQ@mail.gmail.com>
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
To: Thomas Gleixner <tglx@linutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_140833_387139_25F94B98 
X-CRM114-Status: GOOD (  14.26  )
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
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Denys Vlasenko <dvlasenk@redhat.com>,
 Brian Gerst <brgerst@gmail.com>, Julien Thierry <julien.thierry@arm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, valentin.schneider@arm.com,
 Will Deacon <will.deacon@arm.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>,
 James Morse <james.morse@arm.com>, Andrew Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@kernel.org>,
 "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 21, 2019 at 1:35 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> IMNSHO any call inside a AC region is a bug lurking round the corner. The
> only thing which is tolerable is an exception of some sort.
>
> Enforce that with objtool. End of story.

Not quite that simple.

There are some use cases where you really do want a call - albeit to
special functions - inside the AC region.

The prime example of this is likely "filldir()" in fs/readdir.c, which
is actually somewhat important for some loads (eg samba).

And the whole AC thing made it horribly horribly slow because readdir
is one of those things that doesn't just copy one value (or one
structure) to user space, but writes several different things.

Kind of like signal frame setup does.

You may not realize that right now signal frame setup *does* actually
do a call with AC set. See ia32_setup_rt_frame() that does

        put_user_try {
...
                compat_save_altstack_ex(&frame->uc.uc_stack, regs->sp);
...
        } put_user_catch(err);

is a macro, but inside that macro is a call to sas_ss_reset().

Now, that is an inline function, so it hopefully doesn't actually
cause a call. But it's "only" an inline function, not "always_inline".
We did already have (and I rejected, for now) patches that made those
inlines not very strong...

[ Side note: currently signal frame setup uses the absolutely
*disgusting* put_user_ex() thing, but that's actually what
unsafe_put_user() was designed for. I just never got around to getting
rid of the nasty hot mess of put_user_ex() ]

Anyway, while signal frame setup just writes individual values,
"filldir()" does *both* several individual values _and_ does a
copy_to_user().

And it's that "copy_to_user()" that I want to eventually change to a
"unsafe_copy_to_user()", along with making the individual values be
written with unsafe_put_user().

Right now "filldir()" messes with AC a total of *six* times. It sets
four field values, and then does a "copy_to_user()", all of which
set/clear AC right now. It's wasting hundreds of cycles on this,
because AC is so slow to set/clear.

If AC was cheap, this wouldn't be much of an issue. But AC is really
really expensive. I think it's microcode and serializes the pipeline
or something.

Anyway. We already have a possible call site, and there are good
reasons for future ones too. But they are hopefully all very
controlled.

                 Linus

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
