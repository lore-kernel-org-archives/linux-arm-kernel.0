Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56920C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:58:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2680720878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OB3gteQU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JH+ZKmGv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2680720878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AD+sATU9pd0FX5mdU1+VULLfu9QCXnxZoTVbHHUu2Lw=; b=OB3gteQUFskIH5
	rx+2MOs3ZFertdk5fiWJ1WPMDZIriRWTeepaC/lBytweoPbb8UYwTbS/v2cjugKLvUyzivJxkNJnr
	HEsCvLKh1irgz8eUmiN6sVEM1YQrxhYxps4she+RoOhyqR8kcDBf1JAVBGSwBdiFK92DKTHIIYgJ/
	GhkNy3ZbvezvJ3GKchVypb8NELNtRJbAifl6+aLS66sVgBbgvdtfH9SR5zHYgvWcCNkZqiFNX/q4r
	htjcnepDzqEGKv+ulGt71T7lqabqwaPzPl8pVmc3uohMJI/iWoN4/E+oDQ3u72bp2eQhY/gy1CNJR
	RCDRk/f9zArpWlQMXiMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUuB4-0002lo-UJ; Thu, 06 Dec 2018 13:58:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUuAx-0002lK-TC
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 13:58:52 +0000
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B5A532151B
 for <linux-arm-kernel@lists.infradead.org>;
 Thu,  6 Dec 2018 13:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544104716;
 bh=HQXv56DLLTJ127pmhc2yxsN03JMSGpNCNg0TlzRyvuM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=JH+ZKmGvLj4IZtK8pDRwQ9SOw38KJrbJtcu6s4VG++1j7J229O1wYWPWQ47Of5DOB
 wIHA1bxnaxGc+PL63mNOlMO7doIhwBYiqyWYM84eGhsvzQ5nEHb9eU3xHVRKD36+wN
 0mdZdjJouxEFdccYW/w67YyePwmne5/5AB1FiiUw=
Received: by mail-qt1-f175.google.com with SMTP id n21so578548qtl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 05:58:36 -0800 (PST)
X-Gm-Message-State: AA+aEWYgJvFkbQrUkE8aBITVz4ZnbT8SpXR4/uUCLM3UrQisbaWRyUzf
 hMyXJ/KG8Xfo+yU5cSdlDyliR/lD5HL/9FZkEQ==
X-Google-Smtp-Source: AFSGD/XkDO6Xe8jzwXM9S3jZSjSi+DVfv7A7cR7ZA1vnXpeKroX2V0c/F8vxhJe97jZ8Od+s/5FLlNphKpWgXqHQYZU=
X-Received: by 2002:a0c:f212:: with SMTP id h18mr27977871qvk.106.1544104715781; 
 Thu, 06 Dec 2018 05:58:35 -0800 (PST)
MIME-Version: 1.0
References: <20181204183649.GA5716@bogus>
 <20181205135726.70badac7@xhacker.debian>
 <CACRpkdYs_s9m=fUuOcfqcvP5BMXity5GH17RSMyvHzdZ9aFNzA@mail.gmail.com>
 <CAL_JsqJWnB+EAoXk9a1M_D-kH8kZcwD6gTj0yVa_hBCGapB4RQ@mail.gmail.com>
 <20181206133922.4y4qnrqcjtog3ukt@pengutronix.de>
In-Reply-To: <20181206133922.4y4qnrqcjtog3ukt@pengutronix.de>
From: Rob Herring <robh@kernel.org>
Date: Thu, 6 Dec 2018 07:58:24 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+PB3Pmg1RmNqj0whapbcqRBXDNWi4LpjPqqCKeLHbR=A@mail.gmail.com>
Message-ID: <CAL_Jsq+PB3Pmg1RmNqj0whapbcqRBXDNWi4LpjPqqCKeLHbR=A@mail.gmail.com>
Subject: Re: Moving ARM dts files
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_055849_184385_8664BAF7 
X-CRM114-Status: GOOD (  13.07  )
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
 Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Michal Simek <michal.simek@xilinx.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 ARM-SoC Maintainers <arm@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andy Gross <andy.gross@linaro.org>, devicetree@vger.kernel.org,
 Jason Cooper <jason@lakedaemon.net>, Simon Horman <horms@verge.net.au>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVGh1LCBEZWMgNiwgMjAxOCBhdCA3OjM5IEFNIFV3ZSBLbGVpbmUtS8O2bmlnCjx1LmtsZWlu
ZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+IHdyb3RlOgo+Cj4gSGVsbG8sCj4KPiBPbiBXZWQsIERl
YyAwNSwgMjAxOCBhdCAwOTowMTo1OUFNIC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToKPiA+IGku
TVgyMyBpcyBhIFNpZ21hdGVsIGNoaXAgU1RNUD8/Cj4KPiBJIHRoaW5rIHRoZSBGcmVlc2NhbGUg
aS5NWDIzIGRpZG4ndCBleGlzdCBhdCBTaWdtYXRlbCBiYWNrIHRoZW4uIEFGQUlLCj4gdGhpcyBp
cyBhIG5ldyBkZXNpZ24gdXNpbmcgSVAgZnJvbSBTaWdtYXRlbCBhZnRlciB0aGUgYXF1aXNpdGlv
bi4KCkl0IGlzIG5vdC4gSSB3YXMgaW4gdGhlIGkuTVggZ3JvdXAgd2hpY2ggU2lnbWF0ZWwgd2Fz
IG1lcmdlZCBpbnRvIGF0CnRoZSB0aW1lLiBQdXJlbHkgbWFya2V0aW5nIHJlYnJhbmRpbmcuCgpS
b2IKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4
LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFy
bS1rZXJuZWwK
