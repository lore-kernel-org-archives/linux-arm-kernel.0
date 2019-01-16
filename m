Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8517C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:25:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81CE220859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AmxNCY/C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="E0k4wWIA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81CE220859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YxjB7p8xoMhPpgVwx7QpCOm8fq+yC6g+YcXhPMISfgA=; b=AmxNCY/CyTFq7J
	yXWIFjX94HWyKUoYP+Fe3WzcdYxZom2TJvUNfBAnRyUscMAufckB3TKzASlGqI1o9w9ddJ0MseeWK
	efU4uY7vTddYjXSQfBJEZ0QeMAgEfKBKdxPaDjgb1ZBmKAqQVGi+M3Oy9lp3KgxYjmJg++xFe+ft9
	pDno3gdDXc1/4NsGofufFlwkhUVxR/jg0Fi/3hhiyGZbMTIIkwnL2NRb2fZ3L0IR8VczQJsHGV+Re
	VCUjlTvsouv0YJ929jPVAaI5pewc8HCRqXM/vOwXregthSeuk8TwycMKhMqCfpBjrhqEvrNP/ONwq
	+piuUny5ku1cBqXVglSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjgWD-0000Zt-W5; Wed, 16 Jan 2019 08:25:49 +0000
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjgW8-0000ZT-Id
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 08:25:46 +0000
Received: by mail-lj1-x229.google.com with SMTP id n18-v6so4682785lji.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 00:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uqDkxs1cK0J5n5D/Lm38z/YsUnzmJKLTO8oYEyt0YFY=;
 b=E0k4wWIAep/DXJKTzNJe2uu0+PlNTmdCfA+ZT1TEBCgMxQ93DEonDclyY8AmAEpVD0
 6sKgyTWk1agI/ahwR0XIBI887BXCVe1GwLH0O4N51kibArK/lTT6COuc69HZDaxmcR90
 xq2Higmch3Byi1S9502zEf+mkCuC3iZ6tYOVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uqDkxs1cK0J5n5D/Lm38z/YsUnzmJKLTO8oYEyt0YFY=;
 b=Ytdf8O/Wy/WY6MZ2tDMPGu8EmNGw9OhirqARUPfhxUP28uiGej/rQM6TAOVlNqMh6K
 Pk9tGNH2Zj+Y1TlInEZUIXOF8e+G0mWh284GaNwB42rvC85yYDdtVD7cwg3YD16Sjog9
 2QfkEi7H0w86QcwmR++2tlpPlb0z/0arKC09pCr8Q+t2jzmZRBxaFaaLcHr5Yb+GGkEp
 AgZWlFl569DwPnXTz1X0ym0YgEX3x6DsW3P95Am4wvNGSwVvQLwXTQYdUakfzTi/rHg4
 0kSzUbY8Gfe5csej2ot70I7z488RDhFGNvYU2rw2JghHq23kcsvMxMmlDTvABBKVsGQv
 Y6HQ==
X-Gm-Message-State: AJcUukf48fwPNHN5b0FwHLtt80CmtiHmBWftBqD0jBhoFumMQQhRfKm4
 h2LMmejuyy0WPkJqkLsicUuK2xEYKjVc+2GJNCzvPw==
X-Google-Smtp-Source: ALg8bN5CMH0G4Orjr+hQDw/NibT+B8cyrQspuWvGZdLnB/87caZDqVlgaEF7PhoOyJeYurxybwbOQJ1l9krilBOgXpk=
X-Received: by 2002:a2e:9c7:: with SMTP id
 190-v6mr5352172ljj.120.1547627140630; 
 Wed, 16 Jan 2019 00:25:40 -0800 (PST)
MIME-Version: 1.0
References: <5c3cf3a4.1c69fb81.e81c0.fb80@mx.google.com>
 <20190114215926.GF11073@sirena.org.uk>
In-Reply-To: <20190114215926.GF11073@sirena.org.uk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 16 Jan 2019 09:25:28 +0100
Message-ID: <CACRpkdZwuLwEfTd+PnjvCs_WrAQyEUzT+_ToUecHS3ufJhNkeQ@mail.gmail.com>
Subject: Re: broonie-regulator/for-next boot bisection:
 v5.0-rc2-20-g61b67608c6b9 on meson8b-odroidc1
To: Mark Brown <broonie@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_002544_619500_8C4819C9 
X-CRM114-Status: UNSURE (   9.52  )
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
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "kernelci.org bot" <bot@kernelci.org>,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>, guillaume.tucker@collabora.com,
 Paul Parsons <lost.distance@yahoo.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Matt Hart <matthew.hart@linaro.org>, Philipp Zabel <philipp.zabel@gmail.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Russell King <linux@armlinux.org.uk>, Robert Jarzmik <robert.jarzmik@free.fr>,
 Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 14, 2019 at 10:59 PM Mark Brown <broonie@kernel.org> wrote:

> Linus, I'm going to revert this whole series - not sure what's gone
> wrong here but I guess we can test easily with kernelci which is good.

That's fine and I'm onto it, I am trying to create a mock system to test
the gpio-regulator so I have some confidence it's not breaking these
boards before submitting again.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
