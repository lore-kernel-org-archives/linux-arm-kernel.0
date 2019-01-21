Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684E4C37121
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:40:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38E3F2089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iHsUX5VA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E3F2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1FRHjCXbfLu+qdGIfNP0UPpZGwAW0u/Wvfik7E7EtEw=; b=iHsUX5VAYRZKj/
	BCw47KhGjSIXbdRzv7P3jFYfKtyCuuLbaRbC4PLwnexKTzr+CPlH6ZM5zL+19ekJ8POf9X/+nifKa
	iS27DGDIuET5p9NaVfUW/xI/168yW4RQJq9Xoez5QDKu2iOCJqAJ9fr/f88oPKfmapX8MnGtbW6DR
	5n8Y7ysO+l1KDNBA6fMr9HQ2Dw7KGfW/NUP9sSYo/YV46RMjsFeqSegWOz40BBzePvG/52CmB3fkS
	vigJblRDqqeEOJCnMughyY4WESPp44asWyhX28z0l58DRFRFrNeQwx0WWGo3sq82tqYY2rBQb4NmT
	rByac9js2ZI84H5C2sQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glgMo-0004ZZ-GI; Mon, 21 Jan 2019 20:40:22 +0000
Received: from mail-qt1-f194.google.com ([209.85.160.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glgMl-0004ZE-2z
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 20:40:20 +0000
Received: by mail-qt1-f194.google.com with SMTP id t33so25005214qtt.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 12:40:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dkvN5kxF5ScgcD3pJdfvtsR7PQS22YCBaQenUgPUi4M=;
 b=R6/p1gKwA4RU76nd3HKsmUAw44MFs6Is3yguenXJSBaQilbkPtXvEWd2+9a2WH5eB8
 WhQ56OwzmBdjpVuHhGvbOr8QXJZ0fg1OVMqEBzSaR1RViQ+ZgHDrcUG8Vz/pU5fwtR19
 7EWCo2BsiaTF5TJU8loxl1M8E3yVyuLo4LCDPGuWHdPMe0IgSr7r+hWu8Jd6CN+BQBt/
 Tdf8FxgwHMI/24AIXNODFaqibSgLskASdPIk8Sxlp5ctMi2AvBw01B/t9ngPHV2azj20
 ynKcVxncIDTrLboRhXW60bJcMRW9yLcUXneN0LJUvOX4fz9iNy5nbgPBmPkqdmYaH1AI
 DrOw==
X-Gm-Message-State: AJcUukc8Jl6S5Yl4nSvzqyMXzXJSz0Egli90qp2tWXVW//TzMVXL5A5u
 ciSIJlyBRl2ZJr+rfj3SjHdiuxR5wS3sjz5hkBo=
X-Google-Smtp-Source: ALg8bN6NJA3JpmMy0Rnw4UHCeBwdUwtaoF1faqE/rX9S/LB1A3Pp1thWOe1j9+1qk4H6TfQ6cwy2yDs31Lm4Qgs2hsM=
X-Received: by 2002:a05:6214:1087:: with SMTP id
 o7mr27413754qvr.115.1548103218172; 
 Mon, 21 Jan 2019 12:40:18 -0800 (PST)
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de>
 <20190118161835.2259170-30-arnd@arndb.de>
 <CALCETrXqM5mhvwreN5y-9K99h1j9rs9MAVK-cNLC54s1fdHA6w@mail.gmail.com>
 <CAK8P3a0V+xboaGAF2nqrYtpjXXA7y0LcvCKi4ngLTus1D_XZBA@mail.gmail.com>
 <CALCETrWPj6dHEyo=AELoVjXGsiwuSpRp17x3CEWBHvp7i3cy+Q@mail.gmail.com>
 <20190119142852.cntdihah4mpa3lgx@e5254000004ec.dyn.armlinux.org.uk>
 <CAMuHMdXzQNEEDjWrmTph8Krovj1g2WhnBUaM=FvKB+J2fZqctA@mail.gmail.com>
 <CAK8P3a04UC2dHVqx1gHXJQzsDw446h1ghLEuRe0xmUyJgrOktw@mail.gmail.com>
In-Reply-To: <CAK8P3a04UC2dHVqx1gHXJQzsDw446h1ghLEuRe0xmUyJgrOktw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 21 Jan 2019 21:40:01 +0100
Message-ID: <CAK8P3a11Pme2d6VbTb2t7fi_vd7UmNuN-yOf2zT59KPzbCT1Lw@mail.gmail.com>
Subject: Re: [PATCH v2 29/29] y2038: add 64-bit time_t syscalls to all 32-bit
 architectures
To: Geert Uytterhoeven <geert@linux-m68k.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_124019_129869_FA1F971B 
X-CRM114-Status: GOOD (  21.05  )
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

On Mon, Jan 21, 2019 at 6:08 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Jan 21, 2019 at 9:19 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > Regardless, I'm wondering what to do with the holes marked "room for
> > arch specific calls".
> > When is a syscall really arch-specific, and can it be added there, and
> > when does it turn out (later) that it isn't, breaking the
> > synchronization again?
>
> We've had a bit of that already, with cacheflush(), which exists on
> a couple of architectures, including some that use the first
> 'arch specific' slot (244) of the asm-generic table. I think this
> will be rare enough that we can figure out a solution when we
> get there.
>
> > The pkey syscalls may be a bad example, as AFAIU they can be implemented
> > on some architectures, but not on some others.  Still, I had skipped them
> > when adding new syscalls to m68k.
> >
> > Perhaps we should get rid of the notion of "arch-specific syscalls", and
> > reserve a slot everywhere anyway?
>
> I don't mind calling the hole something else if that helps. Out of
> principle I would already assume that anything we add for x86
> or the generic table should be added everywhere, but we can
> make it broader than that.

Applying this fixup below,

     ARnd

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl
b/arch/x86/entry/syscalls/syscall_32.tbl
index d9c2d2eea044..955ab6a3b61f 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -398,7 +398,7 @@
 384    i386    arch_prctl              sys_arch_prctl
 __ia32_compat_sys_arch_prctl
 385    i386    io_pgetevents           sys_io_pgetevents_time32
 __ia32_compat_sys_io_pgetevents
 386    i386    rseq                    sys_rseq
 __ia32_sys_rseq
-# room for arch specific syscalls
+# don't use numbers 387 through 392, add new calls at the end
 393    i386    semget                  sys_semget
 __ia32_sys_semget
 394    i386    semctl                  sys_semctl
 __ia32_compat_sys_semctl
 395    i386    shmget                  sys_shmget
 __ia32_sys_shmget
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl
b/arch/x86/entry/syscalls/syscall_64.tbl
index 43a622aec07e..2ae92fddb6d5 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -343,6 +343,8 @@
 332    common  statx                   __x64_sys_statx
 333    common  io_pgetevents           __x64_sys_io_pgetevents
 334    common  rseq                    __x64_sys_rseq
+# don't use numbers 387 through 423, add new calls after the last
+# 'common' entry

 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/include/uapi/asm-generic/unistd.h
b/include/uapi/asm-generic/unistd.h
index 53831e4a4c86..acf9a07ab2ff 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -740,7 +740,7 @@ __SC_COMP_3264(__NR_io_pgetevents,
sys_io_pgetevents_time32, sys_io_pgetevents,
 __SYSCALL(__NR_rseq, sys_rseq)
 #define __NR_kexec_file_load 294
 __SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
-/* 295 through 402 are unassigned to sync up with generic numbers */
+/* 295 through 402 are unassigned to sync up with generic numbers, don't use */
 #if __BITS_PER_LONG == 32
 #define __NR_clock_gettime64 403
 __SYSCALL(__NR_clock_gettime64, sys_clock_gettime)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
