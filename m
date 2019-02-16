Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14608C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 00:22:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D38EB222D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 00:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ezVhuR72";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="a4rSZM8v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D38EB222D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XJG94bbzoGsQ6vAWomB9aoqu1w9nPS31Pa8EOgTFnbk=; b=ezVhuR72E1k0eW
	4CLtdy5W7a15oehm6T6oYJkXoOJKNh7JORIOl4vpaBw+PGk9AXnpZvtcY8egzLandURbBcqmOOqnU
	c2PUnuNeA7PnVNrAo+Pq1p/Ud/kihxmTSVsU5ZULRntYS63kl1AV9CzUw/1sOyFYaRHlGtF32MPjk
	Yn6LMiTxHdsRjLuEddapAo0xFcijPnINnJA7EVhgfn+D46ovutj6W18xlBi/sVmHC2CrpjYS5QG5U
	gAhXYdhDyrcR9H8bm2Kxe4xU7UW4+10f7VD00T0ZaKzAz44WHI5UfcpBoqWm4GA4/gGh57Zeq1K0M
	KDACO/ho+7L1pd8Q/UQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gunkB-0002E7-KO; Sat, 16 Feb 2019 00:22:11 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gunk7-0002DH-Nv
 for linux-arm-kernel@lists.infradead.org; Sat, 16 Feb 2019 00:22:09 +0000
Received: by mail-lf1-x142.google.com with SMTP id u21so8472818lfu.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 16:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OZu9yKf7/y1PhxZ/QIrEDwuJyhP/izVcuc3XltvUjmQ=;
 b=a4rSZM8vUfxX3uByi7RoJOEoa6DxrIjJRc2yfnndHKn6V212rZYOuPHWhH4kyRMrG2
 BisntrNaR1SEXoRrhAdRMhxsZaQnrY4RN21oq1TADbYda+q7ZPaW3MkyfV3T+QRnF6nP
 2yMAGCpEucf5N0GKlPW2BDpJYUlSNqCDuX1oU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OZu9yKf7/y1PhxZ/QIrEDwuJyhP/izVcuc3XltvUjmQ=;
 b=CE6+GUDB7h2av0Ru4Hy4ds7/HLKs3Yv9RtONMIEGsXw9atr536731nU5M5+rMFP1x4
 9JZovi4vfaUZc+6t79cqjaI7Ln5k3ATDBNFwKhMuTz11YEOXbOR96sMsBBKaRCOzecaD
 w8+gOahTus3cGBt+8PAkG2UYUvN4tP6qkU3a9VUtfOWDGgv+gO9XzWoRwRo1JxQFBM3z
 IWdBDlKXscpcpAz5j50+nSVmj0x8i6P2Y56Be68am2PiG6FvaUIJ+J4q5ayRQKUjRExC
 8OYOqWBDM7UOoppdaD6JP4k6VIsgl7L7v0fmnu11SQu2q9bGp8iZj6ALQNrg9G1EHCGw
 UvZg==
X-Gm-Message-State: AHQUAuYaOW3RGqTvEHz03f1vPS+zAIDf1HFUOl8N9FRqaWNlIfP3edLf
 7pUBCx8yA/KtxIf6x2BsaTAVwO25sdc=
X-Google-Smtp-Source: AHgI3IZR1nwX7IdZN7fb+EC6CRmoYGbFjdCM7R8AIkVgWz5es/F7sdAUBe1pM9qz3Nx4QjI2YLJjQw==
X-Received: by 2002:a19:f249:: with SMTP id d9mr6900204lfk.83.1550276525231;
 Fri, 15 Feb 2019 16:22:05 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com.
 [209.85.167.53])
 by smtp.gmail.com with ESMTPSA id f20-v6sm1647227ljk.33.2019.02.15.16.22.03
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 15 Feb 2019 16:22:04 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id h10so8222966lfc.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 16:22:03 -0800 (PST)
X-Received: by 2002:a19:ab09:: with SMTP id u9mr6928685lfe.149.1550276523131; 
 Fri, 15 Feb 2019 16:22:03 -0800 (PST)
MIME-Version: 1.0
References: <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
 <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net>
 <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net>
 <CAMzpN2hg+CY+AuF=BtetS2HrMQYdxhBZL9QMvJX4LjAs7vwwAw@mail.gmail.com>
 <20190214193432.GR32477@hirez.programming.kicks-ass.net>
 <CAHk-=wgj9yUAhTz8n__s-gHnHJw4fznBbLAfne4EO4n6RukgcA@mail.gmail.com>
 <20190215174034.GP32494@hirez.programming.kicks-ass.net>
 <20190215233414.GS32534@hirez.programming.kicks-ass.net>
In-Reply-To: <20190215233414.GS32534@hirez.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 15 Feb 2019 16:21:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh5sTSF0X7qp80Ls5QZ2AgAm3yk3Ow9qOuNKB6O_zGVKA@mail.gmail.com>
Message-ID: <CAHk-=wh5sTSF0X7qp80Ls5QZ2AgAm3yk3Ow9qOuNKB6O_zGVKA@mail.gmail.com>
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
To: Peter Zijlstra <peterz@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_162207_823953_CE4E63B0 
X-CRM114-Status: GOOD (  12.10  )
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

On Fri, Feb 15, 2019 at 3:34 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Now, EFLAGS bit 1 is supposedly always 1, but it really doesn't seem to
> matter for POPF.

Correct, it's "read as 1", you can try to write it and it doesn't matter.

> I went through the other flags, and aside from VIP/VIF (I've no clue),
> they looks like 0 should be just fine.

So 0 is a perfectly valid initializer in the sense that it _works_, I
just want it to be something that was thought about, not just a random
"initialize to zero" without thinking.

Even just a comment about it would be fine. But it might also be good
to show that it's an explicit eflags value and just use
X86_EFLAGS_FIXED as the initializer.

            Linus

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
