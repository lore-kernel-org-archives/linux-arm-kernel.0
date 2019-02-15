Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5021C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:24:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82D4821925
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I52Xp9bq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ASf2CcNO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D4821925
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BG9TodrcnpK5F2JDju9PpEMHzizq8m5lq6/Wb3l6Fsw=; b=I52Xp9bqezyj7t
	cO7+lgotUPjQ3WiPofVPRo1hOpu+uy37+Q47Tdj5YjmrdPeJghUQplY8F2AKPIzYaN0U6JE1GuheJ
	3a0iLcWdrVl9efKwk55M2HUeJA/qOi9U9puKgofzYhWynbSi2//PhO4jgvi6KfgMcso4t/ErZ24hg
	ygS7wGZLNCR0j107PmaR5xQTgMUeGMpX4x7XOwET3R7Xv/rJerwbxLy84tv0BVTWlZGqIdEcScARO
	PIN9wrzHPERVfDT9DYoO+tJ7oJP1xsWWuMG3bYGsk5sgYCkcopV27yayxImhDdTelImKZocVznsrs
	hASgX8f5j1L5Snh1TR9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guhDy-0007Qr-4b; Fri, 15 Feb 2019 17:24:30 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guhDv-0007QT-2p
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 17:24:28 +0000
Received: by mail-ed1-x541.google.com with SMTP id 10so8582433eds.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 09:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HKRUq4h/ue0wDp79fBlnuukqhRIoARGpcxTy9wm7Zis=;
 b=ASf2CcNOJTffmlwufsEVtqnURgoZhUWsIDpV1Wt0PApsRlxlsyrrNTCLmzQopxBv35
 1GSzieZUR6nIwIwljPzoxD8BaDcMyejsmefnAwYzC7nEJUP9MQfDUeZ7IuvyWu0S93oR
 doynVHl4EX/rPKARWof6UYQncthF6eCgN8fN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HKRUq4h/ue0wDp79fBlnuukqhRIoARGpcxTy9wm7Zis=;
 b=F4oCteMX+Pe2aL+svQhe1cVi8if4gk6zvclX+YI+Ln0GKA6mt6O4t6hTUoLNIC0MpC
 ju/sqmDE/3PYj9wMx080A8w0NTpw5kqEol6q60P8WoyOYXKvxm4AxXLdqctuXLYK6uml
 I+ByCp8B9xReCLrEYPIcS0+i+A0IPl87PIXzE0B+h6bl5orwTfPPxIjrmMp2KJp9Zc32
 bvcSsaDasxh6eCoJYCPri7iS4tEIArNRqlzLPSyVoxyOyhz4+7Y7CMadNLOLXqfNlESE
 UGy/YXHAoJe5TmwB93FzxRbMQb2CSrC/3omYOCo9OfYQ45UXS0avEiPFJgk8e1eTOhBe
 Ov9g==
X-Gm-Message-State: AHQUAuaBrjPE78G8B6wlPHM1KKr+PO2zSYxirx/pI0X13cmHG+7AqlK2
 5xYA5U1/gbMWoWu2hd0Jdui2I/wFeYM=
X-Google-Smtp-Source: AHgI3Ib3jKQRLxGIPCFELwpEbAdfu7RoLTeZSvR7rPBfJJiEbRAx99g4SYIDa3glIyXySbVv971wKg==
X-Received: by 2002:a17:906:114f:: with SMTP id
 i15mr2948859eja.29.1550251464530; 
 Fri, 15 Feb 2019 09:24:24 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com.
 [209.85.128.45])
 by smtp.gmail.com with ESMTPSA id a8sm1345403eju.52.2019.02.15.09.24.24
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 15 Feb 2019 09:24:24 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id h22so7123127wmb.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 09:24:24 -0800 (PST)
X-Received: by 2002:a7b:cb18:: with SMTP id u24mr6921394wmj.138.1550251096655; 
 Fri, 15 Feb 2019 09:18:16 -0800 (PST)
MIME-Version: 1.0
References: <20190213140025.GB6346@brain-police>
 <20190213142524.GW32494@hirez.programming.kicks-ass.net>
 <dd33cc20-f335-0e4c-e3f4-02497ecc3710@arm.com>
 <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
 <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net>
 <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net>
 <CAMzpN2hg+CY+AuF=BtetS2HrMQYdxhBZL9QMvJX4LjAs7vwwAw@mail.gmail.com>
 <20190214193432.GR32477@hirez.programming.kicks-ass.net>
In-Reply-To: <20190214193432.GR32477@hirez.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 15 Feb 2019 09:18:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgj9yUAhTz8n__s-gHnHJw4fznBbLAfne4EO4n6RukgcA@mail.gmail.com>
Message-ID: <CAHk-=wgj9yUAhTz8n__s-gHnHJw4fznBbLAfne4EO4n6RukgcA@mail.gmail.com>
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
To: Peter Zijlstra <peterz@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_092427_164632_76B1875E 
X-CRM114-Status: GOOD (  11.50  )
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
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Julien Thierry <julien.thierry@arm.com>, Brian Gerst <brgerst@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andy Lutomirski <luto@amacapital.net>, valentin.schneider@arm.com,
 Ingo Molnar <mingo@redhat.com>, James Morse <james.morse@arm.com>,
 Andy Lutomirski <luto@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>,
 "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 14, 2019 at 11:34 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Something like the below, right?
>
> +       frame->flags = 0;
> +       frame->flags = 0;

Those are not valid flag values.

Can you popf them? Yes.

Do they make sense? No.

It has the IF flag clear, for example. Is that intentional? If it is,
it should likely be documented. Because IF clear means "interrupts
disabled". Are the places that load flags in irq disabled regions?
Maybe they are, maybe they aren't, but shouldn't this be something
that is made explicit, rather than "oh, let's initialize to zero like
all the other registers we don't care about".

Because a zero initializer for eflags really is odd.

             Linus

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
