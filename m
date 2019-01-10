Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E6DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:15:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 623F02177B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X+rKGglK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623F02177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PsPREz7I/4cwpRp64skIzNz0Rbw916Aocn7AcZCkuDA=; b=X+rKGglKwzxJ6e
	Gu8KDgdA30REfDRLb1VenVGmPXMOFgCbDPsicLEiP+Zpvhha3BoMGhov/OfBIiGgQNNCxX4+gIIQ6
	WNdgx9D5QHvwOqgMV8ZTSCJtjwIGTRYmilz6Zj4iQ66qqy8/hQ0v9y1IalCgQoro+D2BPWICqWij8
	ocLJNIIofqKktjEOoMP+a4uRUQC2PTKYhBOT2PdlrCny+sS11x/Z/NVDU/LEDmRpX+exk8ja1Bkhu
	m2fiF6FmKitn9Sb3bpdqzVz8fbSGGNUCrIB6z97WdbrDlXPiQ2SKFC5vScpQ+KakSpIY2Pg3AHnqF
	6C92gFGdD3jXrhOO2Mdw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghdvC-000512-HG; Thu, 10 Jan 2019 17:15:10 +0000
Received: from mail-qt1-f196.google.com ([209.85.160.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghdv9-0004TD-GY
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 17:15:08 +0000
Received: by mail-qt1-f196.google.com with SMTP id y20so14015828qtm.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 09:15:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Vi+SvwsycUKtGhpMC3QEpN/Bk6bKq1AfTBDWYF1k7VQ=;
 b=HoA42E6NYJh50vhm7/iatsKmB7nE1FBkXEZfHLL6tocnzjjhLGdxaNpkNJKo8cPOQb
 ghHuPHs+LPDUQdr8T+6cRNTSFMOi+xFEXKZp62HkYwo+BNqAa3n+WIWx6S5SXDg9O6+e
 y6SqcTt3uAjfqWsznhQwd9FElfLjcOgNFH5tIV5nejW8kF9ZgSOTe21jtMVMvw7ZFL32
 Jyrc+iBHmO0r5hUpwoNH2ewsCOkPNm9TWB6FNpi1gs6RTQQpgg1u4pG8LI968+WPYySI
 JRql39YI+scMd+39Qn5NiT14GzfWiQm9K+hvmKt3/bt2m9GW4Gfn+xee4N8/ilss6ZJQ
 zsWg==
X-Gm-Message-State: AJcUukcjJ+MhN8jWJvIW1HQ9qDx4CXaTdShP3utRqjNrP0+FxHoMJNNw
 OGkBsr7xJDCjS68rL5d381q1u5FVZnFjRPcytZI=
X-Google-Smtp-Source: ALg8bN4AdylggnguSr7egu7xIPGdOjTe436nAOiytiob3A7SfzgpinZUkBcCe85tXDNMw1nvzwC1nAoiCh7sWU6vHE4=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr10355152qtl.343.1547140506273; 
 Thu, 10 Jan 2019 09:15:06 -0800 (PST)
MIME-Version: 1.0
References: <20190110162435.309262-1-arnd@arndb.de>
 <20190110162435.309262-8-arnd@arndb.de>
 <20190110163908.GC31683@fuggles.cambridge.arm.com>
In-Reply-To: <20190110163908.GC31683@fuggles.cambridge.arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 10 Jan 2019 18:14:50 +0100
Message-ID: <CAK8P3a27hYDL+yjO+DFe8n_C_dyjGNKcKOcWz-p3Pc1LwcxKjw@mail.gmail.com>
Subject: Re: [PATCH 07/15] ARM: add kexec_file_load system call number
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_091507_560663_B875391A 
X-CRM114-Status: GOOD (  15.40  )
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
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
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Firoz Khan <firoz.khan@linaro.org>, Matt Turner <mattst88@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>,
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

On Thu, Jan 10, 2019 at 5:39 PM Will Deacon <will.deacon@arm.com> wrote:
>
> > diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> > index 355fe2bc035b..19f3f58b6146 100644
> > --- a/arch/arm64/include/asm/unistd32.h
> > +++ b/arch/arm64/include/asm/unistd32.h
> > @@ -823,6 +823,8 @@ __SYSCALL(__NR_rseq, sys_rseq)
> >  __SYSCALL(__NR_io_pgetevents, compat_sys_io_pgetevents)
> >  #define __NR_migrate_pages 400
> >  __SYSCALL(__NR_migrate_pages, sys_migrate_pages)
> > +#define __NR_kexec_file_load 401
> > +__SYSCALL(__NR_kexec_file_load, sys_kexec_file_load)
>
> Hmm, I wonder if we need a compat wrapper for this, or are we assuming
> that the early entry code has already zero-extended the long and pointer
> arguments?

Yes, that is generally the assumption for compat syscalls.

s390 needs some extra magic to do a 31-to-64 extension on pointer
arguments, and I think sometimes we need a special wrapper to
do sign-extension of 32-bit arguments into 64-bit, but the arguments
here should not need that.

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
