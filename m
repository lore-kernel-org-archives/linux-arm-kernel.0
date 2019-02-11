Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC87C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:18:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BAB621B69
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IFNl1A8b";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="UjCK47gl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BAB621B69
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UQr/PcFx+dlwB8jmxyF5HrT+sV8UJoPDZNgjlGCjnzQ=; b=IFNl1A8b1hbkrd
	btIXXDv79Pyc0T2V9Ry0ruQxOee/qdpQ39FvZSHz/b692Bw5RXK1xYMYacAat+vNEsu/BPNGDdU2F
	e6L9FL6DMIIRuaO9SqXJ4GmgdhyLOBQ9cLmhsSbWt5mixTYil7GGIsnfOa8cNamYtJXUKyxf6Uo+m
	A639d9qFht/p9oqN019gbvAIlESuthK+iYhPS9unx/cWYYX4i75FaaFluGbJDJl7AKcT+xKk4felU
	lrv8QRTtjoS/UYt71IRZL0YcbKy96omXq2YRvIKx3OxL5wkxblU6/3L/PjDTWI5pV3y0C0HAuR9NS
	NYWFZl7HZbzhMvGq+b7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtG9Z-0000Ei-6T; Mon, 11 Feb 2019 18:18:01 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtG97-0008LA-St
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 18:17:58 +0000
Received: by mail-pf1-x442.google.com with SMTP id u6so5618548pfh.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 10:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eNKvlhATBFZVonShAC/U+yr/Q9vhBiyJjXe6MSCRJrE=;
 b=UjCK47glau/YbFQXXw4TC1dxBLiIYi/B8lKA/qe/XbMMNyCu55AqD0Za/FCdGQQxhw
 RrGN89Qs/xSPC5Je8OugJagNdxlYNelm5/8lijcXNLcYN0I5iIRmWj1QDW1XPgJWbtwf
 CA210PPgdgEfDAlPyYp97ESsSrmiVl4bQqgx5fvP5K6VutSPWOJWybyHChTX7Cc+RdSM
 SadzDW4vwziXkATSTo02DTAaMQWQ8L9EzEJ60wKg4cqbpGLQeGJsIoJkEwXTTkrwNPCo
 0zV8olNa3n2YAcxqtRFntuyMqi6YLTOmdgexOfkoVZlWr9p6VQ0Z3EA+d9NHEiqnUhyF
 qcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eNKvlhATBFZVonShAC/U+yr/Q9vhBiyJjXe6MSCRJrE=;
 b=LF4PCohO2nWP/QV8cjcyDbB2XtEVhahzs14Pezg5UtHpurfz99XoqbgYaaHwPlCeY0
 fvG4MwrArZHABDlo0ZIKP1uQAq8SfpX6m70gU+a90EEZvfomkhULSlRpihGgfg3/nTPx
 DER1/HO+yx4fOCOIPpmoNSf6TrIUtprS0EIErK9E6pZcqLkoA1tOIp27Dw2vH5h0ZOmy
 EpoTeQbnN0Xlrabx/s9Vp9mBQr7c2KmtBFwno5vjBGqV3s6F+3nNGeXLDpr9yOIy0O+z
 4yKVdfxDjGLjz/kfW1etOSwhg7NXohc3oe3fMSj6l7Tc7ZwigvB4fb+vMN2eCNc34R7o
 Tncg==
X-Gm-Message-State: AHQUAuYHO1Z7LkvcLpC32sqHA668++WKqJorMl6D0gNNAs15LdnGUVSy
 5raOChRdrM8XDkOPrpDzuqzCe2RG6LUa4OmbTodgvA==
X-Google-Smtp-Source: AHgI3IbnG2wI8bPyuZz0pgcU88iFpQo08cAWVJj5p7WViaASCDiqapkdplLyT2zxrJ6Ox8S0TJVk/sK8iYRhES4fFkE=
X-Received: by 2002:a62:109b:: with SMTP id 27mr37424825pfq.227.1549909052874; 
 Mon, 11 Feb 2019 10:17:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1549532513.git.stefan@agner.ch>
 <fed4850fb5d8a8ca874affa05d8d116d53e25b88.1549532513.git.stefan@agner.ch>
 <db0e6b8f034f832c7e52fe3dd47073ad@agner.ch>
In-Reply-To: <db0e6b8f034f832c7e52fe3dd47073ad@agner.ch>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 11 Feb 2019 10:17:21 -0800
Message-ID: <CAKwvOdnqOkdD9fFoXmSKZNmceaXcWtdaZ2iwKej3=X-LL0DS9Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] ARM: use unified assembler in c files
To: Stefan Agner <stefan@agner.ch>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_101734_892078_F5794051 
X-CRM114-Status: GOOD (  19.33  )
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
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>,
 Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, julien.thierry@arm.com,
 Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>,
 LKML <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Nathan Chancellor <natechancellor@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Feb 9, 2019 at 9:28 AM Stefan Agner <stefan@agner.ch> wrote:
>
> Thanks for the reviews so far.
>
> During some more testing I stumbled upon another issue:
>
> On 07.02.2019 10:48, Stefan Agner wrote:
> > Use unified assembler syntax (UAL) in inline assembler. Divided
> > syntax is considered depricated. This will also allow to build
> > the kernel using LLVM's integrated assembler.
> >
> > Signed-off-by: Stefan Agner <stefan@agner.ch>
> > ---
> >  arch/arm/mm/copypage-v4mc.c | 2 +-
> >  arch/arm/mm/copypage-v4wb.c | 2 +-
> >  arch/arm/mm/copypage-v4wt.c | 2 +-
> >  3 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/mm/copypage-v4mc.c b/arch/arm/mm/copypage-v4mc.c
> > index b03202cddddb..b19c7ad1a6de 100644
> > --- a/arch/arm/mm/copypage-v4mc.c
> > +++ b/arch/arm/mm/copypage-v4mc.c
> > @@ -56,7 +56,7 @@ static void mc_copy_user_page(void *from, void *to)
> >       ldmia   %0!, {r2, r3, ip, lr}           @ 4\n\
> >       subs    %2, %2, #1                      @ 1\n\
> >       stmia   %1!, {r2, r3, ip, lr}           @ 4\n\
> > -     ldmneia %0!, {r2, r3, ip, lr}           @ 4\n\
> > +     ldmiane %0!, {r2, r3, ip, lr}           @ 4\n\
> >       bne     1b                              @ "
> >       : "+&r" (from), "+&r" (to), "=&r" (tmp)
> >       : "2" (PAGE_SIZE / 64)
> > diff --git a/arch/arm/mm/copypage-v4wb.c b/arch/arm/mm/copypage-v4wb.c
> > index cd3e165afeed..6e3c9b69dd25 100644
> > --- a/arch/arm/mm/copypage-v4wb.c
> > +++ b/arch/arm/mm/copypage-v4wb.c
> > @@ -38,7 +38,7 @@ static void v4wb_copy_user_page(void *kto, const void *kfrom)
> >       ldmia   %1!, {r3, r4, ip, lr}           @ 4\n\
> >       subs    %2, %2, #1                      @ 1\n\
> >       stmia   %0!, {r3, r4, ip, lr}           @ 4\n\
> > -     ldmneia %1!, {r3, r4, ip, lr}           @ 4\n\
> > +     ldmiane %1!, {r3, r4, ip, lr}           @ 4\n\
> >       bne     1b                              @ 1\n\
> >       mcr     p15, 0, %1, c7, c10, 4          @ 1   drain WB"
> >       : "+&r" (kto), "+&r" (kfrom), "=&r" (tmp)
> > diff --git a/arch/arm/mm/copypage-v4wt.c b/arch/arm/mm/copypage-v4wt.c
> > index 8614572e1296..4a40fa1cbc2a 100644
> > --- a/arch/arm/mm/copypage-v4wt.c
> > +++ b/arch/arm/mm/copypage-v4wt.c
> > @@ -34,7 +34,7 @@ static void v4wt_copy_user_page(void *kto, const void *kfrom)
> >       ldmia   %1!, {r3, r4, ip, lr}           @ 4\n\
> >       subs    %2, %2, #1                      @ 1\n\
> >       stmia   %0!, {r3, r4, ip, lr}           @ 4\n\
> > -     ldmneia %1!, {r3, r4, ip, lr}           @ 4\n\
> > +     ldmiane %1!, {r3, r4, ip, lr}           @ 4\n\
> >       bne     1b                              @ 1\n\
> >       mcr     p15, 0, %2, c7, c7, 0           @ flush ID cache"
> >       : "+&r" (kto), "+&r" (kfrom), "=&r" (tmp)
>
> When compiling with gcc, this leads to:
>
> /tmp/ccrvA1wy.s: Assembler messages:
> /tmp/ccrvA1wy.s:180: Error: bad instruction `ldmiane r0!,{r3,r4,ip,lr}'
> make[1]: *** [scripts/Makefile.build:277: arch/arm/mm/copypage-v4wb.o]
> Error 1
> make: *** [Makefile:1042: arch/arm/mm] Error 2
>
> Unfortunately, the gcc option -masm-syntax-unified which allows unified
> syntax in inline assembly is broken (see also
> https://lkml.org/lkml/2019/1/7/1320).
>
> So this requires to sprinkle those inline assembly with ".syntax
> unified" strings, similar to how I've done it in uaccess.h.

Not sure if this is purely a bug in GCC; Clang treats inline asm
statements as unique, so asm directives do not carry over from one
inline asm statement to another.  This has caused issues in other
arch's inline assembly, where we need to repeat asm directives
repeatedly for each inline asm statement.
https://bugs.llvm.org/show_bug.cgi?id=19749

-- 
Thanks,
~Nick Desaulniers

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
