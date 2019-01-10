Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A609C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:04:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63F19208E3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AVkZ4ih3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63F19208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=COKWT5tCKil4Pe2a2Iig8KWre7/jEWlzLY1iYa9gONM=; b=AVkZ4ih3sf7EFG
	NipS786X+26ZDnc8aQgWtX1Cj9cA1zdOkn3yn4Ocf18cEG6ATGEersyIX8AORUKBd+XFJXw4CpnAQ
	IisO54E55+elEhhaYJd+o1T0qRKxpLtFD8/lkauvRzGcGCXkZCfI4W6KlwtkcYbJxOVkcpD3r9YkE
	muIRHWUyejfv3/AsQ1TqtdVL4U2ZAPmdORuZxej7bXzeL+iDI7A2dDRSY+dt4RCCfalsWIaBrGXY4
	v9o/uznLXXlZtpDOt4qUk0UWLKGbcyqB1Izl5O6hJSZ8g8Krtp1SzCVoT2V5oa7f6PY4tIyov1tQb
	nm0FtWeUZ3E6w59ISb+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghjNH-0008UW-Kf; Thu, 10 Jan 2019 23:04:31 +0000
Received: from mail-qt1-f196.google.com ([209.85.160.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghjNE-0008U6-2P
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 23:04:29 +0000
Received: by mail-qt1-f196.google.com with SMTP id t13so15974189qtn.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 15:04:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HtXhbi3vHt8M/OEnatDKUvPiA7NAMQnuGXU1lkYVUOA=;
 b=CbGqq+U2nlJZW5DXOdmQVto8+UQttYx7latfVc8QPqAEoMIH8SM+cxfh1CryyHQkk/
 NWl1RLdjutQR083bvioDZI4d9WQmAsUq0tA5BDct0EjtFZ8ce/VfwXr5o/LjRlnEf6L+
 z/m+eled04sQZY68hxQmEVDW5K+QTnLwsP+cE73sTJ9bH0y5Y09/05/iEnBmn+jumuhU
 EssFhXuLfOLfZdVvPWwc5fZ2SI7XmGgkKtH2MNNnd2n0su5i3eZz92eO/QY7kZVDb9gN
 9SZuTLPxC526tn2jMyuezYrV6JxtM1l3ad1PQyiQ/9MEuQsSDC/lufuA/G0UqFec2S5R
 TprA==
X-Gm-Message-State: AJcUukccI/aD2ekVRb16LQgbxILhPfA/+QckhnQErMqAjiZLoVl2Z5BO
 aieJwrn4Rrc13ZB3Mesztx1q9lM2JSjICOh17kQ=
X-Google-Smtp-Source: ALg8bN4ZeEWRkM9hWnrPPHyShJGIJaQ4v14vU6tq5tVSdcQOtnDoc1B1ZFUD1N8Tb+aXoK9KYlt7H6bjgwfKKkPpLQI=
X-Received: by 2002:a0c:e202:: with SMTP id q2mr11357943qvl.180.1547161466728; 
 Thu, 10 Jan 2019 15:04:26 -0800 (PST)
MIME-Version: 1.0
References: <20190110162435.309262-1-arnd@arndb.de>
 <20190110162435.309262-12-arnd@arndb.de>
 <20190110193949.5wsysvchhhh2gfmu@pburton-laptop>
In-Reply-To: <20190110193949.5wsysvchhhh2gfmu@pburton-laptop>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 11 Jan 2019 00:04:09 +0100
Message-ID: <CAK8P3a1-QvHrPOupHx3sc+c6zAS9E-u8hYbt4keWzpiPgNOD-Q@mail.gmail.com>
Subject: Re: [PATCH 11/15] mips: fix n32 compat_ipc_parse_version
To: Paul Burton <paul.burton@mips.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_150428_109065_53E90C43 
X-CRM114-Status: GOOD (  16.72  )
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
Cc: "dalias@libc.org" <dalias@libc.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
 "linux@dominikbrodowski.net" <linux@dominikbrodowski.net>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>,
 "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>,
 "hpa@zytor.com" <hpa@zytor.com>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "dave@stgolabs.net" <dave@stgolabs.net>,
 "y2038@lists.linaro.org" <y2038@lists.linaro.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "deller@gmx.de" <deller@gmx.de>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "geert@linux-m68k.org" <geert@linux-m68k.org>,
 "firoz.khan@linaro.org" <firoz.khan@linaro.org>,
 "mattst88@gmail.com" <mattst88@gmail.com>,
 "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
 "ink@jurassic.park.msu.ru" <ink@jurassic.park.msu.ru>,
 "luto@kernel.org" <luto@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "monstr@monstr.eu" <monstr@monstr.eu>,
 "tony.luck@intel.com" <tony.luck@intel.com>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "ebiederm@xmission.com" <ebiederm@xmission.com>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "davem@davemloft.net" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 10, 2019 at 8:40 PM Paul Burton <paul.burton@mips.com> wrote:
> On Thu, Jan 10, 2019 at 05:24:31PM +0100, Arnd Bergmann wrote:
> > While reading through the sysvipc implementation, I noticed that the n32
> > semctl/shmctl/msgctl system calls behave differently based on whether
> > o32 support is enabled or not: Without o32, the IPC_64 flag passed by
> > user space is rejected but calls without that flag get IPC_64 behavior.
> >
> > As far as I can tell, this was inadvertently changed by a cleanup patch
> > but never noticed by anyone, possibly nobody has tried using sysvipc
> > on n32 after linux-3.19.
> >
> > Change it back to the old behavior now.
> >
> > Fixes: 78aaf956ba3a ("MIPS: Compat: Fix build error if CONFIG_MIPS32_COMPAT but no compat ABI.")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > As stated above, this was only found by inspection, the patch is not
> > tested. Please review accordingly.
>
> Nice catch! Would you prefer to merge this yourself, or that I take it
> through the mips tree?

Up to you: if you want to merge it for 5.0, I'll just drop it from my tree.

> If the former then:
>
>   Acked-by: Paul Burton <paul.burton@mips.com>

Thanks!

> I suspect kernels configured with n32 support but no o32 support are
> probably not very common - for internal testing we currently always
> enable both.

Do you know of anyone actually still using n32 in production systems
with 4.x kernels? I wonder if it just fell out of popularity as the 64-bit
machines that used it either became large enough to want 64-bit
user space, or got replaced by arm64 or mips32 hardware.

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
