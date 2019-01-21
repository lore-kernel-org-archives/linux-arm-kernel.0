Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5720DC282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:56:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28F9F2084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b4hPtc+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F9F2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TZ5w9WXAlQ475gfwo7IhzAD0bBpFbXv69vD+1dj4JeE=; b=b4hPtc+bf/ndzu
	pnOfkQrsBQFIIOPd6D0vnOs0grB/VEcH5JFjqny5wB3djN1zdf7iMFWN4S97zdoAlA8gul1ckI5kt
	RFaHjEMOBtGDKE6or2HfX2F3WPYiSZDY8TXMwTSWkrDWIQiqrtS21yh14Wh0824APg/sd1EdT06Yk
	lgRrbPZr7/kL4ecdCt6uBbArBBCXT61XeEopssUbcCYFESWYjo5kss9iUA58qTf8kNE09FS16g4Wi
	GpZlirqaShKdxtJG8xFNKdewPVAqH942qij/7jVytApPO8sdsMtV6a3ES008R5TtXICj2JTg2BWbr
	fU4Jw3/toyRWoeLvQgyg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glVO4-00054n-9I; Mon, 21 Jan 2019 08:56:56 +0000
Received: from mail-vs1-f65.google.com ([209.85.217.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glVNS-0004VR-1p
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 08:56:25 +0000
Received: by mail-vs1-f65.google.com with SMTP id x1so12141332vsc.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 00:56:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=E/6v0ZVPaXQi5FWJ19dLuHcLgd/E9ZECv5IjLmf6PoI=;
 b=I64rK65d/OSo8tvqsMkpsaOAryBOMnq84160atZONeUKAFjKKg70n+vIo5MhLLKYus
 JxqtROT+35xdea395ZiCDJ6+LzAi2hR2+MNIlJ3BkD6YCQEhvLpY9c0Oqq9m4Ta4S7NU
 nrPcb2ppMLkNO586Ryd7a81t7iBi5V72Y7NsiFt/gUGl9XVicE8SPq4g1OQ/IeuzRSDS
 yyqRGXpmt87erSuDxj3FujKP2zZTGj9mHmTpNknNHijgttTII9l/WpICm+0vHH9hpwsc
 eFAkH84jUWFSmt4mIykHxOBpm74d1wy9mkIYsfpFHull/GK6eAIyt7KhTeZoKQXfahGx
 nNKA==
X-Gm-Message-State: AJcUuke8B4R+PYzo1vrSZ5O2ZlWihlyLLg069TEOK0UqsXXgT3zH0NmU
 RM385MuZQyWCib9RlQ4r5TTrtCA54JN5h4+0s40=
X-Google-Smtp-Source: ALg8bN6mqPPGjY0mRgSzvQIVAiUYVEkzmmA1fTVJs4P5AJXGDwVjqnqovDI8HCxNMByb80ziNpDqZXxAv1iGgV8yZxk=
X-Received: by 2002:a67:3885:: with SMTP id n5mr10358537vsi.96.1548060976721; 
 Mon, 21 Jan 2019 00:56:16 -0800 (PST)
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de>
 <20190118161835.2259170-27-arnd@arndb.de>
In-Reply-To: <20190118161835.2259170-27-arnd@arndb.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 21 Jan 2019 09:56:02 +0100
Message-ID: <CAMuHMdWiHTjDT9-tnjgJy9qCWRr+qUgsJa6LjpRDJQzhoJqnzw@mail.gmail.com>
Subject: Re: [PATCH v2 26/29] y2038: use time32 syscall names on 32-bit
To: Arnd Bergmann <arnd@arndb.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_005618_758393_889C42B7 
X-CRM114-Status: GOOD (  16.15  )
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
 Max Filippov <jcmvbkbc@gmail.com>, netdev <netdev@vger.kernel.org>,
 Deepa Dinamani <deepa.kernel@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux <sparclinux@vger.kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>,
 Firoz Khan <firoz.khan@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Will Deacon <will.deacon@arm.com>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
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

On Fri, Jan 18, 2019 at 5:21 PM Arnd Bergmann <arnd@arndb.de> wrote:
> This is the big flip, where all 32-bit architectures set COMPAT_32BIT_TIME
> abd use the _time32 system calls from the former compat layer instead
> of the system calls that take __kernel_timespec and similar arguments.
>
> The temporary redirects for __kernel_timespec, __kernel_itimerspec
> and __kernel_timex can get removed with this.
>
> It would be easy to split this commit by architecture, but with the new
> generated system call tables, it's easy enough to do it all at once,
> which makes it a little easier to check that the changes are the same
> in each table.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

>  arch/m68k/kernel/syscalls/syscall.tbl       | 42 +++++------

For m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>


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
