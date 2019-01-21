Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98FEC282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:57:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DA6A2084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mdaV9Ipd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA6A2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uLJTcTVOZBTdo4PFRdk/fZSd8ZkojOot+bthRk1hlN8=; b=mdaV9IpdlgDqpt
	ny1m/ZwajQxnnFtApiHYNvbzatHPVtlnOt/csdynMj8CYcSw6bBsgEiEeaORYORaTiHfRxKlFJDTW
	0PGsycCrHRmkbJSAEyWLiHFECbLduyyNyRzPVa4fmFxCx1SWJze9f3AOrW14IqXd7aC+KBxBFF4IY
	WgiCgY2DPVzLnpaE6sL0xDvqMrCScPicEEB+/3UOse6UE68myVZZPwLT6jGHO1tVFr4kneGAY+GUl
	lu8o+HzwRybRBpKff+2HfqzluZ7YbWwTzCknTxVxdlE23hWo7qli9al2UsFBvjkG8QX7UhTZViDUx
	XG9EYtq+xAwOrBrlMiuQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glVOJ-0005HX-Jo; Mon, 21 Jan 2019 08:57:11 +0000
Received: from mail-vs1-f68.google.com ([209.85.217.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glVNU-0004Yq-7v
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 08:56:33 +0000
Received: by mail-vs1-f68.google.com with SMTP id u11so12137416vsp.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 00:56:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Uun2AU3eJW+aX9fhOUjPPIC4XfawfY9i9oS9NgvU6Z4=;
 b=kUkGprw+nWGT5dTozaZk0dSQzT8prOZGV9Wfy4hyQNrY6BYA8/5LxyNvxW5LxTKXSG
 CXI8UDkcsVZwk+vhRBozb8fLk5CkIQGW5H8TNUxsCznz1z4RbDBE6puXs+Lhoopv2CK9
 1UgklKDxqZPAOA5GlaBqCUzRmUg16I+u++0kvT0eI7NQfxRNcG8+6SqvMB54aGlCyMUB
 AeQxDn3BlfQXGhe+A6YlroG9bz4RlCnV1J6lveykFFGCMxks2GOV6LzHoKeo3qIkfyQG
 cdOijZQLhVRVr8UoxQuK9aFlEMKojVS0+FEfncQCpIvGFWO32q6V+gMQPRTr/hPbpUzj
 PQLw==
X-Gm-Message-State: AJcUukdT1EOz6C7ItiPS/cHJeX5iojhWDlVRUJUmevgsgBKV2CeTaaoy
 vqgG6YXmi5QzoUsXBmpfGcn0/fFjwj9jGZzn7os=
X-Google-Smtp-Source: ALg8bN5Zv5T9HgEze01gQpDUuzyqM6YeldP0GcLXE8vieJqOlkOh/z7Dnz2dgUAbu8nwMIPAviPimX4i+NMBPPzq9wY=
X-Received: by 2002:a67:f43:: with SMTP id 64mr11966034vsp.166.1548060979206; 
 Mon, 21 Jan 2019 00:56:19 -0800 (PST)
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de>
 <20190118161835.2259170-29-arnd@arndb.de>
In-Reply-To: <20190118161835.2259170-29-arnd@arndb.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 21 Jan 2019 09:56:06 +0100
Message-ID: <CAMuHMdVxSVpP0KcBpCSVh0iKBCh3WtGqExtZGPH86hn2TOpTXg@mail.gmail.com>
Subject: Re: [PATCH v2 28/29] y2038: rename old time and utime syscalls
To: Arnd Bergmann <arnd@arndb.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_005620_947982_B8B18442 
X-CRM114-Status: GOOD (  17.74  )
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
> The time, stime, utime, utimes, and futimesat system calls are only
> used on older architectures, and we do not provide y2038 safe variants
> of them, as they are replaced by clock_gettime64, clock_settime64,
> and utimensat_time64.
>
> However, for consistency it seems better to have the 32-bit architectures
> that still use them call the "time32" entry points (leaving the
> traditional handlers for the 64-bit architectures), like we do for system
> calls that now require two versions.
>
> Note: We used to always define __ARCH_WANT_SYS_TIME and
> __ARCH_WANT_SYS_UTIME and only set __ARCH_WANT_COMPAT_SYS_TIME and
> __ARCH_WANT_SYS_UTIME32 for compat mode on 64-bit kernels. Now this is
> reversed: only 64-bit architectures set __ARCH_WANT_SYS_TIME/UTIME, while
> we need __ARCH_WANT_SYS_TIME32/UTIME32 for 32-bit architectures and compat
> mode. The resulting asm/unistd.h changes look a bit counterintuitive.
>
> This is only a cleanup patch and it should not change any behavior.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

>  arch/m68k/include/asm/unistd.h              |  4 ++--
>  arch/m68k/kernel/syscalls/syscall.tbl       | 10 +++++-----

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
