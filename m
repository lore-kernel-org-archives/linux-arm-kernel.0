Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7683C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:15:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6A8E20859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FtO0GVcJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iv234rAt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6A8E20859
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Wg2RZcbZJVWJ93ZjHdJ1Yg0Pewi9aOENG80m0geBo7U=; b=FtO0GVcJ9EvALX
	sNEGZ8UwVHxQP45MV4LT2AsjWWQdMqw0Bfyw0OUhz80BSyrkTuFsExG/c/8xhSo1AV3RkXCpLgAHw
	VGt8vfF8iBjCygP6Ob2gJIID+yoxzRQUuqpnKHxk9W4Hrbg0SV+kftdABo+am1uPL12JDYhmgJs+c
	eBi2TY+ZqAX0dNBM+soOBakYlvMJZTThr9clElubykpzcPse18P26gyDb+aVq2LmiawfGyj0PQrjr
	Fma5xgh783iechiVpk7T/icEcWkIgNBQx+IS+IOST2oNssDa5/gcINRyuULjYUqZqmJGMIME1icdm
	E0QZPSSZUUJ2TGLbs1aw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghM82-0004xd-5p; Wed, 09 Jan 2019 22:15:14 +0000
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghM7y-0004hT-IB; Wed, 09 Jan 2019 22:15:12 +0000
Received: by mail-oi1-x241.google.com with SMTP id a77so7635730oii.5;
 Wed, 09 Jan 2019 14:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Y20vyWCNfVs+m7NNZt80MMEIx2g9VSVEjKCx98AL8Io=;
 b=iv234rAtcDgwWLa+LY9sZhNlZpZlVvhQKUCzM5JF6cQmOUMRsCWJq2mtNCdjuRtiZl
 9swjh5oJetfMm3tsxTXCYcaNyosYfEcDugMfSPlu7f00sS2CAW1EJq3je3HauJJvw2e9
 khXz+1aSe4p/OomWk3beJivi3icV1bE4pK8fVEdvRNTKMCHZSQT0vhjdBWYcG4Nc3nFa
 4lMzYeLkebCu/9R46cgzPy3W2uUZmkGmRKovflOgu7e5EVpUMkEEvpELfxQThZn5n2Bk
 iX9F8yR8zUxLZjAthiMpSP9rkBT3HiOi/i5Ma3rGkYEF6cfub4w//zh1o+iptReubFCc
 U5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Y20vyWCNfVs+m7NNZt80MMEIx2g9VSVEjKCx98AL8Io=;
 b=hBqM8x4BT5LgaPHSBEau0yG1kqzRojXOXkHXxb/g+R4l6wB2Tt6VaYKAlkKY/AkjF6
 qax9v/IQo87b8K0bPGbZ9QtyGFoY0PmRJ5XWfdyim6wEMeZq/hPszN/888786m2E5UyP
 CeT99hj7Cvy5t5qvdSFtcjNzo9uWY+qnfv1kXkH2VEMgrUoLLpHijguNKN/O+YCzNrFN
 A29kyalbin3/aVWYyc7d2H0a0sY0wbxCd0qM0kwfeRoHPSWRNHPpU9iUPJXn7kzTRBsA
 g0l+3WosMpBj5E9/n3pDn/MJUu4QaobDA79OBPyvmv9aXQHGKjuT/y5kkAgrmowZGgoA
 CCxg==
X-Gm-Message-State: AJcUukc1Fq13DlaKiOAmkosNln6MvHnm+V7GKA2Li++Qu2Fn/e7XINew
 mEpsyf40ceKliN+p0O4byK8fExRgQ03iXh2I6O//qA==
X-Google-Smtp-Source: ALg8bN7OHt5BPL8i7w5mIoSdh8CnFfeu2HUjv+4v+6dZBtVWkyVQ65ydAX6Hm76tcpcp4QKN+gKjXVpLf/WHYODKeqM=
X-Received: by 2002:aca:5b43:: with SMTP id p64mr4768763oib.41.1547072108641; 
 Wed, 09 Jan 2019 14:15:08 -0800 (PST)
MIME-Version: 1.0
References: <1547042198-17601-1-git-send-email-lollivier@baylibre.com>
 <CACRpkdbhVB7-Y9EBhBC6GAxqFt8zujS2QJ4CzGDJnDMDjj2Ptg@mail.gmail.com>
In-Reply-To: <CACRpkdbhVB7-Y9EBhBC6GAxqFt8zujS2QJ4CzGDJnDMDjj2Ptg@mail.gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Wed, 9 Jan 2019 23:14:57 +0100
Message-ID: <CAFBinCBf+yJu4z1JYNdH7B4h07-U_0ckysV_=nC65nd5ByOCvA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: meson: Fix mmc cd-gpio polarity
To: Linus Walleij <linus.walleij@linaro.org>,
 Loys Ollivier <lollivier@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_141510_646647_E14477A3 
X-CRM114-Status: GOOD (  14.57  )
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
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Wed, Jan 9, 2019 at 7:31 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Hi Ollivier!
>
> On Wed, Jan 9, 2019 at 2:56 PM Loys Ollivier <lollivier@baylibre.com> wrote:
>
> > Commit 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
> > changed the behavior of "cd-inverted" to follow the device tree bindings
> > specification.
> > Lines specifying "cd-inverted" are now "acitve high".
there's a typo in the description - it should be "active"

> >
> > Fix the SD card for meson by setting the cd-gpio as "active low" according
> > to the boards specifications.
> >
> > Fixes: 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
> > Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> >
> > v2: fix more occurences, also in other meson boards.
>
> This is a good change in itself since it gets rid of some occasions
> of the dreaded "cd-inverted" property. I think Martin Blumenstingl
> already sent patches like these though (I might be confused).
I sent patches for the 32-bit Amlogic SoCs
my TODO-list is now a bit longer, I'll test this series on my Khadas
VIM, VIM2 and Libretech CC during the weekend

> But we should keep the old device trees working as well.
> Can you test if Martins patch:
> https://marc.info/?l=linux-mmc&m=154637189021211&w=2
>
> Also makes your boards work?
feedback on that patch is appreciated


Regards
Martin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
