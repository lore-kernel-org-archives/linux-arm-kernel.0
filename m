Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCDCC2F421
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:31:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0763C21019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="swtuTY1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0763C21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QWQmXd/NVPA4SDOgIj4strKPdEkOaMd+VjzIsN1AfNM=; b=swtuTY1TA3TptW
	m8wY3Elh+JjpQTFEbbMMLMdjZwyXARFUxh0l5r4mpz7QuiGH5+cv5zEGOltxFX0AlimD6a8wHC+op
	RpKPwAKYzZvvgj17cZSj+CU7W/21JBC0aJoJIICurJX2yo8xQyaK8WosssHdJNBOfUSTO4i3PHk8E
	52fD+dgeADcPdT7vCyF9kKLnXIslC0LYaGRBr17wTeuOUBSHRKn/aNZTwaVKrCK/lC5B8wY41cr1y
	VZHW8bxe7WS6f/gA20PN+f1LEsoa6tB6tNNS145x7MToKYyL8dPLihf+0IetyqH0T5lBuEBnuVDPS
	71DJgz0Uwj6hROv0usug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glcU8-0005BW-H0; Mon, 21 Jan 2019 16:31:40 +0000
Received: from mail-qt1-f193.google.com ([209.85.160.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glcTo-0004mV-6A
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 16:31:25 +0000
Received: by mail-qt1-f193.google.com with SMTP id i7so24140815qtj.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 08:31:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ugnN37Htp2pcGbvXPo+DEz/r4541Rca2swp85kVj/dg=;
 b=iGysyjM/XrA/7fLTpHKlsxk8eYodQYLcAEBapUh7/vSPL325asKx8yHo3wPZZU/qfg
 h/B8T+5NNscH7wyXgo/echWgwDXTnvIpsBOjLbmHPiJ0ztJBApVGqNP4JTnA9oIRjTVc
 ZCG4wwk0jxruVwt7mEH/OnfZ2Yf3acZZB40kRMEVGjQP9D7SMPTdaPW7TjUhqrXsYx2j
 c/ONLC/5xHsIPPgA9WKMZVXnN0ZG/njaB7k1E+zjKIG7tVhA/LpJGAlYUvsoRPN5fi7w
 Mz0QxWjb/PLeS7UDa85HHjmOGieDP7OfXRWv2H/8IyT0oLwiF9dTU4EDFHMY+Fv5cWs2
 q4GA==
X-Gm-Message-State: AJcUukfYHotYtaOJKkeRx1uvAkil0kJYr3aRJBe+hO/H/W6Y8FLUCXgA
 ylaUaaP0y4T1rKJgmA1Bwe2euyXarx2Z+Leg5DY=
X-Google-Smtp-Source: ALg8bN4IjC8153m9pB3iBWOATh3R/RnsAQ6wVGb5LY7XqftLLWs9CXLGl7GxR+zlIVcd8dP96h71Ls+Fr/txo5y0uPg=
X-Received: by 2002:aed:35c5:: with SMTP id d5mr27326381qte.212.1548088278474; 
 Mon, 21 Jan 2019 08:31:18 -0800 (PST)
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de>
 <20190118161835.2259170-30-arnd@arndb.de>
In-Reply-To: <20190118161835.2259170-30-arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 21 Jan 2019 17:31:01 +0100
Message-ID: <CAK8P3a2grsgvLeBHFoLnnpJti7qkZFfBPTrXf+CoihtOJKySzw@mail.gmail.com>
Subject: Re: [PATCH v2 29/29] y2038: add 64-bit time_t syscalls to all 32-bit
 architectures
To: y2038 Mailman List <y2038@lists.linaro.org>,
 Linux API <linux-api@vger.kernel.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_083120_797321_AC5EEA9D 
X-CRM114-Status: GOOD (  18.97  )
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
 Heiko Carstens <heiko.carstens@de.ibm.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Deepa Dinamani <deepa.kernel@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux <sparclinux@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Helge Deller <deller@gmx.de>, the arch/x86 maintainers <x86@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Firoz Khan <firoz.khan@linaro.org>, Matt Turner <mattst88@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Will Deacon <will.deacon@arm.com>,
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Networking <netdev@vger.kernel.org>, linux-mips@vger.kernel.org,
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

On Fri, Jan 18, 2019 at 5:25 PM Arnd Bergmann <arnd@arndb.de> wrote:
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

I've successfully tested this with musl and LTP now, using an
i386 kernel. The musl port I used is at
https://git.linaro.org/people/arnd.bergmann/musl-y2038.git/
This is just an updated version of what I used for testing last
year, using the current syscall assignment, and going back
to the time32 versions of getitimer/setitimer and
wait4/waitid/getusage.

It's certainly not intended for merging like this, but a proper
musl port is under discussion now, and this should be
sufficient if anyone else wants to try out the new syscall
ABI before we merge it.

The LTP I have is heavily hacked, and has a number of
failures resulting from differences between musl and glibc,
or from the way we convert between the kernel types and
the user space types.

The testing found one minor bug in all the kernel syscall tables:

> +418    common  mq_timedsend_time64             sys_mq_timedsend
> +419    common  mq_timedreceiv_time64           sys_mq_timedreceive

While this would have fit in with umount(), creat() and mknod(),
it was unintentional, and I've changed it back to
mq_timedreceive_time64 (with an added 'e').

       Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
