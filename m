Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20790C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:42:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC8CD2184A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kIeD8K1S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC8CD2184A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9AYrUQtfGASg4lOVVJz+SpJjb8fjK8mFg/3cyl7gKLQ=; b=kIeD8K1SRtaYFR
	Wlc7lllNwNP/r0mu/auRSxq+0i+Wb510s6ztkznDg+O/M3cQiD38IkRWP/h15RdPGBi0Y1SqKmcjE
	cBA/+2pX/xApdFK7a5rdibGE3pNtpkHalQhIeJ3PMaYJ2wAKSk9je/FoIMjxMQhY8lftVYVFzoHf9
	qzXqvTRAb+yiBDxPDOzoYV9fnmCwftwCTbCJu3KShaYTKwzqGPEt7inlHk5yu0EjQqkz7NyaiRl8x
	k9/iyyP+tchwX3jBVTgVKbUFgHHro4dizP2yT0E7+tGr5/e4HL8BRPWzg5ie8Xw7TBI8yafXqQav0
	sstVBndppIszZM/OVY3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpUOs-0006S6-QY; Fri, 01 Feb 2019 08:42:14 +0000
Received: from mail-qt1-f196.google.com ([209.85.160.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpUOp-0006Rk-Bu
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 08:42:12 +0000
Received: by mail-qt1-f196.google.com with SMTP id l12so6542540qtf.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 00:42:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xBU2TNZakMyKOC4KxmPqNQYRaxeZHiXAJWu2gQGpFiM=;
 b=nmBqkZpmX1ulIidWeQXA7LFGud+fVOyImPvDqxvMGW8rhayV8TI5Z+7Gkp3zq27p+f
 6J5VFlCNfchoj3wFHo6npurqUKM6SY58Z+WQUUnGHsRkXLibNM18s6HTZx0XOOfprRKW
 LGvpn2mSjze3ViedmA+f8fJxFFFpmBwJxRBf4YmIBHvrMPRIfPL7XPDT4DY2nBPmoUv8
 o20Ca8IXx2YNUuU69MPmct1uW+2SXEusxK1wkuRgzAACVAkaXelZ34M39xIAkpRPq+sp
 uykCwFbTLyuciv7Pcb96fdfkiRNK8wMsSlugf8We16RuvT52CYZgHsXQH3QwZYm0SmAv
 DDZg==
X-Gm-Message-State: AJcUukebWAbBHaI2QSaHTQfv1LDXhIFh2KDj9MtyGE0cN5VUbD1c4uO4
 wf2vIgbqr55FSYwjVkAWo5H6bknvQzP2EbPuy5o=
X-Google-Smtp-Source: ALg8bN404msL6/fDmHYgSbisuiK3UViMZuqgpO9BZAt1LX1eLUijpX2MXOEsNjlrBP7uSKgfh4ceMVr6lSeEHxfP0I8=
X-Received: by 2002:aed:35c5:: with SMTP id d5mr37347128qte.212.1549010530162; 
 Fri, 01 Feb 2019 00:42:10 -0800 (PST)
MIME-Version: 1.0
References: <20190126041041.13173-1-manivannan.sadhasivam@linaro.org>
 <CAK8P3a3Y_w5_ZavpyUh0VKrS8FeUPTJKkchtGGLc1qe3nG2mfA@mail.gmail.com>
 <20190201035005.GA4283@Mani-XPS-13-9360>
In-Reply-To: <20190201035005.GA4283@Mani-XPS-13-9360>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 1 Feb 2019 09:41:52 +0100
Message-ID: <CAK8P3a3DVniy47azCP=NAWecCZST_huaeXjLKRczBsit7e4uKQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Add initial Bitmain BM1880 SoC/Board support
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_004211_402396_B57DF398 
X-CRM114-Status: GOOD (  15.49  )
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
Cc: DTML <devicetree@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Amit Kucheria <amit.kucheria@linaro.org>, darren.tsao@bitmain.com,
 Rob Herring <robh+dt@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, haitao.suo@bitmain.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 1, 2019, 04:50 Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org wrote:
> On Sun, Jan 27, 2019 at 10:24:09AM +0100, Arnd Bergmann wrote:
> > On Sat, Jan 26, 2019 at 5:11 AM Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > This patchset adds initial support for Bitmain BM1880 SoC and Sophon
> > > Edge board. BM1880 SoC consists of a Dual Core ARM Cortex A53 Application
> > > processor subsystem, a single core RISC-V subsystem and a Tensor
> > > Processor subsystem. This patchset adds support for only ARM Cortex
> > > A53 Application processor subsystem with UART, which enables the board to
> > > boot into initramfs with 2 CPUs.
> >
> > Nice work! All patches in this series
> >
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks. What is the merge strategy for this patchset? Shall I send a
> Pull Request to arm@kernel.org with topic branches?

I think we should take new platforms as a single topic branch separate
from the normal branches, so please send a single pull request for this
one.

Also, if you have drivers that are closely tied to this platform, that
branch include those as well, provided that you have an Ack from the
respective subsystem maintainers.

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
