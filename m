Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02567C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 22:47:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C345A20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 22:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="os5Pt7xR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bRN8B2j+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C345A20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LNfyht53g3fC3eD2auhs/z2lIV4voXiT9PfLxHIAIyw=; b=os5Pt7xRO9RZRY
	s1sJjPah0PawMTmSvaXG9924iuA19l9xPLg/0YI4kMW9fcMRcTt3lUaIDhY/7h95qvozRwE0qpWAH
	w+IJAdeUBryq42zrDk5O3XKwgGRkM1OM4fGoFFMBrQ9JNn368ryXoK/nYDhH0ASiVk86UwMyfA/Y8
	T5U8V9v6/KoIcCWYIZuo81YZhO9TQLBnxQ/e963m2e8whyU6aVmiC8u+4OiavIqqV7F09pMQwolOE
	bsdDTt/VjXPWOA+9eFfrcO5wf1iMLsEhprQa1Ka0NGfl7+9IoQUOG3Dc1Vph+RvRr8hVVcdF8Kx59
	tvwMhuSdAljlNLgzM1sA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gioX4-0006Xr-P4; Sun, 13 Jan 2019 22:47:06 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gioX2-0006XG-7W
 for linux-arm-kernel@lists.infradead.org; Sun, 13 Jan 2019 22:47:05 +0000
Received: by mail-lj1-x244.google.com with SMTP id q2-v6so17360900lji.10
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 13 Jan 2019 14:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZugiLfpGc/PvcfCiNyfEX7PEKwFV6iHZWa426JGVoS4=;
 b=bRN8B2j+FGnOdyoI/zy70WpEuQ0Tltbg1hJhqwWD2codQTwIui7C8LrA/HGfmNIwF3
 2vgd2GCjsBSxjzsGqbZBfOAIRF4Q+zEuQZyj4sDRWtVqEOZuuuBXU3xGvwvItsIX/pku
 F206+fjKRSZRds9+LUPegtNxaejdVUMI0sLcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZugiLfpGc/PvcfCiNyfEX7PEKwFV6iHZWa426JGVoS4=;
 b=ib0YWRuf0XWDTpFvVlpvmY6q4OizcOHLm6AfohOkz8X/9jejlaXr63s+f1kg4QDBec
 Bwuti22eOVfBWZR0ud/9ZUruhsx1F3XSVIc17HszgOxCi1ho1+nxub4UGTMw4CYT4CTS
 9PGhXfUSXAk/mC/XFJL9OBZuZXyR5dzv6zQLUFDp1OewtGacrM1pXKt9xjKv+/emk7tO
 yT5+cbYnBqTdzePMrc0vRmGjVxOF2dqR6oIDWLLWQ+3FYpsCpfs4eucKMkDhUuzKNR4E
 6pJsj7AM5I3EEuLlFwsOtTxHc/aB8kabew2vYxeUBQZDjJt6PmG5vucswRy2VMwUY/fQ
 DXHw==
X-Gm-Message-State: AJcUukc/Fz2KjPPZndvZVdMEDKn2YCgLcsoSFooMHVHb++Ha/2RDmbE8
 IiBb1cQ295DmXHEbde1BhuYhl4hAnwX215d25r/HzQ==
X-Google-Smtp-Source: ALg8bN63/kv9REjqA84FuUGgN9HHXS2f21SG/p/bYsWjdoQ8/K/HtqoXSchFO5czPECua3VeaAZbhN/r0NUF2YdTlWI=
X-Received: by 2002:a2e:9c7:: with SMTP id
 190-v6mr11368416ljj.120.1547419622453; 
 Sun, 13 Jan 2019 14:47:02 -0800 (PST)
MIME-Version: 1.0
References: <20181213175952.GC26090@n2100.armlinux.org.uk>
 <E1gXVHy-00088e-JK@rmk-PC.armlinux.org.uk>
 <CACRpkdY_LxF82CbUUnf3B3BVucGvGnnXH-DWcWDmKcU9UgLvpA@mail.gmail.com>
 <20190111150935.GA4617@n2100.armlinux.org.uk>
In-Reply-To: <20190111150935.GA4617@n2100.armlinux.org.uk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 13 Jan 2019 23:46:50 +0100
Message-ID: <CACRpkdbM7M7dcbhbw4BQBsbhUzfwy390srv7QBaygpz8WKaCBQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] ARM: qcom: remove unnecessary boot_lock
To: Russell King - ARM Linux <linux@armlinux.org.uk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_144704_276973_9F55A427 
X-CRM114-Status: GOOD (  15.74  )
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
 Daniel Lezcano <daniel.lezcano@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 David Brown <david.brown@linaro.org>, Andy Gross <andy.gross@linaro.org>,
 Linux-OMAP <linux-omap@vger.kernel.org>,
 "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 11, 2019 at 4:09 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Thu, Jan 10, 2019 at 01:50:56PM +0100, Linus Walleij wrote:
> > On Thu, Dec 13, 2018 at 7:00 PM Russell King <rmk+kernel@armlinux.org.uk> wrote:
> >
> > > The boot_lock is something that was required for ARM development
> > > platforms to ensure that the delay calibration worked properly.  This
> > > is not necessary for modern platforms that have better bus bandwidth
> > > and do not need to calibrate the delay loop for secondary cores.
> > > Remove the boot_lock entirely.
> > >
> > > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> >
> > Andy have you had a chance to test/apply this patch?
>
> I would rather folk do not _apply_ these patches - the final patch
> is dependent on all the preceeding patches, and if they're applied
> to individual trees, it will mean that the final patch has to be
> delayed by a complete kernel development cycle to avoid bisect
> breakage.

Ah good point. It's way better that you queue it up indeed.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
