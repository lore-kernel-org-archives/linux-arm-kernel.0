Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21984C07EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:45:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC64D2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OnjbB6yD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="R9WeU/KM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC64D2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AkzWZNU6Ncvj1IghdcLaVMkqmD4rqGnX3jxMKzvo+LE=; b=OnjbB6yDTApCcd
	QyuKQTiQ7bp6b4Thqx/mPn8UC2YorxyfzH8bBI7mgC4JIlrbPna+wPDnCeD6gB3EHnCoQCPAZfqQJ
	AnoH5QVBbfdSr6Gsoz5rlxGaCfnPHC9b3Uriphb72IJIBneoHjyGyPgAnWpR61VG+DI3Ekg8fN0Zu
	fWwINaanC4pHKt2ZTCHQ+xUYlpXjGz7oyOF7cuwth9OTQogvXaHmCfaafuMZ+xM0DGIf1dyjH0sl8
	izb7jDAJR4EiWRR0E1BPGSpSLjE18lwkeJlmDFPAM6kNTOBRSosInwYQzX566o5yafmTcYSGBwLkS
	XoqFwb7GtSirZ4ymij1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkYCv-0006p1-Oe; Fri, 18 Jan 2019 17:45:29 +0000
Received: from bedivere.hansenpartnership.com ([66.63.167.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkYCs-0006o8-Nz
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 17:45:28 +0000
Received: from localhost (localhost [127.0.0.1])
 by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6FC948EE3EB;
 Fri, 18 Jan 2019 09:45:21 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new,
 port 10024)
 with ESMTP id TXlpfntxv04P; Fri, 18 Jan 2019 09:45:20 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 322D28EE10C;
 Fri, 18 Jan 2019 09:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
 s=20151216; t=1547833520;
 bh=XXQLXCymB8vOJAkOPmNQI+AOkRgkwA1dHK7GADdM3yU=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=R9WeU/KMkVaa6iP7Pp3wYocx0/dXtN94bF6JMCXpNgrPa0+6kXx+p8ugiGNGWeFvK
 NyXTpJiwFZR4Yx64OlyySakUFsNn1vA3uDfYr89rHvphDI6UKfVMm7YpmablmnonUb
 SSSVbS9S63Tvu2GKjTbrRiEXQzC+FJCjZHgJo2VE=
Message-ID: <1547833518.2794.36.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 00/29] y2038: add time64 syscalls
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Dennis Clarke <dclarke@blastwave.org>, Arnd Bergmann <arnd@arndb.de>, 
 y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-arch@vger.kernel.org
Date: Fri, 18 Jan 2019 09:45:18 -0800
In-Reply-To: <be3863ae-d903-8e9e-5e6c-e4a58fac189d@blastwave.org>
References: <20190118161835.2259170-1-arnd@arndb.de>
 <be3863ae-d903-8e9e-5e6c-e4a58fac189d@blastwave.org>
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_094526_795949_779B0194 
X-CRM114-Status: GOOD (  16.70  )
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
Cc: dalias@libc.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 catalin.marinas@arm.com, heiko.carstens@de.ibm.com, jcmvbkbc@gmail.com,
 deepa.kernel@gmail.com, hpa@zytor.com, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, mpe@ellerman.id.au, deller@gmx.de, x86@kernel.org,
 linux@armlinux.org.uk, mingo@redhat.com, geert@linux-m68k.org,
 benh@kernel.crashing.org, firoz.khan@linaro.org, mattst88@gmail.com,
 fenghua.yu@intel.com, will.deacon@arm.com, linux-fsdevel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, luto@kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, monstr@monstr.eu, tony.luck@intel.com,
 linux-parisc@vger.kernel.org, netdev@vger.kernel.org,
 linux-mips@vger.kernel.org, paul.burton@mips.com, ebiederm@xmission.com,
 linux-alpha@vger.kernel.org, schwidefsky@de.ibm.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 2019-01-18 at 11:57 -0500, Dennis Clarke wrote:
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

Hey, this is an unfair characterization: lwn.net operates an early
access subscription model, so you can't read the above for 14 days
after publication without paying for an lwn.net subscription, but by
the time these patches are upstream there will be no paywall because it
will expire on 24 January and that URL will then be readable by all. 
That makes LWN.net a nice, reliable resource for us while still
supporting some business model to keep it going.

James


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
