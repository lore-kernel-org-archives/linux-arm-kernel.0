Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC73CC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:26:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 692C62082E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AGen05PD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EgtoxBat"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 692C62082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c9wuwxwZAQhTHJG1FYwMQqdp/LrlTw6PLNBTQyQMnKs=; b=AGen05PDnGySj7
	7wUz/+RX3QzBIufQU9SAGjSZcjnHZvQyqp08LiFzPDuoqAy9TFHQz9kt7bUe9VDtzcdiL4JUWDqxZ
	wEOyBlmrkildN/liROMiYUz4CpLpfBPa3NUHtrDiyTfrODRD2+VWZ+Unhg+26hCv8hz8KMCldOEcO
	1VemHbvwYCvmfon1AY4oNAOP+65GEqjhJww9D5jHB2ZiehqxMMzm5Y7G0VAlh1qgPI+YPnJw35RXO
	uAqypRlqo7IRCllX2bu7fZInTfS7fGE3JxC+Pxkl29C4TSlT+VNpserWkkpgjYGVTIiRThqVOD3EL
	ZiQGt4S8USIvFJEw/0Kg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqfCZ-00020d-Tm; Mon, 04 Feb 2019 14:26:23 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqfCV-0001zd-2D; Mon, 04 Feb 2019 14:26:20 +0000
Received: by mail-ot1-x341.google.com with SMTP id s13so41874otq.4;
 Mon, 04 Feb 2019 06:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IollD43OvYhJ2VvsQKvpoeNx9j8C3XLpJh0+lVUPUGc=;
 b=EgtoxBatkncqv/HDAN/qSWkqCQHcKNCcddSdKA2kbyCMKik9zg5qCwNFXYlw7fr317
 I+HhGoQ6WG/G1K1Jx6taa36T+xaz1dQCBvsyXhtjm/pAzAgXBsHhJcZ+TqAnXdR7BRGR
 h8Rr5jYo1zOMrIQGqX/y7k54nBiXsHhVPso6dkqsvv30beTCtoxtA7ufNruJc981kdwI
 sDb4Qa3BvAVi8qjHx+r8NAvaY9fxnqo21HhSVdX1wWhScQN95cDJt+YiYbjCgPrjdpO5
 +xlo5Rdgta1h1NJZPTceY9oqN53pI0DRIdpnkIx+2S1czO750y3kJ3HMdxAOGxycmid6
 0sqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IollD43OvYhJ2VvsQKvpoeNx9j8C3XLpJh0+lVUPUGc=;
 b=TzA85VKU4sZ3uHi8WgGYgSwtacEkt5h6lEcwHLrgyzd0z6pxdKjHjptx6hRLrsvoFI
 OXGwRl7h7WVfd2Dvn4bHlkjA7V/rImgxCsGuut9Q/42mao9FW3wx2Qq4CSWBkOGMDbPm
 gF5nxuqKZg/GY2ys1dZb9q+q2oCc7YdoJ6Lz4lowAzfAD+eQiFqVlkPsC1nLQPo/8n1G
 FiWM9z1NsMSIDwQAnzhhdKBsNDITMEJvPWZD3gqGORMen3EvVr1mKvE8fsiLGftaL+aj
 BOlCd1WeFP9D8SGyX1MUqB6sJlorZ93qULL0TtOsbAo68OtobOTwb+E9NIESyW3OIWJX
 mscQ==
X-Gm-Message-State: AJcUuke1FLnKkM6Cp6UqJnfTGsmV9v3kJHF1+GEQVfUtKIb0HZzFvp7p
 BOlFvYZLlXxRJSpgvn6b01vkcYvYmbiHf/4A0kQ=
X-Google-Smtp-Source: ALg8bN7/oiWRlfeJwin77wOoeLxswQW5xqEB/MpOLnN98zGcGp3m2NxXihFRkeU7g4EwuhzsvOUI07zrH+II5xAHueo=
X-Received: by 2002:a9d:6a8e:: with SMTP id l14mr36313144otq.348.1549290377710; 
 Mon, 04 Feb 2019 06:26:17 -0800 (PST)
MIME-Version: 1.0
References: <20181229143556.27339-1-martin.blumenstingl@googlemail.com>
 <20181229143556.27339-3-martin.blumenstingl@googlemail.com>
 <7hwoncov8k.fsf@baylibre.com>
In-Reply-To: <7hwoncov8k.fsf@baylibre.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 4 Feb 2019 15:26:06 +0100
Message-ID: <CAFBinCAJhiW0kLgEoPWZRshPAP=UaK2jOBCBeftjz9E+sP2YGA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ARM: dts: meson8b: fix the Ethernet data line
 signals in eth_rgmii_pins
To: Kevin Hilman <khilman@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_062619_130844_E7CFF5B8 
X-CRM114-Status: GOOD (  19.16  )
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
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 jianxin.pan@amlogic.com, ingrassia@epigenesys.com, linus.luessing@c0d3.blue
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgS2V2aW4sCgpPbiBGcmksIEphbiAxMSwgMjAxOSBhdCAyOjA5IEFNIEtldmluIEhpbG1hbiA8
a2hpbG1hbkBiYXlsaWJyZS5jb20+IHdyb3RlOgo+Cj4gTWFydGluIEJsdW1lbnN0aW5nbCA8bWFy
dGluLmJsdW1lbnN0aW5nbEBnb29nbGVtYWlsLmNvbT4gd3JpdGVzOgo+Cj4gPiBBY2NvcmRpbmcg
dG8gdGhlIE9kcm9pZC1DMSsgc2NoZW1hdGljcyB0aGUgRXRoZXJuZXQgVFhEMSBzaWduYWwgaXMK
PiA+IHJvdXRlZCB0byBHUElPSF81IGFuZCB0aGUgVFhEMCBzaWduYWwgaXMgcm91dGVkIHRvIEdQ
SU9IXzYuCj4gPiBUaGUgcHVibGljIFM4MDUgZGF0YXNoZWV0IHNob3dzIHRoYXQgVFhEMCBjYW4g
YmUgcm91dGVkIHRvIERJRl8yX1AgYW5kCj4gPiBUWEQxIGNhbiBiZSByb3V0ZWQgdG8gRElGXzJf
TiBpbnN0ZWFkLgo+ID4KPiA+IFRoZSBwaW4gZ3JvdXBzIGV0aF90eGQwXzAgKEdQSU9IXzYpIGFu
ZCBldGhfdHhkMF8xIChESUZfMl9QKSBhcmUgYm90aAo+ID4gY29uZmlndXJlZCBhcyBFdGhlcm5l
dCBUWEQwIGFuZCBUWEQxIGRhdGEgbGluZXMgaW4gbWVzb244Yi5kdHNpLiBBdCB0aGUKPiA+IHNh
bWUgdGltZSBldGhfdHhkMV8wIChHUElPSF81KSBhbmQgZXRoX3R4ZDFfMSAoRElGXzJfTikgYXJl
IGNvbmZpZ3VyZWQKPiA+IGFzIFRYRDAgYW5kIFRYRDEgZGF0YSBsaW5lcyBhcyB3ZWxsLgo+ID4g
VGhpcyByZXN1bHRzIGluIGEgYmFkIEV0aGVybmV0IHJlY2VpdmUgcGVyZm9ybWFuY2UuIFByZXN1
bWFibHkgdGhpcyBpcwo+ID4gZHVlIHRvIHRoZSBldGhfdHhkMCBhbmQgZXRoX3R4ZDEgc2lnbmFs
IGJlaW5nIHJvdXRlZCB0byB0aGUgd3JvbmcgcGlucy4KPiA+IEFzIGEgcmVzdWx0IG9mIHRoYXQg
ZGF0YSBjYW4gb25seSBiZSB0cmFuc21pdHRlZCBvbiBldGhfdHhkMiBhbmQKPiA+IGV0aF90eGQz
LiBIb3dldmVyLCBJIGhhdmUgbm8gc2NvcGUgdG8gZnVsbHkgY29uZmlybSB0aGlzIGFzc3VtcHRp
b24uCj4gPgo+ID4gVGhlIHZlbmRvciB1LWJvb3Qgc291cmNlcyBmb3IgT2Ryb2lkLUMxIHVzZSB0
aGUgZm9sbG93aW5nIEV0aGVybmV0Cj4gPiBwaW5tdXggY29uZmlndXJhdGlvbjoKPiA+ICAgU0VU
X0NCVVNfUkVHX01BU0soUEVSSVBIU19QSU5fTVVYXzYsIDB4M2Y0Zik7Cj4gPiAgIFNFVF9DQlVT
X1JFR19NQVNLKFBFUklQSFNfUElOX01VWF83LCAweGYwMDAwMCk7Cj4gPiBUaGlzIHRyYW5zbGF0
ZXMgdG8gdGhlIGZvbGxvd2luZyBwaW4gZ3JvdXBzIGluIHRoZSBtYWlubGluZSBrZXJuZWw6Cj4g
PiAtIHJlZ2lzdGVyIDYgYml0ICAwOiBldGhfcnhkMSAoRElGXzBfUCkKPiA+IC0gcmVnaXN0ZXIg
NiBiaXQgIDE6IGV0aF9yeGQwIChESUZfMF9OKQo+ID4gLSByZWdpc3RlciA2IGJpdCAgMjogZXRo
X3J4X2R2IChESUZfMV9QKQo+ID4gLSByZWdpc3RlciA2IGJpdCAgMzogZXRoX3J4X2NsayAoRElG
XzFfTikKPiA+IC0gcmVnaXN0ZXIgNiBiaXQgIDY6IGV0aF90eF9lbiAoRElGXzNfUCkKPiA+IC0g
cmVnaXN0ZXIgNiBiaXQgIDg6IGV0aF9yZWZfY2xrIChESUZfM19OKQo+ID4gLSByZWdpc3RlciA2
IGJpdCAgOTogZXRoX21kYyAoRElGXzRfUCkKPiA+IC0gcmVnaXN0ZXIgNiBiaXQgMTA6IGV0aF9t
ZGlvX2VuIChESUZfNF9OKQo+ID4gLSByZWdpc3RlciA2IGJpdCAxMTogZXRoX3R4X2NsayAoR1BJ
T0hfOSkKPiA+IC0gcmVnaXN0ZXIgNiBiaXQgMTI6IGV0aF90eGQyIChHUElPSF84KQo+ID4gLSBy
ZWdpc3RlciA2IGJpdCAxMzogZXRoX3R4ZDMgKEdQSU9IXzcpCj4gPiAtIHJlZ2lzdGVyIDcgYml0
IDIwOiBldGhfdHhkMF8wIChHUElPSF82KQo+ID4gLSByZWdpc3RlciA3IGJpdCAyMTogZXRoX3R4
ZDFfMCAoR1BJT0hfNSkKPiA+IC0gcmVnaXN0ZXIgNyBiaXQgMjI6IGV0aF9yeGQzIChESUZfMl9Q
KQo+ID4gLSByZWdpc3RlciA3IGJpdCAyMzogZXRoX3J4ZDIgKERJRl8yX04pCj4gPgo+ID4gRHJv
cCB0aGUgZXRoX3R4ZDBfMSBhbmQgZXRoX3R4ZDFfMSBncm91cHMgZnJvbSBldGhfcmdtaWlfcGlu
cyB0byBmaXggdGhlCj4gPiBFdGhlcm5ldCB0cmFuc21pdCBwZXJmb3JtYW5jZSBvbiBPZHJvaWQt
QzEuIEFsc28gYWRkIHRoZSBldGhfcnhkMiBhbmQKPiA+IGV0aF9yeGQzIGdyb3VwcyBzbyB3ZSBk
b24ndCByZWx5IG9uIHRoZSBib290bG9hZGVyIHRvIHNldCB0aGVtIHVwLgo+ID4KPiA+IGlwZXJm
MyBzdGF0aXN0aWNzIGJlZm9yZSB0aGlzIGNoYW5nZToKPiA+IC0gdHJhbnNtaXR0aW5nIGZyb20g
T2Ryb2lkLUMxOiA3NDEgTWJpdHMvc2VjICgwIHJldHJpZXMpCj4gPiAtIHJlY2VpdmluZyBvbiBP
ZHJvaWQtQzE6IDE5OSBNYml0cy9zZWMgKDE3MTMgcmV0cmllcykKPiA+Cj4gPiBpcGVyZjMgc3Rh
dGlzdGljcyBhZnRlciB0aGlzIGNoYW5nZToKPiA+IC0gdHJhbnNtaXR0aW5nIGZyb20gT2Ryb2lk
LUMxOiA2NjcgTWJpdHMvc2VjICgwIHJldHJpZXMpCj4gPiAtIHJlY2VpdmluZyBvbiBPZHJvaWQt
QzE6IDc1MCBNYml0cy9zZWMgKDAgcmV0cmllcykKPiA+Cj4gPiBGaXhlczogYjk2NDQ2NTQxZDgz
OTAgKCJBUk06IGR0czogbWVzb244YjogZXh0ZW5kIGV0aGVybmV0IGNvbnRyb2xsZXIgZGVzY3Jp
cHRpb24iKQo+ID4gU2lnbmVkLW9mZi1ieTogTWFydGluIEJsdW1lbnN0aW5nbCA8bWFydGluLmJs
dW1lbnN0aW5nbEBnb29nbGVtYWlsLmNvbT4KPiA+IENjOiBFbWlsaWFubyBJbmdyYXNzaWEgPGlu
Z3Jhc3NpYUBlcGlnZW5lc3lzLmNvbT4KPiA+IENjOiBMaW51cyBMw7xzc2luZyA8bGludXMubHVl
c3NpbmdAYzBkMy5ibHVlPgo+Cj4gUXVldWVkIGZvciB2NS4xIChicmFuY2g6IHY1LjEvZHQpCmRv
IHlvdSBrbm93IHdoYXQgaGFwcGVuZWQgdG8gdGhpcyBwYXRjaD8gSSBjYW4ndCBmaW5kIGl0IGlu
IHY1LjEvZHQKCmxldCBtZSBrbm93IGlmIEkgc2hvdWxkIHJlLXNlbmQgaXQKCgpSZWdhcmRzCk1h
cnRpbgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
YXJtLWtlcm5lbAo=
