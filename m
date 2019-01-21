Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BB4C31685
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:08:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F183217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bH3IVapJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F183217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LrBWoznren62c7iWXektRoW24/p1Hlq1Ve/oFLK/cGQ=; b=bH3IVapJ63GHuo
	rIZdHda5KcoDNoPNES2SY8TdYPuxvzXdgieN3Bu2Qk41nik9tlTrTpJo+wAR9ppFtjNhdxuXZn8mN
	xR8XpKzF8+KgX+p6SZMkV5hpj4/Uas+uBl1XL1yAnXEtXYZtVvUNWWfsCGfP4MYztqYhkpDJdMvAG
	xon9Ww73Grc7xg3mRzTFi1ili+tPb/7HHC4JqOJ3OkuVMFQse/hS8P5lAXAR4uIefBVbsYE1LLSb3
	SAodw8jmN4AShefxwnT/kQKA+hr/Uyo7t2naLSonhewh88sdg4MH1x09YgEp5GCd7W4uDsCh5sC+V
	tyJilEj8xnoKzTltEXDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gld3x-0005iw-V7; Mon, 21 Jan 2019 17:08:41 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gld3u-0005iV-E6
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 17:08:39 +0000
Received: by mail-qt1-f195.google.com with SMTP id v11so24373957qtc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 09:08:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A3BFzNbMjDWWnmVRt1tolWRl8m0peBLC2YUEivt95tQ=;
 b=cyacAlrIlXrP5av/CRYJLB6hfaM+NjxAsElGIufSmJqnEITpc0/hsPNS5lhRO/wrVQ
 aC3oaRVjbocctUmX2bmi4NgU27ObkSRwk/baJ0eiBiJDQ+JkpfiE+Y6yHfwtLKvEcnMR
 NwqnCxWxLgLDHl3XJ+Qyo6GsCW2tlwkXXX+9QjLHBJfiJSJ/F5AbwzAfFEB3mhfnKLd/
 PiOkVJNruZu88h49sRF0jWiPpge8Rj27qDJDmiMvHj55TjwinEuCVf3b8Jx8xxFYqwkF
 iokkz8/yRCWJyCNPkPzwNkVrLsBJ/tFb3QOtsFB21cbV/iYtxs2iu+o09T8DLagXH2RH
 tyBg==
X-Gm-Message-State: AJcUukcsaY+k/BZFEGGCmPQTzpXMGmjF7Hng7zR3WSD/zTH8BAVIwzb8
 fREZrTc+6iC+WgF3/ZSxaFt5zl7fWuWtgin4XDk=
X-Google-Smtp-Source: ALg8bN7/DN0rP0JOEiYkuJ24jXW/SvkEYHpGox4RlM5iK+eeluX/kG/Kn+zKF5Ngogsr1NCH9MXedHfaxCnYfxa1vgY=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr27232408qtl.343.1548090517294; 
 Mon, 21 Jan 2019 09:08:37 -0800 (PST)
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de>
 <20190118161835.2259170-30-arnd@arndb.de>
 <CALCETrXqM5mhvwreN5y-9K99h1j9rs9MAVK-cNLC54s1fdHA6w@mail.gmail.com>
 <CAK8P3a0V+xboaGAF2nqrYtpjXXA7y0LcvCKi4ngLTus1D_XZBA@mail.gmail.com>
 <CALCETrWPj6dHEyo=AELoVjXGsiwuSpRp17x3CEWBHvp7i3cy+Q@mail.gmail.com>
 <20190119142852.cntdihah4mpa3lgx@e5254000004ec.dyn.armlinux.org.uk>
 <CAMuHMdXzQNEEDjWrmTph8Krovj1g2WhnBUaM=FvKB+J2fZqctA@mail.gmail.com>
In-Reply-To: <CAMuHMdXzQNEEDjWrmTph8Krovj1g2WhnBUaM=FvKB+J2fZqctA@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 21 Jan 2019 18:08:20 +0100
Message-ID: <CAK8P3a04UC2dHVqx1gHXJQzsDw446h1ghLEuRe0xmUyJgrOktw@mail.gmail.com>
Subject: Re: [PATCH v2 29/29] y2038: add 64-bit time_t syscalls to all 32-bit
 architectures
To: Geert Uytterhoeven <geert@linux-m68k.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_090838_471968_FD018050 
X-CRM114-Status: GOOD (  27.00  )
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
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>,
 Network Development <netdev@vger.kernel.org>,
 Deepa Dinamani <deepa.kernel@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux <sparclinux@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>,
 X86 ML <x86@kernel.org>,
 Russell King - ARM Linux admin <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Firoz Khan <firoz.khan@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Matt Turner <mattst88@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Will Deacon <will.deacon@arm.com>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
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

On Mon, Jan 21, 2019 at 9:19 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Sat, Jan 19, 2019 at 3:29 PM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> > On Fri, Jan 18, 2019 at 11:53:25AM -0800, Andy Lutomirski wrote:
> > > On Fri, Jan 18, 2019 at 11:33 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Fri, Jan 18, 2019 at 7:50 PM Andy Lutomirski <luto@kernel.org> wrote:
> > >
> > > Can we perhaps just start the consistent numbers above 547 or maybe
> > > block out 512..547 in the new regime?
> >
> > I don't think you gain much with that kind of scheme - it won't take
> > very long before an architecture misses having a syscall added, and
> > then someone else adds their own.  Been there with ARM - I was keeping
> > the syscall table in the same order as x86 for new syscalls, but now
>
> Same for m68k, and probably other architectures.
>
> > that others have been adding syscalls to the table since I converted
> > ARM to the tabular form, that's now gone out the window.
> >
> > So, I think it's completely pointless to do what you're suggesting.
> > We'll just end up with a big hole in the middle of the syscall table
> > and then revert back to random numbering of syscalls thereafter again.
>
> I believe the plan is to add future syscalls for all architectures in a
> single commit, to keep everything in sync.

Yes, that is the idea. This was not realistic before, since each one
of the old architectures had its own way of describing the system call
tables, and many needed a different set of quirks.

Since (almost) everything is now converted to the syscall.tbl format,
we have removed all obsolete architectures, and a lot of the quirks
(x32, spu, s390-31) won't matter as much in the future, I think it is
now possible to do it.

We could even extend scripts/checksyscalls.sh to warn if a new
syscall above 423 is not added to all 16 tables at the same time.

> Regardless, I'm wondering what to do with the holes marked "room for
> arch specific calls".
> When is a syscall really arch-specific, and can it be added there, and
> when does it turn out (later) that it isn't, breaking the
> synchronization again?

We've had a bit of that already, with cacheflush(), which exists on
a couple of architectures, including some that use the first
'arch specific' slot (244) of the asm-generic table. I think this
will be rare enough that we can figure out a solution when we
get there.

> The pkey syscalls may be a bad example, as AFAIU they can be implemented
> on some architectures, but not on some others.  Still, I had skipped them
> when adding new syscalls to m68k.
>
> Perhaps we should get rid of the notion of "arch-specific syscalls", and
> reserve a slot everywhere anyway?

I don't mind calling the hole something else if that helps. Out of
principle I would already assume that anything we add for x86
or the generic table should be added everywhere, but we can
make it broader than that.

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
