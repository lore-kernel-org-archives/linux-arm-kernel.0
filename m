Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F09DC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:04:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C86BC2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WaOBp7MF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gD/AOMnG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C86BC2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ck0mXK0m4YD81G4W6v6Mxawt64RTX/5G26WAyMJMOBw=; b=WaOBp7MF9I6RFe
	V/WSc4rk1aXbkofYP56jRQJybexPM6uNQixYIU2WTRVBBG9l4dWqx44JczgLke8vXW91I5xyJTQ09
	vvxjZIMtdP8dVfBrZzj2cnXlkMNGyf2EdrnU78xZQbcNmXeoQfF4BApYDZlBKNwuVCOqxfzpIAqCj
	+jwHTq61MjcN7IF2AfHInslD1cadaM5k9eQk0scd//w330zMVPEMLjb164PyjEamDPvHYwTr3zqGy
	NzqKRaAjjH9+M2o0sEmTqg7p/em95DKxz4u3Kwj0Au/Sz1nV0TlK/w8lmdrquqrlM2QcDOS9EVUQL
	V+NwX02u7FO5rDWMNcAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUT6h-0004pE-OY; Wed, 05 Dec 2018 09:04:35 +0000
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUT6e-0004o4-3o
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 09:04:33 +0000
Received: by mail-lj1-x231.google.com with SMTP id v1-v6so17609777ljd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 01:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wXaZHBWuBUvUamqxVoJsvc7ZjgqJ94OBGzhkkNy0g2s=;
 b=gD/AOMnGLJy9gJ8ODKos7Ktu6s67x9S3O8S2ogl+NjInvq8gvZCWUwVasaNO1SaEuu
 ExhPSiuLN5Jgd1fnYk+brqZNBFy8K8Ye+ZI5oeacnMt3RAsofW2UhegcAyAqaHiPD2Fk
 svUBWw3jtuWl0GdxTR1BYOMpuSAtkIGCS2ny0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wXaZHBWuBUvUamqxVoJsvc7ZjgqJ94OBGzhkkNy0g2s=;
 b=kdlBn+oN7e5AvTBabwmAuKjTMPO7xz8Q9XTXAv8ESavCwiPVqdY/x9MDxp6S8Phl2i
 N+cnh83wEsmU6fRF5tdOvZZ+J/g4WZQi2JQqqxd+uBsquhZEPyqEUl/+fAgSVjO7UN/t
 OiVW1Suwhm7TMaBjtPQx5HzIDGlrXdwyTZ+BC9PgRgriHaZy/advZqZZJOs26lR0Z+z5
 uPjhzX1cYPK4dr1c0xihHjR+anQtNSgScmFjlWyoHy6QJl3bKih3xwMiRO6c4bi33Fkq
 284alsdLDjYR8ziBB1JNCjTGn6VTUPjAhQG42L7vyUr/tVZCROVMEBUy6+zoSTmA4rQ4
 q5Ew==
X-Gm-Message-State: AA+aEWY5rQ5ztzfEjQ2QsH1sdR3OOJyuBoDX8vVvmXACkt/odQn/E4Nl
 qpd+kokM1DMljmF2M4rPij70YYALyDLPMEFhfr+UaA==
X-Google-Smtp-Source: AFSGD/XrIuyRHr8vKvvy0aEilQMot5hOlAAJjsf98sLIwlE388OhH40S32MijulDy0N0dtbrc66aLBihhWr1jcuaVDU=
X-Received: by 2002:a2e:29d7:: with SMTP id
 p84-v6mr14917339ljp.12.1544000659697; 
 Wed, 05 Dec 2018 01:04:19 -0800 (PST)
MIME-Version: 1.0
References: <20181204183649.GA5716@bogus>
 <20181205135726.70badac7@xhacker.debian>
 <CACRpkdYs_s9m=fUuOcfqcvP5BMXity5GH17RSMyvHzdZ9aFNzA@mail.gmail.com>
 <20181205162941.2d8bbfaf@xhacker.debian>
In-Reply-To: <20181205162941.2d8bbfaf@xhacker.debian>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 5 Dec 2018 10:04:07 +0100
Message-ID: <CACRpkdbo2rQOPyY5UWfyKA=K9PGnXXt1=EL-VVp=NKoGjHqn5Q@mail.gmail.com>
Subject: Re: Moving ARM dts files
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_010432_158748_1DA63449 
X-CRM114-Status: GOOD (  14.94  )
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
Cc: Andrew Lunn <andrew@lunn.ch>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 ext Tony Lindgren <tony@atomide.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Kevin Hilman <khilman@kernel.org>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Michal Simek <michal.simek@xilinx.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 arm-soc <arm@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andy Gross <andy.gross@linaro.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>,
 Simon Horman <horms@verge.net.au>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 5, 2018 at 9:34 AM Jisheng Zhang
<Jisheng.Zhang@synaptics.com> wrote:
> [Me]
> > It actually makes much more sense to organize these files by
> > the SoC family name, because that doesn't change when the
> > SoC is sold to another company.
>
> If the SoC is sold to another company, then
>
> case1: The original SoC family is renamed to another family.
>
> case2: Based on the original SoC, a newer SoC family comes out.
>
> I'm not sure it's still fine to put the new or renamed SoCs' files into the
> original SoC directory.
>
> Another issue is: who will be the maintainer of new or renamed SoC family?

Of course marketing prefer to associate the acquired
company's SoC with itself and rename it.

But that doesn't account for the case where the same SoC
is produced by the new owner under the old name.

Example:
The Gemini SoC arch/arm/boot/dts/gemini-*
https://dflund.se/~triad/krad/gemini/

This SoC was produced by StorLink Semiconductor in Taiwan
early 2000s.

At some point between 2000 and 2008 the company changed
its name and/or got restructured and was renamed
Storm Semiconductor. The masks for the packaging was retained
so the chips still said "StorLink".

Then in 2008 Cortina Systems acquired Storm Semiconductor
eventually changed the masks and and renamed the identical
chips from "SLnnnn" to "CSnnnn" but the chip inside the package
was still the same.

The SoC is still codenamed "Gemini", that is the only constant.

And now we will put these devicetrees into folder...?

storlink/
storm/
cortina/

If we look at the chip packageing, it should be different
folders depending on what supplier was used when the device
was manufactured.

This is why the Vendor scheme is not really working.

Another issue is illustrated again with the Synaptics device:
an SoC produced exclusively for Synaptics (IIUC) but
with a intimate relationship to a very easily identifed SoC.

This naming nomenclature is a half-measure and a can
of worms, that is my only point.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
