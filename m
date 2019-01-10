Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EF4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:11:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0AB8206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="noDWO0h7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0AB8206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sK3NJ2hwQqb9XnRW/GcGlcy9fylOXLbuM42/DTPEwfc=; b=noDWO0h7oPGb8d
	LOhreqLl+bO/QrKoZJfp2vxWQRFChp6pia68ZiRjkns8iFPCOW3KVhI22qq9LZlnM5V9jz0JQoRq/
	tWq+bRIBA97V3FsT2xtezr/n8iUoTOABAbVXBCCZpMsf4XAmKNYqv8LpF+Il1+eyC9Gy4cMbRkmeX
	fsvEsmsbYJ20vyKuke4CItg5dQKzwA0+HNcowkPmeKDQEOrEzt20UIux9QNtHitLiufoqYqbt7VuG
	YsshYMyJ/KyBpLqXtXlcx3jYIPcsV0qGe7abad2Zy6JYbUtztRS92Hn7k/62LsPlM1JFJpvdZjyAZ
	4/ETYjpNFgOD3AemwTpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghenV-0000Ci-Gr; Thu, 10 Jan 2019 18:11:17 +0000
Received: from mail-vs1-f67.google.com ([209.85.217.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghenS-0000Bw-M6
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 18:11:16 +0000
Received: by mail-vs1-f67.google.com with SMTP id y27so7619445vsi.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 10:11:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EUuZ5Krtu82auHRun9veeZBKChDTVOpn44W3kwgqDtY=;
 b=lIjH6PQRCJrK/Tj0Tao6aSKDnfsrlZ5Uyf/kcSOb9ZTVEbBTkBiGu8xGC8Gva4xDEK
 JvakLHN6J5dPljbt0oOkQJCwv3TiybvTV1ao9GXExQANQvE+fQBdgmyl+ysEn0/y6KDJ
 ChCr3msQ6cVTea+w2dSaN7zPUxmBRuT2RzsQZeCUcKcH1WGZ5NTlFu/iAPy2o/KrnclZ
 MMwVqBth/Nb8/gwPMGtKZ5LaUCclptV/feBIcgFwRJbjRVZEioDfZByjUS2odKqHZZmT
 knIjHssHEWvNgQx3ZdaoVVIPUPz8ZTl57mKUawb/jUdFGYE+FFfI9l6PDblzC0Ak99+B
 m43g==
X-Gm-Message-State: AJcUukcqbrZa2pjNGcPSmh+mosAM9+xFRuJuVtoF3EC1RYzI2LJ9UbH7
 62bw/+ScZt4XchsKdvrzYyzPITi7hzai2M4uM8Q=
X-Google-Smtp-Source: ALg8bN6aokmnpf1j0NX2Ej8BYTOm8/6RZGNDOHHw2gQ7ocUs2TauDUatTN8cLeSj84eryGhe6FE/dq+5R1mIXqFPJxk=
X-Received: by 2002:a67:c202:: with SMTP id i2mr4350248vsj.11.1547143873299;
 Thu, 10 Jan 2019 10:11:13 -0800 (PST)
MIME-Version: 1.0
References: <20190110162435.309262-1-arnd@arndb.de>
 <CAMuHMdXYP3=TRHYqddVRfbRRaj_Ou=wfoX6ohKM7XNAx-c2RXw@mail.gmail.com>
 <CAK8P3a0kmr2ju+sZE+f-+=-2t5Eu+t-DS-+r6OKrPVTAxHwf8w@mail.gmail.com>
In-Reply-To: <CAK8P3a0kmr2ju+sZE+f-+=-2t5Eu+t-DS-+r6OKrPVTAxHwf8w@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 10 Jan 2019 19:11:00 +0100
Message-ID: <CAMuHMdVpUNUx-wdDYChYNzMYqYi79w5tzjk5x3JskdS88VQCQw@mail.gmail.com>
Subject: Re: [PATCH 00/15] arch: synchronize syscall tables in preparation for
 y2038
To: Arnd Bergmann <arnd@arndb.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_101114_720879_CE1927BC 
X-CRM114-Status: GOOD (  20.54  )
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

On Thu, Jan 10, 2019 at 6:06 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Jan 10, 2019 at 5:59 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, Jan 10, 2019 at 5:26 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > The system call tables have diverged a bit over the years, and a number
> > > of the recent additions never made it into all architectures, for one
> > > reason or another.
> > >
> > > This is an attempt to clean it up as far as we can without breaking
> > > compatibility, doing a number of steps:
> >
> > Thanks a lot!
> >
> > > - Add system calls that have not yet been integrated into all
> > >   architectures but that we definitely want there.
> >
> > It looks like you missed wiring up io_pgetevents() on m68k.
> > Is that intentional?
>
> Yes, I thought I had described that somewhere but maybe I
> forgot: semtimedop() and io_pgetevents() get replaced with
> time64 versions in the follow-up, so I only added them in
> 64-bit architectures. If you think we should have both
> io_pgetevents() and io_pgetevents_time32() on all 32-bit
> architectures, I can add that as well.

Thanks, sounds fine to me.

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
