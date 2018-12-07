Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AF2C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:57:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8027F20868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mXmkOJsc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j2ERtJzz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8027F20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AGBy8noUTNqKtW3tsxAvqSiMILu82dZ0skBwOEwkL+k=; b=mXmkOJsccNeB6+
	jsDEYs53vLkbCzF/vkhv3a+IM2eoRIYUN3JYxG7w0031WtxGgrhCApnYDqZdawOQ77wFjdjA36IcR
	BOY7G3EGJsX0m6XMrcc2RksN+Uxd2RcuUUcUgsV/gNrsdfwQRKfWCoq0/aySVqLe8JC0yeY4zes7Y
	6so+p+lOug5soliYsZ3dgr4J+1t6WhZaoUKy5xRfcf715GdejNiAhhjZwixzcRCNbT1XDW6E6ZMrq
	FFf1OIIXI/h08PmPh7oM0OldTz+Gq2iYOKy+L8P6bhA2d3j8kQovWKzuseNdANKeAOREv8XrHQsKx
	er4jtaaonRACzDkKOsjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVCsj-0006DX-8l; Fri, 07 Dec 2018 09:57:13 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVCsX-00061T-Om
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 09:57:03 +0000
Received: by mail-lf1-x142.google.com with SMTP id n18so2574807lfh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 01:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KTjai6kHiUR0odcZA9EHZhqkNVQOQl3RYUcwFUikFS0=;
 b=j2ERtJzzxIbygE9U01GJqPeMTI7J2Pxzyz0cR8mWcTi/21bMShxwdN94BJbz/culJw
 hTzgRy+DQ3abM9R3smqYHR5XonZ8MlLqnZm/yYFa5yby09AP9g+7FTyyycAxP3+MIWi5
 /Qmu163PjkEEYhaEBH4gamYN6Gf130qI5YgsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KTjai6kHiUR0odcZA9EHZhqkNVQOQl3RYUcwFUikFS0=;
 b=t82SgAv4TSLpMkEOcN0J4rk+aBughva6Aa23z5Vh49oQeoe7k57qM/uX3HQJiSn3jh
 h2CbhsKAnv1hmC1rHz9iPoiVs6pKA0r+ZilCHaD0BWBlwXSn7OnUb1EmBnjqKezP8XS4
 z26/ZfcOgkUScZ4S+0Maz6+vV5iC/PNlRmy10G8BOGcPHgdjZ9KXKZs60NDG5vJk0yf9
 R0QrP9y0meuS8ozFus81NlXNGmVcGWI4rUIUhf+yADKF8/SixecsCM79SxNkMM7xNogo
 Wkge8xn2dOfmM7FKIOV7vmFY7Rr32bTq6ZqWaIbW14fgPS/6ZMA8gIe3k3Ipr0LfwjVG
 872g==
X-Gm-Message-State: AA+aEWYzlC4OGSovZWngzrd7UX7L0piv7Bu6e88hP2Wu5spoYGTEYm3Q
 Y0fxO0PqgiVd/VoBSN3AYbf8tyb807FxbX/qXZNZ26aXA/E=
X-Google-Smtp-Source: AFSGD/VUiCK/4AJtezECsg6K6s4oa4I5beMPOb/CArUTncuglMUSoYzkcU8YtiNpezHIXn7AEZf7LrJxkOPm2O03nqk=
X-Received: by 2002:a19:4849:: with SMTP id v70mr912397lfa.62.1544176609609;
 Fri, 07 Dec 2018 01:56:49 -0800 (PST)
MIME-Version: 1.0
References: <20181128224841.3646-1-vz@mleia.com>
 <20181128224841.3646-2-vz@mleia.com>
In-Reply-To: <20181128224841.3646-2-vz@mleia.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 7 Dec 2018 10:56:37 +0100
Message-ID: <CACRpkdboOz-6EJyUQr3m+Qoa5-j4JjjEpjHWVq8hMufyhbWPrQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: gpio: lpc18xx: describe interrupt
 controllers of GPIO controller
To: Vladimir Zapolskiy <vz@mleia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_015701_804444_E2FE9331 
X-CRM114-Status: GOOD (  11.35  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Nov 28, 2018 at 11:48 PM Vladimir Zapolskiy <vz@mleia.com> wrote:

> From LPC18xx and LPC43xx User Manuals the GPIO controller consists of
> the following weakly connected blocks:
> * GPIO pin interrupt block at 0x40087000,
> * GPIO GROUP0 interrupt block at 0x40088000,
> * GPIO GROUP1 interrupt block at 0x40089000,
> * GPIO port block at 0x400F4000.
>
> While all 4 sub-controller blocks have their own I/O addresses, moreover
> all 3 interrupt blocks are APB0 peripherals and high-speed GPIO block is
> an AHB slave, according to the hardware manual interrupt controllers and
> GPIO controller block are seen as a single device, all 4 sub-controllers
> have the shared reset signal RGU #28 and the same shared clock to access
> registers CLK_Mx_GPIO on CCU1.
>
> The change adds descriptions of the currently missing interrupt controller
> blocks found on GPIO controller, new added properties are 'reg-names',
> 'resets', 'interrupt-controller' and '#interrupt-cells', also the example
> is updated to reflect the changes in device tree binding description.
>
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>

That is some seriously Frankenstein hardware.

But I see no problem with the way you are dealing with it,
it seems pretty much to the point.

So: patch applied.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
