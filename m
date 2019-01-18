Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF78C5ACD3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:50:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F312D20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TKfwNiTq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DywJP3k6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F312D20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oM9DgDZtYVPk85/IiBht1DODlxcoRTIoJ8AADGR7Ugw=; b=TKfwNiTq91j+6h
	PH9eeDLyplOJRnI/RQdZTLsjCIW4kriwnTPkp7f1djal4FwBvdYGKpSNN0YZ3agTSNd8NhOjVB74o
	cflUKt7v/B/PHLpQ7tWHDxjZneerNiTUxWpiVqYqAKYm+j4KMTPtPfr+EITdpT3dOxvo7RMzpu0s3
	E5AODG+fzwoysXuUy7yXu3CdZbXucZrNQYnnGgUgcsJUlD/Iqhv+r3aaX1Iqx8Ur8scdQU9s0jD4r
	xCLa2f54Yg6TQOtkiS+ztderAw+wk84Lq3DsKH1c/B1wnoyUxK9/yFt/5mWWntnEWviZAsRjCFUmk
	Sh3ZC1SFSfPrsfaMGI7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkZE5-0005ng-V9; Fri, 18 Jan 2019 18:50:46 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkZE3-0005n1-Ep
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 18:50:44 +0000
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 056CB2173B
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 18:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547837442;
 bh=VoFGDVLCVcIdDEcxLef2+rlsJOjPa2ebgAiYkYzOvZE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=DywJP3k6H+iZLdOWLhNpkjuA11yZaLbQY7NIRl85r8DEi6PK+JLiiJK2i7CxdLFSi
 37mZQhM6bmlvbAMbWz9fnq6sjSaX6UNXp7qoXQL4PBfIvKyNcTWoFU1f++CVkC7IYh
 eReNFOQ/KgRMLwNXqjvc1Ze6jSQuFE2pBg+YmYgo=
Received: by mail-wr1-f41.google.com with SMTP id r10so16259375wrs.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 10:50:41 -0800 (PST)
X-Gm-Message-State: AJcUukeJCtIVLNryBbyyiOtmPk5A7Eg9x56rLNTswVSjdFKf2P8Pcnoj
 gOWBLWQKxhPWMTccfDu18ZZ/0GZLiCUStDMLHxFD0A==
X-Google-Smtp-Source: ALg8bN67TmQMlfRaxpFOTS6mBbA0hkrufcMeB82R0DYAMNtI7glElQBQro2q4MgunvPtGRQh0RhmI0b7ZOkTrvyT000=
X-Received: by 2002:adf:e08c:: with SMTP id c12mr17046840wri.199.1547837438534; 
 Fri, 18 Jan 2019 10:50:38 -0800 (PST)
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de>
 <20190118161835.2259170-30-arnd@arndb.de>
In-Reply-To: <20190118161835.2259170-30-arnd@arndb.de>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 18 Jan 2019 10:50:27 -0800
X-Gmail-Original-Message-ID: <CALCETrXqM5mhvwreN5y-9K99h1j9rs9MAVK-cNLC54s1fdHA6w@mail.gmail.com>
Message-ID: <CALCETrXqM5mhvwreN5y-9K99h1j9rs9MAVK-cNLC54s1fdHA6w@mail.gmail.com>
Subject: Re: [PATCH v2 29/29] y2038: add 64-bit time_t syscalls to all 32-bit
 architectures
To: Arnd Bergmann <arnd@arndb.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_105043_546738_F578578B 
X-CRM114-Status: GOOD (  22.78  )
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
 linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>,
 Network Development <netdev@vger.kernel.org>, deepa.kernel@gmail.com,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>, y2038@lists.linaro.org,
 Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>,
 X86 ML <x86@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Catalin Marinas <catalin.marinas@arm.com>, firoz.khan@linaro.org,
 Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Will Deacon <will.deacon@arm.com>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 linux-m68k@lists.linux-m68k.org, Andrew Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 linux-parisc@vger.kernel.org, Linux API <linux-api@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Paul Burton <paul.burton@mips.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>, linux-alpha@vger.kernel.org,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 18, 2019 at 8:25 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> This adds 21 new system calls on each ABI that has 32-bit time_t
> today. All of these have the exact same semantics as their existing
> counterparts, and the new ones all have macro names that end in 'time64'
> for clarification.
>
> This gets us to the point of being able to safely use a C library
> that has 64-bit time_t in user space. There are still a couple of
> loose ends to tie up in various areas of the code, but this is the
> big one, and should be entirely uncontroversial at this point.
>
> In particular, there are four system calls (getitimer, setitimer,
> waitid, and getrusage) that don't have a 64-bit counterpart yet,
> but these can all be safely implemented in the C library by wrapping
> around the existing system calls because the 32-bit time_t they
> pass only counts elapsed time, not time since the epoch. They
> will be dealt with later.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> The one point that still needs to be agreed on is the actual
> number assignment. Following the earlier patch that added
> the sysv IPC calls with common numbers where possible, I also
> tried the same here, using consistent numbers on all 32-bit
> architectures.
>
> There are a couple of minor issues with this:
>
> - On asm-generic, we now leave the numbers from 295 to 402
>   unassigned, which wastes a small amount of kernel .data
>   segment. Originally I had asm-generic start at 300 and
>   everyone else start at 400 here, which was also not
>   perfect, and we have gone beyond 400 already, so I ended
>   up just using the same numbers as the rest here.
>
> - Once we get to 512, we clash with the x32 numbers (unless
>   we remove x32 support first), and probably have to skip
>   a few more. I also considered using the 512..547 space
>   for 32-bit-only calls (which never clash with x32), but
>   that also seems to add a bit of complexity.

I have a patch that I'll send soon to make x32 use its own table.  As
far as I'm concerned, 547 is *it*.  548 is just a normal number and is
not special.  But let's please not reuse 512..547 for other purposes
on x86 variants -- that way lies even more confusion, IMO.

--Andy

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
