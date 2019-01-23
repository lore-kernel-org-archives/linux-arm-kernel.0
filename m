Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B247C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:42:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B73520861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CQt0qdcS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="eAA+fV4Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B73520861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7dtYkGvRlP5LkV6UouNCmXMHzN+CXjqPTeWzZBt1C5A=; b=CQt0qdcS29s6yh
	UjpwxyHIDXOZ0DxX4uhc3BSCKvfFbDGYAyrwfjyUJXbyrKlaNU4jdA/GYV7Fj12aUF7/M38iZ/ag/
	Ge3um9I5Ew5O1PAv0ZssVQtQGC18ac1ekwC5VcMBHEGxBhueytjz0zA0syBC2Fe/6+01PJ4doGYtR
	LtCl/XCj6jHYbf/ilnzjgwvFmk+aZtrhAtjjcEM7hubs0uYim4l8N2dLU16H3CcV6lEa5+2541IAz
	j5e5peLM6cIN3tI8NLgBifxcmNekmCmVA6oLGHt/rwzcOo/2I+r0wnfXppKztrrV2o3MKAXgETaSD
	v9WzyKRU1HxkT8+D6aug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmFzU-0006dc-27; Wed, 23 Jan 2019 10:42:40 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmFzQ-0006dG-4Y
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 10:42:37 +0000
Received: by mail-wr1-x443.google.com with SMTP id 96so1839323wrb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 02:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version:content-transfer-encoding;
 bh=H25etrGNjxSODoOpRAcSl1GwwR0jQoxSTl7MkAQp0Lw=;
 b=eAA+fV4YKIrp3jwyK1x+hfX7JYQW+IVrfyoOQAJL2Gu3LET5L+6W4Bjv74DKFprQWp
 8apqegkRh0H/CpAahX1eT29AGzxOqKyEeOOdiaNAWBSRf/clsnV3/jP508MVOLx/8bIX
 neql5Xc8bw3diGkC9QSpbchHU9HgXiK6swI6itclCrK0XdCpX5nwYMgtX8/tVx3uWOiL
 89XpTC7E4Euu6K0xMdQbO0i1gS5g/+t+cU4+Ety7oBeOV4aXFynZny07IM3ZrQeyUd7z
 GNhkCqx1SD+U2V3PVFhZFE7fcAdmtqGsjVH0uHOEsJn3Nve7ytbtxpniNbM7DNT6JqNs
 kYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version:content-transfer-encoding;
 bh=H25etrGNjxSODoOpRAcSl1GwwR0jQoxSTl7MkAQp0Lw=;
 b=cq5yAfdqkaqNQ4UCQcP6YnTYdOqR0Y6i7+Nyk22jW5QyMLkZ0C9Dm05z8K4ZMzp0C4
 XwGcBPlOilWZw0X9DU0ZBn66J/wOYBO00Ua95RXk43l5vR22tYLlTrl5Mt9CagsPfHGy
 Zd/BSXeA6E31NapR0J02RPq0PtKz388taylebq6SV5XlwI3XltDYJK5LYR9TgErbfMDW
 0IttIoQq0xd1VXl/EjC+K6cQUojQ/76vDaC+JYONkMqsYM2CbDrB1lTeerm4mVW2avaq
 RC1HwIaRn1Hd+kMiex7scJSuoxQZ6ofOXy5GLCp61dQNIDKZCOZKg+XI52BYx/xp5J/S
 f8AQ==
X-Gm-Message-State: AJcUukc9n6XQrwjrSEMzvFuu7zkkjCHKvw0YzA8fij1gW3XhIh/pzeqH
 zNpb5inzhkWr7R+LWlVtd7IVUg==
X-Google-Smtp-Source: ALg8bN7pUoPkWMsOMCZyVFK77sAxZW3/UyzCQuPDTadSsK+YzevQF1uQh/1UUXZGYhJ5SptFvtzypQ==
X-Received: by 2002:adf:e5d0:: with SMTP id a16mr2083681wrn.89.1548240153595; 
 Wed, 23 Jan 2019 02:42:33 -0800 (PST)
Received: from localhost (aputeaux-684-1-20-21.w90-86.abo.wanadoo.fr.
 [90.86.223.21]) by smtp.googlemail.com with ESMTPSA id
 u204sm90668588wmu.30.2019.01.23.02.42.32
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 23 Jan 2019 02:42:32 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 02/17] clocksource: davinci-timer: new driver
In-Reply-To: <CAMRc=McrT4KTW45=3CTBxspVb+z8k=DDjOvKi9NH0aA9eJ8=cQ@mail.gmail.com>
References: <20190111172134.30147-1-brgl@bgdev.pl>
 <20190111172134.30147-3-brgl@bgdev.pl>
 <08200de1-fde5-c525-c874-c7872259067b@ti.com>
 <CAMRc=McrT4KTW45=3CTBxspVb+z8k=DDjOvKi9NH0aA9eJ8=cQ@mail.gmail.com>
Date: Tue, 22 Jan 2019 16:30:07 -0800
Message-ID: <7hef94z04w.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_024236_178138_7586E9C3 
X-CRM114-Status: GOOD (  20.26  )
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

QmFydG9zeiBHb2xhc3pld3NraSA8YnJnbEBiZ2Rldi5wbD4gd3JpdGVzOgoKPiBwb24uLCAxNCBz
dHkgMjAxOSBvIDEzOjIwIFNla2hhciBOb3JpIDxuc2VraGFyQHRpLmNvbT4gbmFwaXNhxYIoYSk6
Cj4+Cj4+IEhpIEJhcnRvc3osCj4+Cj4+IE9uIDExLzAxLzE5IDEwOjUxIFBNLCBCYXJ0b3N6IEdv
bGFzemV3c2tpIHdyb3RlOgo+PiA+IEZyb206IEJhcnRvc3ogR29sYXN6ZXdza2kgPGJnb2xhc3pl
d3NraUBiYXlsaWJyZS5jb20+Cj4+ID4KPj4gPiBDdXJyZW50bHkgdGhlIGNsb2Nrc291cmNlIGFu
ZCBjbG9ja2V2ZW50IHN1cHBvcnQgZm9yIGRhdmluY2kgcGxhdGZvcm1zCj4+ID4gbGl2ZXMgaW4g
bWFjaC1kYXZpbmNpLiBJdCBoYXJkLWNvZGVzIG1hbnkgdGhpbmdzLCB1c2VkIGdsb2JhbCB2YXJp
YWJsZXMsCj4+ID4gaW1wbGVtZW50cyBmdW5jdGlvbmFsaXRpZXMgdW51c2VkIGJ5IGFueSBwbGF0
Zm9ybSBhbmQgaGFzIGNvZGUgZnJhZ21lbnRzCj4+ID4gc2NhdHRlcmVkIGFjcm9zcyBtYW55IChv
ZnRlbiB1bnJlbGF0ZWQpIGZpbGVzLgo+PiA+Cj4+ID4gSW1wbGVtZW50IGEgbmV3LCBtb2Rlcm4g
YW5kIHNpbXBsaWZpZWQgdGltZXIgZHJpdmVyIGFuZCBwdXQgaXQgaW50bwo+PiA+IGRyaXZlcnMv
Y2xvY2tzb3VyY2UuIFdlIHN0aWxsIG5lZWQgdG8gc3VwcG9ydCBsZWdhY3kgYm9hcmQgZmlsZXMg
c28KPj4gPiBleHBvcnQgYSBjb25maWcgc3RydWN0dXJlIGFuZCBhIGZ1bmN0aW9uIHRoYXQgYWxs
b3dzIG1hY2hpbmUgY29kZSB0bwo+PiA+IHJlZ2lzdGVyIHRoZSB0aW1lci4KPj4gPgo+PiA+IFdl
IGRvbid0IGNoZWNrIHRoZSByZXR1cm4gdmFsdWVzIG9mIHJlZ21hcCByZWFkcyBhbmQgd3JpdGVz
IHNpbmNlIHdpdGgKPj4gPiBtbWlvIGl0J3Mgb25seSBsaWtlbHkgdG8gZmFpbCBkdWUgdG8gcHJv
Z3JhbW1lcidzIGVycm9ycy4KPj4gPgo+PiA+IFdlIGFsc28gZG9uJ3QgYm90aGVyIGZyZWVpbmcg
cmVzb3VyY2VzIG9uIGVycm9ycyBpbgo+PiA+IGRhdmluY2lfdGltZXJfcmVnaXN0ZXIoKSBhcyB0
aGUgc3lzdGVtIHdvbid0IGJvb3Qgd2l0aG91dCBhIHRpbWVyIGFueXdheS4KPj4gPgo+PiA+IFNp
Z25lZC1vZmYtYnk6IEJhcnRvc3ogR29sYXN6ZXdza2kgPGJnb2xhc3pld3NraUBiYXlsaWJyZS5j
b20+Cj4+Cj4+IFdpdGggdGhpcyBzZXJpZXMsIERBODMwIGZhaWxzIHRvIGJvb3QuIFJlc3Qgb2Yg
dGhlIGRldmljZXMgYXJlIG9rYXkgZnJvbQo+PiBib290IHBlcnNwZWN0aXZlLgo+Pgo+PiBEQTgz
MCBpcyBwcmV0dHkgdW5pcXVlIGJlY2F1c2UgaXQgdXNlcyB0aGUgc2FtZSB0aW1lci1oYWxmIGZv
ciBib3RoCj4+IGNsb2Nrc291cmNlIGFuZCBjbG9ja2V2ZW50LiBNYXkgYmUgeW91IGNhbiBzZXQg
dGhlIHNhbWUgY29uZmlndXJhdGlvbiBvbgo+PiB5b3VyIERBODUwIHRvIHNlZSB0aGUgc2FtZSBp
c3N1ZT8gRWxzZSwgSSB3aWxsIGVuYWJsZSBsb3ctbGV2ZWwgZGVidWcKPj4gYW5kIHRyeSB0byBw
cm92aWRlIG1vcmUgZGVidWcgZGF0YS4KPj4KPgo+IEkgY2FuJ3QgYm9vdCBkYTg1MCB3aXRoIHRo
ZSBzYW1lIGNvbmZpZyBhcyBkYTgzMCAoMHg2MCBjb21wYXJlCj4gcmVnaXN0ZXIsIGNvbXBhcmUg
aXJxIDc0KSBldmVuIHdpdGggdGhlIG9sZCB0aW1lciBjb2RlLiBKdXN0IHRvIG1ha2UKPiBzdXJl
OiBkb2VzIGRhODMwIGJvb3QgZmluZSB3aXRoIG1haW5saW5lIHY1LjAtcmMyPwo+Cj4+IFNvbWUg
bWlub3IgY29tbWVudHMgYmVsb3cgZnJvbSBxdWljayBsb29rOgo+Pgo+PiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLWRhdmluY2kuYyBiL2RyaXZlcnMvY2xvY2tzb3Vy
Y2UvdGltZXItZGF2aW5jaS5jCj4+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPj4gPiBpbmRleCAw
MDAwMDAwMDAwMDAuLjcyODJhMWZkYTgwZgo+PiA+IC0tLSAvZGV2L251bGwKPj4gPiArKysgYi9k
cml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVyLWRhdmluY2kuYwo+PiA+IEBAIC0wLDAgKzEsNDE1IEBA
Cj4+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKwo+PiA+ICsvKgo+PiA+
ICsgKiBUSSBEYVZpbmNpIGNsb2Nrc291cmNlIGRyaXZlcgo+PiA+ICsgKgo+PiA+ICsgKiBDb3B5
cmlnaHQgKEMpIDIwMTkgVGV4YXMgSW5zdHJ1bWVudHMKPj4gPiArICogQXV0aG9yOiBCYXJ0b3N6
IEdvbGFzemV3c2tpIDxiZ29sYXN6ZXdza2lAYmF5bGlicmUuY29tPgo+PiA+ICsgKiAod2l0aCBz
b21lIHBhcnRzIGFkb3B0ZWQgZnJvbSBjb2RlIGJ5IEtldmluIEhpbG1hbiA8a2hpbG1hbkBiYXls
aWJyZS5jb20+KQo+Pgo+PiBEaWQgeW91IHJlYWxseSBpbnRlbmQgR1BMIHYyIG9yIGxhdGVyPyBU
aGUgb3JpZ2luYWwgY29kZSByZWZlcnJlZCB0bwo+PiBhYm92ZSBpcyBtYXJrZWQgMi4wIG9ubHku
Cj4+Cj4KPiBJJ20gbm90IHN1cmUuIFNob3VsZCBpdCBiZSBHUEx2MiBvbmx5PyBJJ20gbm90IHdl
bGwgdmVyc2VkIHdpdGggbGljZW5zaW5nLgoKSSBndWVzcyBpdCdzIHVwIHRvIHlvdSBzaW5jZSB5
b3UncmUgdGhlIGF1dGhvciBvZiB0aGlzIG5ldywgcmV3b3JrZWQKZHJpdmVyLCBidXQgdGhlIG9y
aWdpbmFsIG9uZSBJIHdyb3RlIHdhcyBHUEx2MiBvbmx5LgoKTm90ZSBob3dldmVyIHRoYXQgdGhh
dCB0aGUgY2hvaWNlIG9mIHYyIG9ubHkgd2FzIG5vdCBvdXQgb2Ygb2JqZWN0aW9uIHRvCnYyKyBi
dXQgYmVjYXVzZSBJIHdyb3RlIHRoYXQgaW4gMjAwNywgd2hlbiB0aGVyZSB3YXMgbm8gIisiIDsp
CgpLZXZpbgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LWFybS1rZXJuZWwK
