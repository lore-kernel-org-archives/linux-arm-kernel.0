Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12792C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:33:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEC9120878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LFvu/a8N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEC9120878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oiJMHwqRORJRfpTi9n4fo9O8aY1l0QXnTEJNjHkM6LM=; b=LFvu/a8N0mACFF
	w2TPqlrmcCTulR9jqW3IlNFM7RDRlaezjUUbfYXnthyrPD+SGDm1fwM0ftSeyj2K7RWe1oQiPL8Gq
	nEZvb5ghvYOvT50/W8BfbGSimhlU6OgbRRSFGyLB64w3ADPb76dqZqfUtDzxtqK4BFYn9i027kqWf
	xtlwwycbsu/iPPh9MCgjkgMtmAynLkHZmyJQAbaXH6y6TUuKwMBllGTrqXuqfsZCbHJwTOjEQTQMA
	QMSGkjMdyW5Ikqq7bCVrzgZQHbUduSpu0R4bdYKcYP0Wv/umpJUgws0sXDFT4FDUa6IkAjSD4VJEE
	k7ytPQlqkkCSPUATLH6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi0gQ-0000uu-Op; Fri, 11 Jan 2019 17:33:26 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi0gN-0000uV-7C
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 17:33:24 +0000
Received: by mail-qt1-f195.google.com with SMTP id l11so19708575qtp.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 09:33:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PlXu3O61pUFPLleZ5AMTVxcoWeFNM1mKAK5t7dNAM0o=;
 b=sd91tPYyw7WkqKTRfu7qqHtSnjXK8WJtaJ5vYxXMk/XKHmMvKXLvOTjc4vL4R30Uqo
 55z/1FcBBicglvI3WpKDVm0VNeVxI0WQ/Qq7k6YxLgUmsuevdf9bk6NDRPeMb1npeCmK
 Ngd3od23DGeM4nNz7L2PNPICVzjNBqQjsQKqM/NihRaQ1qrZ+StCDYWukm0Pz1uy8sDq
 EOuBFrDZ0EGHp2J6RwOlTFX/i958GlHTo1ox6Y2RWyAokr1jxp6Mef6PH3b/yLUzJYGY
 pHsUOEGhPuBhkcZHbJ3R1q7iKOaVaMWN7n6v/kSN5QqSM+8j304hDJyZCj7d35b3p7yc
 l5Ew==
X-Gm-Message-State: AJcUukcCAMUxIKzpJHv1Jb3OMHepY22lpcy0s0PyHRsCtp88WGh0WFg4
 28fv472JsmF15z0KJSYQUfTykA+m1PP7IgAYyS8=
X-Google-Smtp-Source: ALg8bN69vX9vcq63IXhYC33aOwWxtfAvEwzhoWorTBpfa9Zlf+nERekjdxP7iJFo0Zjh4Gu5ospxdXcZfV6z9FLdQY4=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr14381544qtl.343.1547228002113; 
 Fri, 11 Jan 2019 09:33:22 -0800 (PST)
MIME-Version: 1.0
References: <20190110162435.309262-1-arnd@arndb.de>
 <20190110162435.309262-15-arnd@arndb.de>
 <20190110203253.GA3676@osiris>
In-Reply-To: <20190110203253.GA3676@osiris>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 11 Jan 2019 18:33:05 +0100
Message-ID: <CAK8P3a0PahP8Bbc7OfiqrRcoxMReDuoyn8Hw=aSFtPjNeyrjcA@mail.gmail.com>
Subject: Re: [PATCH 14/15] arch: add split IPC system calls where needed
To: Heiko Carstens <heiko.carstens@de.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_093323_263134_62AB6630 
X-CRM114-Status: GOOD (  17.97  )
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
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
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

On Thu, Jan 10, 2019 at 9:33 PM Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:
> On Thu, Jan 10, 2019 at 05:24:34PM +0100, Arnd Bergmann wrote:

> > diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
> > index 022fc099b628..428cf512a757 100644
> > --- a/arch/s390/kernel/syscalls/syscall.tbl
> > +++ b/arch/s390/kernel/syscalls/syscall.tbl
> > @@ -391,3 +391,15 @@
> >  381  common  kexec_file_load         sys_kexec_file_load             compat_sys_kexec_file_load
> >  382  common  io_pgetevents           sys_io_pgetevents               compat_sys_io_pgetevents
> >  383  common  rseq                    sys_rseq                        compat_sys_rseq
> > +# room for arch specific syscalls
> > +392  64      semtimedop              sys_semtimedop                  -
> > +393  common  semget                  sys_semget                      sys_semget
> ...
> > +395  common  shmget                  sys_shmget                      sys_shmget
> ...
> > +398  common  shmdt                   sys_shmdt                       sys_shmdt
> > +399  common  msgget                  sys_msgget                      sys_msgget
>
> These four need compat system call wrappers, unfortunately... (well,
> actually only shmget and shmdt require them, but let's add them for
> all four). See arch/s390/kernel/compat_wrapper.c
>
> I'm afraid this compat special handling will be even more annoying in
> the future, since s390 will be the only architecture which requires
> this special handling.
>
> _Maybe_ it would make sense to automatically generate a weak compat
> system call wrapper for s390 with the SYSCALL_DEFINE macros, but that
> probably won't work in all cases.

For some reason I was under the impression that s390 already did that.
However, it seems that x86 does, so I'll try to convert the x86 version
for s390, and see if I can get rid of all the wrappers that way.

It would certainly be safer to have the wrappers always present,
especially if we expect future system calls to be added to the
s390 table by whoever implements the syscall itself.

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
