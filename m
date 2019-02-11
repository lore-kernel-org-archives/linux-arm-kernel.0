Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E89C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:57:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2251222B3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dvMmyERC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n2vJkJ+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2251222B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BquAJhdjrTcjQiDKsH0C92CSic6T5l3X4HPmSv2BWpc=; b=dvMmyERCzLWiAK
	ug5anHR5Zmaeb+hZ1IH7WBOBxd32vrNFuEztbxEW4e7juWFkJLIbBj1iEyqvYqbh0Lqnt7bNuAqpR
	JdPbznamwAf3vxiiPA6fMUFo70qakcHSdPhcf/EfWVa8RmjBI4ySfHdfgu3Hfm8JiTHWV9fwgOYEO
	cn+WS/FDurqKpSQTsu6w5Qvk0eHB4jTHeyWxJC1TRmnU+joxZFxTXD5YVd8G1b98VDOP94bN/wt7k
	fxo0TuZzqlgqjsjrXiGrz3wM6MbhBk+1pRXEoUR+vM2M/qpe8j7c6v/IWBACAcGQ49a1ch6yBAn7m
	LlyLvRCY+pASw9NnuZnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtDxp-0003Yf-8k; Mon, 11 Feb 2019 15:57:45 +0000
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtDxl-0003Xo-Cf
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 15:57:43 +0000
Received: by mail-qt1-x842.google.com with SMTP id y20so12618860qtm.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 07:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=DqOpUoTQQC1JLGdgGbuLKwQTFqB8zvIBiOG+uuPfDOA=;
 b=n2vJkJ+tw2Ef+r9R1/27SalBItfZ1tFh44ogj7Pgt3kHfvQ5uvyHIw3j24X4ROdUDz
 mOOzI3Iaw1LALF2rF+hsyLVS2Fnt9XclIku4jQXsmKLsHISqSL+Z1YYL9QMczAV6hTbQ
 LwTJUMD2j9NzxRmuuQIz56lPBddpGN7F5x1SygQ09otNx3qhCv/ApX/s7SHaM/H2dlKt
 BdKF/35LqtoBg9wJbQ/Rcm5INj5+PTiT7X83nvIIAyXiDVBm0zOlIlBVeUd/QUWm+xEt
 D8V3iwNv3KrU61/6a+dnOW4DeU7a75Xv67O+GTT8vfpOcsAjMM5qceUVCQm8vhequvJu
 SiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=DqOpUoTQQC1JLGdgGbuLKwQTFqB8zvIBiOG+uuPfDOA=;
 b=A9cOcMATb0nM4w0ah9bUNsYo8eCeUiEZIAHhX1EBaXvfsIPLD6pzKWYsQHBMdGGAUe
 IwDz6AP49L4zeCb1qHJrmAhuoRXmKJAkXAiWKkdd9aCbSjVYXKRLR/w/y5tgrsK53yQP
 TvB3CiwRzpWttUg9e1QOhV/Nws68cy0U5KqJYZd6X/tRg8tzI+nHQNp7/UMz8xqL0awQ
 6tSszDIsqq1Ab0NCZhWmGHT3z4K7MlyH3bnPq8YwCjuMtDA28fXC1KkCa7N0tQi6wk1T
 XErxGqibd0WUi3gRh+Ab1pOaexFjVBCU3U+tlEyWu4n2mEqc/A64kKTbMs38GzQUwwX3
 w5eQ==
X-Gm-Message-State: AHQUAuby1Iaqil9V8N01l+5cDUGID23ndNQqNl8zvZD+1GCV2IrLI8J7
 BlpDy4Pyjne9n/MraG3QC5nWkg==
X-Google-Smtp-Source: AHgI3IadTAbnGTEgItCOiIXzgFdIkSQaZ/UP5eDpWcoOx2HIr3C11K9fZ8TZN9Msf0JjL/B7lCBMSw==
X-Received: by 2002:a0c:e98f:: with SMTP id z15mr8124612qvn.115.1549900660049; 
 Mon, 11 Feb 2019 07:57:40 -0800 (PST)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca.
 [70.82.104.228])
 by smtp.gmail.com with ESMTPSA id v57sm14440655qtv.80.2019.02.11.07.57.38
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 11 Feb 2019 07:57:39 -0800 (PST)
Date: Mon, 11 Feb 2019 10:57:38 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Stuart Menefy <stuart.menefy@mathembedded.com>
Subject: Re: [PATCH] ARM: MCPM: Add provision for platform specific wfi
 alternative
In-Reply-To: <CAPoDyq6vzXuR+Z=t9eyJytuOGZknyY1nOY7v_ir86VTZM3DH5g@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.76.1902111056070.2213@knanqh.ubzr>
References: <20190210231212.20470-1-stuart.menefy@mathembedded.com>
 <CAPoDyq6vzXuR+Z=t9eyJytuOGZknyY1nOY7v_ir86VTZM3DH5g@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_075741_432981_89804999 
X-CRM114-Status: GOOD (  17.61  )
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
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 11 Feb 2019, Stuart Menefy wrote:

> Folks
> 
> On Sun, 10 Feb 2019 at 23:12, Stuart Menefy
> <stuart.menefy@mathembedded.com> wrote:
> >
> > On some platforms (in particular the Exynos5260) the wfi is not
> > executed directly by the operating system but by trapping into the
> > secure monitor. This allows us to replicate the behaviour of the
> > vendor supplied kernel using the MCPM framework.
> >
> > Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>
> 
> I forgot to add, this is a part of a series of patches which updates
> the Exynos 5260
> support, allowing use of the kernel on secure parts and adding suspend
> functionality,
> Version 1 of the patches has been posted to the samsung-soc mailing list:
> https://www.spinics.net/lists/linux-samsung-soc/#65035
> and I'm just about to post version 2. However as this is the only patch which
> touches generic ARM files I though I'd better check the approach is acceptable
> to a wider audience.

I was about to ask that you also post those patches making use of this 
change.  It is not possible to evaluate if the approach makes sense 
without seeing how it is used.


Nicolas

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
