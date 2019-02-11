Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CABC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:53:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 222E2218A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sX7H3hRV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mathembedded-com.20150623.gappssmtp.com header.i=@mathembedded-com.20150623.gappssmtp.com header.b="wA9wY1xV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 222E2218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mathembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=5Fe6UUvtMlYqz9tq1F4h+uUyNyg/o53gSOb3VaBGpsE=; b=sX7H3hRVgrRmRowWs/aMdJZV+m
	fVULBwx/xFGaqfeW0qsVVSG9RtAuDFqiviiE3NbHbnxDa1Dm9uJnpMRXn2j1Q9Q6CQyooCeHC72oH
	28WnjnRUMf1pThQgnvPvKGNxUYzeirIRtCHb3rSUPFnHPuKZAdhtbHDBYN6kwiYL14SUbZ+TxjYEr
	RA1F4/fzQA3vquJF7OnDWVrfxkby7wU+I9ca7NsSBvF8DfJ2dCqnNICSScFXftQqfRFlgvJFtNkjW
	fFPgEk/AD0t4nK6f4ji63j6gD697JPm7sVIfLgOzLHCQMtpCayMggwF05WrAxMXu9cq2wsmcd5FuE
	HtScU0Vw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtC1t-0001qD-RF; Mon, 11 Feb 2019 13:53:49 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtC1q-0001pl-9v
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 13:53:48 +0000
Received: by mail-it1-x143.google.com with SMTP id v72so1424002itc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 05:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mathembedded-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=iVvK5cTS2MGtwxTxEkntqA/F6l5oKzOt5NJvEpyj8KM=;
 b=wA9wY1xVbUMidFtuDpWi0OlLKbALEe7L/yp8k0412FHOeUoKxx9UZSJJL1/zeH260E
 8LEqlJO7Dj3oN+TS658UKUBbjk8sGriLxzlqSABTt5VLHpYhIZIpyYu3pltGuagT2f5K
 bfNjorF47rzkbbmoi53a5g7b8nhO9WsGcOL4V1mYx+Yz2kQI+Fv+BgamW5geKG65pqXz
 DkS7QNRv0TVKFFc68pzH9yQRRFs7o7j+boG7ixoFNCr0NbZhHw8ZLbnMBrLaB7VDqVQf
 NxgiFNKdD8ISI3pIq7cp5zU/hkQ7+JCE2Z0Uc4VECsIkq4Kkwm7mviO+i6CuQlLPbSf3
 /9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=iVvK5cTS2MGtwxTxEkntqA/F6l5oKzOt5NJvEpyj8KM=;
 b=tmU+VAVGpuemeCx4Ljtay4EUsqFzON6WR/O0LrChYpW99zomHbD8wfB3Z0BmNZa5XM
 z3enbXWkHsdAC0TfMaOO/m+U+nSMhkQeImKnj3kXImc1c5BGIAhJq/wpsButW1vXyN1n
 GuYjNEplLZkhBeUkN6tkaAOHtjL8RJByryAWE7JQT9DlhnZwOsDkovz7s6ZjN4sGr7Wn
 QKJZmaOl6h2oOK7XFDRltLFrnwRq5fnyUhbSq82YYvgoTH8IH7fCKf1yq3NMlmnMV/Jb
 /CACj53QIcaE0Tz8lFc/hbQ6PIZ29AnG6BhpvVEzeB2bPiU/xZbeuzvN4j+L+dFyiT9O
 Lqrw==
X-Gm-Message-State: AHQUAuYoPPwmwRHY4GTmqThUXB2iawcd8Bbhi6wce+Czs9Dc92ZcFfRx
 6HnuvLrKBKswT3YlOXFUWf4oXTAEYkiUtR2mWMLYMw==
X-Google-Smtp-Source: AHgI3IbiXjJgswTOvWdGDjSNvNL75z6HQ7pVKrCwZ/NVXuDL2+DmjwjhDdQir91WR+oAH4Ke5BKXFA3THcoMDx0ye78=
X-Received: by 2002:a6b:5b01:: with SMTP id v1mr16382075ioh.12.1549893225086; 
 Mon, 11 Feb 2019 05:53:45 -0800 (PST)
MIME-Version: 1.0
References: <20190210231212.20470-1-stuart.menefy@mathembedded.com>
In-Reply-To: <20190210231212.20470-1-stuart.menefy@mathembedded.com>
From: Stuart Menefy <stuart.menefy@mathembedded.com>
Date: Mon, 11 Feb 2019 13:53:14 +0000
Message-ID: <CAPoDyq6vzXuR+Z=t9eyJytuOGZknyY1nOY7v_ir86VTZM3DH5g@mail.gmail.com>
Subject: Re: [PATCH] ARM: MCPM: Add provision for platform specific wfi
 alternative
To: Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, 
 Will Deacon <will.deacon@arm.com>, Nicolas Pitre <nico@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_055346_390230_1CA01E67 
X-CRM114-Status: GOOD (  10.95  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Folks

On Sun, 10 Feb 2019 at 23:12, Stuart Menefy
<stuart.menefy@mathembedded.com> wrote:
>
> On some platforms (in particular the Exynos5260) the wfi is not
> executed directly by the operating system but by trapping into the
> secure monitor. This allows us to replicate the behaviour of the
> vendor supplied kernel using the MCPM framework.
>
> Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>

I forgot to add, this is a part of a series of patches which updates
the Exynos 5260
support, allowing use of the kernel on secure parts and adding suspend
functionality,
Version 1 of the patches has been posted to the samsung-soc mailing list:
https://www.spinics.net/lists/linux-samsung-soc/#65035
and I'm just about to post version 2. However as this is the only patch which
touches generic ARM files I though I'd better check the approach is acceptable
to a wider audience.

Stuart

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
