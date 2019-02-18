Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D232C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 22:10:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69F2821479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 22:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g3yGTusC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yF/87ky2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F2821479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+oRstoVhMWPssN4az9Fe5ZRMfle72qYhvkJaAjZitnA=; b=g3yGTusCcyXaom
	tfiaH0BUhff3EMo7BwmlqCAiSh3Fl4BU2qsZw6jaoc7HEiPm4l5P8jZ+/OsU8RWkuWn/71X1A/zr5
	a63wp6UPrMJSIiz6c3cLS64m7z3+iDp7R1LVvWO+k14W7+0me3oKtywHBhQvscDQpVoLyqM+XoMNn
	zGdN9QTmk9IvU22ZOAiTPrH/gVoUZZKqtBY0KbHGk+Mh98psiMzIDV4XkMwdhGirpW2mqR8qKIyjp
	RjMLClGWfimnXFOGCxsRz3KEhRJ5K3AAILVJbQ1lbDgC6Khhl08ZJ8VFM+Cp8h8Y28Y5xOx3vzCGS
	r3qv4tkqAbPZRYVta9eg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvr7M-0002UM-9P; Mon, 18 Feb 2019 22:10:28 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvr7I-0002Tp-Ov
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 22:10:26 +0000
Received: by mail-wr1-x441.google.com with SMTP id l5so18932566wrw.6
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 14:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=R0bn5taxWRqUMAv5zSE5dcEH/CzEfGMqwRcpBifHjZk=;
 b=yF/87ky2TyWbt0jAxKvSMZh6Zunp8XbPFbXHvNqnk0kShaUzGrpdEZV43e7rQ0/OrK
 AIy9NRu9Pa2RysfZvxeRieokSCOI8JayQYd27VtyspOgmP/qo7KYbT5cOpw9F1r77y+s
 jMbzAqCU+oHuGfMN10BDbw4sPOtzNW1iDYy9iOmovwKAVizHCnmrjvCJMEOcsSQFfNYq
 xQZriOPTKo9fk+7qZspRPstVKFBP3vX4gs6Hk1WzUKzJ06cPkck2VyvJoobfUr3qdGK5
 KA67tWxjOvePQEiq1fWlXlPD2UTYYdVaNuXX8E/vdSEc1qnIjKLgp8j5/pMDnJlK8VbW
 9O+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=R0bn5taxWRqUMAv5zSE5dcEH/CzEfGMqwRcpBifHjZk=;
 b=Fla/SLpbxiaxnJuE/aXGj1BeDde4fdmOEqs/NsKHPNdaAiPyEg+6f9McmE/yPhgNOt
 Dn5OsD+MLdr4SwydnTuOgsN6AchqCcZJhzYT6vAmo+Dvl0wf0rB5p9hNJ0i28LWNC308
 qjdjDGqRmcQuks/rS5iPzlOGc59P6LijVieLb6zBKSTlWMH+VlZpjyTkvXO4boxjjT/D
 /s/UtpRd2SYwYRCThzouES/zs94333s0GXaT2+lTVqslV2TmF2+rAcavendNcSZd4cYA
 g7fo5IidJFkYsDXOTVY+svNUCxUwLlqjSVVNbv6zrnjGQjbjy3bnLMrWrFGVkv66YKbP
 rrGA==
X-Gm-Message-State: AHQUAubAXGukv5bzgmS0wVAwqHbAuQnCnBlN12jUZFFs3KtklqFIlpjK
 jOlE6ULPNvjw/7tVRpYHG8NLCA==
X-Google-Smtp-Source: AHgI3IbKNUejdcHnYShGALTI+xVZqLr9d0hjGxYyHQpviPJkJWPsteyfqqAc4cqRa9rrBFFrloUHeA==
X-Received: by 2002:adf:fa51:: with SMTP id y17mr19161525wrr.233.1550527821431; 
 Mon, 18 Feb 2019 14:10:21 -0800 (PST)
Received: from [192.168.0.41] (175.247.136.77.rev.sfr.net. [77.136.247.175])
 by smtp.googlemail.com with ESMTPSA id m6sm14205482wrv.24.2019.02.18.14.10.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Feb 2019 14:10:20 -0800 (PST)
Subject: Re: [PATCH 11/17 v1] clocksource/drivers/ixp4xx: Add DT bindings
To: Rob Herring <robh@kernel.org>, Linus Walleij <linus.walleij@linaro.org>
References: <20190203214205.13594-1-linus.walleij@linaro.org>
 <20190203214205.13594-12-linus.walleij@linaro.org>
 <CAL_JsqKd=93Xkp4OAu9GxMMqLrzYWTmr2rv=-NsDnqxMmSavYA@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <555a839d-3e84-9ba3-271a-4564df0f8e23@linaro.org>
Date: Mon, 18 Feb 2019 23:10:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKd=93Xkp4OAu9GxMMqLrzYWTmr2rv=-NsDnqxMmSavYA@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_141024_876677_89BDDC0B 
X-CRM114-Status: GOOD (  15.15  )
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
Cc: devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Tim Harvey <tharvey@gateworks.com>, Krzysztof Halasa <khalasa@piap.pl>,
 Olof Johansson <olof@lixom.net>, Thomas Gleixner <tglx@linutronix.de>,
 Imre Kaloz <kaloz@openwrt.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTgvMDIvMjAxOSAyMjoyNiwgUm9iIEhlcnJpbmcgd3JvdGU6Cj4gT24gU3VuLCBGZWIgMywg
MjAxOSBhdCAzOjQyIFBNIExpbnVzIFdhbGxlaWogPGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZz4g
d3JvdGU6Cj4+Cj4+IFRoaXMgYWRkcyBkZXZpY2UgdHJlZSBiaW5kaW5ncyBmb3IgdGhlIEludGVs
IElYUDR4eAo+PiB0aW1lcnMuCj4+Cj4+IENjOiBEYW5pZWwgTGV6Y2FubyA8ZGFuaWVsLmxlemNh
bm9AbGluYXJvLm9yZz4KPj4gQ2M6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRl
Pgo+PiBDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcKPj4gU2lnbmVkLW9mZi1ieTogTGlu
dXMgV2FsbGVpaiA8bGludXMud2FsbGVpakBsaW5hcm8ub3JnPgo+PiAtLS0KPj4gQ2xvY2tzb3Vy
Y2UvdGltZXIgbWFpbnRhaW5lcnM6IEkgYW0gcmVxdWVzdGluZyBhbiBBQ0sgZm9yCj4+IHRoaXMg
b25jZSB5b3UncmUgaGFwcHkgd2l0aCB0aGUgYmluZGluZ3MsIGFzIEkgaW50ZW5kIHRvCj4+IG1l
cmdlIGFsbCBvZiB0aGlzIElYUDR4eCByZXdvcmsgdGhyb3VnaCBBUk0gU29DLgo+PiAtLS0KPj4g
IC4uLi9iaW5kaW5ncy90aW1lci9pbnRlbCxpeHA0eHgtdGltZXIudHh0ICAgICAgfCAxOCArKysr
KysrKysrKysrKysrKysKPj4gIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgMSArCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKykKPj4g
IGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdGlt
ZXIvaW50ZWwsaXhwNHh4LXRpbWVyLnR4dAo+IAo+IFNhbWUgd2lzaCBhbmQgY29tbWVudHMgaGVy
ZS4uLgo+IAo+IFJldmlld2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPgoKVGhh
bmtzLAoKQWNrZWQtYnk6IERhbmllbCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3Jn
PgoKCi0tIAogPGh0dHA6Ly93d3cubGluYXJvLm9yZy8+IExpbmFyby5vcmcg4pSCIE9wZW4gc291
cmNlIHNvZnR3YXJlIGZvciBBUk0gU29DcwoKRm9sbG93IExpbmFybzogIDxodHRwOi8vd3d3LmZh
Y2Vib29rLmNvbS9wYWdlcy9MaW5hcm8+IEZhY2Vib29rIHwKPGh0dHA6Ly90d2l0dGVyLmNvbS8j
IS9saW5hcm9vcmc+IFR3aXR0ZXIgfAo8aHR0cDovL3d3dy5saW5hcm8ub3JnL2xpbmFyby1ibG9n
Lz4gQmxvZwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LWFybS1rZXJuZWwK
