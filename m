Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB38C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:13:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3324A21924
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D+4b6rLg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwEmyCcE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3324A21924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0AxtgpmUHbqC7HBCnjRUzbtgm9SdoLvTR1buz2kd9/E=; b=D+4b6rLgdFaLCr
	yJZg0C3gBPOmCAWSkeaXX2Q6fyekLqEk8QIqHjhgv9OqusOo49BDyodQdRyNrCXI3oEpKwwxGMbNT
	FE9t6ivAkzH9yRGpP+pRZXbdFhXy+KofRiimovT6sjcF63u2ILr2umkhdCcm+DKQAobzYbuzd8pkt
	tCcZCRVv+UecHd5eftdZTab0jZ+AxVtOMx0DDXRNT5vGNg/3Bf/UiZEx1kCfsfLoRDcjroDqjQ4Fu
	XLOLQr+iGtLCpLpR1Vsi94oCW8aIGsBxyQZILlQmrSanfkb5zi1vwym9BmyR+36yWg+Nu8Muu9eAp
	wvjgYpliKdUPmx6ZSXvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guknP-0006MN-ET; Fri, 15 Feb 2019 21:13:19 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guknL-0006Lp-8G
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 21:13:17 +0000
Received: by mail-pf1-x442.google.com with SMTP id h1so5395685pfo.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 13:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OQq7DubBRisUqpQdvl7Spf1SjfSR028yZWr3xtT773Q=;
 b=qwEmyCcEcJggs9dFKS3VpUqnR7AxNQo9DoJkyx2tVC3xJf3xb++BYmgbOWphUmzWgA
 VRglVLT7suUv19/0X8b23iuo+J6qtH8aG5B1S5wIHevWi7HYPYFezPatwjbvvKY4WJkV
 ax68wPd1VfDCnbzj5mfGtsiPUsx4aWHCVE+8Z2h+0aawK72toy/eVMxgwn+2cAJWrabo
 5RI92aOh3MEtEIVIn1JbyKhUVo76FPPRdoJaIducBWLtlcJoChK913mirbnP/MvqGcIP
 zeCuUFTnTtxObYM9fkcSp8fvpj5dbqR4Z8hYrpAGYE8CiGr86Q4xqX4mllfVO0Na87ok
 TNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OQq7DubBRisUqpQdvl7Spf1SjfSR028yZWr3xtT773Q=;
 b=byQ41Cxs4T/36GlZvPiuJHthQFdQMQyWGdSd2+k5ZMWEguihCi8oRrouDO7ZKe0Pkm
 d2QCI2dmPLv+/4qyU5kCM6e4pcN65jlvtO8PIwk5M9Nb9it7xXNSL4y//zLSh0qP8EAb
 /g/vs5jBFBTISa9kJqK0yrNxErbk/7BvKreBmKy1rfCPTkREj3fkSBO+q65oZqS59fAG
 Ht3jQA5IIpuVZ+p8aOvXHsSs5vFobodpzDfIk+lQ1DG9xZtumuhzypq5pVqRTZ8zHdcm
 o/fAkZuYWY22tmZcyFYt5eZmEIsrjPfU/EKfA+J3oepXyMo0h+YDgcr9bQfnIhF3h/YU
 dpVA==
X-Gm-Message-State: AHQUAuZn27XA/0ETBndfVmdyNzQJF/XalR09+L2wpB1kMMPJm8IRt3mm
 hbHWNwEE5WsnwkqMGdjtmadyokTa3btMeL5vG3c=
X-Google-Smtp-Source: AHgI3IYBKy7/khy+vprVsRRV/QeLtJ6qZiWSLpJKv75jYZj9THWmcapKlmBmQFN9Pobq19qsb+SBgjZ1IOpWAKH3n58=
X-Received: by 2002:a63:ef4c:: with SMTP id c12mr6871825pgk.84.1550265192400; 
 Fri, 15 Feb 2019 13:13:12 -0800 (PST)
MIME-Version: 1.0
References: <1550253761-26841-1-git-send-email-Frank.Li@nxp.com>
 <1550253761-26841-4-git-send-email-Frank.Li@nxp.com>
 <20190215200141.pncrzp3oaoja2mnd@pengutronix.de>
In-Reply-To: <20190215200141.pncrzp3oaoja2mnd@pengutronix.de>
From: Zhi Li <lznuaa@gmail.com>
Date: Fri, 15 Feb 2019 15:13:00 -0600
Message-ID: <CAHrpEqTexakw-OXjUt3nTdroPxv2YVjT-8VmZTUpDeF6e_dZMw@mail.gmail.com>
Subject: Re: [PATCH V4 4/4] MAINTAINERS: Added imx DDR performonitor driver
 maintainer information
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_131315_319461_A8C3C5E5 
X-CRM114-Status: GOOD (  14.31  )
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
 Aisheng Dong <aisheng.dong@nxp.com>, "festevam@gmail.com" <festevam@gmail.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Frank Li <frank.li@nxp.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCBGZWIgMTUsIDIwMTkgYXQgMjowMSBQTSBVd2UgS2xlaW5lLUvDtm5pZwo8dS5rbGVp
bmUta29lbmlnQHBlbmd1dHJvbml4LmRlPiB3cm90ZToKPgo+IE9uIEZyaSwgRmViIDE1LCAyMDE5
IGF0IDA2OjAzOjE2UE0gKzAwMDAsIEZyYW5rIExpIHdyb3RlOgo+ID4gQWRkIEREUiBwZXJmIGNv
dW50ZXIgZHJpdmVyIG1haW50YWluZXIgaW5mb3JtYXRpb24KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5
OiBGcmFuayBMaSA8RnJhbmsuTGlAbnhwLmNvbT4KPiA+IC0tLQo+ID4gTm8gY2hhbmdlIGZyb20g
djEgdG8gdjQKPiA+Cj4gPiAgTUFJTlRBSU5FUlMgfCA3ICsrKysrKysKPiA+ICAxIGZpbGUgY2hh
bmdlZCwgNyBpbnNlcnRpb25zKCspCj4gPgo+ID4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIv
TUFJTlRBSU5FUlMKPiA+IGluZGV4IDZiYTA2OGUuLjY4N2JlMGYgMTAwNjQ0Cj4gPiAtLS0gYS9N
QUlOVEFJTkVSUwo+ID4gKysrIGIvTUFJTlRBSU5FUlMKPiA+IEBAIC02MTYzLDYgKzYxNjMsMTMg
QEAgTDogICAgIGxpbnV4LWkyY0B2Z2VyLmtlcm5lbC5vcmcKPiA+ICBTOiAgIE1haW50YWluZWQK
PiA+ICBGOiAgIGRyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtY3BtLmMKPiA+Cj4gPiArRlJFRVNDQUxF
IElNWCBERFIgUGVyZm9ybWFuY2UgTW9uaXRvciBEUklWRVIKPiA+ICtNOiAgIEZyYW5rIExpIDxG
cmFuay5saUBueHAuY29tPgo+ID4gK0w6ICAgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnCj4gPiArUzogICBNYWludGFpbmVkCj4gPiArRjogICBkcml2ZXJzL3BlcmYvZnNsX2lt
eDhfZGRyX3BlcmYuYwo+ID4gK0Y6ICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3BlcmYvZnNsLWlteC1kZHIudHh0Cj4gPiArCj4KPiBXaXRoIGRhOGI3ZjBmYjAyYiAoIk1BSU5U
QUlORVJTOiBhZGQgYWxsIGZpbGVzIG1hdGNoaW5nICJpbXgiIGFuZCAibXhzIgo+IHRvIHRoZSBJ
TVggZW50cnkiKSB0aGF0IHNpdHMgY3VycmVudGx5IGluIG5leHQgdGhlICJBUk0vRlJFRVNDQUxF
IElNWCAvCj4gTVhDIEFSTSBBUkNISVRFQ1RVUkUiIGFsc28gbWF0Y2hlcyBmb3IgdGhlc2UgdHdv
IGZpbGVzLgo+Cj4gSXMgdGhpcyBnb29kIGhlcmUgb3Igbm90PwoKWWVzISB3aGF0J3MgZG8geW91
IG1lYW5zPwpOZWVkbid0IHRoZXNlIGVudHJ5IGJlY2F1c2UgZGE4YjdmMGZiMDJiPwoKPgo+IEJl
c3QgcmVnYXJkcwo+IFV3ZQo+Cj4gLS0KPiBQZW5ndXRyb25peCBlLksuICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCBVd2UgS2xlaW5lLUvDtm5pZyAgICAgICAgICAgIHwKPiBJbmR1c3RyaWFs
IExpbnV4IFNvbHV0aW9ucyAgICAgICAgICAgICAgICAgfCBodHRwOi8vd3d3LnBlbmd1dHJvbml4
LmRlLyAgfAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbAo=
