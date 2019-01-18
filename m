Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D21C1B0F7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:44:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 726082086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ABvH+Zbs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 726082086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y5CZ6HtW0F7GR1QWdwJ9zr16SiXJS546Z+ziaLzkwWc=; b=ABvH+Zbsnqj8IY
	Ibz7w3NZ7XiFLAXJjjzh5VRXEErkI3j+RSGJ056pl6KYSsfFnmBZB/K9FvjZNSUuX2lSXmC2y7WWr
	COuEBPn62CRSvuEYeqe6GydFHxt5pX/l1WXWF4ez0mTz2+Si3Ktqs1CH2/Qc5ZYPULr7yQuXTGTv3
	FNz+wirCQd5HKrCV1Y4/9k7AkeOaimGXi3CHJJYdiEE1oT1uLykyHD5uc1yKEurk6bDp9REgExfhb
	/xwVraNdahWl1Rjoo2R6LqQniOspHGi04l/Pc5ym5cykzoJ8nfbWDv0BA9AcPPIddEKeIMstmwlTz
	6Vy4tbj7A2PFB722Lm0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkb0G-0004jo-V9; Fri, 18 Jan 2019 20:44:36 +0000
Received: from mail-qt1-f194.google.com ([209.85.160.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkb0E-0004jT-70
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 20:44:35 +0000
Received: by mail-qt1-f194.google.com with SMTP id p17so16734384qtl.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 12:44:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ORQ5TPnixziDIHsuvdhJc04sEDyDC/r90DJmiSnzeTU=;
 b=mBVsSi4Jw7zkRb9iIbuCDCyZ/ufPDGvL+s7QcQ+muinpOk0idp5hBPetls4vQSN9qm
 J8pMVOvMVQ3XCRsI84uE9FnK7cWFbAovAw7ASj4vIo8iM0kJS176847JiqxhcLs+NKBX
 P2LOSZCXRp1PH71n/dnMRF5ZS6F2r728KrnHfDl9s9S7CH9J+LbEvI3bZKQOFG4jCIEK
 hN9WxuHn2TKsnJt5k5CHm7UNmuUT6H8q+e7PPdFNSiVKLuQVl1cY9MUkwnlu+Im4wlqk
 aeVrGeuhWfvEsKaLw7iwXgIWdJtF9JzupNVYv+I92zWHgzEmMvGYL2wmiLCPcJG1wtBM
 J0bQ==
X-Gm-Message-State: AJcUukdC7gwr7uLTlYkWtxCdT/UImP9AOpkSz/ADhXtkf1nXk8A3agVX
 3q3EHZMZ75UdvBX0SuRypyNWVGJU0eMapx8XXYeZEw==
X-Google-Smtp-Source: ALg8bN4ggcJ9u9iUb42HjHwnUQYctSfqKH3E3MdNfQhsEyd2ovYbbCJ8aRRYCcgq2HtqlmRxO9eWK6dWZp4WMFrZjzM=
X-Received: by 2002:a0c:d992:: with SMTP id y18mr17616058qvj.161.1547844273008; 
 Fri, 18 Jan 2019 12:44:33 -0800 (PST)
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de>
 <20190118161835.2259170-30-arnd@arndb.de>
 <CALCETrXqM5mhvwreN5y-9K99h1j9rs9MAVK-cNLC54s1fdHA6w@mail.gmail.com>
 <CAK8P3a0V+xboaGAF2nqrYtpjXXA7y0LcvCKi4ngLTus1D_XZBA@mail.gmail.com>
 <CALCETrWPj6dHEyo=AELoVjXGsiwuSpRp17x3CEWBHvp7i3cy+Q@mail.gmail.com>
In-Reply-To: <CALCETrWPj6dHEyo=AELoVjXGsiwuSpRp17x3CEWBHvp7i3cy+Q@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 18 Jan 2019 21:44:16 +0100
Message-ID: <CAK8P3a3bGF9iL6fZyyGS1p6vw56FHNMuosVBShX=MTptb6g4Hw@mail.gmail.com>
Subject: Re: [PATCH v2 29/29] y2038: add 64-bit time_t syscalls to all 32-bit
 architectures
To: Andy Lutomirski <luto@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_124434_282067_FEC922E5 
X-CRM114-Status: GOOD (  15.12  )
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
 X86 ML <x86@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Firoz Khan <firoz.khan@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Will Deacon <will.deacon@arm.com>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Thomas Gleixner <tglx@linutronix.de>,
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

On Fri, Jan 18, 2019 at 8:53 PM Andy Lutomirski <luto@kernel.org> wrote:
> I think we have two issues if we reuse those numbers for new syscalls.
> First, I'd really like to see new syscalls be numbered consistently
> everywhere, or at least on all x86 variants, and we can't on x32
> because they mean something else.  Perhaps more importantly, due to
> what is arguably a rather severe bug, issuing a native x86_64 syscall
> (x32 bit clear) with nr in the range 512..547 does *not* return
> -ENOSYS on a kernel with x32 enabled.  Instead it does something that
> is somewhat arbitrary.  With my patch applied, it will return -ENOSYS,
> but old kernels will still exist, and this will break syscall probing.
>
> Can we perhaps just start the consistent numbers above 547 or maybe
> block out 512..547 in the new regime?

I'm definitely fine with not reusing them ever, and jumping from 511 to
548 when we get there on all architectures, if you think that helps.

While we could also jump to 548 *now*, I think that would be a
bit wasteful. Syscall numbers are fairly cheap, but not entirely
free, especially when you consider architectures like mips that
have an upper bound of 1000 syscalls before they have to get
inventive.

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
