Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281BEC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:36:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAF4320657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pQ5/C06a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF4320657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S9cKGyYiSVjuAn29Q9OyAKpr8F3vJyfcqAacuJUj4Hw=; b=pQ5/C06ahee+DX
	7EeYJYyahRAIchmsZEbFggKFUdGZJuZPyl0bPIr9/XEliHPyXKggR0yQxTy6IimQhAc1R2AytSfnC
	Zqd27ud6MYFK5M0cZk3bNtidYBToSK/kUyE5qyopnIOab+S6LvmWFpJ4TBVT3iiLp+poIs1pfKl06
	qU8+b7dyveL53I3UkjvWN07YhisxxxYpJ3tCidAmAjR8w9fCw0jCyzHd+sOB7Y7899UsFOLoqvqHC
	XuXkcbpkcUscKjr7a4vActma6BYpapBvtKvEpZCvRgYxlkB+FbqeLKBIOdlhNlcVLqQ0vDQ6L+L3N
	ab2NZqipx2KFfNFkjQmQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjRhF-00060F-Ri; Tue, 15 Jan 2019 16:36:13 +0000
Received: from mail-ua1-f66.google.com ([209.85.222.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjRhC-0005zX-Hh
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 16:36:12 +0000
Received: by mail-ua1-f66.google.com with SMTP id v24so1121887uap.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 08:36:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=adm1Mw3mLDDQkb5Mftiy3lAZ198qNeHBJOL4SrY1tf8=;
 b=JAXghG66tDWFTqVoz1YQteBvy1JIT8Qgfc3OQhnryNB97xRDr+0pIyKEX8KR8qwwb4
 j2/WBWkMteRg/drglDKoFuzYkdxml7pW46oxk6xXzHQqhsmfdHVvg4CNHSyYRiV7dMbm
 NSlWU7YNOuleCXz4c+SJrYwatnkxtpmyXFHlCu1xWVX3CVv+YhDXmy4PFW2X3rmXsuil
 OA4haNJcYdpODkOeeT5epUhDICsj6PYDZrFXWx6/U3wMB8oKiOBrkaIaMWEtnxLmvv0u
 2mdmsEMOGcc21QWYRMs9OZbJIf51+yRVwSkD/JLyQLflELXHwDfC0ssORBg0WDPqwyU1
 UOHg==
X-Gm-Message-State: AJcUukeuuFCR6thtwZAHe0RI2aROdYVfsXyQJyH4dCiiAVkjAX+dY9p6
 EqPXDWG+xkapqZpv7itPf+JFe3pQuOVBsasHc0w=
X-Google-Smtp-Source: ALg8bN5nyuahVho846ktl4afIc2BkzN7/rQ1M7vxhSJ6rgU6eyfffsa43/9sALd1FvtSGdvtLkpiFjHkbityoUbDtSg=
X-Received: by 2002:ab0:210e:: with SMTP id d14mr1882691ual.20.1547570168071; 
 Tue, 15 Jan 2019 08:36:08 -0800 (PST)
MIME-Version: 1.0
References: <20190110162435.309262-1-arnd@arndb.de>
 <20190110162435.309262-15-arnd@arndb.de>
 <87pnsz28k2.fsf@concordia.ellerman.id.au>
 <CAK8P3a0uas76i2W1yjFvxHT-2=A8_egUZeAUM-Vya6386+87Xg@mail.gmail.com>
 <CAK8P3a3eUzGDrJtV2ySpgHwjKHwZYr+1xHp6tChCt1gWi=mJ+g@mail.gmail.com>
In-Reply-To: <CAK8P3a3eUzGDrJtV2ySpgHwjKHwZYr+1xHp6tChCt1gWi=mJ+g@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 15 Jan 2019 17:35:55 +0100
Message-ID: <CAMuHMdVw1mBLGdn4hkiNVyoJ_oxMwi3d=_e7WL5ru+ALA4MKbw@mail.gmail.com>
Subject: Re: [PATCH 14/15] arch: add split IPC system calls where needed
To: Arnd Bergmann <arnd@arndb.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_083610_585597_7BB81226 
X-CRM114-Status: GOOD (  20.55  )
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
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Firoz Khan <firoz.khan@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Will Deacon <will.deacon@arm.com>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Burton <paul.burton@mips.com>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 alpha <linux-alpha@vger.kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Arnd,

On Tue, Jan 15, 2019 at 4:19 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Jan 15, 2019 at 4:01 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Mon, Jan 14, 2019 at 4:59 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> > > Arnd Bergmann <arnd@arndb.de> writes:
> > > >  arch/m68k/kernel/syscalls/syscall.tbl     | 11 +++++++++++
> > > >  arch/mips/kernel/syscalls/syscall_o32.tbl | 11 +++++++++++
> > > >  arch/powerpc/kernel/syscalls/syscall.tbl  | 12 ++++++++++++
> > >
> > > I have some changes I'd like to make to our syscall table that will
> > > clash with this.
> > >
> > > I'll try and send them today.
> >
> > Ok. Are those for 5.0 or 5.1? If they are intended for 5.0, it would be
> > nice for me to have a branch based on 5.0-rc1 that I can put
> > the other patches on top of.
>
> There is also another change that I considered:
>
> At the end of my series, we have a lot of entries like
>
> 245     32      clock_settime                   sys_clock_settime32
> 245     64      clock_settime                   sys_clock_settime
> 245     spu     clock_settime                   sys_clock_settime
>
> which could be folded into
>
> 245     32      clock_settime                   sys_clock_settime32
> 245     spu64 clock_settime                   sys_clock_settime
>
> if we just add another option to the ABI field. Any thoughts on
> that?

So "spu64" would mean "spu + 64"?
That makes it more difficult to read, and to grep.
What about allowing multiple ABIs, separated by commas?
So that line would become:

    245     spu,64 clock_settime                   sys_clock_settime

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
