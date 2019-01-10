Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EF0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:16:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A998213F2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B1tJPgyI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A998213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=orcon.net.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=124xDs1leqOVHHGH6NWPm7+yLGkAIziRR/kiRkF3+IA=; b=B1tJPgyIUHP5/+
	UrHCOg3gizgjP6RrWkyYV5Hs5uS5ASDtkOQyeFwM0JUeF8qrGgAqvhYwadBoq3Kwoqxwcarg6YgzP
	HE6pEgi3JLlHk1EEmUDt7DHLBz3WH2h238macBgliTuMzZ5VGnlEnyu3ITu67JE4R1+EFGq/SadoM
	/Um64XnmthJsdrVCEXmyFNLeb3BKDB3Omy5jdy9RJW7TQhyK81Cy2lhDUMbvTo9xn2+Vp1ftWBdZ7
	hyY1JCM0YZNGwGWoLoN1ub8dbw5tDg7X+TIvmmce2viU/FLroRQhNfcEgz0CbJMP20DnBYoOc8zpE
	zzoe7B8bPkw+HvLAUPvA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghjYN-0005Fu-Bj; Thu, 10 Jan 2019 23:15:59 +0000
Received: from smtp-1.orcon.net.nz ([60.234.4.34])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghjYI-0005Et-UC
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 23:15:57 +0000
Received: from [121.99.228.40] (port=24388 helo=tower)
 by smtp-1.orcon.net.nz with esmtpa (Exim 4.86_2)
 (envelope-from <mcree@orcon.net.nz>)
 id 1ghjX2-0006MW-NK; Fri, 11 Jan 2019 12:14:37 +1300
Date: Fri, 11 Jan 2019 12:14:31 +1300
From: Michael Cree <mcree@orcon.net.nz>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/15] arch: synchronize syscall tables in preparation
 for y2038
Message-ID: <20190110231431.ho6mjhjkj4p47hww@tower>
Mail-Followup-To: Michael Cree <mcree@orcon.net.nz>,
 Arnd Bergmann <arnd@arndb.de>,
 Joseph Myers <joseph@codesourcery.com>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Linux API <linux-api@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Michal Simek <monstr@monstr.eu>, Paul Burton <paul.burton@mips.com>,
 Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Rich Felker <dalias@libc.org>, David Miller <davem@davemloft.net>,
 Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 the arch/x86 maintainers <x86@kernel.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Firoz Khan <firoz.khan@linaro.org>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 Deepa Dinamani <deepa.kernel@gmail.com>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 alpha <linux-alpha@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-ia64@vger.kernel.org,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 linux-mips@vger.kernel.org,
 Parisc List <linux-parisc@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 sparclinux <sparclinux@vger.kernel.org>
References: <20190110162435.309262-1-arnd@arndb.de>
 <alpine.DEB.2.21.1901101808220.31458@digraph.polyomino.org.uk>
 <CAK8P3a2f4SCJXrm6HWO9UKY-akSW+ONNpOvQOtYbia_fRo9ciQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a2f4SCJXrm6HWO9UKY-akSW+ONNpOvQOtYbia_fRo9ciQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-GeoIP: NZ
X-Spam_score: -2.9
X-Spam_score_int: -28
X-Spam_bar: --
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_151555_127847_BFCCD3C3 
X-CRM114-Status: GOOD (  17.81  )
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
 Joseph Myers <joseph@codesourcery.com>,
 linux-s390 <linux-s390@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
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

On Thu, Jan 10, 2019 at 11:42:32PM +0100, Arnd Bergmann wrote:
> On Thu, Jan 10, 2019 at 7:10 PM Joseph Myers <joseph@codesourcery.com> wrote:
> >
> > On Thu, 10 Jan 2019, Arnd Bergmann wrote:
> >
> > > - Add system calls that have not yet been integrated into all
> > >   architectures but that we definitely want there.
> >
> > glibc has a note that alpha lacks statfs64, any plans for that?
> 
> Good catch, I missed that because all other 64-bit architectures
> have a statfs() call with 64-bit fields. I see that it also has an
> osf_statfs64 structure and system call with lots of padding and some
> oddly sized fields: f_type, f_flags and f_namemax are only 16 bits
> wide, the rest is all 64-bit.
> 
> Adding the regular statfs64() should be easy enough, we just need to
> decide which layout to use:
> 
> a) use the currently unused 'struct statfs64' as provided by the
>     alpha uapi headers, which has a 32-bit __statfs_word but
>     64-bit f_blocks, f_bfree, f_bavail, f_files, and f_ffree.
> 
> b) copy asm-generic/statfs.h to the alpha asm/statfs.h and
>     change statfs64 to have the regular layout that we use
>     on all other 64-bit architectures, using all 64-bit fields.
> 
> The other open question for alpha (as mentioned in one of the
> patches I sent) would be whether to add get{eg,eu,g,p,pp,u}id()
> with the regular calling conventions.

I would be interested in seeing those provided on Alpha.  There are
a handful of projects choosing to sidestep glibc for these syscalls
and they break on Alpha.  Such projects are never keen to include
special assembler code (because the extant syscalls on Alpha are not
C ABI compliant) to support a legacy arch.

Cheers
Michael.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
