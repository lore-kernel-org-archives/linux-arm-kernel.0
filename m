Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25D5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:44:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E66E217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZaKWnMDs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E66E217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bK0Y7+uXMrlj1Kor/UFA3aAknzoAEV//GL43me5yb0o=; b=ZaKWnMDsIr7AGO
	ZwHavVwq8o+P6iUAcaFB9o2izcJFKKhfET53HWN+vYpZ5R8vBvgZwbZhKnQheqNcHzvMF+7fOYiR4
	lRBQ4OsmQfQEB00lWKxW4dj/YrnmjSOaXcLKbVbG54RuJR/ikB2SmvlTuHjMatLJo+2hyfOow3ixK
	oFhuQdIwj/7EhI8I6/pUQ0Qap30cFH9xbC6XWe9QlDFctKhvle7xzrkQqcZfkTjIblBssd9+ZgciD
	Q3s61z0aw/E4SlYcELrL+XMolAfsvHh+QehlnmouaGzit7smLvsVHV8OsHPaQf7O03I1EM71p5UYq
	vIChIxTUOHIrlhzNTSuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gviHp-000559-A7; Mon, 18 Feb 2019 12:44:41 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gviHl-00054l-C6
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 12:44:38 +0000
Received: by mail-qt1-f195.google.com with SMTP id v10so18957352qtp.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 04:44:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bYusHv4P61X4zYESeYqei9+lHN1wEJOPIq88EC0Ix28=;
 b=Ubxs37QEJnXGoqAEG2Ath4aYcGZIBFjLaL/reHTGRoMVq/n0JXT8bYzceJ7AqR2r6o
 sQSUK4xolLSn7PR8Ssp7xCqlsW9o8ZufZ74+PIPd7oF8DUsY1FiTu4aa3KYKIgc3NZiX
 aKCdWAAYNGrj2zrcKlVSbzKYr9xWF2WrinVDk4VZ852Cvh96WJc+sBPmKVi0b0CmH2XK
 3RVx03yv6JUasHNK0cBK1Vk9W2mBlUma/JYxKXRU0T8NkixpMeMFqGnYQHq3sh/OQJem
 /O1UEjkj8waHaxnGxfyFN7ueJTW2WZwIZDuOyvbfMJwZOlgwLrW/6kfvz1oEoD6MPOCW
 hmzA==
X-Gm-Message-State: AHQUAubc5z7KFVhGH/N9U+OJHkAmsiFAxTTyA1FVL2x/dEDFR0jgRhZI
 D5wK3VYRlpGOpJSen01CEr6+PbteLch3QZmR+WQ=
X-Google-Smtp-Source: AHgI3IaLRhDeLDaW8RrwWTGtHVfAWW2ivOLZDAGQ3JstDzTBrVitFVIt4h7xbDWrwCbHhBENUV2HXDcT9f2SBHSPyF4=
X-Received: by 2002:ac8:33f1:: with SMTP id d46mr17814152qtb.319.1550493876252; 
 Mon, 18 Feb 2019 04:44:36 -0800 (PST)
MIME-Version: 1.0
References: <20190203214205.13594-1-linus.walleij@linaro.org>
 <20190203214205.13594-5-linus.walleij@linaro.org>
 <ffc97649-bfc2-e411-149f-cd5ed9e8c77e@arm.com>
 <CACRpkdZK7OU9rb-qw9tTjJLNvfQG-VmN_VBXUz9DPqVV11zuww@mail.gmail.com>
 <20190211221156.10036ad8@why.wild-wind.fr.eu.org> <m3k1hxvan4.fsf@t19.piap.pl>
 <CACRpkdYuvZEPzmeKo552g4DR3wxQZtw24jX3ONbmdoD_6bUSPw@mail.gmail.com>
 <CAK8P3a1Y2kLeDYKGMGpuLk8rxUxFwuPvjMRoLj-c2a8Bnwi56w@mail.gmail.com>
 <m3bm39uwvm.fsf@t19.piap.pl>
In-Reply-To: <m3bm39uwvm.fsf@t19.piap.pl>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 18 Feb 2019 13:44:19 +0100
Message-ID: <CAK8P3a0iubKdPrTO9ZxM+=0c3H8djpBw11KY-SO0Ai1Zgx3zHg@mail.gmail.com>
Subject: Re: [PATCH 04/17 v1] irqchip: Add driver for IXP4xx
To: =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_044437_409735_B3708B47 
X-CRM114-Status: GOOD (  14.59  )
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
Cc: Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>, Olof Johansson <olof@lixom.net>,
 Thomas Gleixner <tglx@linutronix.de>, Imre Kaloz <kaloz@openwrt.org>,
 Tim Harvey <tharvey@gateworks.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBGZWIgMTgsIDIwMTkgYXQgMTowMyBQTSBLcnp5c3p0b2YgSGHFgmFzYSA8a2hhbGFz
YUBwaWFwLnBsPiB3cm90ZToKPgo+IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+IHdyaXRl
czoKPgo+ID4gSSBmb3VuZCBhIGRvY3VtZW50IHRoYXQgZXhwbGFpbnMgc29tZSBvZiB0aGUgbW9y
ZSBvYnNjdXJlIGRldGFpbHMKPiA+IG9mIHRoaXMgY2hpcCAoYW1vbmcgYSBsb3Qgb2YgdGhlIGdl
bmVyYWwgY29uY2VwdHMpLCBpbiBwYXJ0aWN1bGFyIGhvdwo+ID4geW91IGNhbiBjb25maWd1cmUg
bWVtb3J5IHJlZ2lvbnMgYXMgZWl0aGVyIEJFLCBMRS1kYXRhLWNvaGVyZW50IG9yCj4gPiBMRS1h
ZGRyZXNzLWNvaGVyZW50LCBhbmQgdGhlIGJ5dGUgc3dhcCBvbiBQQ0kgZGVwZW5kaW5nIG9uIHRo
YXQ6Cj4KPiBUaGVyZSBpcyBhbHNvIGEgcHJvYmxlbSB3aXRoIGNlcnRhaW4gZGV2aWNlcyAoY2Vy
dGFpbiBvbGQgVVMgUm9ib3RpY3MKPiBhY2Nlc3Mgc2VydmVycz8pIHVzaW5nIElYUDQyNSByZXYu
IEEwLiBUaG9zZSBmaXJzdCBjaGlwcyBkb24ndCBoYXZlIHRoZQo+IExFIGRhdGEgY29oZXJlbnQg
bW9kZS4KPiBXZSAoPSB0aGUgb2ZmaWNpYWwgTGludXgga2VybmVsKSBkb24ndCB1c2UgTEUgZGF0
YSBjb2hlcmVudCBtb2RlIGF0IGFsbCwKPiB0aG91Z2ggSSBoYXZlIGhhZCBhIHBhdGNoIChub3Qg
dmVyeSBjbGVhbikgd2hpY2ggY291bGQgZG8gdGhhdC4KCkl0IGRvZXMgc291bmQgYXBwZWFsaW5n
IHRvIG1vdmUgdG8gZGF0YSBjb2hlcmVudCBtb2RlLCBzaW5jZSB0aGF0IGlzCmNsb3NlciB0byB3
aGF0IHdlIGhhdmUgZWxzZXdoZXJlLiBNYXliZSB3ZSBjYW4gZmluYWxseSB3b3JrIHRoYXQgb3V0
CmFuZCB0aGVuIGFsbG93IGEgbGl0dGxlLWVuZGlhbiBtdWx0aXBsYXRmb3JtIGNvbmZpZ3VyYXRp
b24gdG8gaW5jbHVkZQppeHA0eHguCgpJIGhhdmUgdHdvIHF1ZXN0aW9ucyBhYm91dCB0aGlzOgoK
LSBJIGhhdmUgYSB2YWd1ZSBtZW1vcnkgdGhhdCBvbmx5IHNwZWNpZmljIHJldmlzaW9ucyBhY3R1
YWxseSByZXF1aXJlCiAgdGhlIFBDSSBpbmRpcmVjdCBtb2RlLiBJcyBpdCB0aGUgc2FtZSBjaGlw
IHJldmlzaW9uIEEwIG9mIElYUDQyNQogIHRoYXQgcmVxdWlyZXMgYm90aCBwY2ktaW5kaXJlY3Qg
YW5kIGFkZHJlc3MtY29oZXJlbnQgbW9kZSwgb3IgYXJlCiAgdGhlcmUgb3RoZXIgY29tYmluYXRp
b25zPwoKLSBIb3cgbXVjaCB3b3VsZCBpdCBodXJ0IGFjdHVhbCB1c2VycyB0byBkcm9wIHN1cHBv
cnQgZm9yIGJvdGgKICBmZWF0dXJlcz8gSS5lLiBkbyB3ZSBrbm93IG9mIGFueW9uZSB1c2luZyB0
aGUgYWZmZWN0ZWQgY2hpcHMKICAoYW5kIHN0aWxsIGRvaW5nIHVwZGF0ZXMpLCBvciBhcmUgdGhl
IHJlbWFpbmluZyBpeHA0eHggc3lzdGVtcwogIGdlbmVyYWxseSB1c2luZyB0aGUgbGF0ZXIgY2hp
cCByZXZpc2lvbj8KCiAgICAgIEFybmQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
