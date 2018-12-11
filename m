Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DB1C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:44:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 061992082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m4J8fe4F";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RjJmRXUU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 061992082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qGwJBCJnJo5Qgjocy+c2z0EZPm5lHFAJIZs6Si9kJ4s=; b=m4J8fe4FVNBuXN
	KWHeuF1X3OEdTFUr9VEFaWbv8ELrrbMkMIM3C/8uXZvO5oyzEOsaLzG/6kl6e9zwCvtP3vKhDJmvd
	6BB94gUW2WlwVOS/YLOepHO77dbmFgaIwuLtlyEAeLVWiibJcP1GR8GeJctZWHjLj21hQmq3JlXHn
	XCuiYB2FBYMUnNmH76pYxOdC5L5/ZEmV4kTUsNK1mQs9lla1T2qMgf2GTgt0FH65tKORY8+cYuKJZ
	guvYu+C54mMCg9AQE+UkSpwKPY4l1NrXWSzlXUoSSYl7tqvOFZRauxyrNSlHhfwkmPFwsFZzBe/4P
	xwVrmzH8ZKt83U7hayjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWfWo-0002nw-Kc; Tue, 11 Dec 2018 10:44:38 +0000
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWfWk-0002ls-HG
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 10:44:35 +0000
Received: by mail-lf1-x143.google.com with SMTP id z13so10371450lfe.11
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 02:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=S0G90vwj8/M2LQveuNJTC8/U5GntaUn0knA/ecTeIaE=;
 b=RjJmRXUU4hamnaLJWRoQiOn+nRhPotTZ9eFXCIZa3EK0i357llUZBnF6zFrKzvm04D
 ntzEEUr2bncefwcXRMwqYcWgywl1ozCPJfQ+XMuSey/xl1sJjAmbVXztg/9q1baeHUnW
 2VOzM2fL8j665C4H47x9ciADMF4nFKfL3KP2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=S0G90vwj8/M2LQveuNJTC8/U5GntaUn0knA/ecTeIaE=;
 b=lPhadTWq8aJeBB3E5YP19Fn38uR0LL9a6M+eCakmPi1cqG04udQAfOc5HIq0LlBEkm
 kQ4qinpB9nvv7tl1PMweUxbotOOwcIrXfYPNFb/dqlqLeJic6ijnCt4KGMCUhCH8yM7n
 pntqaCUO/8bEl8c8VOXlQLNPNbPktYIwjfrJtSpKwK53poRWFW3z3a4o/WfVTLMP3AKZ
 S1U6ZvTP3iUh9OgvlubLyUOmlpJstV5XXF+8ky6z9Rq8RAEVzFt/EBVD65mqcQjlF93h
 XklacV2QpT/Ldh2l2wWzi0dn7h33N361plGLbOPcNh2p12KDCTJbB8SqsQyVKhZyipsk
 c3rw==
X-Gm-Message-State: AA+aEWa4xmwdeOlMr6ls5k0pkk4hT3Y2pJiuUH/EckYGtexXMLJRgKfZ
 sJep4NnYx+X79DEyj3RQ2+GriviTjZ/3AKW1JECmuw==
X-Google-Smtp-Source: AFSGD/UqW65rfQAPCrdE8ppZ6uMm4xnPWyXgJ8tTJPnhrMQv3eXa8514icTBWFvLi9oNa6lbcqTeyTl7si8fPsKFB3E=
X-Received: by 2002:a19:4849:: with SMTP id v70mr8806384lfa.62.1544525060909; 
 Tue, 11 Dec 2018 02:44:20 -0800 (PST)
MIME-Version: 1.0
References: <20181210215856.2238253-1-arnd@arndb.de>
 <20181210215856.2238253-4-arnd@arndb.de>
 <CAPDyKFogJv0OeaqdXBUyVAtmFqNTxDOJU_EMgMO7tFYdoQMY4A@mail.gmail.com>
In-Reply-To: <CAPDyKFogJv0OeaqdXBUyVAtmFqNTxDOJU_EMgMO7tFYdoQMY4A@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 11 Dec 2018 11:44:07 +0100
Message-ID: <CACRpkdb_JnC13q2qMdFQ93MyDCSTmpP9L6_g8EK3m=6LZ4be4w@mail.gmail.com>
Subject: Re: [PATCH 4/4] ARM: pxa: avoid section mismatch warning
To: Ulf Hansson <ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_024434_573984_A5BE756C 
X-CRM114-Status: GOOD (  13.50  )
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
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, arm-soc <arm@kernel.org>,
 Igor Grinberg <grinberg@compulab.co.il>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 10:40 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Mon, 10 Dec 2018 at 23:00, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > WARNING: vmlinux.o(.text+0x19f90): Section mismatch in reference from the function littleton_init_lcd() to the function .init.text:pxa_set_fb_info()
> > The function littleton_init_lcd() references
> > the function __init pxa_set_fb_info().
> > This is often because littleton_init_lcd lacks a __init
> > annotation or the annotation of pxa_set_fb_info is wrong.
> >
> > WARNING: vmlinux.o(.text+0xf824): Section mismatch in reference from the function zeus_register_ohci() to the function .init.text:pxa_set_ohci_info()
> > The function zeus_register_ohci() references
> > the function __init pxa_set_ohci_info().
> > This is often because zeus_register_ohci lacks a __init
> > annotation or the annotation of pxa_set_ohci_info is wrong.
> >
> > WARNING: vmlinux.o(.text+0xf95c): Section mismatch in reference from the function cm_x300_init_u2d() to the function .init.text:pxa3xx_set_u2d_info()
> > The function cm_x300_init_u2d() references
> > the function __init pxa3xx_set_u2d_info().
> > This is often because cm_x300_init_u2d lacks a __init
> > annotation or the annotation of pxa3xx_set_u2d_info is wrong.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> I have queued a bunch of pxa changes via my mmc tree for gpio
> descriptor conversions, by Linus Walleij.
>
> Are those causing this problem? Should I queue this one via mmc tree as well?

Nopes just correlation without causation...

I also made a bunch of patches to PXA through the regulator tree,
those are not related either.

It *seems* they touch so different code lines that it shouldn't
be a problem to merge orthogonally in ARM SoC.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
