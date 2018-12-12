Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EB6C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:53:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C262084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dsqcdPFo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e+hnAaDj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C262084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MwzC829KC0JA9rRJJZYYEn7dMeuFgclk4VIWR/xQphE=; b=dsqcdPFoWPCwPK
	I7wzyCcYIuz8jGPiRUPkHq0neucJxvP4VtxkTJyRPGLdbFuLmYfsII5E05kUX/XwIxGNo0bJjJQvq
	nHMd3nBNpJxbbplKi9dh3GsgTqEbkW+WaPz1oyY7akMusZnqE/pRMXNbaoGZggSPq1JlJ6PTgLckn
	d1TEWIUeBxTaVHo4cN0Ho8BA0DEyqqlM562yeGi4KT/ERWvbMeHBvzg2J4gZjwLPGudDxr20s7e16
	qWAWeixsE1uzQAnLmGPPBoFRJ3MuGp+Lgifm22/pra1FMFmlbO985zmXP7wupqEqPIfjnyNHFTmzs
	XXWAjljkN8ssxYDXPWsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX6p1-0004KG-Kv; Wed, 12 Dec 2018 15:53:15 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX6oy-0004JI-SN
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 15:53:14 +0000
Received: by mail-wr1-x444.google.com with SMTP id q18so18184893wrx.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 07:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=eZOkEsSD876kQAIHIKoB50hknJaF111Sooyv/HfcqUI=;
 b=e+hnAaDjI6PEZL5glA1EKOEksfwQ0LX/NBSFnrV5EqEUe5ESsAuq4IjCTDdzQyFe8w
 6i6C3RFBzN6whGlHpfVJ7fcU3JAE0OQ/PYf4utSK7fImezCNg4aqgq+Nwrs07mGjjIQT
 oLjYbhoOOsC6ovRzE/N/s18Lc32YAPFHra3xI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eZOkEsSD876kQAIHIKoB50hknJaF111Sooyv/HfcqUI=;
 b=KC1Ek/kVCy4pbYBOXZt9ks+tslzALilpye85DOEsHTZ529ozxRtb2dxgXW/kNmip8Y
 m7L3Wt6uTuleJSN2jsuicERHtIgSBDWd9SLkOE9kBEBVpCw8/AQiloKW8u0w8ixra6rN
 xMPyQUeWtj34Inc//WrFc4f+iPpgJpdnn4Gc2+djdmG3DqAUMpurDgZ98eRTHref0zxS
 sNDBlH6r+/4tYvFWXm73XQ3XOR2PwjTR/0w3JXI7UZxbWV/JShEkPsitcVnXncfND/qV
 WwcvLcGkZGf21CazqWEja9K+QxPFFACITLX1QTmUOVcdnP5jBrwDBnI4FSeJZbUBoybU
 J7Cg==
X-Gm-Message-State: AA+aEWYYyRVjB5ZYA43eei9W3JIMtzM04eQ4X9kU8QaIpb7whDrzluYg
 QHDVb2FRj5tEY2NF4Xyc/WSy3A==
X-Google-Smtp-Source: AFSGD/Wn511cQF7AvdAPj5Q5rNC7KM6tsewGV3tqpWxDYY3tIVQcvWt+ClH7A3kLWKK5tdSfWEtsnw==
X-Received: by 2002:adf:f211:: with SMTP id p17mr17510890wro.293.1544629980745; 
 Wed, 12 Dec 2018 07:53:00 -0800 (PST)
Received: from [192.168.0.40] (73.150.94.92.rev.sfr.net. [92.94.150.73])
 by smtp.googlemail.com with ESMTPSA id b12sm6256501wrt.17.2018.12.12.07.52.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Dec 2018 07:53:00 -0800 (PST)
Subject: Re: [PATCH v4 11/15] clocksource: Add clock driver for RDA8810PL SoC
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
 <20181210173550.29643-12-manivannan.sadhasivam@linaro.org>
 <0b90a179-aa4b-57f7-0874-996d5c535ea9@linaro.org>
 <20181212154748.GA28130@Mani-XPS-13-9360>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <affe5ffd-66de-526a-f568-52ad5f0c0083@linaro.org>
Date: Wed, 12 Dec 2018 16:52:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181212154748.GA28130@Mani-XPS-13-9360>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_075312_979658_95608B0D 
X-CRM114-Status: GOOD (  15.42  )
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
Cc: devicetree@vger.kernel.org, jason@lakedaemon.net, arnd@arndb.de,
 marc.zyngier@arm.com, gregkh@linuxfoundation.org, linus.walleij@linaro.org,
 linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
 linux-unisoc@lists.infradead.org, robh+dt@kernel.org,
 linux-serial@vger.kernel.org, jslaby@suse.com, olof@lixom.net,
 tglx@linutronix.de, afaerber@suse.de, linux-arm-kernel@lists.infradead.org,
 zhao_steven@263.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTIvMTIvMjAxOCAxNjo0NywgTWFuaXZhbm5hbiBTYWRoYXNpdmFtIHdyb3RlOgo+IEhpIERh
bmllbCwKPiAKPiBPbiBXZWQsIERlYyAxMiwgMjAxOCBhdCAwNDowNzo1M1BNICswMTAwLCBEYW5p
ZWwgTGV6Y2FubyB3cm90ZToKPj4gT24gMTAvMTIvMjAxOCAxODozNSwgTWFuaXZhbm5hbiBTYWRo
YXNpdmFtIHdyb3RlOgo+Pj4gQWRkIGNsb2NrIGRyaXZlciBmb3IgUkRBIE1pY3JvIFJEQTg4MTBQ
TCBTb0Mgc3VwcG9ydGluZyBPU1RJTUVSCj4+PiBhbmQgSFdUSU1FUi4KPj4+Cj4+PiBSREE4ODEw
UEwgaGFzIHR3byBpbmRlcGVuZGVudCB0aW1lcnM6IE9TVElNRVIgKDU2IGJpdCkgYW5kIEhXVElN
RVIKPj4+ICg2NCBiaXQpLiBFYWNoIHRpbWVyIHByb3ZpZGVzIG9wdGlvbmFsIGludGVycnVwdCBz
dXBwb3J0LiBJbiB0aGlzCj4+PiBkcml2ZXIsIE9TVElNRVIgaXMgdXNlZCBmb3IgY2xvY2tldmVu
dHMgYW5kIEhXVElNRVIgaXMgdXNlZCBmb3IKPj4+IGNsb2Nrc291cmNlLgo+Pj4KPj4+IFNpZ25l
ZC1vZmYtYnk6IEFuZHJlYXMgRsOkcmJlciA8YWZhZXJiZXJAc3VzZS5kZT4KPj4+IFNpZ25lZC1v
ZmYtYnk6IE1hbml2YW5uYW4gU2FkaGFzaXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFy
by5vcmc+Cj4+Cj4+IFRoZSBkcml2ZXIgbG9va3MgZ29vZCB0byBtZS4gRG8geW91IHdhbnQgbWUg
dG8gcGljayBpdCB1cCB2aWEgbXkgdHJlZT8KPj4KPiAKPiBZZXMsIHBsZWFzZSBkby4gTWFyYyBp
cyBnb2luZyB0byBwaWNrIHVwIHRoZSBpcnFjaGlwIGRyaXZlciBidXQgSSdtIG5vdAo+IHN1cmUg
YWJvdXQgdGhlIHNlcmlhbCBkcml2ZXIuIFRoZSByZXN0IG9mIHRoZSBwYXRjaGVzIGNhbiBiZSBw
aWNrZWQgdXAKPiBieSB0aGUgQVJNIG1haW50YWluZXJzIChJIG5lZWQgdG8gc2VuZCBhbm90aGVy
IHZlcnNpb24gZm9yIGRyb3BwaW5nCj4gQW5kcmVhcyBmcm9tIE1BSU5UQUlORVJTKS4KCk9rLCBh
cHBsaWVkLgoKVGhhbmtzCgogIC0tIERhbmllbAoKCi0tIAogPGh0dHA6Ly93d3cubGluYXJvLm9y
Zy8+IExpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29DcwoKRm9s
bG93IExpbmFybzogIDxodHRwOi8vd3d3LmZhY2Vib29rLmNvbS9wYWdlcy9MaW5hcm8+IEZhY2Vi
b29rIHwKPGh0dHA6Ly90d2l0dGVyLmNvbS8jIS9saW5hcm9vcmc+IFR3aXR0ZXIgfAo8aHR0cDov
L3d3dy5saW5hcm8ub3JnL2xpbmFyby1ibG9nLz4gQmxvZwoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0
CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
