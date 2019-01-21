Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB4CC2F421
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:54:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B08520823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E4r8UiVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B08520823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g79oBdMXZkWnDXQzrAziwFoOGb4LW0u6TL/cbpd4iZo=; b=E4r8UiVFFJYerr
	PjhSebLf1z7AF6f3lvte3F8V+kZ9F0ZFyLNNc/x9ZpqXLvSKT93GfjNO9b0q3jgFkbp58/AOmH8k9
	5ZupLtMrcFwkeLYSOEeEyhooIJDxRExPGw7mE52VHuMVC7L0uerW+lqyfnUN5yP+szS6ndzV3lR/l
	Y0CO/PUOt6EPd7UAPypL/21UZeC+nBOHMQBZjnrwPCfG/EDxeWZRLGHkPLw992s8l6fWuj+74gEnA
	pcoRp8qo05NexABmzD4D6X/6NwrwjRrZ+tIsTPfSNAhzhlANmKdNYrjY3DSnvtsuzBQs7NNdXzci7
	Xe0nXExeFfKBBBDQ8N8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glbu0-0000ai-EJ; Mon, 21 Jan 2019 15:54:20 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glbts-0000aI-7T
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 15:54:18 +0000
Received: by mail-qt1-f195.google.com with SMTP id l11so24125729qtp.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 07:54:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BolUHUemdSZNYDTaUCTkJTDa+hu/AMvXO0Ph+5Tguds=;
 b=qL/+JJPTOGxZ9fzpk9ygR6a2UIRJZdB4ZDp2xD+nr5hQ0J5ace2YGBvZn/zbRl0Dp+
 YAzV6yG9Yq/aDJrsYhnwVdLHakZU0ps6zd1SUcw/Hv0//vSFTf+cbVWs2MfMUOIZr032
 1GSZIZ9PyPkVfT8Vqt1IHaZuACTX2QPAabdWCw75SaqV53HshTBLn1rVkIn+H47knUmw
 WvFZMMCfLrXymnmFTkoxXM88DKkT2foAHs33VhmehVMtSCia8/jmVkKpVTvCQeZXUGQC
 s8CPYyMfXJbsAhGihXALPViifymPA/Ca52Tx8v16gitKwL7tKoWpeUuprb8yTHxeUSxm
 RWLQ==
X-Gm-Message-State: AJcUukelfZutDFFO80ryJPD2qbNAz9v4l3bXVOc4lPLxWf5oPzUBS2YZ
 keS2kJAXy/lZWjBg9NdCQ1rtumEQXSjAfrJ3+dk=
X-Google-Smtp-Source: ALg8bN4xhZ8yHvW/KbKdBj9RO2PeHmyu5vnU6SbfaaKJj41epoElZRzRk0KzYbg3nXv6YWZzWm/df9KJulT854RZ60g=
X-Received: by 2002:ac8:7451:: with SMTP id h17mr26877541qtr.319.1548086050519; 
 Mon, 21 Jan 2019 07:54:10 -0800 (PST)
MIME-Version: 1.0
References: <1546530025-26014-1-git-send-email-firoz.khan@linaro.org>
 <20190119235650.GC26876@brain-police>
In-Reply-To: <20190119235650.GC26876@brain-police>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 21 Jan 2019 16:53:54 +0100
Message-ID: <CAK8P3a1kiS7oF=eKLqPs6kKTYE1uTjhz++edH_J-tCUmXY2PNQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] arm64: system call table generation for asm-generic
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_075412_263714_3C94CA32 
X-CRM114-Status: GOOD (  20.30  )
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
 Philippe Ombredanne <pombredanne@nexb.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Stefan Agner <stefan@agner.ch>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Deepa Dinamani <deepa.kernel@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Firoz Khan <firoz.khan@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

n Sun, Jan 20, 2019 at 12:57 AM Will Deacon <will.deacon@arm.com> wrote:
>
> On Thu, Jan 03, 2019 at 09:10:22PM +0530, Firoz Khan wrote:
> > This will be an automated scripts to provide easy support
> > for add/modify/delete the system call entry by add in
> > respective *.tbl file.
> >
> > System call table generation support for asm-generic is
> > provide for arm64 architecture which will use the common
> > scripts resides in scripts directory and use syscall.tbl
> > syscall_arm32.tbl files as inputs. This implementation
> > will replace asm-generic/unistd.h.
> >
> > This patch depends on:
> >  https://lore.kernel.org/lkml/1546439331-18646-1-git-send-email-firoz.khan@linaro.org/
> >  https://lore.kernel.org/lkml/1546520681-24453-1-git-send-email-firoz.khan@linaro.org/
>
> I'm having a hard time understanding what the benefit of this series is,
> given that we only support EABI compat tasks. When adding a new compat
> system call, you can't just blindly hook it up without checking whether it
> needs a wrapper to deal with any type conversion etc, so really we're just
> replacing one table with another as far as I can tell. What am I missing?

The point that is missing in the description above is that all unistd.h
and syscall.S files are now being generated from a .tbl file, across
all architectures. This was already done on arm32, x86 and s390
before 4.20, but is now done on all architectures that don't use
the uapi/asm-generic/unistd.h header, and the arm32 compat version for
arm64.

The newly added file has the same format as all other tables, and
will be easier to synchronize with the arm32 version, which has
almost the same contents (arm32 has oabi support, arm64 has
compat support).

> I also really don't think we should be generating the 32-bit UAPI headers
> from the 64-bit compat system call support (if that's what you're trying to
> do -- make headers_check fails with your patches applied). arch/arm/ is the
> canonical place for the 32-bit UAPI, and we're just implementing that.

I think you just misread what Firoz was trying to say here: The
arm64 uapi/asm/unistd.h file is now being generated from the
generic syscall.tbl file, while the compat asm/unistd32.h file is not
part of the UAPI. In both cases though, the data from the old files
is being replaced with data in the more compact and (hopefully)
more readable format.


    Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
