Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C43AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:48:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C95F20874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rma9atG9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j8ydqZpU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C95F20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/IwjsO6+i9OfG5eOXDrp3ooBF1rRnK4ytedqFhsGJ98=; b=rma9atG91V+JLW
	ZpfUCwHhHxQ5jcyH0Ez/X/XOwSEd0rgaswSRkvJ/QisdJY+FYxPCt2w/LbHPQc3Z4gD/VgLXDLqrF
	2eU9aUna+2tNXpZzwvnw0LJG765UIXO/YTwD/dasywT/PLHo1Cmf1Zvx6orFvbOCDHSYFndPRlC3z
	kZkkGEbfR4DYgkfGlo6OXUm1Hug8o9MbdHKUeviEwJvqAq8BBrMcfSUVmy3cVKmDk/tAl04WNj53M
	RX4ZOyhVKnZOyIWj2d4oQYm3Loa4hgoGxKgSEIzp3lmAnk1vKSNmVAeuD5BMtOpR/DiGyPVbOw8ck
	sZ1ieRaVEPIpcTpnWrjA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghiBN-0006NW-FZ; Thu, 10 Jan 2019 21:48:09 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghiBK-0006NA-Iv
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 21:48:07 +0000
Received: by mail-lf1-x142.google.com with SMTP id l10so9367826lfh.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 13:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bcye/yLcq+BLPeOGqCtlyaXT/f1Q8e/HFaXxTnsmvn8=;
 b=j8ydqZpURPuvnjyGTC6uRr3S0FVoZV19uAEsBfRSUebc6tYs1iLFv403r9L4yPpTDN
 qzuygmafptEE33FQj5eqfXC4aG7ecJqDPgXr2ueUFY8u4W7mIln70nABthvggX3HE3ki
 Ah1pBhIg8shSvFdEbaM3QBD8ufNpRCbfOU5XI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bcye/yLcq+BLPeOGqCtlyaXT/f1Q8e/HFaXxTnsmvn8=;
 b=AlGAxd+9WJ9OAw6V+D2448HEkOYC/9P9aBFbmExsatGXmmzzElcxuikYEPU3JbngEz
 1s4OK55tx4GManD1+8eR9UyVtiUdNPU0uPOgb0auomN1ry5tbs78Hpnhofef2VRN2Zpr
 pKf9XOdjMdG3CiPHsHa1ozKoJShI1wrGsh3Lw+/luW8j3PgY5TM/bfuMAC6vNToC8RdT
 9Hf5yVMyHIsExT7KdDskr5t3ID2aZIWMenwJjA0wbsadbYd+O4wHqeBRonQubpKWT1F0
 7cwSsyEQGKWWAl00PuZF/TIopigNqOXHAfoVbUFI28156zLcNOnBVCWDGlWbcN2S9MnY
 0P+Q==
X-Gm-Message-State: AJcUukfJiWFZTO/lkWMKj2fLHZmLFUgT+CWhMASodR3+SunatjMkI4Ev
 n6f3xMLmFlZ0XuMb6YmHewmkzbB8LxbItuU3vBetYQ==
X-Google-Smtp-Source: ALg8bN5z8PXp5lD+mwMmTsHm1E4fV0ULPJLaozgG4QEn6vS80xMdd1CtF9ILtsCJRLkLBKRrqIRuLL4dQPiGQO/hhXs=
X-Received: by 2002:a19:5154:: with SMTP id f81mr7120063lfb.96.1547156884777; 
 Thu, 10 Jan 2019 13:48:04 -0800 (PST)
MIME-Version: 1.0
References: <20181213175952.GC26090@n2100.armlinux.org.uk>
 <E1gXVHy-00088e-JK@rmk-PC.armlinux.org.uk>
 <CACRpkdY_LxF82CbUUnf3B3BVucGvGnnXH-DWcWDmKcU9UgLvpA@mail.gmail.com>
 <154715377593.19284.1463901972122807524@swboyd.mtv.corp.google.com>
In-Reply-To: <154715377593.19284.1463901972122807524@swboyd.mtv.corp.google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Jan 2019 22:47:53 +0100
Message-ID: <CACRpkdbKgVCQeTwgbBuwTBosNwOB-fNfv9bU+wZr0PJG3GxwjQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] ARM: qcom: remove unnecessary boot_lock
To: Stephen Boyd <sboyd@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_134806_625532_91402C0A 
X-CRM114-Status: UNSURE (   9.93  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-oxnas@groups.io,
 Marc Zyngier <Marc.Zyngier@arm.com>, linux-arm-msm@vger.kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 David Brown <david.brown@linaro.org>,
 Russell King <rmk+kernel@armlinux.org.uk>, Andy Gross <andy.gross@linaro.org>,
 Linux-OMAP <linux-omap@vger.kernel.org>,
 "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 10, 2019 at 9:56 PM Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Linus Walleij (2019-01-10 04:50:56)

> > Mark/Marc: is there any specific reason to why the ARM arch
> > timer does not register an arch delay timer?
>
> Doesn't the ARM arch timer get registered in
> arch/arm/kernel/arch_timer.c via arch_timer_delay_timer_register()?

Ah indeed it does, OK then, this patch should be fine from that
point of view.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
