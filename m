Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37B7C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:43:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C19D7214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ViIlRQvs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19D7214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yadL7JPsU/cmedRAzokP72amwUA3YZ3UJEvv7R8dfn4=; b=ViIlRQvs/x3FQD
	1PruZwbEtqJINVUIx4tMhokdL3sdlEklFN9ciTWKsRkXsBn03LjAtH41zrap2h/yZRWeC2OiLZnIn
	x5P285Gl26FZ0S7pkXUQ8Mq2hf5GLCPfOJrmz4bKgm5pkDJlZJYKEkn1AjkhoaERXLMDhMZDmID/p
	3dea08CD7Ch6gT2ju83cRAlAp7G3jHbmDRu25+KBcePfllOQZOPHCjpksldOV3fOhi4jaJ/dlzsmB
	Hr0Kgg0Aum6o6VQ0BuY01Xb4rXOAOAnb8XApg9MdCIgjHpEuFLuPRWfDSoEoH6fbZ1lNxunlUs4m5
	pf1gWZrWL5Df4QSOCIYA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghj3K-0008Ip-N7; Thu, 10 Jan 2019 22:43:54 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghj3H-0008IJ-7o
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 22:43:52 +0000
Received: by mail-qt1-f195.google.com with SMTP id l11so15904706qtp.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 14:43:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8BQxy77aw0o+DSOGQG1SQtIdLEpkaKMICEdNR1LQ13U=;
 b=N7lwu4D8aNZiCcL90YG5LCDNeJHUbXMnqGb32NJagDZY2pV531JcDan8PrFcEiTozH
 A/83la4DVU8WnKwiqa+epAPSQJG75jVTi0M+euCBOtIXzFLfZ0A8klREu0h0tfeGyj1I
 6ZWkXTSElSWMzIK3BQ4HptZZRP73kxFlSsjke04rp7Hn5Q1knP0Xki8SwnAmpf532ArM
 ZyEpI12p4BcvAff74zwpuU2en+FosuT4/Tq3IaeSLtugIeA9xRZFt8U7OdWHtNO7arOu
 ez05yVo8qjL5lAxhpOTLai+42tbedA5wTawo17d0HOY7kn0fT9KXnZLvt/aYOnjbt9+N
 3b4Q==
X-Gm-Message-State: AJcUukcQ6fKlXdVN7MJqoUnTvt8LK2p0Pcj/RgvXHuWiJafCoHhvHSjH
 IY5XKHm1iTMIwVPgXeCUWuupa//arZbJKt1Wx48=
X-Google-Smtp-Source: ALg8bN6HaEyY/0zx6RGqFtKtlSPz+RZx+KrllRYiKjcCjzeA51uZ4VQUxl3HD7ARydoqD46n7kKW7Dhkol5Ir927zA4=
X-Received: by 2002:ae9:d8c2:: with SMTP id
 u185mr10538686qkf.107.1547160230039; 
 Thu, 10 Jan 2019 14:43:50 -0800 (PST)
MIME-Version: 1.0
References: <20190110162435.309262-1-arnd@arndb.de>
 <CAMuHMdXYP3=TRHYqddVRfbRRaj_Ou=wfoX6ohKM7XNAx-c2RXw@mail.gmail.com>
 <CAK8P3a0kmr2ju+sZE+f-+=-2t5Eu+t-DS-+r6OKrPVTAxHwf8w@mail.gmail.com>
 <CAMuHMdVpUNUx-wdDYChYNzMYqYi79w5tzjk5x3JskdS88VQCQw@mail.gmail.com>
In-Reply-To: <CAMuHMdVpUNUx-wdDYChYNzMYqYi79w5tzjk5x3JskdS88VQCQw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 10 Jan 2019 23:43:32 +0100
Message-ID: <CAK8P3a07yNiadLCJcA0Tyfo90YeQ0P2XF-wOEy9XAb8cDTFObw@mail.gmail.com>
Subject: Re: [PATCH 00/15] arch: synchronize syscall tables in preparation for
 y2038
To: Geert Uytterhoeven <geert@linux-m68k.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_144351_279323_FE85C7EB 
X-CRM114-Status: GOOD (  22.02  )
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
Cc: Rich Felker <dalias@libc.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Dominik Brodowski <linux@dominikbrodowski.net>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Deepa Dinamani <deepa.kernel@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux <sparclinux@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>,
 Firoz Khan <firoz.khan@linaro.org>, Matt Turner <mattst88@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Will Deacon <will.deacon@arm.com>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Burton <paul.burton@mips.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 alpha <linux-alpha@vger.kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 10, 2019 at 7:11 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Jan 10, 2019 at 6:06 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thu, Jan 10, 2019 at 5:59 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Thu, Jan 10, 2019 at 5:26 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > The system call tables have diverged a bit over the years, and a number
> > > > of the recent additions never made it into all architectures, for one
> > > > reason or another.
> > > >
> > > > This is an attempt to clean it up as far as we can without breaking
> > > > compatibility, doing a number of steps:
> > >
> > > Thanks a lot!
> > >
> > > > - Add system calls that have not yet been integrated into all
> > > >   architectures but that we definitely want there.
> > >
> > > It looks like you missed wiring up io_pgetevents() on m68k.
> > > Is that intentional?
> >
> > Yes, I thought I had described that somewhere but maybe I
> > forgot: semtimedop() and io_pgetevents() get replaced with
> > time64 versions in the follow-up, so I only added them in
> > 64-bit architectures. If you think we should have both
> > io_pgetevents() and io_pgetevents_time32() on all 32-bit
> > architectures, I can add that as well.
>
> Thanks, sounds fine to me.

Just to be sure, you mean it's fine to not add it, not that we should
add it?

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
