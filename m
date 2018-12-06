Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54167C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:19:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 222A52082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nq3cqNHX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="upjF35iY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 222A52082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T+dVzNpyNchBwGdUvCi7I6xmL55xWr9O0nK7jZ1IFaY=; b=nq3cqNHXBmU9Q6
	idox9i523fA4kCLLye18L5s5ULEHn3PktdxhpImi/g42ShK4U5HDIDSAH+Y2jAOjpohheCdP0jUg5
	Du11+D+uz486yHEV3Xqm9nzDhrjBGC9hk6yH+K5Pr65lr9X8htWn1hhljQauc4IRsd0hzgNcEBRVU
	HLUqwAXhKdptufclRoyjDJE7gR3o8GS9kUz6hbi8scWdu4fTBJ2/1vPD+mkjoZLvwYwpHM2t17cMj
	b02pi6AGTUM1arVEQDPqn/Z0Zu1avYphCF1C8T7Q5euVuz6HFupgDtLy3kxdv0DEJIxLrB8Bfaawa
	RzBXjYDBHsmd++ptc9yw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUqkq-0006Un-7X; Thu, 06 Dec 2018 10:19:36 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUqkn-0006UF-BQ
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 10:19:35 +0000
Received: by mail-it1-x142.google.com with SMTP id g85so492469ita.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 02:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8E9PbE8KN4ACuzYfCxgB7Qnel5iCJrJXGdqLgrAraZs=;
 b=upjF35iYD3/uGdNNZCfP2U5fqUW4lGBU094scjynoWN24nJtSnzyCQqcxaHybWVzTh
 N7OgaX+UfENuRID4VRbgfPpcQ05YxW/GrXX7KSfwHvgsxXk9r2GrrDY4aLYQCQVJ0kUU
 8fYkkUxjwlHn2HmF6nNqAzHdGXlJFCh1hl/+X29kSZfPHToJyc0fP0es/GufFNCHXI0k
 dQommNJoqgPlcdZVHypT9FoOksl1wBVsNfqws9WrDxqG4GMb1RlcISoT2fD1aRQFOr2G
 fxXmsxtpUjaz06HCMwqJHoHFG/6thVs2Ar/RV4WKGYensUIUeX6CPLjCG6/demjq4LZu
 d7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8E9PbE8KN4ACuzYfCxgB7Qnel5iCJrJXGdqLgrAraZs=;
 b=Knad77suXacYtPttKpdXjGqoRUcAEYzDBUBsSvel0zgrBUBgkd1lNEXx+j9cTvXHBO
 zBawZOcWDZLPLRfdeln8M5KEzjXBufzqofH06lH6Al9LkiUnz/0nNQS6jOrsnOitcHpL
 L9Q7TJieZk5/GduXImujURa3q5iWggi6T1/JIVPFZ6r1KS1gi4yz9f81ShvmhDbxH3t1
 1IdIuqjYua8iq7vUbZ+vGs1kgZ/xPG+yMcf2SGouMBMW2o5+Ikyhu3IYeGgeBltVe6/H
 ZyaPEgLn+OkzCq2ZnB7RnRhtnu5pAKhMrEoUkQbeB/lpZPj/Yt9xOWXyeQSKFiXruWMf
 sfUg==
X-Gm-Message-State: AA+aEWahhXpC7Q9G5w3BJjU4zI1MPXQsF7slXCP+hxsknI/OWD2I0BzW
 20QYLwBkE5cBHoGQ+e30ad7wRJpw3pCY2URC9ywEfw==
X-Google-Smtp-Source: AFSGD/UlXjTp0eoz8N48OkTtlNnBxX8SmW0cQOYEM9DQprpIXPKQHJY+yksBfJAv3tL7v8D5cexmCQZLv1b9UiGEGNE=
X-Received: by 2002:a24:2716:: with SMTP id g22mr16771301ita.40.1544091555752; 
 Thu, 06 Dec 2018 02:19:15 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543337629.git.andreyknvl@google.com>
 <20728567aae93b5eb88a6636c94c1af73db7cdbc.1543337629.git.andreyknvl@google.com>
 <CAMo8BfK5aEGae--xvboLxMXTe1orA7kmLR_uFNCqC6M-a=Om5Q@mail.gmail.com>
In-Reply-To: <CAMo8BfK5aEGae--xvboLxMXTe1orA7kmLR_uFNCqC6M-a=Om5Q@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Thu, 6 Dec 2018 11:19:04 +0100
Message-ID: <CAAeHK+zprEaJMexWRZj1QbuygL0dOC5LqJRok8cairfLw=VVvw@mail.gmail.com>
Subject: Re: [PATCH v12 05/25] kasan: add CONFIG_KASAN_GENERIC and
 CONFIG_KASAN_SW_TAGS
To: Max Filippov <jcmvbkbc@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_021933_416858_0EFE511D 
X-CRM114-Status: GOOD (  23.73  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Paul Lawrence <paullawrence@google.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Alexander Potapenko <glider@google.com>,
 Chintan Pandya <cpandya@codeaurora.org>, Christoph Lameter <cl@linux.com>,
 Ingo Molnar <mingo@kernel.org>, Jacob Bramley <Jacob.Bramley@arm.com>,
 Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Mark Brand <markbrand@google.com>,
 kasan-dev <kasan-dev@googlegroups.com>, linux-sparse@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Martin <dave.martin@arm.com>,
 Evgenii Stepanov <eugenis@google.com>, Vishwath Mohan <vishwath@google.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Dmitry Vyukov <dvyukov@google.com>,
 Kostya Serebryany <kcc@google.com>, Jann Horn <jannh@google.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "Eric W . Biederman" <ebiederm@xmission.com>, Lee Smith <Lee.Smith@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 4, 2018 at 11:24 PM Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> Hello,
>
> On Tue, Nov 27, 2018 at 9:00 AM Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > This commit splits the current CONFIG_KASAN config option into two:
> > 1. CONFIG_KASAN_GENERIC, that enables the generic KASAN mode (the one
> >    that exists now);
> > 2. CONFIG_KASAN_SW_TAGS, that enables the software tag-based KASAN mode.
>
> [...]
>
> > --- a/lib/Kconfig.kasan
> > +++ b/lib/Kconfig.kasan
> > @@ -1,35 +1,95 @@
> > +# This config refers to the generic KASAN mode.
> >  config HAVE_ARCH_KASAN
> >         bool
> >
> > +config HAVE_ARCH_KASAN_SW_TAGS
> > +       bool
> > +
> > +config CC_HAS_KASAN_GENERIC
> > +       def_bool $(cc-option, -fsanitize=kernel-address)
> > +
> > +config CC_HAS_KASAN_SW_TAGS
> > +       def_bool $(cc-option, -fsanitize=kernel-hwaddress)
> > +
> >  if HAVE_ARCH_KASAN
> >
> >  config KASAN
> > -       bool "KASan: runtime memory debugger"
> > +       bool "KASAN: runtime memory debugger"
> > +       help
> > +         Enables KASAN (KernelAddressSANitizer) - runtime memory debugger,
> > +         designed to find out-of-bounds accesses and use-after-free bugs.
> > +         See Documentation/dev-tools/kasan.rst for details.
>
> Perhaps KASAN should depend on
> CC_HAS_KASAN_GENERIC || CC_HAS_KASAN_SW_TAGS,
> otherwise make all*config may enable KASAN
> for a compiler that does not have any -fsanitize=kernel-*address
> support, resulting in build failures like this:
>   http://kisskb.ellerman.id.au/kisskb/buildresult/13606170/log/

Will fix in v13, thanks!

>
> --
> Thanks.
> -- Max
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To post to this group, send email to kasan-dev@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/CAMo8BfK5aEGae--xvboLxMXTe1orA7kmLR_uFNCqC6M-a%3DOm5Q%40mail.gmail.com.
> For more options, visit https://groups.google.com/d/optout.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
