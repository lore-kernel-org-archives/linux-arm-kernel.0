Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977BBC282F6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:56:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 688A52084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CbMC/orV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 688A52084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=709jUL+jzRfTPVtXk6Woyt3ME/HYgWHDb15oH+mAdYk=; b=CbMC/orV/0RujK
	/+62HIzqJ0s3o0D3w1oW7YZq4urgYi1BOZu2A4l583Z1tUmwCJ3C8jvNpXzpUsRs40g+VDHVMXjlW
	QlPL1Iq5y6u6Czvc676W7FUudxgfgvQpUiTnctTrG/s6LJVZdWlFnmQp2RWmFW4TAmqs/gIRCRNBE
	0LViHKjdIpB4cnjcEoBI1tD1/OYJxriwxzW38YNNGnq/RY9GKbcV0p+xnJat06fz8P8twnbLKBoE6
	wsRA5upzMGdqpaQVVQ+md1nW3XoLw25lV9UBkKezskcxS4bNitwL67QLQFcu5hxcJtFLrZCcaiz2d
	1jdprlTDjgkGqQK/7mXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glVNO-0004Rt-CH; Mon, 21 Jan 2019 08:56:14 +0000
Received: from mail-ua1-f68.google.com ([209.85.222.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glVNB-0004AR-Uy
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 08:56:06 +0000
Received: by mail-ua1-f68.google.com with SMTP id d19so6652217uaq.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 00:56:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OJScdj9p18oAEvTl9TNP9AzhiR3NeXZIyKQOy3xgTy8=;
 b=KlTiL3S3JBAbN9DxXoTn3DL7/OHbo0yFYiS3QS8ndT5Wwe9SrJl3O6zz2Hg8fXqxx5
 yo+I8WsDQxTAJs+vuTR+6OTTAmbHNkcLVPBKa4qbwi5JVbdxBXXCV/Y2HYyTFg8lKyB0
 moHjefi+weGZTJ4dHnUdq1um60c6gpm2zi+WBfCEmy+b2KMdGbQ5W+ftUd+cY6AP26Ul
 9q733B1WtGQq814Q7hz6aNLzRoZ5tnma1qXt2faGkG5tqhITqGFHjPlEUrS3fEYUaD5h
 0BxcA+/oRYJbdlexlU2nsWZNO1qxgSm0JRcuTbdVA1U78QhwTzGYH8sUjaizU72sW4Lt
 N1nw==
X-Gm-Message-State: AJcUukcMQKQJjoHjsx9EbbgeXpcj10+QhXWgEr77wV+RdrhjiWtpboOl
 xZRRMQJo+vOjRlBnITFZYVtZF6izv0dzVlmWGNA=
X-Google-Smtp-Source: ALg8bN4uFN3zWGMaGcasO6usU7NqldPno3Vg0buANjUHshxvHAfNTtSuQ7VautHVX5df0UK1s1iotaDgJP2GFGxetwA=
X-Received: by 2002:ab0:7251:: with SMTP id d17mr11840905uap.0.1548060960356; 
 Mon, 21 Jan 2019 00:56:00 -0800 (PST)
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de>
 <20190118161835.2259170-15-arnd@arndb.de>
In-Reply-To: <20190118161835.2259170-15-arnd@arndb.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 21 Jan 2019 09:55:48 +0100
Message-ID: <CAMuHMdWaJyNqUeq4qu3AgU0fYrQdZ_zbo0DFFiM97Y5HESYYnA@mail.gmail.com>
Subject: Re: [PATCH v2 14/29] arch: add pkey and rseq syscall numbers
 everywhere
To: Arnd Bergmann <arnd@arndb.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_005602_491322_D136227B 
X-CRM114-Status: GOOD (  14.71  )
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

On Fri, Jan 18, 2019 at 5:20 PM Arnd Bergmann <arnd@arndb.de> wrote:
> Most architectures define system call numbers for the rseq and pkey system
> calls, even when they don't support the features, and perhaps never will.
>
> Only a few architectures are missing these, so just define them anyway
> for consistency. If we decide to add them later to one of these, the
> system call numbers won't get out of sync then.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

>  arch/m68k/kernel/syscalls/syscall.tbl   | 4 ++++

> --- a/arch/m68k/kernel/syscalls/syscall.tbl
> +++ b/arch/m68k/kernel/syscalls/syscall.tbl
> @@ -388,6 +388,10 @@
>  378    common  pwritev2                        sys_pwritev2
>  379    common  statx                           sys_statx
>  380    common  seccomp                         sys_seccomp
> +381    common  pkey_alloc                      sys_pkey_alloc
> +382    common  pkey_free                       sys_pkey_free
> +383    common  pkey_mprotect                   sys_pkey_mprotect
> +384    common  rseq                            sys_rseq

Note that all architectures that already define pkey syscalls, list
pkey_mprotect
first.

Regardless, for m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

>  # room for arch specific calls
>  393    common  semget                          sys_semget
>  394    common  semctl                          sys_semctl

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
