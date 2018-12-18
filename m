Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE1BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:28:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB34620815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ENhSxnqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB34620815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+gCUAsLIaiwVHAm0t2U4Om10PCjA+mtFmM1oXBZ48Hg=; b=ENhSxnqmgg7gIR
	GsHoGLKDbl2gXBPNaRRVdKr9G4FtGhtMQ+lp6i/ModAn1FNiM8RL38pD1852pIBSNo5dYDty2osj1
	2SuSdkwDKRYhKZm5Hr3vPrNXHXbGsp1B/1ksHWVL7uT0URmrjXbaEaf0UqI9O405Un/NofVqGupB/
	nw5te1bhnBjhQ1KrwuKAFRpT61OV85MdvjLR/ILs+yW00jTqxYbdhk+pGk4n+j1ooOJNXMVEjxaid
	19iGOpr28EoLRDinGSTySKSOjP3/csw/CgewPqVeLuI82amkvREjqDB+5XmmWdoThVx/mIzcI4qso
	0BZkzOz+3dj3zyVwVKqA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZHIF-0006iK-HS; Tue, 18 Dec 2018 15:28:23 +0000
Received: from mail-qt1-f194.google.com ([209.85.160.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZHID-0006hY-4o
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 15:28:22 +0000
Received: by mail-qt1-f194.google.com with SMTP id r14so18633014qtp.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 07:28:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HfgorODbpVkjZqCdqJGdyxUgeJdhQFotZQQyGrSkU1s=;
 b=HVjGz5AyYr4Cghe26b6JEgFJ3rxmjdIhDDSKFUQ1Z9EYB6oxjZLzt9HOcBoVQIe970
 pW/2SXa0Gl2B4P/iZ7HyCvHyWT/UYi2c9oCUGSWZ9la/Sk7enFbvi587r3SJb9HNXlJO
 jwTo1s7WFq2TnfWuSl/lbLehlxjKUst06F88tZrul26X3rqteDfA+H6Oqi+ZZny2FEPB
 o506qpd78fHnFibMJ2GnMCI5RZgnpMAWs+dFBqkrU0lvKfFPLEgr8YY2wZry4L5Rvl4d
 dcj+q4DrPzr4u5gN8725bYj9tBiHJd7+4RIo93s2I4KVZeCtVQ9uTnxFy+UMXCLGzJsB
 v/Og==
X-Gm-Message-State: AA+aEWZRyR45jiy3ddQvkNsTCCsQGnGY6bsqZXN6h/XEli/QFjT75bDN
 FJuCk0WmZ0yrpi/4bhNtKGC7ZzfNQgaCoSEFLj+F8KHy
X-Google-Smtp-Source: AFSGD/UJ49VGdvY5717Fi3HOSqG//l1W4trL4ZUTDM7ZgT04rTECMWtzk9X3a5Vr3dUBusS23lyLCd7KMmkUjn5dL5k=
X-Received: by 2002:a0c:d992:: with SMTP id y18mr17911906qvj.161.1545146890054; 
 Tue, 18 Dec 2018 07:28:10 -0800 (PST)
MIME-Version: 1.0
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
 <4344b70b-41fb-5ca0-281e-d4b5500b6256@free.fr>
 <20181211154159.54yaytbp4pyjqjhg@localhost>
 <20181213065113.sz7ce7kpkenyu3dy@localhost>
 <78bcd495-087e-aabf-6462-8950ee986732@free.fr>
In-Reply-To: <78bcd495-087e-aabf-6462-8950ee986732@free.fr>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 18 Dec 2018 16:27:53 +0100
Message-ID: <CAK8P3a0jbQoAd=q15FPFJixAKgYYiSLCarO=Zfx3zyWkWtPq0g@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Regenerate arm64 defconfig for current kernel
To: Marc Gonzalez <marc.w.gonzalez@free.fr>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_072821_198176_46E3DAB3 
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
Cc: Olof Johansson <olof@lixom.net>, arm-soc <arm@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 14, 2018 at 4:44 PM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>
> On 13/12/2018 07:51, Olof Johansson wrote:
>
> > I've applied the patches from the series that were still needed. When
> > re-running savedefconfig as part of patch 1, several of them were no longer
> > applicable.
>
> FWIW, Arnd had suggested that the first patch should only deal with the
> trivial case (moving options around), and subsequent patches should deal
> with removed options, and corner cases.
>
> IIUC, you folded "trivial + removed" into a single patch. I suppose it
> does make the commit log less bloated ;-)
>
> Thanks for merging the series.

I suppose I should have asked for the patch to reorder the series to be
the /last/ one in the series instead, to keep the useful changelog texts.

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
