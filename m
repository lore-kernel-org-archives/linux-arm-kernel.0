Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E88C282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:17:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91CD820855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a4nOCAob";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QAHz9ViX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91CD820855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5ESEGysFp/8mckVVsO4T/7BUgmKSPNKfuC+3GCvirTE=; b=a4nOCAobYekGlC
	eSkvWQWKwPkbsfW4q2xP0EP07nR+1m1+kHyaBAVXKI9gjoMhGqrKt929m0VERmmtxxYAP0SAMDPSw
	fValWmxgvigvcXoGsXDpX7w1w9Sxc7mXs3js8r5rU+KYcc+LY6JB+jxx2/pa9lBkdMvrFv0KBAV2f
	1tpbvY3SiaJGDeI8j0BDWt2XRWTHkLln3We2WFmSMTepSidBKrOSyZDlS3eszg1hD3K0sB1GfSvXv
	ZUFfVZJa+CCpiHHXCPpjIT0GUmpTubrWbQ8QOeJGRHEW+PrBxlndBho4K/zZdSGbeCwcNtn3SNaoy
	+9s947Da0fkeDb7nm2mg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glnVZ-0007iH-Ej; Tue, 22 Jan 2019 04:17:53 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glnVV-0007hE-FJ
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 04:17:51 +0000
Received: by mail-it1-x141.google.com with SMTP id b5so18340869iti.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 20:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mNCiLSCOs3HIOeMuRVgReUCd+ne31UPnW0KZgc5m+zA=;
 b=QAHz9ViXtFffS1ULvCTtubzPehSRnYyYPPoHXhvVBgqhIPiQxlN67iGbs9/m9fptlW
 mbftemqKpCPpb84j8a3fXCUhA0Nnqu73NSxtd+5KItm+8aaLI1FRIvXOIudxnEgFWbBF
 BhuTTuQQk8dO+BCA12SMxl+9K4k7vgKF4R4xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mNCiLSCOs3HIOeMuRVgReUCd+ne31UPnW0KZgc5m+zA=;
 b=jd7qRCzUCt/o5PVpl0xZsqHor4aqzYUWWaOwk+QfbXAU7u2Iw/EOXf5T0wEhrI+myt
 nDQuaot2UpyZwoJ/9XAVszTUAU/3pUEH2/R7Hy7zfZpT+75DBXSLqXqQ7J3QdisTuC3h
 CbpECEEwe7/I9wleUEFCEoQVgq3p7Folq7OXuk2RVLcXgELjuRIAMR/p0eUqlUJHMEhr
 5BCNqB0nICbuC9fbuQyGbTSps1qNfmRtyN5waSpIkytKaGfdAPkgZp52ZAxsaWeFLqGm
 hqkh9SE9f6cQpkE117zkUYsy1AJr5PvF9ynzfLh7nqVM8Q4x1MiY2i8yMCFT1nJ6vyo6
 AnvQ==
X-Gm-Message-State: AJcUukdv47ODtn/KyAxUMtBbFpPeIr1v7Kx8Kn6k/egaN0eYPr2dxAcV
 7JsmAwg+Z6pmvfJNx4PrdHTJ5PscVA9fdWWLnN8aVw==
X-Google-Smtp-Source: ALg8bN5GlXzkDXSzuQpWtdpGUbIFc+urhwgY4mQj32A/c4P4ZfZKF6yRF0pHgpLttOBuPMH4biJBmbF2qhFL+K+RKlg=
X-Received: by 2002:a24:f14d:: with SMTP id q13mr1180269iti.166.1548130667985; 
 Mon, 21 Jan 2019 20:17:47 -0800 (PST)
MIME-Version: 1.0
References: <1546530025-26014-1-git-send-email-firoz.khan@linaro.org>
 <20190119235650.GC26876@brain-police>
 <CAK8P3a1kiS7oF=eKLqPs6kKTYE1uTjhz++edH_J-tCUmXY2PNQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1kiS7oF=eKLqPs6kKTYE1uTjhz++edH_J-tCUmXY2PNQ@mail.gmail.com>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Tue, 22 Jan 2019 09:47:36 +0530
Message-ID: <CALxhOngnGKk==Cj+3EM1LkBK4FYRXNu4JxVg-d=3uttVcLwqQw@mail.gmail.com>
Subject: Re: [PATCH 0/3] arm64: system call table generation for asm-generic
To: Arnd Bergmann <arnd@arndb.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_201749_814762_C7B2ED4F 
X-CRM114-Status: GOOD (  26.16  )
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
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Philippe Ombredanne <pombredanne@nexb.com>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Stefan Agner <stefan@agner.ch>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Deepa Dinamani <deepa.kernel@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Arnd, Will,

thanks for the email.

I'm want to abandon this patch series. Will post new patch series for
system call
table generation support for asm-generic and some other stuff together by end of
this week or early next week.

Thanks
Firoz

On Mon, 21 Jan 2019 at 21:24, Arnd Bergmann <arnd@arndb.de> wrote:
>
> n Sun, Jan 20, 2019 at 12:57 AM Will Deacon <will.deacon@arm.com> wrote:
> >
> > On Thu, Jan 03, 2019 at 09:10:22PM +0530, Firoz Khan wrote:
> > > This will be an automated scripts to provide easy support
> > > for add/modify/delete the system call entry by add in
> > > respective *.tbl file.
> > >
> > > System call table generation support for asm-generic is
> > > provide for arm64 architecture which will use the common
> > > scripts resides in scripts directory and use syscall.tbl
> > > syscall_arm32.tbl files as inputs. This implementation
> > > will replace asm-generic/unistd.h.
> > >
> > > This patch depends on:
> > >  https://lore.kernel.org/lkml/1546439331-18646-1-git-send-email-firoz.khan@linaro.org/
> > >  https://lore.kernel.org/lkml/1546520681-24453-1-git-send-email-firoz.khan@linaro.org/
> >
> > I'm having a hard time understanding what the benefit of this series is,
> > given that we only support EABI compat tasks. When adding a new compat
> > system call, you can't just blindly hook it up without checking whether it
> > needs a wrapper to deal with any type conversion etc, so really we're just
> > replacing one table with another as far as I can tell. What am I missing?
>
> The point that is missing in the description above is that all unistd.h
> and syscall.S files are now being generated from a .tbl file, across
> all architectures. This was already done on arm32, x86 and s390
> before 4.20, but is now done on all architectures that don't use
> the uapi/asm-generic/unistd.h header, and the arm32 compat version for
> arm64.
>
> The newly added file has the same format as all other tables, and
> will be easier to synchronize with the arm32 version, which has
> almost the same contents (arm32 has oabi support, arm64 has
> compat support).
>
> > I also really don't think we should be generating the 32-bit UAPI headers
> > from the 64-bit compat system call support (if that's what you're trying to
> > do -- make headers_check fails with your patches applied). arch/arm/ is the
> > canonical place for the 32-bit UAPI, and we're just implementing that.
>
> I think you just misread what Firoz was trying to say here: The
> arm64 uapi/asm/unistd.h file is now being generated from the
> generic syscall.tbl file, while the compat asm/unistd32.h file is not
> part of the UAPI. In both cases though, the data from the old files
> is being replaced with data in the more compact and (hopefully)
> more readable format.
>
>
>     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
