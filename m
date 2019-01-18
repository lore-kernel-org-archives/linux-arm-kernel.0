Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F17EC5AC81
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:31:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D4E020883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nEhclApV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D4E020883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5Oy3nd+98JgXsaF+nSKVw/1zIuDcbIMgD+KVVi8Xl6w=; b=nEhclApVInOKqR
	iLS2lg2dEbwo4vNRXRXXmxvGJxv5VQ15tLsLP5qJaXo+XKDIeSu1N2h4WLrEklL4H5MxUAfjZC8h6
	YdLHPpcKQxsnScUpB65qsqfG0OxudA/L3+Y35wfn6vhWgs68sNFgJU7ruJeTHQjR1PgwKpN5HrJRN
	Nosm1QablFVFPSyYkB1gBVyQ/w7Tz0/twPITrQENDArMdPkV+rBcXg91Z5fSQ78qWMVBEtgabwUaL
	mIz0oa5+Qt2AxfWwzAF8cs7PqR8gIAk5Ep8phO/HhG7TnYsNHtiMXTEMh2evrQtj4E9Ubn+JLhS/C
	njUWxQo7cKJhCriCwGUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkZrK-0001o6-Re; Fri, 18 Jan 2019 19:31:18 +0000
Received: from mail-qt1-f193.google.com ([209.85.160.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkZrH-0001nf-2i
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 19:31:16 +0000
Received: by mail-qt1-f193.google.com with SMTP id u47so16473253qtj.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 18 Jan 2019 11:31:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0AqmTALoASBra3sCdglfdVs8uL/QVnAKemn1xthUo0g=;
 b=RMgczplPS1gLJHKi/ZWR1tzBwaWKM0kKhKlHvLBsXghLmV7vO5nETK338X7LqgGEuE
 KAdDoKsJ9t90MPwP7L9wMSLjtpyNNqg9wQ1Md/R83Y+CBBiTpWmpm/QcEI/ysgfUuFSE
 d7MMRvoBKAeVuIqMDEsMFucrPe7RTJG98ItJemHfikzrlEZjnb2VKtmcabs3yrkysEoB
 PQFSsydhZbPJuuIjVfC5FSVSJ/lmlM5KKJsNh9jr54YJObtcgSFrga8mHOdNAoxyQg8Z
 up7kzRzPaIbE0Gy63kS6t/90ULlEcmaA6mlWJXPvDjIZjBTzU5VU370+KSY0AtIGL1v9
 YGYA==
X-Gm-Message-State: AJcUukdDKbaPNm151j3tNPtvv9X1gIswPv/dvaU7tcCqTCKFY1sjT7I2
 R7MybOS14YPc3YRGYb1TrTpDTP9pQV+u07Y1ZxM=
X-Google-Smtp-Source: ALg8bN6j9yHcnKi+481JiICcfzmXamZ1jIWHSB1ab1h/DB+ThocBrv+KhcCDCSjIJzxiV13/exH4DDVlgzHxeSHApHc=
X-Received: by 2002:a0c:e202:: with SMTP id q2mr16397093qvl.180.1547839873593; 
 Fri, 18 Jan 2019 11:31:13 -0800 (PST)
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de>
 <20190118161835.2259170-14-arnd@arndb.de>
 <20190118171830.quvvwdgbuhq2nqrh@lt-gp.iram.es>
In-Reply-To: <20190118171830.quvvwdgbuhq2nqrh@lt-gp.iram.es>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 18 Jan 2019 20:30:57 +0100
Message-ID: <CAK8P3a1R8BfAnNGvBa-hoQBL3uJQ5bJ0_YO91YLv8pp3-nAe3Q@mail.gmail.com>
Subject: Re: [PATCH v2 13/29] arch: add split IPC system calls where needed
To: Gabriel Paubert <paubert@iram.es>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_113115_165285_580F9598 
X-CRM114-Status: GOOD (  13.90  )
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
 linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
 Deepa Dinamani <deepa.kernel@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux <sparclinux@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>, Helge Deller <deller@gmx.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Firoz Khan <firoz.khan@linaro.org>, Matt Turner <mattst88@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 alpha <linux-alpha@vger.kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Burton <paul.burton@mips.com>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 Networking <netdev@vger.kernel.org>,
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 18, 2019 at 6:20 PM Gabriel Paubert <paubert@iram.es> wrote:
>
> On Fri, Jan 18, 2019 at 05:18:19PM +0100, Arnd Bergmann wrote:
> > The IPC system call handling is highly inconsistent across architectures,
> > some use sys_ipc, some use separate calls, and some use both.  We also
> > have some architectures that require passing IPC_64 in the flags, and
> > others that set it implicitly.
> >
> > For the additon of a y2083 safe semtimedop() system call, I chose to only
>
> It's not critical, but there are two typos in that line:
> additon -> addition
> 2083 -> 2038

Fixed both, thanks!

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
