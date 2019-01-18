Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A872FC5ACD3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:15:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AC2A20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rEt+R0+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC2A20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ia9/M1eL0TIhUpcvKo0dhEFcSnP5aLuFYUrIaPokJAI=; b=rEt+R0+9qkUR9C
	H0YTZx70w4XhzDsrnvR99Odyd/6HdpqUgGDuN5eU65x1qRY0Ba3jnRei7O896ALLCZbo9gvojdvAt
	KGTi7kD39h1rV4Ba6+g+QWhrrnYyoP6tQmv9MfmLb6jxHJz+5EWuYWtY1YPKMlG6XRm3tjnFeezDE
	knP/Y35QJBa/srOlEtydZYSrKNgxSlyNyEVEDSA+LKORKRLTwKMC7YOnhAV/22vo7nOx/qrXOoXht
	lEs67DJ7YnQ+WgdQ3T79otIhwsqislJenVAARNZEAl7iKHl9cL6ee1h5G6maX7j6mGhpsWDegV69U
	3pbWzIbzb8GjLRGHH3QA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkXjJ-0007g5-JJ; Fri, 18 Jan 2019 17:14:53 +0000
Received: from mail-qk1-f194.google.com ([209.85.222.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkXjH-0007f3-0i
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 17:14:52 +0000
Received: by mail-qk1-f194.google.com with SMTP id m17so999973qki.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 09:14:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cM6Ct6RNNXTziZEbUSSe56myHuH3NS1roB2yrpi3ejY=;
 b=rqNNbA3QXLtYjakCygXQ02msskjOWBqkPOo/DnS9XCkeYv3ZMdsou6qE18b1dLrA1i
 bMFUy3u97R5ywl8a/Q85tJDbpBIn/FTbzLwSODTOaNkdl6SwE2rBn+jw5l//oAHi3d3X
 Wh8u0DkPsZ/XhGUpzeDhernHF0eFGhaw2RsMTVVE3Upd1A8Cc/zrK5EBQTWyvyB13pO7
 MqnP1UuWP8SXI7WIkZUWpm0bP0QN+gVkYPjlcqeB58A1a1FuT68HO+yG0YjHaplbNfwA
 ZzTHYIyJlvfSPrY8jDVnF22Se4AG/lzoXSOhwf7B3NhQhikSKNl1BwmwvDnGUwxzqcz2
 x56w==
X-Gm-Message-State: AJcUukcGREi7JtgU2yc02HQ8SbIQ0oXh5MEMQqrjSN+A4exyA6ecP8dg
 1W8+hKkntI2SybJ6vUPWUi0TQyui+7UBROHzC30=
X-Google-Smtp-Source: ALg8bN6YuxAZx88mWjLK6OJGww6yso8mTxW2uQ+U16+TTtpFWJaRgawaUEpqTv2Trum/q/Wu6cLlwpnMJ3TVNfmaobA=
X-Received: by 2002:ae9:d8c2:: with SMTP id
 u185mr15079174qkf.107.1547831689678; 
 Fri, 18 Jan 2019 09:14:49 -0800 (PST)
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de>
 <be3863ae-d903-8e9e-5e6c-e4a58fac189d@blastwave.org>
In-Reply-To: <be3863ae-d903-8e9e-5e6c-e4a58fac189d@blastwave.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 18 Jan 2019 18:14:33 +0100
Message-ID: <CAK8P3a3xUpbk+Wpo5kdDtZ81jQuzEZH6jdmJJNeNM+acueg+Dw@mail.gmail.com>
Subject: Re: [PATCH v2 00/29] y2038: add time64 syscalls
To: Dennis Clarke <dclarke@blastwave.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_091451_055005_4B647499 
X-CRM114-Status: GOOD (  20.70  )
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
 Max Filippov <jcmvbkbc@gmail.com>, Networking <netdev@vger.kernel.org>,
 Deepa Dinamani <deepa.kernel@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux <sparclinux@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Firoz Khan <firoz.khan@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Will Deacon <will.deacon@arm.com>,
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
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

On Fri, Jan 18, 2019 at 5:57 PM Dennis Clarke <dclarke@blastwave.org> wrote:
>
> On 1/18/19 11:18 AM, Arnd Bergmann wrote:
> > This is a minor update of the patches I posted last week, I
> > would like to add this into linux-next now, but would still do
> > changes if there are concerns about the contents. The first
> > version did not see a lot of replies, which could mean that
> > either everyone is happy with it, or that it was largely ignored.
> >
> > See also the article at https://lwn.net/Articles/776435/.
>
> I would be happy to read "Approaching the kernel year-2038 end game"
> however it is behind a pay wall.  Perhaps it may be best to just
> host interesting articles about open source idea elsewhere.

It's a short summary of the current state. You can also find a
video and slides from my ELC presentation online for a little more
context.

Generally speaking, I'd recommend paying for the subscription to
lwn.net to anyone interested in the kernel, but it should become
visible to everyone with the next day (a week after the initial
publication). In the meantime, you can find the article at
https://lwn.net/SubscriberLink/776435/a59d93d01d1addfc/.

Finally, I've made a list of the remaining work that Deepa
and I are planning to still continue (this should be mostly
complete but may be missing a few things):

syscalls
 - merge big series for 5.1, to allow time64 syscalls
 - waitid/wait4/getrusage should get a replacement based on __kernel_timespec
 - getitimer/setitimer should probably follow getrusage
 - vdso, waiting for consolidation series from Vincenzo Frascino before
   adding time64 entry points

file systems
 - range checks on timestamps
 - xfs
 - NFS
 - hfs/hfsplus
 - coda
 - hostfs
 - relatime_need_update

drivers
 - media
 - alsa
 - sockets
 - af_packet
 - ppp ioctl
 - rtc ioctl
 - omap3isp

core kernel
 - fix ELF core files (elfcore.h)
 - syscall Audit code (kernel/audit.c, kernel/auditsc.c)
 - make all time32 code conditional
 - remove include/linux/timekeeping32.h
 - remove compat_time* from time32.h
 - remove timeval
 - remove timespec
 - remove time_t

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
