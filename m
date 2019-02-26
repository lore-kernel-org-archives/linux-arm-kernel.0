Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD5AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 21:34:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04F8221873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 21:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R0lQKKXy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLhBP4BD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04F8221873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ah15Da2A8Uy8hmkTWedwcaykXdmyKBVdbFtbaf1w7fY=; b=R0lQKKXyovm01K
	t3iAWSQzBkOZ6/YSPPx8/CQT0//UJ0c/zVfj3geg+9NM3LlxTrh1XdjUUTbCSZmSCpmRfZ9sWpUi+
	VIm7u/od2pg78Q7CNvbA6xTZOhxILz07G5sB4UHvvCZplMrHCch3CRfMUexOodusFwtAyHz1aoTDP
	WXTFiwfpNwXAnztRtbDzs6Xvt97D3LTYljHlhNt063bKrMT7Arophs0pgvQ7JIPCGQ8nMKmZBQC/l
	GH2HuBPE3DjTi9uTWnFx1dMZ0+9fejF5bT39xDexmlvzHi0U/AWvB/UEnVpqOa3V1dsf2UYQ7EuKa
	nwUJO5pVegG8q+iitY4A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gykMv-00057T-V2; Tue, 26 Feb 2019 21:34:29 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gykMr-00057A-Rz
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 21:34:27 +0000
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2E6A2218A1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 21:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551216865;
 bh=JyaDGX3hs9RLtLz2dOXSGcTto7IId9FywDR6kkZChyE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=KLhBP4BDca/U6Yr1HD173qYXg0lBczYcTJgPWKAyKvIZlHHgRQfcURQIsyS76hlkm
 sGYCPdfU9nGPUaYcdR3LG83eVkFgo8l19pGSCwWr8XLmH+izm9UY7iMI5nwyQtM6cn
 X00qGFGDHJVtrG8e9VRXVteJwNjRSpwoKJMq0ZpY=
Received: by mail-qk1-f172.google.com with SMTP id z13so8595588qki.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 13:34:25 -0800 (PST)
X-Gm-Message-State: AHQUAuaapxcwItPQfuwPeO43pcWPSVWEoi0Nn4ZEp7oSvYeROIldxU6w
 VcugPrVm0vWbooGf9kf/kzty9dYOe+MVwh4orQ==
X-Google-Smtp-Source: AHgI3IZuDcM7Pvc1Y1u4qp0F76hvY3pHxmdySWtRxhm3/zmKveZBQuALhlestLEWggBE2Wn//2C08K7oCrc+aUouar4=
X-Received: by 2002:a37:a381:: with SMTP id m123mr1712984qke.147.1551216864323; 
 Tue, 26 Feb 2019 13:34:24 -0800 (PST)
MIME-Version: 1.0
References: <1550472539-16590-1-git-send-email-Anson.Huang@nxp.com>
 <1550472539-16590-2-git-send-email-Anson.Huang@nxp.com>
 <20190222195217.GA22194@bogus>
 <bb19470c-1590-f8dd-72e6-b382444d7902@roeck-us.net>
 <DB3PR0402MB3916912A64AF0837A9649913F5790@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <96932b3e-87f1-d8f2-95bc-0e9a8d5d45ed@roeck-us.net>
 <DB3PR0402MB391659B6A466B1D85114E9C9F57A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB391659B6A466B1D85114E9C9F57A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 26 Feb 2019 15:34:12 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJV9NxpOJi3Jh2Uk-TOmOL4rWwqZp3sodxsRinAHZ3m3w@mail.gmail.com>
Message-ID: <CAL_JsqJV9NxpOJi3Jh2Uk-TOmOL4rWwqZp3sodxsRinAHZ3m3w@mail.gmail.com>
Subject: Re: [PATCH RESEND V2 1/4] dt-bindings: fsl: scu: add watchdog binding
To: Anson Huang <anson.huang@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_133425_942654_1964B258 
X-CRM114-Status: GOOD (  34.13  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "heiko@sntech.de" <heiko@sntech.de>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 Andy Gross <andy.gross@linaro.org>, Guenter Roeck <linux@roeck-us.net>,
 dl-linux-imx <linux-imx@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "olof@lixom.net" <olof@lixom.net>,
 "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
 "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Aisheng Dong <aisheng.dong@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gU3VuLCBGZWIgMjQsIDIwMTkgYXQgODoyNiBQTSBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdA
bnhwLmNvbT4gd3JvdGU6Cj4KPiBIaSwgR3VlbnRlcgo+Cj4gQmVzdCBSZWdhcmRzIQo+IEFuc29u
IEh1YW5nCj4KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gPiBGcm9tOiBHdWVudGVy
IFJvZWNrIFttYWlsdG86Z3JvZWNrN0BnbWFpbC5jb21dIE9uIEJlaGFsZiBPZiBHdWVudGVyCj4g
PiBSb2Vjawo+ID4gU2VudDogMjAxOeW5tDLmnIgyNOaXpSAxMToyMAo+ID4gVG86IEFuc29uIEh1
YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPjsgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4K
PiA+IENjOiBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZzsKPiA+IHMu
aGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21h
aWwuY29tOwo+ID4gY2F0YWxpbi5tYXJpbmFzQGFybS5jb207IHdpbGwuZGVhY29uQGFybS5jb207
IHdpbUBsaW51eC13YXRjaGRvZy5vcmc7Cj4gPiBBaXNoZW5nIERvbmcgPGFpc2hlbmcuZG9uZ0Bu
eHAuY29tPjsgdWxmLmhhbnNzb25AbGluYXJvLm9yZzsgRGFuaWVsCj4gPiBCYWx1dGEgPGRhbmll
bC5iYWx1dGFAbnhwLmNvbT47IEFuZHkgR3Jvc3MgPGFuZHkuZ3Jvc3NAbGluYXJvLm9yZz47Cj4g
PiBob3JtcytyZW5lc2FzQHZlcmdlLm5ldC5hdTsgaGVpa29Ac250ZWNoLmRlOyBhcm5kQGFybmRi
LmRlOwo+ID4gYmpvcm4uYW5kZXJzc29uQGxpbmFyby5vcmc7IGphZ2FuQGFtYXJ1bGFzb2x1dGlv
bnMuY29tOwo+ID4gZW5yaWMuYmFsbGV0Ym9AY29sbGFib3JhLmNvbTsgbWFyYy53LmdvbnphbGV6
QGZyZWUuZnI7IG9sb2ZAbGl4b20ubmV0Owo+ID4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS0KPiA+IGtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnOyBsaW51eC13YXRjaGRvZ0B2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4
LWlteAo+ID4gPGxpbnV4LWlteEBueHAuY29tPgo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCBSRVNF
TkQgVjIgMS80XSBkdC1iaW5kaW5nczogZnNsOiBzY3U6IGFkZCB3YXRjaGRvZwo+ID4gYmluZGlu
Zwo+ID4KPiA+IE9uIDIvMjMvMTkgNzowNCBQTSwgQW5zb24gSHVhbmcgd3JvdGU6Cj4gPiA+IEhp
LCBHdWVudGVyL1JvYgo+ID4gPgo+ID4gPiBCZXN0IFJlZ2FyZHMhCj4gPiA+IEFuc29uIEh1YW5n
Cj4gPiA+Cj4gPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+ID4gPj4gRnJvbTogR3Vl
bnRlciBSb2VjayBbbWFpbHRvOmdyb2VjazdAZ21haWwuY29tXSBPbiBCZWhhbGYgT2YgR3VlbnRl
cgo+ID4gPj4gUm9lY2sKPiA+ID4+IFNlbnQ6IDIwMTnlubQy5pyIMjTml6UgMTowOAo+ID4gPj4g
VG86IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBBbnNvbiBIdWFuZwo+ID4gPGFuc29u
Lmh1YW5nQG54cC5jb20+Cj4gPiA+PiBDYzogbWFyay5ydXRsYW5kQGFybS5jb207IHNoYXduZ3Vv
QGtlcm5lbC5vcmc7Cj4gPiA+PiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0
cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsKPiA+ID4+IGNhdGFsaW4ubWFyaW5hc0Bhcm0u
Y29tOyB3aWxsLmRlYWNvbkBhcm0uY29tOyB3aW1AbGludXgtCj4gPiB3YXRjaGRvZy5vcmc7Cj4g
PiA+PiBBaXNoZW5nIERvbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPjsgdWxmLmhhbnNzb25AbGlu
YXJvLm9yZzsgRGFuaWVsCj4gPiA+PiBCYWx1dGEgPGRhbmllbC5iYWx1dGFAbnhwLmNvbT47IEFu
ZHkgR3Jvc3MgPGFuZHkuZ3Jvc3NAbGluYXJvLm9yZz47Cj4gPiA+PiBob3JtcytyZW5lc2FzQHZl
cmdlLm5ldC5hdTsgaGVpa29Ac250ZWNoLmRlOyBhcm5kQGFybmRiLmRlOwo+ID4gPj4gYmpvcm4u
YW5kZXJzc29uQGxpbmFyby5vcmc7IGphZ2FuQGFtYXJ1bGFzb2x1dGlvbnMuY29tOwo+ID4gPj4g
ZW5yaWMuYmFsbGV0Ym9AY29sbGFib3JhLmNvbTsgbWFyYy53LmdvbnphbGV6QGZyZWUuZnI7Cj4g
PiA+PiBvbG9mQGxpeG9tLm5ldDsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7Cj4gPiA+PiBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0tIGtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnOwo+ID4gPj4gbGludXgtd2F0Y2hkb2dAdmdlci5rZXJuZWwub3JnOyBkbC1saW51
eC1pbXggPGxpbnV4LWlteEBueHAuY29tPgo+ID4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCBSRVNF
TkQgVjIgMS80XSBkdC1iaW5kaW5nczogZnNsOiBzY3U6IGFkZAo+ID4gPj4gd2F0Y2hkb2cgYmlu
ZGluZwo+ID4gPj4KPiA+ID4+IE9uIDIvMjIvMTkgMTE6NTIgQU0sIFJvYiBIZXJyaW5nIHdyb3Rl
Ogo+ID4gPj4+IE9uIE1vbiwgRmViIDE4LCAyMDE5IGF0IDA2OjUzOjQ4QU0gKzAwMDAsIEFuc29u
IEh1YW5nIHdyb3RlOgo+ID4gPj4+PiBBZGQgaS5NWDhRWFAgc3lzdGVtIGNvbnRyb2xsZXIgd2F0
Y2hkb2cgYmluZGluZy4KPiA+ID4+Pj4KPiA+ID4+Pj4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVh
bmcgPEFuc29uLkh1YW5nQG54cC5jb20+Cj4gPiA+Pj4+IC0tLQo+ID4gPj4+PiBDaGFuZ2VzIHNp
bmNlIFYxOgo+ID4gPj4+PiAgLSB1cGRhdGUgZHRzIG5vZGUgbmFtZSB0byAid2F0Y2hkb2ciOwo+
ID4gPj4+PiAtLS0KPiA+ID4+Pj4gICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eHQgfCAxMAo+ID4gPj4gKysrKysrKysrKwo+ID4gPj4+
PiAgICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQo+ID4gPj4+Pgo+ID4gPj4+PiBk
aWZmIC0tZ2l0Cj4gPiA+Pj4+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Fy
bS9mcmVlc2NhbGUvZnNsLHNjdS50eHQKPiA+ID4+Pj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4dAo+ID4gPj4+PiBpbmRleCA0Yjc5
NzUxLi5mMzg4ZWM2IDEwMDY0NAo+ID4gPj4+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4dAo+ID4gPj4+PiArKysgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4dAo+
ID4gPj4+PiBAQCAtMTM2LDYgKzEzNiwxMiBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOgo+ID4gPj4+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVzb3VyY2UgaWQgZm9yIHRoZXJtYWwgZHJp
dmVyIHRvIGdldCB0ZW1wZXJhdHVyZQo+ID4gPj4gdmlhCj4gPiA+Pj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBTQ1UgSVBDLgo+ID4gPj4+Pgo+ID4gPj4+PiArV2F0Y2hkb2cgYmluZGlu
Z3MgYmFzZWQgb24gU0NVIE1lc3NhZ2UgUHJvdG9jb2wKPiA+ID4+Pj4gKy0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ID4gPj4+PiAr
Cj4gPiA+Pj4+ICtSZXF1aXJlZCBwcm9wZXJ0aWVzOgo+ID4gPj4+PiArLSBjb21wYXRpYmxlOiBz
aG91bGQgYmUgImZzbCxpbXg4cXhwLXNjLXdkdCI7Cj4gPiA+Pj4+ICsKPiA+ID4+Pj4gICAgRXhh
bXBsZSAoaW14OHF4cCk6Cj4gPiA+Pj4+ICAgIC0tLS0tLS0tLS0tLS0KPiA+ID4+Pj4gICAgbHNp
b19tdTE6IG1haWxib3hANWQxYzAwMDAgewo+ID4gPj4+PiBAQCAtMTg4LDYgKzE5NCwxMCBAQCBm
aXJtd2FyZSB7Cj4gPiA+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICB0c2Vucy1udW0gPSA8
MT47Cj4gPiA+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAjdGhlcm1hbC1zZW5zb3ItY2Vs
bHMgPSA8MT47Cj4gPiA+Pj4+ICAgICAgICAgICAgICAgICAgfTsKPiA+ID4+Pj4gKwo+ID4gPj4+
PiArICAgICAgICAgICAgICAgIHdhdGNoZG9nOiB3YXRjaGRvZyB7Cj4gPiA+Pj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImZzbCxpbXg4cXhwLXNjLXdkdCI7Cj4gPiA+
Pj4KPiA+ID4+PiBBcy1pcywgdGhlcmUncyBubyByZWFzb24gZm9yIHRoaXMgdG8gYmUgaW4gRFQu
IFRoZSBwYXJlbnQgbm9kZSdzCj4gPiA+Pj4gZHJpdmVyIGNhbiBpbnN0YW50aWF0ZSB0aGUgd2Rv
Zy4KPiA+ID4+Pgo+ID4gPj4KPiA+ID4+IEFzIHRoZSBkcml2ZXIgaXMgY3VycmVudGx5IHdyaXR0
ZW4sIHlvdSBhcmUgY29ycmVjdCwgc2luY2UgaXQgZG9lc24ndAo+ID4gPj4gYWNjZXB0IHdhdGNo
ZG9nIHRpbWVvdXQgY29uZmlndXJhdGlvbiB0aHJvdWdoIGRldmljZXRyZWUuCj4gPiA+Pgo+ID4g
Pj4gUXVlc3Rpb24gaXMgaWYgdGhhdCBpcyBpbnRlbmRlZC4gSXMgaXQgPwo+ID4gPgo+ID4gPiBJ
IGFtIGEgbGl0dGxlIGNvbmZ1c2VkLCBkbyB5b3UgbWVhbiB3ZSBubyBuZWVkIHRvIGhhdmUgIndh
dGNoZG9nIiBub2RlCj4gPiBpbiBzaWRlICJzY3UiCj4gPiA+IG5vZGU/IE9yIHdlIG5lZWQgdG8g
bW9kaWZ5IHRoZSB3YXRjaGRvZyBub2RlJ3MgY29tcGF0aWJsZSBzdHJpbmcgdG8gIgo+ID4gPiBm
c2wsaW14LXNjLXdkdCIgdG8gbWFrZSBpdCBtb3JlIGdlbmVyaWMgZm9yIG90aGVyIHBsYXRmb3Jt
cz8gSWYgeWVzLCBJIGNhbgo+ID4gcmVzZW5kIHRoZSBwYXRjaCBzZXJpZXMgdG8gbW9kaWZ5IGl0
Lgo+ID4gPgo+ID4KPiA+IEkgdGhpbmsgUm9iIHN1Z2dlc3RlZCB0aGF0IHRoZSBTQ1UgcGFyZW50
IGRyaXZlciBzaG91bGQgaW5zdGFudGlhdGUgdGhlCj4gPiB3YXRjaGRvZyB3aXRob3V0IGV4cGxp
Y2l0IHdhdGNoZG9nIG5vZGUuIFRoYXQgd291bGQgYmUgcG9zc2libGUsIGJ1dCBpdAo+ID4gY3Vy
cmVudGx5IHVzZXMKPiA+IGRldm1fb2ZfcGxhdGZvcm1fcG9wdWxhdGUoKSB0byBkbyB0aGUgaW5z
dGFudGlhdGlvbiwgYW5kIGNoYW5naW5nIHRoYXQKPiA+IHdvdWxkIGJlIGEgbWVzcy4gQmVzaWRl
cywgaXQgZG9lcyBzZW0gdG8gbWUgdGhhdCB5b3VyIHN1Z2dlc3RlZCBub2RlIHdvdWxkCj4gPiBk
ZXNjcmliZSB0aGUgaGFyZHdhcmUsIHNvIEkgYW0gbm90IHN1cmUgSSB1bmRlcnN0YW5kIHRoZSBy
ZWFzb25pbmcuCgpJdCB3b3VsZCBqdXN0IGJlIGEgY2FsbCB0byBjcmVhdGUgYSBwbGF0Zm9ybSBk
ZXZpY2UgaW5zdGVhZC4gSG93IGlzIHRoYXQgYSBtZXNzPwoKSXQncyBkZXNjcmliaW5nIGZpcm13
YXJlLiBXZSBoYXZlIERUIGZvciBkZXNjcmliaW5nIGgvdyB3ZSd2ZSBmYWlsZWQKdG8gbWFrZSBk
aXNjb3ZlcmFibGUuIFdlIHNob3VsZCBub3QgcmVwZWF0IHRoYXQgYW5kIGp1c3QgZGVzY3JpYmUK
ZmlybXdhcmUgaW4gRFQuIE1ha2UgdGhlIGZpcm13YXJlIGRpc2NvdmVyYWJsZSEgVGhvdWdoIHRo
ZXJlIGFyZSBjYXNlcwpsaWtlIGZpcm13YXJlIHByb3ZpZGVkIGNsb2NrcyB3aGVyZSB3ZSBzdGls
bCBuZWVkIHNvbWV0aGluZyBpbiBEVCwgYnV0CnRoaXMgaXMgbm90IG9uZSBvZiB0aGVtLgoKPiA+
Cj4gPiBGb3IgbXkgcGFydCBJIHJlZmVycmVkIHRvCj4gPiAgICAgICB3YXRjaGRvZ19pbml0X3Rp
bWVvdXQoaW14X3NjX3dkZCwgREVGQVVMVF9USU1FT1VULCAmcGRldi0KPiA+ID5kZXYpOyBpbiB0
aGUgZHJpdmVyLCB3aGljaCBndWFyYW50ZWVzIHRoYXQgdGhlIHRpbWVvdXQgcHJvcGVydHkgd2ls
bCBub3QgYmUKPiA+IHVzZWQgdG8gc2V0IHRoZSB0aW1lb3V0LiBBIG1vcmUgY29tbW9uIGltcGxl
bWVudGF0aW9uIHdvdWxkIGhhdmUgYmVlbgo+ID4KPiA+ICAgICAgIGlteF9zY193ZGQtPnRpbWVv
dXQgPSBERUZBVUxUX1RJTUVPVVQ7Cj4gPiAgICAgICByZXQgPSB3YXRjaGRvZ19pbml0X3RpbWVv
dXQoaW14X3NjX3dkZCwgdGltZW91dCwgJnBkZXYtPmRldik7Cj4gPgo+ID4gd2hlcmUgJ3RpbWVv
dXQnIGlzIHRoZSBtb2R1bGUgcGFyYW1ldGVyLiBXaGljaCBpcyBhY3R1YWxseSBub3QgdXNlZCBp
biB5b3VyCj4gPiBkcml2ZXIuCj4gPiBIbW0gLi4uIEkgd2Fzbid0IGNhcmVmdWwgZW5vdWdoIHdp
dGggbXkgcmV2aWV3LiBUaGUgdGltZW91dCBpbml0aWFsaXphdGlvbiBhcy0KPiA+IGlzIGRvZXNu
J3QgbWFrZSBzZW5zZS4gSSdsbCBjb21tZW50IG9uIHRoYXQgaW4gdGhlIHBhdGNoLgo+Cj4gSSB1
bmRlcnN0YW5kIG5vdywgaW4gb3VyIGNhc2VzLCBJIHdvdWxkIHN0aWxsIHByZWZlciB0byBoYXZl
IHdhdGNoZG9nIG5vZGUgdW5kZXIKPiB0aGUgU0NVIHBhcmVudCBub2RlLCBzaW5jZSB0aGVyZSBj
b3VsZCBiZSBvdGhlciBwcm9wZXJ0eSBzZXR0aW5nIGRpZmZlcmVuY2UgYmV0d2Vlbgo+IGRpZmZl
cmVudCBpLk1YIHBsYXRmb3JtcyB3aXRoIHN5c3RlbSBjb250cm9sbGVyIHdhdGNoZG9nIGluc2lk
ZSwgdXNpbmcgdGhlIFNDVSBub2RlCj4gdG8gaW5zdGFudGlhdGUgbWFrZXMgdXMgYSBsaXR0bGUg
Y29uZnVzZWQgYWJvdXQgdGhlIHdhdGNoZG9nLCBzbyBpZiBpdCBpcyBOT1QgdGhhdCBjcml0aWNh
bCwKPiBJIHRoaW5rIHdlIHNob3VsZCBrZWVwIHdhdGNoZG9nIG5vZGUuIEJ1dCB0byBtYWtlIHRo
ZSB3YXRjaGRvZyBkcml2ZXIgbW9yZSBnZW5lcmljCj4gZm9yIG90aGVyIGkuTVggcGxhdGZvcm1z
LCBJIGNoYW5nZWQgdGhlIGNvbXBhdGlibGUgc3RyaW5nIHRvICJmc2wsaW14LXNjLXdkdCIgaW4g
ZHJpdmVyLCBhbmQKPiBlYWNoIFNvQyBzaG91bGQgaGFzIGl0IGFzIGZhbGxiYWNrIGlmIGl0IGNh
biByZXVzZSB0aGlzIHdhdGNoZG9nIGRyaXZlci4KCllvdSBoYW5kbGUgZGlmZmVyZW5jZXMgYmV0
d2VlbiBTb0NzIGJ5IGhhdmluZyBzcGVjaWZpYyBjb21wYXRpYmxlcy4gU28KImZzbCxpbXgtc2Mt
d2R0IiBtb3ZlcyBpbiB0aGUgd3JvbmcgZGlyZWN0aW9uIGFzc3VtaW5nIHdlIGhhdmUgYSBub2Rl
CmluIHRoZSBmaXJzdCBwbGFjZS4KClJvYgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
