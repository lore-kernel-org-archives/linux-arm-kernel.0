Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A8DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:51:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA52020880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CpvSmtbk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iYioyhIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA52020880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m+AicEOaHmV000KjrfSXKx2dhOgLxhIqyh4MTk3h9Fg=; b=CpvSmtbkP9ZWJp
	XTfDBg1j2At7M2X5BRboPDbB+cogUZIRrYbXTMKs+7Wh7o0KCNaB8v7mdVvAfrIUJdntzD4xU5DoR
	JXhJWmnCu57yEKHxPFWxFIbal9gf/ejpNW7vPt86irqgiNK37BeFjbQAJg7MlPksvbdlbpc3H4u5k
	MQRxtZRvPifyiH6ajKPdY9NQr+RT8hTbHErNsPOcKguq96/woqsS1oCwg8w5y0iJkEsRSQnyE7NqC
	6aeDmbxeoH3pCpO742aw8tOQz3cD9nRsXQ6m69VoMsTYEaWlLXNHjSV3iRpiJntjcb+GzFcjhN1gt
	roWMQkF4tpyNxnsl2uNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwk4O-0000v0-2M; Thu, 21 Feb 2019 08:51:04 +0000
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwk4K-0000uT-Ih
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 08:51:02 +0000
Received: by mail-qk1-x743.google.com with SMTP id y140so3796083qkb.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 00:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=oiS4Pjl+T75fHcgICKv+6sHcTh4gWWotX7SaWHxKgzE=;
 b=iYioyhIbgm3U5kGLRXPn6UdO1GPscv5UM4q+gsM3Yr+DevoPJmAZqHgY42JoytIrjy
 9Mx2CESaZDD4/8LKFf3btsznv+an2egdTTnohPlVkVF/WVt3USig5akbUzFXQIB+0MFE
 TZ7iwFzmmDSq6DrWhZ6f+/F9bM65sAu16OgIAwMMfLXZfoGZDFnThEt0tJTE1PPMjhtK
 ausPJvWjanbYamFaP2Py/mtdxNq//D3l7isD+27NI936JEUjH6JttbwngOkZtlbNeixP
 l/RYRdhtAm/ya4HAPakRfcFXV1REivAZq+OMV0hF2RSaOHIQP3U/E0dnrQ2X8RM6reDc
 vm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=oiS4Pjl+T75fHcgICKv+6sHcTh4gWWotX7SaWHxKgzE=;
 b=eHS3Bz6Q4pQM1+gfuEg0XllrdDGSHY5BCeovadtwYNSqS6ot7IaO1FheKjP0bFB+/6
 byHg3KrrBUFqkiEvYvADH0b9gMlWiykR9ty0iWg37oVdQY9Gw7s5209U+8G6rc1kK2s8
 KmPj+dVeege2lwYvwIhS94HKc1CmLaTKRJrCMguX+hJ+uXAJeqizvk39N+xm1xyX7DWG
 +xAlmRAVIsFR4FwU0M87lsFzKnYSiJVKnNLv4lLxZSYj+RjWNALYJYyebk8Ww0EsalPK
 dZ90pfRQT016zaAKwYK9ROYPXo4Kw0B8AUbGpyU1kvJRkRPDwnTsSvD/ng6REI0B9SZ3
 LW6w==
X-Gm-Message-State: AHQUAuZrBTSC2NyLZQLPzhtJDTgupRf/A6Wfu6pZaDiasag2/CDrjxB4
 EX4bHo2gspfgNrqRGwO8z0h30U2eDmVlN8F7hTTqig==
X-Google-Smtp-Source: AHgI3IaORCb+guUb8l9eknxSFIPRCDgo7zbGdOaV7E28QY181l50rRuou4QtYMqqFONYiZlmXvufexGd1Z+XzywNpc8=
X-Received: by 2002:a37:9442:: with SMTP id w63mr26956765qkd.109.1550739059402; 
 Thu, 21 Feb 2019 00:50:59 -0800 (PST)
MIME-Version: 1.0
References: <20190203214205.13594-1-linus.walleij@linaro.org>
 <20190203214205.13594-6-linus.walleij@linaro.org>
 <CAMpxmJWRH9+fbwyhjHe-ERjQfMCXTGzOLWeq1HJbbYXsZ14nXA@mail.gmail.com>
In-Reply-To: <CAMpxmJWRH9+fbwyhjHe-ERjQfMCXTGzOLWeq1HJbbYXsZ14nXA@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 21 Feb 2019 09:50:45 +0100
Message-ID: <CACRpkdYiLPCeLGmynPeroGD9mKeRKKbA5u-1AH0+-yOyQxZ8hQ@mail.gmail.com>
Subject: Re: [PATCH 05/17 v1] gpio: ixp4xx: Add driver for the IXP4xx GPIO
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_005100_619533_AB8132FB 
X-CRM114-Status: GOOD (  27.30  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Tim Harvey <tharvey@gateworks.com>,
 Krzysztof Halasa <khalasa@piap.pl>, Olof Johansson <olof@lixom.net>,
 Imre Kaloz <kaloz@openwrt.org>, arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQmFydG9zeiwKCnRoYW5rcyBmb3IgdGhlIHJldmlldyEKCk9uIFdlZCwgRmViIDYsIDIwMTkg
YXQgNTowNCBQTSBCYXJ0b3N6IEdvbGFzemV3c2tpCjxiZ29sYXN6ZXdza2lAYmF5bGlicmUuY29t
PiB3cm90ZToKPiBuaWVkei4sIDMgbHV0IDIwMTkgbyAyMjo0MiBMaW51cyBXYWxsZWlqIDxsaW51
cy53YWxsZWlqQGxpbmFyby5vcmc+IG5hcGlzYcWCKGEpOgooLi4uKQo+IEp1c3QgYSBuaXQsIGJ1
dCBJJ2QgYWRkIGEgbmV3bGluZSBiZXR3ZWVuIHRoZSBpbmNsdWRlcyBhbmQgdGhlIGhlYWRlci4K
PiBBbHNvOiBDKysgc3R5bGUgY29tbWVudCBmb3IgdGhlIGhlYWRlci4KCk9LCgo+ID4gKyNpbmNs
dWRlIDxsaW51eC9pcnFjaGlwL2lycS1peHA0eHguaD4KPgo+IEkgdGhpbmsgYSBuZXdsaW5lIGJl
dHdlZW4gbGludXgvIGFuZCBhc20vIGluY2x1ZGVzIGlzIGEgZ29vZCBydWxlLgoKT0sKCj4gPiAr
I2RlZmluZSBJWFA0WFhfR1BJT19HUE9VVFIgICAgIDB4MDAKPiA+ICsjZGVmaW5lIElYUDRYWF9H
UElPX0dQT0VSICAgICAgMHgwNAo+ID4gKyNkZWZpbmUgSVhQNFhYX0dQSU9fR1BJTlIgICAgICAw
eDA4Cj4gPiArI2RlZmluZSBJWFA0WFhfR1BJT19HUElTUiAgICAgIDB4MEMKPiA+ICsjZGVmaW5l
IElYUDRYWF9HUElPX0dQSVQxUiAgICAgMHgxMAo+ID4gKyNkZWZpbmUgSVhQNFhYX0dQSU9fR1BJ
VDJSICAgICAweDE0Cj4gPiArI2RlZmluZSBJWFA0WFhfR1BJT19HUENMS1IgICAgIDB4MTgKPiA+
ICsjZGVmaW5lIElYUDRYWF9HUElPX0dQREJTRUxSICAgMHgxQwo+Cj4gU2luY2UgdGhlc2UgYXJl
IHJlZ2lzdGVycyBvZmZzZXRzIC0gbWF5YmUgdGhlIHByZWZpeCBjb3VsZCBiZQo+IElYUDRYWF9H
UElPX1JFR18qIG9yIElYUDRYWF9HUElPX09GRl8qPyBJIHRoaW5rIGl0J3MgbW9yZSByZWFkYWJs
ZS4KCk9LIEkgcmVuYW1lZCB0aGVtIElYUDRYWF9SRUdfR1BPVVQgZXRjLgoKPiA+ICsjZGVmaW5l
IElYUDRYWF9HUElPX1NUWUxFX01BU0sgICAgICAgICAweDcKPgo+IEknZCB1c2UgR0VOTUFTSygy
LCAwKSBoZXJlLgoKT0sKCj4gPiArICAgICAgIC8qIENsZWFyIHRoZSBzdHlsZSBmb3IgdGhlIGFw
cHJvcHJpYXRlIHBpbiAqLwo+ID4gKyAgICAgICB2YWwgPSBfX3Jhd19yZWFkbChnLT5iYXNlICsg
aW50X3JlZyk7Cj4gPiArICAgICAgIHZhbCAmPSB+KElYUDRYWF9HUElPX1NUWUxFX01BU0sgPDwg
KGxpbmUgKiBJWFA0WFhfR1BJT19TVFlMRV9TSVpFKSk7Cj4gPiArICAgICAgIF9fcmF3X3dyaXRl
bCh2YWwsIGctPmJhc2UgKyBpbnRfcmVnKTsKPgo+IEkga25vdyB5b3UncmUgbm90IHVzaW5nIHJl
Z21hcCwgYmVjYXVzZSB0aGlzIGRyaXZlcidzIGJhc2VkIG9uCj4gZ3Bpby1tbWlvLCBidXQgSSdt
IHdvbmRlcmluZyBpZiB5b3UgY291bGQgbWF5YmUgd3JhcCB0aG9zZSB0aHJlZQo+IG9wZXJhdGlv
bnMgaW4gYSBoZWxwZXIgd3JhcHBlciBlLmcuIGl4cDR4eF91cGRhdGVfcmVnKCkgb3Igc29tZXRo
aW5nCj4gdG8gbWFrZSBpdCBlYXNpZXIgdG8gcmVhZC4gU2FtZSBiZWxvdy4KCkknbSB1bmNlcnRh
aW4gYWJvdXQgdGhhdCwgSSBmZWVsIHRoYXQga2luZCBvZiBzdHVmZiBjcmVhdGVzIGV4dHJhCnJ1
bnBhdGhzIHRoYXQgbWFrZSB0aGUgY29kZSBoYXJkIHRvIHJlYWQsIHRoZSBjb21waWxlciB3aWxs
Cm9mIGNvdXJzZSBpbmxpbmUgaXQsIGJ1dCBJIGxpa2UgdGhlIHJlYWQtbW9kaWZ5LXdyaXRlIGV4
cGxpY2l0IGluc3RlYWQKb2Ygd3JhcHBlZCBpbiBhIGZ1bmN0aW9uLgoKPiA+ICtzdGF0aWMgc3Ry
dWN0IGlycV9jaGlwIGl4cDR4eF9ncGlvX2lycWNoaXAgPSB7Cj4gPiArICAgICAgIC5uYW1lID0g
IklYUDRHUElPIiwKPiA+ICsgICAgICAgLmlycV9hY2sgPSBpeHA0eHhfZ3Bpb19pcnFfYWNrLAo+
ID4gKyAgICAgICAuaXJxX21hc2sgPSBpcnFfY2hpcF9tYXNrX3BhcmVudCwKPiA+ICsgICAgICAg
LmlycV91bm1hc2sgPSBpeHA0eHhfZ3Bpb19pcnFfdW5tYXNrLAo+ID4gKyAgICAgICAuaXJxX3Nl
dF90eXBlID0gaXhwNHh4X2dwaW9faXJxX3NldF90eXBlLAo+ID4gK307Cj4KPiBJIGFzc3VtZSB0
aGlzIGRldmljZSBjYW5ub3QgaGF2ZSBtdWx0aXBsZSBpbnN0YW5jZXMsIHNvIGl0J3Mgc2FmZSB0
bwo+IGhhdmUgYSBzdGF0aWMgaXJxY2hpcD8KClllcyB0aGVyZSBjYW4gYmUgb25seSBvbmUuCgo+
ID4gK3N0YXRpYyBpbnQgaXhwNHh4X2dwaW9fdG9faXJxKHN0cnVjdCBncGlvX2NoaXAgKmdjLCB1
bnNpZ25lZCBpbnQgb2Zmc2V0KQo+ID4gK3sKPiA+ICsgICAgICAgc3RydWN0IGl4cDR4eF9ncGlv
ICpnID0gZ3Bpb2NoaXBfZ2V0X2RhdGEoZ2MpOwo+ID4gKyAgICAgICBzdHJ1Y3QgaXJxX2Z3c3Bl
YyBmd3NwZWM7Cj4gPiArCj4gPiArICAgICAgIGZ3c3BlYy5md25vZGUgPSBnLT5md25vZGU7Cj4g
PiArICAgICAgIGZ3c3BlYy5wYXJhbV9jb3VudCA9IDI7Cj4gPiArICAgICAgIGZ3c3BlYy5wYXJh
bVswXSA9IG9mZnNldDsKPiA+ICsgICAgICAgZndzcGVjLnBhcmFtWzFdID0gSVJRX1RZUEVfTk9O
RTsKPiA+ICsKPiA+ICsgICAgICAgcmV0dXJuIGlycV9jcmVhdGVfZndzcGVjX21hcHBpbmcoJmZ3
c3BlYyk7Cj4gPiArfQo+ID4gKwo+Cj4gVGhpcyBpcyB3ZXJlIEkgc3RhcnQgdG8gc3RydWdnbGUu
IEknbSBzdGlsbCBub3QgdmVyeSB3ZWxsIHZlcnNlZCBpbgo+IGlycSBkb21haW4gaGllcmFyY2hp
ZXMgeWV0LiBZb3UgYWxyZWFkeSBleHBsYWluIHRoZSBjb25jZXB0IGluIHRoZQo+IGNvbW1pdCBt
ZXNzYWdlLCBidXQgaXQgd291bGQgYmUgZ3JlYXQgaWYgeW91IGNvdWxkIGFkZCBhIGNvbW1lbnQK
PiBkZXNjcmliaW5nIHRoZSB0ZWNobmljYWwgZGV0YWlscyBvZiBpbXBsZW1lbnRhdGlvbiBoZXJl
IGFuZCBpbiBvdGhlcgo+IHJlbGF0ZWQgY2FsbGJhY2tzLiBUaGUgd2hvbGUgZndzcGVjIHRoaW5n
eSBpcyBub3QgdmVyeSBvYnZpb3VzIGFuZCBpdAo+IHdvdWxkIHNlcnZlIGFzIGFuIGV4YW1wbGUg
Zm9yIHRoZSBmdXR1cmUuCgpJIHdyb3RlIGEgcGFyYWdyYXBoIG9mIGV4cGxhbmF0aW9ucyBidXQg
SSByZWFsaXplZCB0aGF0IEkgd2FzIGp1c3QKd3JpdGluZyBkb2N1bWVudGF0aW9uIHRoYXQgc2hv
dWxkIHJhdGhlciBiZSBpbiBpcnFkb21haW4uCk15IHBsYW4gaXMgdG8gdXBkYXRlIHRoZSBHUElP
IGRyaXZlciBkb2N1bWVudGF0aW9uIHdpdGggYQp0aG9yb3VnaCBkZXNjcmlwdGlvbiBvZiBoaWVy
YXJjaGljYWwgaXJxcyBpbnN0ZWFkLgoKPiA+ICtzdGF0aWMgaW50IGl4cDR4eF9ncGlvX2lycV9k
b21haW5fdHJhbnNsYXRlKHN0cnVjdCBpcnFfZG9tYWluICpkb21haW4sCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBpcnFfZndzcGVjICpmd3Nw
ZWMsCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2ln
bmVkIGxvbmcgKmh3aXJxLAo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB1bnNpZ25lZCBpbnQgKnR5cGUpCj4gPiArewo+ID4gKwo+ID4gKyAgICAgICAvKiBX
ZSBzdXBwb3J0IHN0YW5kYXJkIERUIHRyYW5zbGF0aW9uICovCj4gPiArICAgICAgIGlmIChpc19v
Zl9ub2RlKGZ3c3BlYy0+Zndub2RlKSAmJiBmd3NwZWMtPnBhcmFtX2NvdW50ID09IDIpIHsKPiA+
ICsgICAgICAgICAgICAgICAqaHdpcnEgPSBmd3NwZWMtPnBhcmFtWzBdOwo+ID4gKyAgICAgICAg
ICAgICAgICp0eXBlID0gZndzcGVjLT5wYXJhbVsxXTsKPiA+ICsgICAgICAgICAgICAgICByZXR1
cm4gMDsKPiA+ICsgICAgICAgfQo+Cj4gVGhpcyBsb2dpYyBpcyBhIGJpdCBub24taW50dWl0aXZl
IC0gbWF5YmUgeW91IGNvdWxkIGZpcnN0IGNoZWNrIGZvcgo+IGVycm9yIGNvbmRpdGlvbnMgYW5k
IHRoZW4gZG8gYW55IHByb2Nlc3Npbmc/CgpCcmlhbiBoYXMgY3JlYXRlZCBhIGdlbmVyaWMgdHdv
Y2VsbCB0cmFuc2xhdGlvbiBoZWxwZXIgaW4gaXJxY2hpcApmb3IgdGhpcywgc28gSSB3aWxsIHJl
ZmFjdG9yIG9uIHRvcCBvZiB0aGF0IGF0IHNvbWUgcG9pbnQgYW5kIHRoaXMKY29tcGxleGl0eSBn
b2VzIGF3YXkuCgo+IERvbid0IHlvdSBuZWVkIHRvIGRpc3Bvc2Ugb2YgdGhlIGRvbWFpbiBpbiB0
aGUgcmVtb3ZlIGNhbGxiYWNrPyBUaGV5Cj4gZG9uJ3Qgc2VlbSB0byBoYXZlIGRldm1fIHZhcmlh
bnRzIHlldC4KClRoaXMgaXMgYSBib29sIEtjb25maWcgc3ltYm9sIHNvIHRoZSBkcml2ZXIgaXMg
Y29tcGlsZWQgaW50byB0aGUga2VybmVsLgpPbmNlIHByb2JlZCwgdGhlIGlycWNoaXAvZG9tYWlu
IG5ldmVyIGdvZXMgYXdheS4gSWYgSSB0cnkgdG8gcmVtb3ZlIGl0Cml0IHdvdWxkIGp1c3QgdGFr
ZSBkb3duIHRoZSB3aG9sZSBzeXN0ZW0gd2l0aCBpdCwgc28gZXZlbiBpZiBJIHdvdWxkCmltcGxl
bWVudCBpdCBpdCB3b3VsZCBtYWtlIG5vIHNlbnNlLiBUaGVyZSBpcyBzb21ldGhpbmcgb2YgYQoi
aGFyZG5lc3MiIGluIGhvdyB0aWdodCBhbiBpcnFkb21haW4vY2hpcCBpcyBjb3VwbGVkIHRvIGEg
c3lzdGVtLAphbmQgb24gdGhpcyBzeXN0ZW0gaXQgaXMgKGN1cnJlbnRseSkgdXNlZCBmb3IgYSBs
b3Qgb2Ygc3RhdGljIGJvYXJkIGZpbGVzCmFuZCBpdCBqdXN0IGNhbid0IGdvIGF3YXkuIChUaGUg
b3Bwb3NpdGUgYmVpbmcgZS5nLiBhIFVTQiBleHBhbmRlcgpncGlvY2hpcCB3aGljaCBzaG91bGQg
bWUgYSBtb2R1bGUgYW5kIGNhbiBjb21lIGFuZCBnbyBhcyBpdApwbGVhc2UuKQoKV2UgY291bGQg
cmVjb25zaWRlciBvbmNlIGFsbCBpcyBtb3ZlZCBvdmVyIHRvIGRldmljZSB0cmVlIGFuZCBtb3Jl
CmR5bmFtaWMgdGhvdWdoLgoKWW91cnMsCkxpbnVzIFdhbGxlaWoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBs
aXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
