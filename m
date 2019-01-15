Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C0CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:01:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5710120656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GkF3V3UW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5710120656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XS0Yea0KoAPcL3dhw0Q6jiHOEOrTsEOQGSUS9fhKwqg=; b=GkF3V3UW4tsRTI
	2mqWXIl1aIeo1ml6/9tUYw9i/tJxIlnl6FTpVy9c9EFxDa5MmoelQezZWYtupX4MoVQaOLrLuDebM
	uE/8ld28oh4WvZDXQs7VorUagSSjkiqTj3+oV3WglBvCk6cgjgaelgNnxFQm6vkJsN5kmvIHCpc7H
	8IstLpch0T+L+LYTv5Y+1OwoBj/f78YP5+YZeQLNK1SrAMCr0sQ+7t5qgaOdiP9apPEn22a8ljzJL
	YWJRDevTDUc8/dvNNZFesdp4rGzciXpCMZUJxj5u2dIirOglW58wLK9XYaIVz1zWSF0i+IOnv6hyf
	5Oop0WtNIgFaDbBcEgqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjQDq-0005AS-Pp; Tue, 15 Jan 2019 15:01:46 +0000
Received: from mail-qk1-f194.google.com ([209.85.222.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjQDm-0005A5-Dn
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 15:01:45 +0000
Received: by mail-qk1-f194.google.com with SMTP id w204so1718976qka.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 07:01:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/j2xo8vyz06xg1gQlvQEYwJpD6WHXsDfeyUW+0147bI=;
 b=lHKarO0RKoBbaVf307yGRpXCchZ6PNE584Cpet5hEK/484raQRdXR4jJgxvMblPVzt
 oEktw8/Te2z2GiXUalYXbNkNoJo87x9O05XQa4s3QBwggIZeEvEe8Hs9/HoT5b7sc0yp
 j/TBmYEfFg5ixtdrUXh/uEpaIiKTDkbpoZsQ9HMh8pAZSF3hEoyFIsewuKSv4Lsgbd7j
 4+Zx5BGR+NRDTYYMbhmk4hpZAuk2EykirziYyPJHKRoA4nrNAuvpVBFoHTPUOzw9Qqdt
 JMqQ/2O6jjYo729CLaoUAKZv3anqQkknVnDYEkaDFgeZ7SRZDdRc6tA92+A3nB/+j+es
 LASQ==
X-Gm-Message-State: AJcUukd9W1YvVi6GOjlNcKL2cMsmyeoGiJRTPkHZcyi93qvbVbsb481G
 6blhqlPuSL7RxMAf8vElpPQj7dqtlrhj1nS2Ma8=
X-Google-Smtp-Source: ALg8bN66ERQQcRHL6kpituOugRhaYl47wq+bMeU6L9UD0bbjiIXTK390uY37r+V2oE8uztNtYSgBmDdqY7/ckMkByIg=
X-Received: by 2002:ae9:d8c2:: with SMTP id u185mr2882793qkf.107.1547564501193; 
 Tue, 15 Jan 2019 07:01:41 -0800 (PST)
MIME-Version: 1.0
References: <20190110162435.309262-1-arnd@arndb.de>
 <20190110162435.309262-15-arnd@arndb.de>
 <87pnsz28k2.fsf@concordia.ellerman.id.au>
In-Reply-To: <87pnsz28k2.fsf@concordia.ellerman.id.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 15 Jan 2019 16:01:24 +0100
Message-ID: <CAK8P3a0uas76i2W1yjFvxHT-2=A8_egUZeAUM-Vya6386+87Xg@mail.gmail.com>
Subject: Re: [PATCH 14/15] arch: add split IPC system calls where needed
To: Michael Ellerman <mpe@ellerman.id.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_070142_563825_26401DFF 
X-CRM114-Status: GOOD (  19.80  )
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
 y2038 Mailman List <y2038@lists.linaro.org>, Helge Deller <deller@gmx.de>,
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

On Mon, Jan 14, 2019 at 4:59 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> >  arch/m68k/kernel/syscalls/syscall.tbl     | 11 +++++++++++
> >  arch/mips/kernel/syscalls/syscall_o32.tbl | 11 +++++++++++
> >  arch/powerpc/kernel/syscalls/syscall.tbl  | 12 ++++++++++++
>
> I have some changes I'd like to make to our syscall table that will
> clash with this.
>
> I'll try and send them today.

Ok. Are those for 5.0 or 5.1? If they are intended for 5.0, it would be
nice for me to have a branch based on 5.0-rc1 that I can put
the other patches on top of.

> > diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> > index db3bbb8744af..1bffab54ff35 100644
> > --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> > +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> > @@ -425,3 +425,15 @@
> >  386  nospu   pkey_mprotect                   sys_pkey_mprotect
> >  387  nospu   rseq                            sys_rseq
> >  388  nospu   io_pgetevents                   sys_io_pgetevents               compat_sys_io_pgetevents
> > +# room for arch specific syscalls
> > +392  64      semtimedop                      sys_semtimedop
> > +393  common  semget                          sys_semget
> > +394  common  semctl                          sys_semctl                      compat_sys_semctl
> > +395  common  shmget                          sys_shmget
> > +396  common  shmctl                          sys_shmctl                      compat_sys_shmctl
> > +397  common  shmat                           sys_shmat                       compat_sys_shmat
> > +398  common  shmdt                           sys_shmdt
> > +399  common  msgget                          sys_msgget
> > +400  common  msgsnd                          sys_msgsnd                      compat_sys_msgsnd
> > +401  common  msgrcv                          sys_msgrcv                      compat_sys_msgrcv
> > +402  common  msgctl                          sys_msgctl                      compat_sys_msgctl
>
> We already have a gap at 366-377 from when we tried to add the split IPC
> calls a few years back.
>
> I guess I don't mind leaving that gap and using the common numbers as
> you've done here.
>
> But it would be good to add a comment pointing out that we have room
> at 366 for more arch specific syscalls as well.

Ah, I missed that. I've added this to my patch now:

index 5c0936d862fc..2ddfba536d5f 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -460,6 +460,7 @@
 363    spu     switch_endian                   sys_ni_syscall
 364    common  userfaultfd                     sys_userfaultfd
 365    common  membarrier                      sys_membarrier
+# 366-377 originally left for IPC, now unused
 378    nospu   mlock2                          sys_mlock2
 379    nospu   copy_file_range                 sys_copy_file_range
 380    common  preadv2                         sys_preadv2
         compat_sys_preadv2

       Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
