Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64A3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:51:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD8A9214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DCS9x3xk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fUi1x7tY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD8A9214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6XVi8SNiImb5//aahFw1AKzlraYc7tKzIj9q2rSgNyg=; b=DCS9x3xk8ZwwbD
	XLttJoIAikC2eK2Qc3EuYLhP3plQGwvkRdP/MsJMUUBf+IybgsMkJYzy0Pm1he9xc1UazrsQBOGrj
	8mqBYypJjB8L8RnbEQQT5fr1zHsuBPATxh3z5eQPpUjPuzBJdXE8ZV0tDml8B0RA7i1Y7sz2JmUcI
	rSL3bWd4ym8JmNLucmSj1tEm5CkzDARo7AeDY+1QsiUtkPtFUSUMNCr7ryRdHpJpuX1p490Mc+L9D
	8ir/QJIdrtgvX7aXy8COjrkBt/BLnTwDOjhunkw1U4XQkL5/MqZPWFHLiqQgnPHcB0brAZAfxJNgO
	PtBPI0eVmRLabhkKPoWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghZnn-0005tB-Ju; Thu, 10 Jan 2019 12:51:15 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghZnj-0005se-Iw
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 12:51:13 +0000
Received: by mail-lj1-x243.google.com with SMTP id x85-v6so9609420ljb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 04:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7jLikAVAvfr2tZ5PkK6c/iGuhs51cN1FFTyvTOoKkuU=;
 b=fUi1x7tYOFQqkDYCdwvAJRebschYRnTIwB5TBEx1ZJ0FWu5s3WQKHrWWPjKBb4POyB
 d5km6+FJeByFjp64Jll4Vkd5ibNXSA2evVSEt0Ka9TPftpE4PlvajpUCWUnTQ0iWs4VO
 lkk0MwfKNT7B3VnmQJBMtGlgxGCieRdgtt650=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7jLikAVAvfr2tZ5PkK6c/iGuhs51cN1FFTyvTOoKkuU=;
 b=Yj/ZzugFyoGGL6dCKR97if+vmhzOh24H7SfAYA4NhCtQujwmTVfORjqLfmv32TCRmv
 R7MDYXg08wBZiPR4lNiU9QGJQmV5G8VGNQOEDyZBIj0fjwfPIeW+YPN8QbkeVZif94g1
 abt7ePtmm3haeK0Qugn/0RPUlC+7FQeop30TsORK82Yr83xHNZ0PBtl2Bn8B1jbp53Hv
 lgSvZ4ReNRMF9rlTDUpzrPA4clLafj22y7p6kZWkPdhaQc9aXMV+9O/lMgZnS30c70ur
 lenYSfm7RUpHdmxsEICdOCKyY40m7DeHp2zX8FcAWiHV9ED2G+8FqBShSfjeAVK1Jz4E
 IHsg==
X-Gm-Message-State: AJcUukd7CZ+EANwuQn6E07oi960Nj7ECsBmzlK7hN5AA+UwU2VyP+8IW
 NLDqTjKtUhQF8HBss3q9XdRrfnawJZjXRjQ3OS9vIw==
X-Google-Smtp-Source: ALg8bN4VE9I4gcszrLgoM/KrVgoibhmoW0VP+CQCRwG9OQObSN97GZDdA6R/N2+Oze8Pf5cHkF3fWuIxTanE74HgLkk=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr5892607ljj.9.1547124669099; 
 Thu, 10 Jan 2019 04:51:09 -0800 (PST)
MIME-Version: 1.0
References: <20181213175952.GC26090@n2100.armlinux.org.uk>
 <E1gXVHy-00088e-JK@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1gXVHy-00088e-JK@rmk-PC.armlinux.org.uk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Jan 2019 13:50:56 +0100
Message-ID: <CACRpkdY_LxF82CbUUnf3B3BVucGvGnnXH-DWcWDmKcU9UgLvpA@mail.gmail.com>
Subject: Re: [PATCH 2/9] ARM: qcom: remove unnecessary boot_lock
To: Russell King <rmk+kernel@armlinux.org.uk>,
 Andy Gross <andy.gross@linaro.org>, 
 Marc Zyngier <Marc.Zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_045111_669553_FAE7547A 
X-CRM114-Status: GOOD (  12.03  )
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
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 linux-arm-msm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 David Brown <david.brown@linaro.org>, linux-oxnas@groups.io,
 "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 13, 2018 at 7:00 PM Russell King <rmk+kernel@armlinux.org.uk> wrote:

> The boot_lock is something that was required for ARM development
> platforms to ensure that the delay calibration worked properly.  This
> is not necessary for modern platforms that have better bus bandwidth
> and do not need to calibrate the delay loop for secondary cores.
> Remove the boot_lock entirely.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Andy have you had a chance to test/apply this patch?

I think the majority of Qcom systems use CLKSRC_QCOM
which registers an arch delay timer and swiftly bypasses the
calibration anyways so this code is pretty much pointless.

There is a question about MSM8974 though. This appears
to not use CLKSRC_QCOM but rather HAVE_ARM_ARCH_TIMER.
drivers/clocksource/arm_arch_timer.c seems to
not register a delay timer, which is probably something that
should be fixed?

Mark/Marc: is there any specific reason to why the ARM arch
timer does not register an arch delay timer?

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
