Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F6DC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:52:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 808FA2075D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uSxXT7bK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tafc+u63"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 808FA2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UYWSh1CuLF3pyp9ul3fIGndB0UU6P7n+y2xYuGsCyEQ=; b=uSxXT7bKPhG4Bx
	tXyh81MzR3kUcFa76vFKmZSleiwpj+NRkDk6GoKeyfgN2tqur+qyyTtpIIsc49IHl095ThTgSx5ac
	KzdDYVbI/XoncHDYCpSsMWKa3QH+JBk6HL4SJSjNcNBf1eeOp59z8GQg9xOABmW29gOlbO8cOjaE8
	sb3uGY1WIEybZH2dIs1Z7GojnD8ksOIAPgs3W1bXqpjejRe75eMx2lQ6+AGRKffyxFgxrbo0clI6S
	AaXBuLf+WPzBfXcVW8RI42+VAWetgweEDUfvgpdyy68kolwbp/mWynBOgF57JZJ8T9/Ujz7g/I1yb
	q4xnXtiuk30qvAps6AuA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grOYT-0003Ng-U2; Wed, 06 Feb 2019 14:52:01 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grOYQ-0003NE-CY
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 14:52:00 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x16EosYP021591;
 Wed, 6 Feb 2019 08:50:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1549464654;
 bh=oy2ChVmX2j5Tfb7NSqZbTsnzgnMLWzokfQv3Mlcq3zs=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=tafc+u630pEqh3ivbKrNtG/Z5HwX4OZZx7WLLgDeEFYoif+YoVg2cdXjvfUNBOvwk
 PlWf88m08u8I599VasxNLUwZcNnm9yCv9SBOvz7g9GA/0/pT5dQklrm2MzoDG/muQU
 t3kOud2FIZ+Kp8yrBJkGIx7EELQUjjbbpILFPouE=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x16EosdQ084225
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Feb 2019 08:50:54 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 6
 Feb 2019 08:50:53 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 6 Feb 2019 08:50:53 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x16EooIb025225;
 Wed, 6 Feb 2019 08:50:51 -0600
Subject: Re: [PATCH 05/35] ARM: davinci: drop irq defines from
 default_priorites
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-6-brgl@bgdev.pl>
 <3038ba79-f411-9aa1-00ec-689060ed13d4@lechnology.com>
 <21c3d8cd-f767-04bc-f4d8-3001405ffd1d@ti.com>
 <CAMpxmJWU6WRK70xNN72Ke2kXi6F-uLWrCpF+K-+qKX3DcRy7uw@mail.gmail.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <9fd8f5ec-7d5f-3d05-2141-65c1b4d02c87@ti.com>
Date: Wed, 6 Feb 2019 20:20:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAMpxmJWU6WRK70xNN72Ke2kXi6F-uLWrCpF+K-+qKX3DcRy7uw@mail.gmail.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_065158_764256_C584DB1D 
X-CRM114-Status: GOOD (  20.78  )
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
Cc: David Lechner <david@lechnology.com>, Kevin Hilman <khilman@kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
 LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 arm-soc <linux-arm-kernel@lists.infradead.org>,
 Jason Cooper <jason@lakedaemon.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMDYvMDIvMTkgNzowMiBQTSwgQmFydG9zeiBHb2xhc3pld3NraSB3cm90ZToKPiDFm3IuLCA2
IGx1dCAyMDE5IG8gMTQ6MDMgU2VraGFyIE5vcmkgPG5zZWtoYXJAdGkuY29tPiBuYXBpc2HFgihh
KToKPj4KPj4gT24gMDUvMDIvMTkgMzo1MSBBTSwgRGF2aWQgTGVjaG5lciB3cm90ZToKPj4+IE9u
IDEvMzEvMTkgNzozOCBBTSwgQmFydG9zeiBHb2xhc3pld3NraSB3cm90ZToKPj4+PiBGcm9tOiBC
YXJ0b3N6IEdvbGFzemV3c2tpIDxiZ29sYXN6ZXdza2lAYmF5bGlicmUuY29tPgo+Pj4+Cj4+Pj4g
SW4gb3JkZXIgdG8gc2VsZWN0IFNQQVJTRV9JUlEgd2UgbmVlZCB0byBtYWtlIHRoZSBpbnRlcnJ1
cHQgbnVtYmVycwo+Pj4+IGR5bmFtaWMgKGF0IGxlYXN0IGF0IGJ1aWxkLXRpbWUgZm9yIHRoZSB0
b3AtbGV2ZWwgY29udHJvbGxlcikuIFRoZQo+Pj4+IGludGVycnVwdCBudW1iZXJzIGFyZSB1c2Vk
IGFzIGFycmF5IGluZGV4ZXMgZm9yIGlycSBwcmlvcml0aWVzLgo+Pj4+Cj4+Pj4gRHJvcCB0aGUg
ZGVmaW5lcyBhbmQganVzdCBpbml0aWFsaXplIHRoZSBhcnJheXMgaW4gYSBsaW5lYXIgbWFubmVy
Lgo+Pj4+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogQmFydG9zeiBHb2xhc3pld3NraSA8YmdvbGFzemV3
c2tpQGJheWxpYnJlLmNvbT4KPj4+PiAtLS0KPj4+Cj4+PiAuLi4KPj4+Cj4+Pj4gLXN0YXRpYyB1
OCBkbTM1NV9kZWZhdWx0X3ByaW9yaXRpZXNbREFWSU5DSV9OX0FJTlRDX0lSUV0gPSB7Cj4+Pj4g
LSAgICBbSVJRX0RNMzU1X0NDRENfVkRJTlQwXSAgICAgICAgPSAyLAo+Pj4+IC0gICAgW0lSUV9E
TTM1NV9DQ0RDX1ZESU5UMV0gICAgICAgID0gNiwKPj4+PiAtICAgIFtJUlFfRE0zNTVfQ0NEQ19W
RElOVDJdICAgICAgICA9IDYsCj4+Pj4gLSAgICBbSVJRX0RNMzU1X0lQSVBFX0hTVF0gICAgICAg
ID0gNiwKPj4+PiAtICAgIFtJUlFfRE0zNTVfSDNBSU5UXSAgICAgICAgPSA2LAo+Pj4+IC0gICAg
W0lSUV9ETTM1NV9JUElQRV9TRFJdICAgICAgICA9IDYsCj4+Pj4gLSAgICBbSVJRX0RNMzU1X0lQ
SVBFSUZJTlRdICAgICAgICA9IDYsCj4+Pj4gLSAgICBbSVJRX0RNMzU1X09TRElOVF0gICAgICAg
ID0gNywKPj4+PiAtICAgIFtJUlFfRE0zNTVfVkVOQ0lOVF0gICAgICAgID0gNiwKPj4+PiAtICAg
IFtJUlFfQVNRSU5UXSAgICAgICAgICAgID0gNiwKPj4+PiAtICAgIFtJUlFfSU1YSU5UXSAgICAg
ICAgICAgID0gNiwKPj4+PiAtICAgIFtJUlFfVVNCSU5UXSAgICAgICAgICAgID0gNCwKPj4+PiAt
ICAgIFtJUlFfRE0zNTVfUlRPSU5UXSAgICAgICAgPSA0LAo+Pj4+IC0gICAgW0lSUV9ETTM1NV9V
QVJUSU5UMl0gICAgICAgID0gNywKPj4+PiAtICAgIFtJUlFfRE0zNTVfVElOVDZdICAgICAgICA9
IDcsCj4+Pj4gLSAgICBbSVJRX0NDSU5UMF0gICAgICAgICAgICA9IDUsICAgIC8qIGRtYSAqLwo+
Pj4+IC0gICAgW0lSUV9DQ0VSUklOVF0gICAgICAgICAgICA9IDUsICAgIC8qIGRtYSAqLwo+Pj4+
IC0gICAgW0lSUV9UQ0VSUklOVDBdICAgICAgICAgICAgPSA1LCAgICAvKiBkbWEgKi8KPj4+PiAt
ICAgIFtJUlFfVENFUlJJTlRdICAgICAgICAgICAgPSA1LCAgICAvKiBkbWEgKi8KPj4+PiAtICAg
IFtJUlFfRE0zNTVfU1BJTlQyXzFdICAgICAgICA9IDcsCj4+Pj4gLSAgICBbSVJRX0RNMzU1X1RJ
TlQ3XSAgICAgICAgPSA0LAo+Pj4+IC0gICAgW0lSUV9ETTM1NV9TRElPSU5UMF0gICAgICAgID0g
NywKPj4+PiAtICAgIFtJUlFfTUJYSU5UXSAgICAgICAgICAgID0gNywKPj4+PiAtICAgIFtJUlFf
TUJSSU5UXSAgICAgICAgICAgID0gNywKPj4+PiAtICAgIFtJUlFfTU1DSU5UXSAgICAgICAgICAg
ID0gNywKPj4+PiAtICAgIFtJUlFfRE0zNTVfTU1DSU5UMV0gICAgICAgID0gNywKPj4+PiAtICAg
IFtJUlFfRE0zNTVfUFdNSU5UM10gICAgICAgID0gNywKPj4+PiAtICAgIFtJUlFfRERSSU5UXSAg
ICAgICAgICAgID0gNywKPj4+PiAtICAgIFtJUlFfQUVNSUZJTlRdICAgICAgICAgICAgPSA3LAo+
Pj4+IC0gICAgW0lSUV9ETTM1NV9TRElPSU5UMV0gICAgICAgID0gNCwKPj4+PiAtICAgIFtJUlFf
VElOVDBfVElOVDEyXSAgICAgICAgPSAyLCAgICAvKiBjbG9ja2V2ZW50ICovCj4+Pj4gLSAgICBb
SVJRX1RJTlQwX1RJTlQzNF0gICAgICAgID0gMiwgICAgLyogY2xvY2tzb3VyY2UgKi8KPj4+PiAt
ICAgIFtJUlFfVElOVDFfVElOVDEyXSAgICAgICAgPSA3LCAgICAvKiBEU1AgdGltZXIgKi8KPj4+
PiAtICAgIFtJUlFfVElOVDFfVElOVDM0XSAgICAgICAgPSA3LCAgICAvKiBzeXN0ZW0gdGljayAq
Lwo+Pj4+IC0gICAgW0lSUV9QV01JTlQwXSAgICAgICAgICAgID0gNywKPj4+PiAtICAgIFtJUlFf
UFdNSU5UMV0gICAgICAgICAgICA9IDcsCj4+Pj4gLSAgICBbSVJRX1BXTUlOVDJdICAgICAgICAg
ICAgPSA3LAo+Pj4+IC0gICAgW0lSUV9JMkNdICAgICAgICAgICAgPSAzLAo+Pj4+IC0gICAgW0lS
UV9VQVJUSU5UMF0gICAgICAgICAgICA9IDMsCj4+Pj4gLSAgICBbSVJRX1VBUlRJTlQxXSAgICAg
ICAgICAgID0gMywKPj4+PiAtICAgIFtJUlFfRE0zNTVfU1BJTlQwXzBdICAgICAgICA9IDMsCj4+
Pj4gLSAgICBbSVJRX0RNMzU1X1NQSU5UMF8xXSAgICAgICAgPSAzLAo+Pj4+IC0gICAgW0lSUV9E
TTM1NV9HUElPMF0gICAgICAgID0gMywKPj4+PiAtICAgIFtJUlFfRE0zNTVfR1BJTzFdICAgICAg
ICA9IDcsCj4+Pj4gLSAgICBbSVJRX0RNMzU1X0dQSU8yXSAgICAgICAgPSA0LAo+Pj4+IC0gICAg
W0lSUV9ETTM1NV9HUElPM10gICAgICAgID0gNCwKPj4+PiAtICAgIFtJUlFfRE0zNTVfR1BJTzRd
ICAgICAgICA9IDcsCj4+Pj4gLSAgICBbSVJRX0RNMzU1X0dQSU81XSAgICAgICAgPSA3LAo+Pj4+
IC0gICAgW0lSUV9ETTM1NV9HUElPNl0gICAgICAgID0gNywKPj4+PiAtICAgIFtJUlFfRE0zNTVf
R1BJTzddICAgICAgICA9IDcsCj4+Pj4gLSAgICBbSVJRX0RNMzU1X0dQSU84XSAgICAgICAgPSA3
LAo+Pj4+IC0gICAgW0lSUV9ETTM1NV9HUElPOV0gICAgICAgID0gNywKPj4+PiAtICAgIFtJUlFf
RE0zNTVfR1BJT0JOSzBdICAgICAgICA9IDcsCj4+Pj4gLSAgICBbSVJRX0RNMzU1X0dQSU9CTksx
XSAgICAgICAgPSA3LAo+Pj4+IC0gICAgW0lSUV9ETTM1NV9HUElPQk5LMl0gICAgICAgID0gNywK
Pj4+PiAtICAgIFtJUlFfRE0zNTVfR1BJT0JOSzNdICAgICAgICA9IDcsCj4+Pj4gLSAgICBbSVJR
X0RNMzU1X0dQSU9CTks0XSAgICAgICAgPSA3LAo+Pj4+IC0gICAgW0lSUV9ETTM1NV9HUElPQk5L
NV0gICAgICAgID0gNywKPj4+PiAtICAgIFtJUlFfRE0zNTVfR1BJT0JOSzZdICAgICAgICA9IDcs
Cj4+Pj4gLSAgICBbSVJRX0NPTU1UWF0gICAgICAgICAgICA9IDcsCj4+Pj4gLSAgICBbSVJRX0NP
TU1SWF0gICAgICAgICAgICA9IDcsCj4+Pj4gLSAgICBbSVJRX0VNVUlOVF0gICAgICAgICAgICA9
IDcsCj4+Pj4gK3N0YXRpYyB1OCBkbTM1NV9haW50Y19wcmlvc1tdID0gewo+Pj4+ICsgICAgMiwg
NiwgNiwgNiwgNiwgNiwgNiwgNywKPj4+PiArICAgIDYsIDYsIDYsIDQsIDQsIDcsIDcsIDUsCj4+
Pj4gKyAgICA1LCA1LCA1LCA3LCA0LCA3LCA3LCA3LAo+Pj4+ICsgICAgNywgNywgNywgNywgNywg
NCwgMiwgMiwKPj4+PiArICAgIDcsIDcsIDcsIDcsIDcsIDMsIDMsIDMsCj4+Pj4gKyAgICAzLCAz
LCAzLCA3LCA0LCA0LCA3LCA3LAo+Pj4+ICsgICAgNywgNywgNywgNywgNywgNywgNywgNywKPj4+
PiArICAgIDcsIDcsIDcsIDcsIDcsIDcsIDAsIDAsCj4+Pj4gICB9Owo+Pj4KPj4+IEhtbS4uLiB0
aGlzIG1ha2VzIGl0IGhhcmRlciB0byBzZWUgd2hhdCBpcyBnb2luZyBvbiBoZXJlLgo+Pj4gWW91
IGNhbiBubyBsb25nZXIgc2VlIHdoaWNoIHByaW9yaXR5IGNvcnJlc3BvbmRzIHRvIHdoaWNoCj4+
PiBJUlEgd2l0aG91dCBjb25zdWx0aW5nIGEgbWFudWFsLgo+Pgo+PiBJIGFncmVlIHdpdGggRGF2
aWQgaGVyZS4gVGhlIGludGVycnVwdCBudW1iZXJzIGFyZSBkeW5hbWljLCBidXQgdGhlCj4+IGlu
dGVycnVwdCBudW1iZXIgb2Zmc2V0IGZyb20gaGFyZHdhcmUgcG9pbnQtb2YtdmlldyBpcyBmaXhl
ZC4gU28gY2FuCj4+IHRoZXNlIG1hY3JvcyBiZSByZS1wdXJwb3NlZCB0byByZXByZXNlbnQgdGhl
IGhhcmR3YXJlIG9mZnNldCAoZXZlbnR1YWxseQo+PiB5b3Ugd291bGQgcGFzcyB0aGVtIHRvIERB
VklOQ0lfSU5UQ19JUlEoKSk/Cj4+Cj4+IFRoYW5rcywKPj4gU2VraGFyCj4gCj4gU2hvdWxkIHdl
IGtlZXAgdGhlIG1hY2gvaXJxcy5oIGhlYWRlciB0aGVuPyBXaGlsZSB3b3JraW5nIG9uIHBhdGNo
ZXMKPiBmb3Igc3VwcG9ydGluZyB0aGUgbXVsdGlfdjVfZGVmY29uZmlnIGJ1aWxkIEkgbm90aWNl
ZCB0aGUgbWFjaC8qCj4gaGVhZGVycyB0ZW5kIHRvIGNhdXNlIGJ1aWxkIHByb2JsZW1zIGluIGNl
cnRhaW4gZHJpdmVycyB0aGF0IHVzZSB0aGVtLgo+IE1vc3QgbWFjaGluZXMgaGF2ZSBnb3R0ZW4g
cmlkIG9mIHRoZW0uIFNob3VsZCB3ZSBtYXliZSBjcmVhdGUgYSBsb2NhbAo+IGhlYWRlciBpbiBt
YWNoLWRhdmluY2kvPwoKWWVzLCB3ZSBzaG91bGQgaGF2ZSBhIGxvY2FsIGhlYWRlciBpbiBtYWNo
LWRhdmluY2kuIEl0IHNob3VsZCBub3QgYmUgaW4KaW5jbHVkZS9tYWNoLyBzbyBpdCBzaG91bGQg
bm90IGJlIGV4cG9zZWQgdG8gZHJpdmVycy4KClRoYW5rcywKU2VraGFyCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxp
bmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
