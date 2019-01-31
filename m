Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D9DC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:48:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D24B3218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QH58NMtV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D24B3218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kJrsKsxlKaiIDGCZBQnwOOlRx2apBq2Vju1F7EKjWD4=; b=QH58NMtVBNGEks
	E2V31DmNYV/cizCXHQSlPpISLp60unLemvXZtM+TV/FgsZV2hSKOxtoHCURelRQrZX1YcQyBGlwgc
	aKYNOu9iv/J7jy87+Hb6HT/7vClreG1TfQ5O2zjK3T4zhYkgjYWpsZjxU+2HJ5n/js1kkbCBKNbnk
	lksZ0G/cSBAix7AGS7K+DOLBfbXI4skh6iZGKYmPDJ1V6L4GB/ZnOWV0N65Zi5aQEkQrx4vyRVVZC
	CzWDJC9xbOibjhXIQMtHyXx1LE0x12XQOl3BmzLBn5P9iCwZr5I55tQMuu5RXGKB+tkVKFVEYS/7u
	u3HsMF2B2K19lDfQgH4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp9tQ-0003RU-Np; Thu, 31 Jan 2019 10:48:24 +0000
Received: from mail-qk1-f193.google.com ([209.85.222.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp9tM-0003Ql-Fr
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 10:48:22 +0000
Received: by mail-qk1-f193.google.com with SMTP id c21so1572910qkl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 02:48:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WVxlOaK+eZZ185G95DcvekJ8Q60BcSh9dQMaiUdwJ7g=;
 b=Grm6cFM8L8j3hOP0EUMs7VXJ+VznuwjZKTjkuOE7EhShFFmP3+lCQPjA0Sos12qR5q
 gWZkVtSDKcNBPzUSVlgKoMlDllAr7VKnnUQFoskB8+8r9LqGNerAq+1iDW6kVdWo7/KN
 m+vsWcfGgv49wvD+B+v8V8aSF/vf1IeHYhClxX3MVH7/nWmJoyBCHSOWwA0iOg3/T9a8
 Gg+7gMyMDDdgCPcvKqR7oWjsJRUm7S5pzWoMozG7JXIaN7E9fVj68+O2t82LlJwUdB9F
 AbgZPTzQqc7KT591HsyYTH5yTyJ5fBmRkDKkctZ63VzhHzJZwFTeX1ljtraMjUWdsYjR
 EaWQ==
X-Gm-Message-State: AJcUukdlpnRDEE0ptnbPWhl8nQpYm+0SAHsjeS8sRUE3rXuG1r6M7B5r
 qwg4/v4U+NRlEuKOhlOfzvlHwrREOVxL5cXRI8k=
X-Google-Smtp-Source: ALg8bN4r7yVR/gLXnv2cpoIBd9HHa+y+s4oGvmNIZnw3Z2E/HDgvEaKyisAGfV8k3B6BSmEvv6tSgtD8FlNJt70htWE=
X-Received: by 2002:ae9:e102:: with SMTP id g2mr29384363qkm.343.1548931698990; 
 Thu, 31 Jan 2019 02:48:18 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdYRiWZbkduBRxQdPC_1hJjQJCYhX9NFB31t1Su1CSBNyw@mail.gmail.com>
 <CAK8P3a1GK3sZ+1pFS-4y5EgsV0ttA0OsYrmdmSzrJc8me26J7A@mail.gmail.com>
 <CACRpkdancbk84o+wEvMPA-+qjeAQDo5Ob24KzaEc9TUH=x5Y3Q@mail.gmail.com>
In-Reply-To: <CACRpkdancbk84o+wEvMPA-+qjeAQDo5Ob24KzaEc9TUH=x5Y3Q@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 31 Jan 2019 11:48:02 +0100
Message-ID: <CAK8P3a1YesRk+w1aDOTF_pr5S+g6ekS2vqv_QzUuvD6wu8RfaQ@mail.gmail.com>
Subject: Re: [GIT PULL] SPEAr defconfig update
To: Linus Walleij <linus.walleij@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_024820_523744_0892004E 
X-CRM114-Status: GOOD (  18.43  )
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
Cc: viresh kumar <viresh.kumar@linaro.org>, arm-soc <arm@kernel.org>,
 shiraz hashim <shiraz.linux.kernel@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 31, 2019 at 9:03 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, Jan 30, 2019 at 10:52 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Mon, Jan 21, 2019 at 1:30 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > >
> > > Hi ARM SoC maintainers,
> > >
> > > this:
> > > 1. updates the SPEAr 3xx defconfig
> > > 2. replaces the fbdev PL11x framebuffer driver with the DRM PL11x driver
> > >    in the defconfig
> > >
> > > This has the ACK of the SPEAr maintainer Viresh Kumar. I don't think
> > > there even is a SPEAr git tree so I send this from my GPIO tree. If they
> > > have other plans, they can say so now :D
> > >
> > > Please pull it into ARM SoC in the appropriate place, next kernel is
> >
> > I have a similar comment to the nomadik update, though there
> > is only one non-obvious option: why do you turn on CONFIG_PREEMPT=y?
>
> Oh that's just something from my script, sorry.
>
> It'd good that it comes up but I guess it should be a
> separate patch.
>
> These are not servers so any other configuration than
> CONFIG_PREEMPT is probably just wrong, as is any
> other setting than Tickless idle and HRTimers on.
>
> I am thinking maybe we should actually have ARMv7 and
> ARMv8 multi Kconfig simply select these things, I don't
> really see why anyone would want to configure these
> differently, it just seems vaguely cargoculty and overcautious.

Yes, I agree that turning these on is a good idea, but please
send that as a separate patch. One patch to turn it on in
all configurations you care about is fine.

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
