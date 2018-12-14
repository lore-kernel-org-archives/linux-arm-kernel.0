Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021A7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:09:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7E8A20656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R95YCscP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JHJV+sTI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E8A20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dZaiXs8Xt6qcf3YuWBM1q8LrS8gR1g7HWLZux/OUYdo=; b=R95YCscP9ktxxA
	DmbobFpks/MITO/13Cd5tK8zIA0ck0w+TXtYxQP5eQi+eH0FK92CeIiu3b1X7+AookgsLrHpYBHS5
	LheE6138GBUVyE0wIBObovFS+0z8lNiIHq9FHSF9CQi6eGAY9U8jxQ4FnFzz8BjDayKrnjgx7d6Pm
	Jit0cPa3pmQ/EWrTvmfznGF5niz9NK1lVu2h1bCmS6dBjUTgKvfwk8KbFcT9I86HWBw8fl+b+DWGy
	GZLrKOeXlXAfpv8Vn8xEcOyi2BphtO+sg0nDnI4lFipybtZJphJscqroSuhQnBfFoLyP0vN6klVLj
	hFtUfXFTaYlI+m308ohw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXp5Z-0006co-4O; Fri, 14 Dec 2018 15:09:17 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXp5V-0006cU-4f
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 15:09:14 +0000
Received: by mail-lf1-x142.google.com with SMTP id b20so4480853lfa.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 07:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9HJkJoEJFu38+CfrqHc1fTFtL2FzdTUCcigrAI+e+D8=;
 b=JHJV+sTIDsPmvWSLae9RT6hVD6yxHHzlOoXtzxY/rQHs1m6FNZf2SLstJdaBzCAATt
 a9PGbUzKOh39Cb+lw3Ks+NTMU20OU9T57/aDa2htd9ltLNEHK1yhhdBM17chnvH8vt3k
 aWj+NPB1mO2nk732H2YKPf8NYbLlSoPe17HMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9HJkJoEJFu38+CfrqHc1fTFtL2FzdTUCcigrAI+e+D8=;
 b=kDNzSiWz+bCsoghEq1LJcZqnlX+zcbQwrUHTedguDXJdDy29qX/xjpQSJmBFMW4x4A
 elZkLz6yMd6O8iRu8+Ng89UTfL+KfJ/ePIggN0gZ+nXC+cJ4erBrqoaAQjodenxM9BG4
 5VO9evi86bCDfwDMPHmG0gBy/uUj3aLcRoOTmMX+8pqav6v3lWZSLDzoJP7MfS83Najn
 AiASitwZ/Wwv51W20U3ktndl9hx7a0kWKSnasVo3ATK5CIyB5xRnD2Ls+oMGuffGuxXp
 y5uHyZQjDCZvxE5B++Nzv98AL081FSFn8IYRquN+5ZwPoLXKdwj3rlph7R6uPezP52bJ
 rNNw==
X-Gm-Message-State: AA+aEWYnxeXJup0k1CsHAvjAW/fqepCfX8i6pZN2Ay0vmiOP1XYQAjUj
 oEP/mKIy34pG9Rlpr9/ivy+A8UWb+u0Zz+4kke+/Kw==
X-Google-Smtp-Source: AFSGD/WWnyRarP5fpOx30IQcATni2S1lmgTc/9P5chwidH75ogrv6H7V+NmoqvleRKzvPk9bFTn0ASPgu6pW/YjTpN8=
X-Received: by 2002:a19:789:: with SMTP id 131mr2151344lfh.11.1544800140410;
 Fri, 14 Dec 2018 07:09:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.50931fbda5c95345087740e4c1ef5a57fdd53480.1544104801.git-series.maxime.ripard@bootlin.com>
 <3401ca7517927243f567899819e0d02eee12984f.1544104801.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <3401ca7517927243f567899819e0d02eee12984f.1544104801.git-series.maxime.ripard@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Dec 2018 16:08:48 +0100
Message-ID: <CACRpkdZi2tqrwPh9_gi19X_MME1oXehv8AOvvfJmurSb5XDYKw@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: sunxi: Deal with per-bank regulators
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_070913_176872_2B21FEB8 
X-CRM114-Status: GOOD (  17.30  )
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
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Chen-Yu Tsai <wens@csie.org>,
 =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@bootlin.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 6, 2018 at 3:02 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> The Allwinner SoCs have on most of their GPIO banks a regulator input.
>
> This issue was mainly ignored so far because either the regulator was a
> static regulator that would be providing power anyway, or the bank was used
> for a feature unsupported so far (CSI). For the odd cases, enabling it in
> the bootloader was the preferred option.
>
> However, now that we are starting to support those features, and that we
> can't really rely on the bootloader for this, we need to model those
> regulators as such in the DT.
>
> This is slightly more complicated than what it looks like, since some
> regulators will be tied to the PMIC, and in order to have access to the
> PMIC bus, you need to mux its pins, which will need the pinctrl driver,
> that needs the regulator driver to be registered. And this is how you get a
> circular dependency.
>
> In practice however, the hardware cannot fall into this case since it would
> result in a completely unusable bus. In order to avoid that circular
> dependency, we can thus get and enable the regulators at pin_request time.
> We'll then need to account for the references of all the pins of a
> particular branch to know when to put the reference, but it works pretty
> nicely once implemented.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Patch applied.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
