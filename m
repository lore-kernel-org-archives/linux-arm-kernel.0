Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E304EC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:19:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91D6F21872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P7ktNFzJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91D6F21872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tHPi69meHhcEqXpOoe91jfQ2zu8SOvYCJbbKYqyDvc4=; b=P7ktNFzJs8dkLE
	Jy97wVLXe95tyEQhd+dxAO/XLuidSDnn2cmhDb6yU4aE2U5kn9gDfMznRZ0DmnWR5xVEe3bYgfpJ1
	+8zJNOiK2y3a3Zgbm/Cf48blGnZQ3HqFKBi4QnzHSQZLJsjRzJgsnPiSkMOd1iE3pEHQBp3x6iozn
	Ef7bJ6y5Hyi+bq8TX7xI/Y/IFQIxT4NTK+h5mTJL2pXbpDXxAwNi3eLBqO2ZKrPio63r70jX5rKoc
	Xr9c9nCobRxFB/7HmzfDiaZhiEblfOflDZYm5smpd+peyLC+2Av8jLMZKrIYq0aJCsFJAyeVtm/aP
	1C378ogXo0zQfHGWClRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmd2e-0004pX-MH; Thu, 24 Jan 2019 11:19:28 +0000
Received: from mail-ed1-f46.google.com ([209.85.208.46])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmd2a-0004p9-P5
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 11:19:26 +0000
Received: by mail-ed1-f46.google.com with SMTP id f9so4245463eds.10
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 03:19:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0NqzwY66JqyLd2Ihiqe2zw22z9qsYJW34hQJda4K5CU=;
 b=UqDVP0BYLB3pm92mvSfVtw56TeRNMXeJLObQyloldMecunShdctst9uwUfkDHiJQhx
 nwIO7KuepiYyZ8s1d+kghDwW4v82FijlZ6IrUpj9n8btUV8WpFqE1QEmTY3gvHCzHjtm
 /qW+kSlGww5twbXZwLnZP3GsrjtDOFv9u8jfwt991CFctDz6f6QAPMhwS9NsR9V8yMcs
 8+uuTT+JRT1xQv/7AHnoLhZ29XNVrniZbJNyc+ZhFCOxGa52Sv7ttaxNfc96BSBeV49J
 Mfw3XTNz29ynCqDopOdFTdNzwZyAOEwKDZcK5LyNjq3shlnw0du+eP50Oxkle8KN6BG6
 CFIA==
X-Gm-Message-State: AJcUukeVqsaIhKVt2vEczNWoV/7lkGZFHWw6Q+FuP3ZVkD546k705v5N
 eHzILvSv/OqnllYSGFqkpEQHmdZj57w=
X-Google-Smtp-Source: ALg8bN4tpg27SvA8Sno6dAB3P3LPYf1aA655+k5JfhJVpcqa2qkkuaUSIG++A1xY/mDPnlZloPHbYg==
X-Received: by 2002:a17:906:4e82:: with SMTP id
 v2-v6mr5562560eju.149.1548328762697; 
 Thu, 24 Jan 2019 03:19:22 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com.
 [209.85.128.41])
 by smtp.gmail.com with ESMTPSA id n11sm10858233edn.14.2019.01.24.03.19.21
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 03:19:21 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id d15so2694893wmb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 03:19:21 -0800 (PST)
X-Received: by 2002:a1c:c008:: with SMTP id q8mr2012314wmf.99.1548328761436;
 Thu, 24 Jan 2019 03:19:21 -0800 (PST)
MIME-Version: 1.0
References: <09bd31e2-afb7-98ae-9c77-96380ec18de0@suse.de>
In-Reply-To: <09bd31e2-afb7-98ae-9c77-96380ec18de0@suse.de>
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 24 Jan 2019 19:19:08 +0800
X-Gmail-Original-Message-ID: <CAGb2v67wu9AoMnhMw-kJ4bREpfNZPKc9zSXAWpNwFhG-FmiPmQ@mail.gmail.com>
Message-ID: <CAGb2v67wu9AoMnhMw-kJ4bREpfNZPKc9zSXAWpNwFhG-FmiPmQ@mail.gmail.com>
Subject: Re: [5.0-rc3] arm64: sun50i: h6: Pine H64 uart2 vs. emac
To: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_031924_809908_7D9DCA09 
X-CRM114-Status: GOOD (  16.49  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gV2VkLCBKYW4gMjMsIDIwMTkgYXQgNzoxNiBQTSBBbmRyZWFzIEbDpHJiZXIgPGFmYWVyYmVy
QHN1c2UuZGU+IHdyb3RlOgo+Cj4gSGkgZ3V5cywKPgo+IEluIDUuMCB0aGUgUGluZSBINjQncyBF
dGhlcm5ldCBoYXMgYmVjb21lIHVzYWJsZSAodGhhbmtzIGZvciB5b3VyIHdvcmspLgo+Cj4gSSdt
IG5vdyB0cnlpbmcgdG8gdXNlIHRoZSBQaS0yIFVBUlQgcGlucyAoc3VwcG9zZWRseSBQRDE5L1BE
MjAgVUFSVDIpOwo+IGhvd2V2ZXIgdGhlIEg2IC5kdHNpIHJlc2VydmVzIHRob3NlIHBpbnMgaW4g
ZXh0X3JnbWlpX3BpbnMsIGNhdXNpbmcgYW4KPiBlcnJvci4gSWYgSSBvdmVyd3JpdGUgaXRzIHBp
bnMgcHJvcGVydHkgKHdoaWNoIGlzIGEgbGl0dGxlIGN1bWJlcnNvbWUsCj4gYW55IGNoYW5jZSB3
ZSBjYW4gc3BsaXQgdGhlbSBvZmYgaW50byBhIHNlcGFyYXRlIG5vZGU/KSBFdGhlcm5ldCBpcyBu
bwo+IGxvbmdlciB3b3JraW5nLiBJJ20gZ3Vlc3NpbmcgdGhhdCdzIHJlbGF0ZWQgdG8gTURJTy9Q
SFksIGFzIHRoZQo+IGludGVyZmFjZSBkb2VzIHNob3cgdXAsIGp1c3QgZG9lc24ndCBnZXQgdGhl
IGxpbmsgdXAuCgpDb3JyZWN0LCB0aGUgcGlucyBoYXBwZW4gdG8gYmUgdGhlIE1ESU8gZGF0YSBh
bmQgY2xvY2sgcGlucy4KCj4gSXMgaXQgbm90IHBvc3NpYmxlIHRvIHVzZSBFdGhlcm5ldCBhbmQg
R1BJTyBoZWFkZXIgYXQgdGhlIHNhbWUgdGltZSwKPiB1bmxpa2UgdGhlIG9yaWdpbmFsIFBpbmU2
NCssIG9yIGFtIEkgbWlzc2luZyBzb21lIHJlcXVpcmVkIERUIGNoYW5nZT8KCkxvb2tzIGxpa2Ug
aXQgd29uJ3QgYmUgcG9zc2libGUuIEkgc3VnZ2VzdCB1c2luZyBVQVJUMyBpbnN0ZWFkLCB3aGlj
aAphcmUgcGlucyBQRDIzL1BEMjQsIGFuZCBjb3JyZXNwb25kIHRvIHBpbnMgMzcvMzggb24gdGhl
IEdQSU8gaGVhZGVyLgoKQ2hlbll1Cgo+IFRoYW5rcywKPiBBbmRyZWFzCj4KPgo+ICAgICAgICAg
ZnJhZ21lbnRAMCB7Cj4gICAgICAgICAgICAgICAgIHJlZyA9IDwwPjsKPgo+ICAgICAgICAgICAg
ICAgICB0YXJnZXQgPSA8JnBpbz47Cj4KPiAgICAgICAgICAgICAgICAgX19vdmVybGF5X18gewo+
ICAgICAgICAgICAgICAgICAgICAgICAgIHVhcnQyX3BpbnM6IHVhcnQyLXBpbnMgewo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgcGlucyA9ICJQRDE5IiwgIlBEMjAiOwo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgZnVuY3Rpb24gPSAidWFydDIiOwo+ICAgICAgICAg
ICAgICAgICAgICAgICAgIH07Cj4gICAgICAgICAgICAgICAgIH07Cj4gICAgICAgICB9Owo+Cj4g
ICAgICAgICBmcmFnbWVudEAxIHsKPiAgICAgICAgICAgICAgICAgcmVnID0gPDE+Owo+Cj4gICAg
ICAgICAgICAgICAgIHRhcmdldCA9IDwmZXh0X3JnbWlpX3BpbnM+Owo+Cj4gICAgICAgICAgICAg
ICAgIF9fb3ZlcmxheV9fIHsKPiAgICAgICAgICAgICAgICAgICAgICAgICBwaW5zID0gIlBEMCIs
ICJQRDEiLCAiUEQyIiwgIlBEMyIsICJQRDQiLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAiUEQ1IiwgIlBENyIsICJQRDgiLCAiUEQ5IiwgIlBEMTAiLAo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAiUEQxMSIsICJQRDEyIiwgIlBEMTMiLyosICJQRDE5IiwgIlBEMjAi
Ki87Cj4gICAgICAgICAgICAgICAgIH07Cj4gICAgICAgICB9Owo+Cj4gICAgICAgICBmcmFnbWVu
dEAyIHsKPiAgICAgICAgICAgICAgICAgcmVnID0gPDI+Owo+Cj4gICAgICAgICAgICAgICAgIHRh
cmdldCA9IDwmdWFydDI+Owo+Cj4gICAgICAgICAgICAgICAgIF9fb3ZlcmxheV9fIHsKPiAgICAg
ICAgICAgICAgICAgICAgICAgICBzdGF0dXMgPSAib2theSI7Cj4gICAgICAgICAgICAgICAgICAg
ICAgICAgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsKPiAgICAgICAgICAgICAgICAgICAgICAg
ICBwaW5jdHJsLTAgPSA8JnVhcnQyX3BpbnM+Owo+ICAgICAgICAgICAgICAgICB9Owo+ICAgICAg
ICAgfTsKPgo+Cj4gLS0KPiBTVVNFIExpbnV4IEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7D
vHJuYmVyZywgR2VybWFueQo+IEdGOiBGZWxpeCBJbWVuZMO2cmZmZXIsIEphbmUgU21pdGhhcmQs
IEdyYWhhbSBOb3J0b24KPiBIUkIgMjEyODQgKEFHIE7DvHJuYmVyZykKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGlu
ZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
