Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CED2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:11:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB979217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O6TJAjxq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="uytcb79l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB979217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ITB8PbdT3bkImw8xMt3U8TyyIAD7lThPsNSWjGchDAU=; b=O6TJAjxqEULqwb
	nNFBjN0gzDhHdp5EsUxuUS07tyaPknH4pU5xK2qaja9Dz20wZRMZeypIMGYjwhDjYbDgZUnr3dqQL
	RxsjZxesi5cQHTzLQkkFPke7jHElyrPhmYVcVty4KD5vxHpUcWa7qbYDnBmcqa3pQhvkHia4h5wa2
	9MvqP4EQfxnrDAS+TFb46TUzfyGSNVdDGd3JJ01d9JCqIwzKBzoGNKeMIPwQo73fQGWDSy3Ixsdmk
	L2IPxkDLfv6eGb0kwXIlqMJ/BZATteM9LECll4elhUyazeTVMz3DDkcoBkSlTZX0OVNcI9l7lBJWX
	40v82OzhJfWHYUP1rGFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gybaO-0006Es-DI; Tue, 26 Feb 2019 12:11:48 +0000
Received: from mail-io1-f68.google.com ([209.85.166.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybYI-0003Yx-HA
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 12:10:34 +0000
Received: by mail-io1-f68.google.com with SMTP id r136so10286284iod.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 04:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jFGSDSqsinybQJOsU/D36ElOP7a9yW2c6i9xoNwf52I=;
 b=uytcb79l5j3EcEj+DPAaQ+RSlHdaGaSy8RizIyzQocwB3bD640rLf+3nHmBtYlGbvu
 VUK9wHJAlZYg8szu5He/bcyCF9sGdXTh25dZIX78DYd/z1SmHKrnmA66Bmj/Cb0hpaDg
 CjaHLhDFEFtg3NbwFQML+Tv1JaYBLV+lTF6wA6CGYC3vQYpTlDDr2g2gMBdpBrmFy8L9
 +1hXe76F3uuGM5u99xmkbWfwlN5yIW6P80MuNzskfupz288bWD8tNA+Ja96jTqIXcWYs
 d9ZAuuqw7R8qSA5HwscMXuU8tG+RyBiNG4uu8lse3Dhg9I6F7CkTDu9lRFRGXioFNelX
 n4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jFGSDSqsinybQJOsU/D36ElOP7a9yW2c6i9xoNwf52I=;
 b=l4N/5E3JkoHbgqxIFPaNDekcrgcvntCoHhnhHB4R7SuGg/XifyiBxevlrhDg9cZrdt
 U7jXl47OGOJL3/2G9WJo1lKbujct5dsqS51Br8RxjV5H6mhbd9+yCZ8vRgrh4Pl+47g1
 bwtpMkxNyRioYpVdZ6bgTLHcZG7wA14WpY7Ndf/fCV7/gD5O16HwRGCHp2Sf+Zn/Nc55
 4xJuqQxtL+m3LStlWK9IdmL/kTnw7Px1P491Doi8cxhd4XO45JWhOLPY0m7oK01tSINs
 ucebwtTK1TLWpdTi2VB2+mI4qmrf3gaJnTPj6XubQ1TvpbwncokQibf0H2xOOUoMw96a
 uCHQ==
X-Gm-Message-State: AHQUAuZ/Ui13jH86/cId3ZDMrVTcKshFtU8SqBkwo9k/NetyxWf4t9h3
 sLnQutSQSu23mkP1kHS6NadSKQNzULGO9RXKH6jCJA==
X-Google-Smtp-Source: AHgI3IYcdQn8f0YErB1c+1z8veB6DoMZZkGSIotAr8GE0WsLAUrb/RQBbhPycEaVpHCnvImGiUbJGqo/y+jgN8J3778=
X-Received: by 2002:a5e:de05:: with SMTP id e5mr13247886iok.111.1551182977250; 
 Tue, 26 Feb 2019 04:09:37 -0800 (PST)
MIME-Version: 1.0
References: <20190204171757.32073-1-brgl@bgdev.pl>
 <20190204171757.32073-9-brgl@bgdev.pl>
 <bb0bc61a-8c2b-affa-c58a-1e7c14f9390d@ti.com>
In-Reply-To: <bb0bc61a-8c2b-affa-c58a-1e7c14f9390d@ti.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 26 Feb 2019 13:09:26 +0100
Message-ID: <CAMRc=Mf8wGNaPOxNx8xmvw5cRpA1fnRQ1-sc7iyMihcZ=Fb6dw@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] ARM: davinci: dm355: switch to using the
 clocksource driver
To: Sekhar Nori <nsekhar@ti.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_040939_370058_5199985B 
X-CRM114-Status: GOOD (  12.82  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

cHQuLCA4IGx1dCAyMDE5IG8gMTM6MzQgU2VraGFyIE5vcmkgPG5zZWtoYXJAdGkuY29tPiBuYXBp
c2HFgihhKToKPgo+IE9uIDA0LzAyLzE5IDEwOjQ3IFBNLCBCYXJ0b3N6IEdvbGFzemV3c2tpIHdy
b3RlOgo+ID4gLS8qCj4gPiAtICogVDBfQk9UOiBUaW1lciAwLCBib3R0b206ICBjbG9ja2V2ZW50
IHNvdXJjZSBmb3IgaHJ0aW1lcnMKPiA+IC0gKiBUMF9UT1A6IFRpbWVyIDAsIHRvcCAgIDogIGNs
b2Nrc291cmNlIGZvciBnZW5lcmljIHRpbWVrZWVwaW5nCj4gPiAtICogVDFfQk9UOiBUaW1lciAx
LCBib3R0b206ICAodXNlZCBieSBEU1AgaW4gVEkgRFNQTGluayBjb2RlKQo+ID4gLSAqIFQxX1RP
UDogVGltZXIgMSwgdG9wICAgOiAgPHVudXNlZD4KPgo+IERvY3VtZW50aW5nIHRoaXMgdGltZXIg
ZGl2aXNpb24gaXMgaW1wb3J0YW50IGJlY2F1c2UgRFNQIHVzYWdlIGFuZAo+IHVudXNlZCB0aW1l
cnMgYXJlIG5vdCBpbW1lZGlhdGVseSBjbGVhciBmcm9tIGtlcm5lbCBjb2RlIGFsb25lLiBDYW4g
eW91Cj4gcmV0YWluIHRoZXNlIGNvbW1lbnRzIGluIGFsbCBwYXRjaGVzIG9mIHRoaXMgc2VyaWVz
IChJIGd1ZXNzIFQwX0JPVCBldGMuCj4gdGVybWlub2xvZ3kgaXMgY2hhbmdlZCwgc28gZmVlbCBm
cmVlIHRvIGFkanVzdCB0aGUgY29tbWVudCB0ZXh0KS4KPgo+ID4gLSAqLwo+ID4gLXN0YXRpYyBz
dHJ1Y3QgZGF2aW5jaV90aW1lcl9pbmZvIGRtMzU1X3RpbWVyX2luZm8gPSB7Cj4gPiAtICAgICAu
dGltZXJzICAgICAgICAgPSBkYXZpbmNpX3RpbWVyX2luc3RhbmNlLAo+ID4gLSAgICAgLmNsb2Nr
ZXZlbnRfaWQgID0gVDBfQk9ULAo+ID4gLSAgICAgLmNsb2Nrc291cmNlX2lkID0gVDBfVE9QLAo+
ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZGF2aW5jaV90aW1lcl9jZmcgZG0zNTVfdGltZXJfY2Zn
ID0gewo+ID4gKyAgICAgLnJlZyA9IHsKPiA+ICsgICAgICAgICAgICAgLnN0YXJ0ICAgICAgICAg
ID0gREFWSU5DSV9USU1FUjBfQkFTRSwKPiA+ICsgICAgICAgICAgICAgLmVuZCAgICAgICAgICAg
ID0gREFWSU5DSV9USU1FUjBfQkFTRSArIFNaXzRLLAo+Cj4gSGVyZSBhbmQgb3RoZXIgcGxhY2Vz
IHRvbywgU1pfNEsgLSAxCj4KPiBUaGFua3MsCj4gU2VraGFyCgpJIHVzZWQgYXBwcm9wcmlhdGUg
REVGSU5FX1JFU194KCkgbWFjcm9zIGluc3RlYWQuCgpCYXJ0CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
