Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9E3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:08:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D39D2064C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FL8cNln4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D39D2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=14III9M+tyu8j/XbsZX3Pie5j4CvPCWjfTeSLJIC+8w=; b=FL8cNln4lHqZpP
	epbIja2HZyyb0Mwqpn0SQgh4E6NNQqx7ld33wdK3WzAn2rDMRKxY4yvE2/QTs23NrNJLh+F+dpwBK
	kqBfChkeGn/rhVxyz/7ucbPSHoYczRpJs6kMX2IEVarnXosZlm9A0YCmXKgPKZsC1Qm1WqriVPjnx
	LP0y4mthACHqzC3PPg3QTkYFozJ11CzNdk0iwScxhpjYgvLIVavuM/Vm53/2ic5K/APbVA2CqmaeB
	zpYuD8VZzgFbCmCMSTpsR0zJFwUHkjw7at2t6hzi7lU80h7OX7RP2LqxIcXpAHin+WQFZJZC4hkCd
	NDqpNoATxWD5R7jlWkmw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghrrD-0005e1-Nt; Fri, 11 Jan 2019 08:07:59 +0000
Received: from mail-vs1-f66.google.com ([209.85.217.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghrrA-0005dY-Ml
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 08:07:58 +0000
Received: by mail-vs1-f66.google.com with SMTP id n13so8707343vsk.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 00:07:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Gk5sRyaMorBl1gCKq795+qZVHE+uAsmqqhSvjIZGPmU=;
 b=LwOzlVyZAVREcZR86dROuIyWPvZ8TSK8ouq1hGoKH4zYkBwyybZXmpu+qQe8E5KTqj
 2W1pHLFx/RTQzzgQEiARCf5MySvAKF6IToLuH5wqkw+NgfCebpoZ1Lk/ewf9W3JscVKx
 DayKuOWhr9O0vuZF9bdlLrna4WYC2GZaa6ZjA9hFbYz4J58Z0Url6EJSAS5oRwe/dGIJ
 jhuqplLIYW+kwDEyN9jksygFskU2/1x6FKzdFWpn7BS8yGbNMLh/CMIwuInaCG69lZ6/
 9eJvMnJ7wP59m9gTQUSMfwTsC91bJjmyT7IQxXYW0Y3RQWtyxVKA42rplZjE9vXwM8CX
 WMPw==
X-Gm-Message-State: AJcUukeurb5Cbsdh114Ww6wrsdMPQy1YbaqKj/q4CCUbr+qe68xVVTLb
 vSogLslKHtxtgeT150yKLJcHO8XBcWYqjxvxOos=
X-Google-Smtp-Source: ALg8bN4BZSRCmO8JcdiTKsQLtOiGYCRcA4qcLBhQcTtWAUJ36fVLDe+20wntOZTNXHVnjK/m8j2ch6eOfrp0E8t9JNI=
X-Received: by 2002:a67:f43:: with SMTP id 64mr5594803vsp.166.1547194075355;
 Fri, 11 Jan 2019 00:07:55 -0800 (PST)
MIME-Version: 1.0
References: <20190110162435.309262-1-arnd@arndb.de>
 <CAMuHMdXYP3=TRHYqddVRfbRRaj_Ou=wfoX6ohKM7XNAx-c2RXw@mail.gmail.com>
 <CAK8P3a0kmr2ju+sZE+f-+=-2t5Eu+t-DS-+r6OKrPVTAxHwf8w@mail.gmail.com>
 <CAMuHMdVpUNUx-wdDYChYNzMYqYi79w5tzjk5x3JskdS88VQCQw@mail.gmail.com>
 <CAK8P3a07yNiadLCJcA0Tyfo90YeQ0P2XF-wOEy9XAb8cDTFObw@mail.gmail.com>
In-Reply-To: <CAK8P3a07yNiadLCJcA0Tyfo90YeQ0P2XF-wOEy9XAb8cDTFObw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 11 Jan 2019 09:07:43 +0100
Message-ID: <CAMuHMdUpThq_fmSitzUrEUFx40itYdURpjmunLs_YLA9BPaMQg@mail.gmail.com>
Subject: Re: [PATCH 00/15] arch: synchronize syscall tables in preparation for
 y2038
To: Arnd Bergmann <arnd@arndb.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_000756_744463_2FA02099 
X-CRM114-Status: GOOD (  23.96  )
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

Hi Arnd,

On Thu, Jan 10, 2019 at 11:43 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Jan 10, 2019 at 7:11 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, Jan 10, 2019 at 6:06 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Thu, Jan 10, 2019 at 5:59 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Thu, Jan 10, 2019 at 5:26 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > The system call tables have diverged a bit over the years, and a number
> > > > > of the recent additions never made it into all architectures, for one
> > > > > reason or another.
> > > > >
> > > > > This is an attempt to clean it up as far as we can without breaking
> > > > > compatibility, doing a number of steps:
> > > >
> > > > Thanks a lot!
> > > >
> > > > > - Add system calls that have not yet been integrated into all
> > > > >   architectures but that we definitely want there.
> > > >
> > > > It looks like you missed wiring up io_pgetevents() on m68k.
> > > > Is that intentional?
> > >
> > > Yes, I thought I had described that somewhere but maybe I
> > > forgot: semtimedop() and io_pgetevents() get replaced with
> > > time64 versions in the follow-up, so I only added them in
> > > 64-bit architectures. If you think we should have both
> > > io_pgetevents() and io_pgetevents_time32() on all 32-bit
> > > architectures, I can add that as well.
> >
> > Thanks, sounds fine to me.
>
> Just to be sure, you mean it's fine to not add it, not that we should
> add it?

I'm fine with not having the legacy 32-bit ones.

Sorry for being unclear.

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
