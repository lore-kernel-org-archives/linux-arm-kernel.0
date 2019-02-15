Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41F4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:20:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81AE321925
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DMPX/58/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81AE321925
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uKdnS0dg8JaYsLfOz4SKM1C+zKkVs9I3sL2Pzl80mPo=; b=DMPX/58/NQ9SNP
	V5cQ7YNBuJcYBdOiaK6CydiCrpmT4p0/kCG2w/XT04rQa+CvmYdd031/PA2/HMLDS8XoIanIPkgUd
	APIS+WUuo8d+e9OFog3N6EqWVvpyX4RHY1pSfOnAVYQ2BXgpIynUwmJY7ayslG259U0c/h8UspAI0
	7jYU87RRuvxv6g+jqpMUf8Zb3Jm9RD19CQ/XtC8Pb9sYLEWF/xSXCu9CqOUt057AXnc6vRQBoBMGu
	sGYuQ20qWjv5+yPyLDSdnYKKKqHNJBVwxuOHDIick+5EiSqY68cG3hhznWxHeOf04w4RKRBg50YqK
	YahF/6G9Il/aCMEdQkjg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gufIF-0006MY-92; Fri, 15 Feb 2019 15:20:47 +0000
Received: from mail-qk1-f169.google.com ([209.85.222.169])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gufIB-0006Lv-IT
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 15:20:45 +0000
Received: by mail-qk1-f169.google.com with SMTP id x6so5882988qki.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 07:20:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Xbayz+nu1qpytE7iYRRc5A0uJlCr69al+zVCAWIlcsg=;
 b=jgAF/58NVyev2rN1ZKtA7yiDlEFcnvsDnAqNnyP/VYVeiMeaztxnuaWJwt4qNPv7L/
 1qIQ2qmg1dSnStys56mUmkNFzr1UmdbMpSmwO3cTo84QpZiGyvoaVdia0L4ZebCS9dO7
 OltY0KS/Idby/yBZopGkQwvxOAFyD+31yn3m1/fPNaYvwHjCgo8m1IibDef06sNHZnLE
 ox9tCvgCJUpgqeYBmGd9961wxHKRxWK1SzDURW9dH63Iqhy0MwxxOI9beRnay6S9XjzA
 afZq4e7qj+WW8lcx7jTuXTSBUpmwKlsNa7drvtqz81g/g9sXYPhale6zFp/7R1oxKhlY
 GWjQ==
X-Gm-Message-State: AHQUAuYIeSVYcYACoNhxOG9hQCfd6Fy59XNJz/AbHRBQ4UUBrFzT/e4U
 fqaiJgloWZlx1s7QN0LQ+s0UT9grLVLWcyksxx4=
X-Google-Smtp-Source: AHgI3IZgyHH0gTJEGsYgPUvQ5JAkl4lYxSQcy50CMJQ6iOKf7E7b2gGvYYMTCHGgyL2TgQRU9OW0BvY4+bp83dGR3uw=
X-Received: by 2002:a37:7cf:: with SMTP id 198mr7414886qkh.173.1550244042133; 
 Fri, 15 Feb 2019 07:20:42 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNAQOQ7KczCUP7hWWTX+9oRA3zycbBTDR7rXXkfhb0TG-Zg@mail.gmail.com>
In-Reply-To: <CAK7LNAQOQ7KczCUP7hWWTX+9oRA3zycbBTDR7rXXkfhb0TG-Zg@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 16:20:25 +0100
Message-ID: <CAK8P3a19FYb1UJtkL18x523_h_EE6J=VS4U8UyjMg==SRWSbMg@mail.gmail.com>
Subject: Re: [GIT PULL] arm64: dts: uniphier: UniPhier DT updates for v5.1
To: Masahiro Yamada <yamada.masahiro@socionext.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_072043_606990_60E15ED1 
X-CRM114-Status: UNSURE (   8.93  )
X-CRM114-Notice: Please train this message.
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
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 1:13 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> ----------------------------------------------------------------
> UniPhier ARM64 SoC DT updates for v5.1
>
> - Add PCI Express controller nodes
>

Pulled into arm/dt, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
