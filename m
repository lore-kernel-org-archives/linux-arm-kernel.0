Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE334C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:31:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5A1320836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sKSMjuTy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A1320836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U8aHuVfGMu2/keorFEI/NHD/QW1qg6HIsxJxWXRF0Co=; b=sKSMjuTy4hZ6Ch
	iEPhvYP+YbtjwSxh6ozmEqMhIlxcjNJeZWiEunArgSqUiYeIFhbb5o9YYu/dslH9sSq+Cm2DHvvy7
	PqlRMfb8Ev6WgnN7amrHhWdndUm0ZbCTy1W7S3z5MI+yGSTPzcCdy5L7iz7vP+U8kGnSaqEPa2W0M
	J11DyI0YjydDOLmqx8yzVMDjYkvj6OtyKyvqnkmV4FkFEcZBLfQFB+hZq+XR6ZifB3Y5r9A293H8/
	1sXNFN4Xt+CgD6hkdbzHYkYA6tRoAymccmI8YqR3ARgHdRohq5+aQ1Sga+IyzHbFYxc3lB/yXUHdt
	CXNVZnxxlgZ0AGOoN52A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi0el-0000Wo-Jh; Fri, 11 Jan 2019 17:31:43 +0000
Received: from mail-qt1-f194.google.com ([209.85.160.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi0e6-0008Ii-3d
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 17:31:10 +0000
Received: by mail-qt1-f194.google.com with SMTP id d19so19650674qtq.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 09:31:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SGHCnfowgHn30T+nuPC0hqbUSrYY8+wFH1Oi3pXaRzM=;
 b=Qc0kjL6t7exRRCFRiUtk+uDHeUnZaKKKiB+tLrYfXcMP7el4cJkzHeTMLd8Y+WcFOu
 KHfnudRgy5EAEOTrjh/CziUw4HGYVRFTekuytKVCGBx35Msmw3V4our+W589osQq/ajz
 JZLQpjjzHWkG5TrShY13iaOE+i0PRavkYSpBDnPhgEWsd3JtGTUhkjP1EG0KuBogmnxB
 k0Z/sXFpj3aIYCpjcrffVufRGOrBOt8r3fjEVFGjF7KtlM08s3jS6kls2eLwRvcp3f0w
 8ZXjrbcpOO2nffGKXj/jkg+RyDDfQuOhC5r4DhhmCpuLU6Zq86Dr4Pyx0mGxsdo/61hE
 ZauA==
X-Gm-Message-State: AJcUukdUZdD1BikLvG5zw+dydE+Pc7YzuKNNxGgRMf98G8dnDC5bmY2Z
 A/TOrvu4hftVfM17Ls1GiyxDLUTZSDXJRjhq7ks=
X-Google-Smtp-Source: ALg8bN775BnYYqpcTaMAandAOOVFGcb1fag8zY9M3WMS/TPmNFpmSdRaCOyAJ14+1Aq8ng+YTuIZvIzlZbwDHzn2U4I=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr14875090qta.152.1547227860501; 
 Fri, 11 Jan 2019 09:31:00 -0800 (PST)
MIME-Version: 1.0
References: <20190110162435.309262-1-arnd@arndb.de>
 <20190110162435.309262-16-arnd@arndb.de>
 <20190110203638.GB3676@osiris>
In-Reply-To: <20190110203638.GB3676@osiris>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 11 Jan 2019 18:30:43 +0100
Message-ID: <CAK8P3a0M6qSJQAtFNKVS5muissKvyzeE9MSYT_uwKnM4BKCAug@mail.gmail.com>
Subject: Re: [PATCH 15/15] arch: add pkey and rseq syscall numbers everywhere
To: Heiko Carstens <heiko.carstens@de.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_093102_557490_4A871C45 
X-CRM114-Status: GOOD (  12.98  )
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

On Thu, Jan 10, 2019 at 9:36 PM Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:
> On Thu, Jan 10, 2019 at 05:24:35PM +0100, Arnd Bergmann wrote:

> Since you only need/want the system call numbers, could you please
> change these lines to:
>
> > +384  common  pkey_alloc              -                               -
> > +385  common  pkey_free               -                               -
> > +386  common  pkey_mprotect           -                               -
>
> Otherwise it _looks_ like we would need compat wrappers here as well,
> even though all of them would just jump to sys_ni_syscall() in this
> case. Making this explicit seems to better.

Ok, fair enough. I considered doing this originally and then
decided against it for consistency with the asm-generic file,
but I don't care much either way.

Is this something you may want to add later? I'm not sure exactly
how pkey compares to s390 storage keys, or if this is something
completely unrelated.

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
