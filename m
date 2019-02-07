Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBD9C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:08:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AB87218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SxN5+bqC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DsrZo98r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AB87218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bUnE3+HZlLDpPres4X/iyYwQpbkEsH1ysvw1ks+f6NE=; b=SxN5+bqCVyfkv/
	OQ7QnGhgMhc4EBqU7ygxt53e3qSZaO9/mDTQXcsfVQXzJRdQfFZb08FX+4bI1W0mL2s30/cehMdHj
	uPHCA7Z1uIEyiqFNo2qhNorhvMf93Z0y8/a5Dh9ggfk3hdyDrPn44igsv/P3oJreGNQnjK3yeKe4T
	9xiQEAn9vBO98Uw1dQGbdQLiZZt3hbwcGwEsQK5JHEN234IKUlnPxkz2ZWQqoaLNuiZ3rWagur+r3
	R+A8njX3ujYLkIX0I6/UsyXuJGi4bbEr542uGbt9o1/CF326DfsU295FAWGmJmECwjxUl7PX601Tk
	rD7mqFgB2qbOQvtEYaew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grffh-0001AL-IL; Thu, 07 Feb 2019 09:08:37 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grffe-00019a-N7
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 09:08:36 +0000
Received: by mail-wr1-x443.google.com with SMTP id q15so10582121wro.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 01:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=+jTkujky4AE5vc4xMQoKZMHg+3sbx8t0WyPCS7ve00M=;
 b=DsrZo98rfzwuZaDD06Px6Jn+g0bDVUU4Bii5BQisSz4Yrbmdm+hb4JvrFUm2acZ9Yj
 QdXBddg1dT4kWRHixCGCOwUW/Jyo6VQkUkLsITqLqblOsKqQzaqfU3uP3+cAYoUyKSOl
 Dbn0sbSnNsYOj0c0+9RkiZ91YKPtySWLcFLPOBdELt7zRaNODLKgWRej9sJ5heAcD11i
 /FGGUUAD6t1qb98AEj9dbNLabhluF5Bi7kWi5EXFg8yRQpapE0Mt/XePaHpqgVZF+4kx
 1FcB9qV/X2UnM/s9RzHai66a22VnES5A/7k8BqRgoGMDFV+dP9sPHjXruTT6n4u/IB2y
 i7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=+jTkujky4AE5vc4xMQoKZMHg+3sbx8t0WyPCS7ve00M=;
 b=Hkb3QoOQnDrdPfAwkmSaCf/FRVl3AfHYQNEdsWWHejZB9Gw0jYsez1b1ssKHtJLR6U
 ustEz9pIKlAqTUjtj3OuyigWIXXbgs6lNkQko+mtUMa/jSKmE3Y7x9WLeMLcjgXo7e4z
 oxvRGIbrA2DIus/aYXY6CFHHRdzQbhooD99++IoxWVS4/8yF6UxQ65Sx4DyS5Nf8Tzs9
 FfzZbNsd9kycmjE/BU2hE2hSgEmjg6GaYhrowjgub9xB9QUDM6xzKioXrCq411F6L903
 UiSCao9J2X2/NFno/1/8snMldUsM/wZREDNXMsb4A7XdWfXR5h8SczPCQelQdZlWf4P4
 5wdw==
X-Gm-Message-State: AHQUAuayZNCq/9tNE2PhNVXGrpglYySi9/9oov9iJb0mvZZMBn4qitwJ
 gSDmr/M67fjvGlzUq1t2L/NVrQ==
X-Google-Smtp-Source: AHgI3IaUfJPR7k9AWINvkWdUBw/FGNg5qowLMllB4reECGa05XO60NWMhq57je1OXLyA6cwEKLbnzA==
X-Received: by 2002:a5d:6549:: with SMTP id z9mr10886447wrv.116.1549530512402; 
 Thu, 07 Feb 2019 01:08:32 -0800 (PST)
Received: from dell ([2.27.35.171])
 by smtp.gmail.com with ESMTPSA id 133sm28982022wme.9.2019.02.07.01.08.31
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Feb 2019 01:08:31 -0800 (PST)
Date: Thu, 7 Feb 2019 09:08:30 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Subject: Re: [PATCH 1/6] mfd: mt6397: extract irq related code from core driver
Message-ID: <20190207090830.GG4672@dell>
References: <1548839891-20932-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1548839891-20932-2-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548839891-20932-2-git-send-email-hsin-hsiung.wang@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_010834_825596_AD01A744 
X-CRM114-Status: GOOD (  17.05  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gV2VkLCAzMCBKYW4gMjAxOSwgSHNpbi1Ic2l1bmcgV2FuZyB3cm90ZToKCj4gSW4gb3JkZXIg
dG8gc3VwcG9ydCBkaWZmZXJlbnQgdHlwZXMgb2YgaXJxIGRlc2lnbiwKPiB3ZSBkZWNpZGUgdG8g
YWRkIHNlcGFyYXRlIGlycSBkcml2ZXJzIGZvciBkaWZmZXJlbnQKPiBkZXNpZ24gYW5kIGtlZXAg
bXQ2Mzk3IG1mZCBjb3JlIHNpbXBsZSBhbmQgcmV1c2FibGUKPiB0byBhbGwgZ2VuZXJhdGlvbnMg
b2YgUE1JQ3Mgc28gZmFyLgoKV2h5IGhhdmUgeW91IGN1dCB0aGVzZSBsaW5lcyBzbyBzaG9ydD8K
CkluIGFsbCBjYXNlczoKCiBzL2lycS9JUlEvCiBzL21mZC9NRkQKIHMvbXQ2Mzk3L01UNjM5Ny8K
Cj4gU2lnbmVkLW9mZi1ieTogSHNpbi1Ic2l1bmcgV2FuZyA8aHNpbi1oc2l1bmcud2FuZ0BtZWRp
YXRlay5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvbWZkL01ha2VmaWxlICAgICAgICAgICAgfCAgIDIg
Ky0KPiAgZHJpdmVycy9tZmQvbXQ2Mzk3LWNvcmUuYyAgICAgICB8IDIzNSArKysrKysrLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gIGRyaXZlcnMvbWZkL210NjM5Ny1pcnEuYyAg
ICAgICAgfCAyMTQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gIGluY2x1
ZGUvbGludXgvbWZkL210NjM5Ny9jb3JlLmggfCAgMTIgKysKPiAgNCBmaWxlcyBjaGFuZ2VkLCAy
NjUgaW5zZXJ0aW9ucygrKSwgMTk4IGRlbGV0aW9ucygtKQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy9tZmQvbXQ2Mzk3LWlycS5jCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWZkL01h
a2VmaWxlIGIvZHJpdmVycy9tZmQvTWFrZWZpbGUKPiBpbmRleCAxMjk4MGE0Li4wODhlMjQ5IDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvbWZkL01ha2VmaWxlCj4gKysrIGIvZHJpdmVycy9tZmQvTWFr
ZWZpbGUKPiBAQCAtMjMwLDcgKzIzMCw3IEBAIG9iai0kKENPTkZJR19JTlRFTF9TT0NfUE1JQykJ
Kz0gaW50ZWwtc29jLXBtaWMubwo+ICBvYmotJChDT05GSUdfSU5URUxfU09DX1BNSUNfQlhUV0Mp
CSs9IGludGVsX3NvY19wbWljX2J4dHdjLm8KPiAgb2JqLSQoQ09ORklHX0lOVEVMX1NPQ19QTUlD
X0NIVFdDKQkrPSBpbnRlbF9zb2NfcG1pY19jaHR3Yy5vCj4gIG9iai0kKENPTkZJR19JTlRFTF9T
T0NfUE1JQ19DSFREQ19USSkJKz0gaW50ZWxfc29jX3BtaWNfY2h0ZGNfdGkubwo+IC1vYmotJChD
T05GSUdfTUZEX01UNjM5NykJKz0gbXQ2Mzk3LWNvcmUubwo+ICtvYmotJChDT05GSUdfTUZEX01U
NjM5NykJKz0gbXQ2Mzk3LWNvcmUubyBtdDYzOTctaXJxLm8KPiAgCj4gIG9iai0kKENPTkZJR19N
RkRfQUxURVJBX0ExMFNSKQkrPSBhbHRlcmEtYTEwc3Iubwo+ICBvYmotJChDT05GSUdfTUZEX1NV
TjRJX0dQQURDKQkrPSBzdW40aS1ncGFkYy5vCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWZkL210
NjM5Ny1jb3JlLmMgYi9kcml2ZXJzL21mZC9tdDYzOTctY29yZS5jCj4gaW5kZXggNzdiNjRiZC4u
YTcyNTI0ZCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL21mZC9tdDYzOTctY29yZS5jCj4gKysrIGIv
ZHJpdmVycy9tZmQvbXQ2Mzk3LWNvcmUuYwo+IEBAIC0xMiwyMyArMTIsMTkgQEAKPiAgICogR05V
IEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4KPiAgICovCj4gIAo+IC0j
aW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+Cj4gICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4K
PiAgI2luY2x1ZGUgPGxpbnV4L29mX2RldmljZS5oPgo+ICAjaW5jbHVkZSA8bGludXgvb2ZfaXJx
Lmg+Cj4gICNpbmNsdWRlIDxsaW51eC9yZWdtYXAuaD4KPiAgI2luY2x1ZGUgPGxpbnV4L21mZC9j
b3JlLmg+Cgo+IC0jaW5jbHVkZSA8bGludXgvbWZkL210NjM5Ny9jb3JlLmg+Cj4gICNpbmNsdWRl
IDxsaW51eC9tZmQvbXQ2MzIzL2NvcmUuaD4KPiAtI2luY2x1ZGUgPGxpbnV4L21mZC9tdDYzOTcv
cmVnaXN0ZXJzLmg+Cj4gKyNpbmNsdWRlIDxsaW51eC9tZmQvbXQ2Mzk3L2NvcmUuaD4KPiAgI2lu
Y2x1ZGUgPGxpbnV4L21mZC9tdDYzMjMvcmVnaXN0ZXJzLmg+Cj4gKyNpbmNsdWRlIDxsaW51eC9t
ZmQvbXQ2Mzk3L3JlZ2lzdGVycy5oPgoKSSB3aWxsIGlnbm9yZSB0aGVzZSB1bnJlbGF0ZWQgY2hh
bmdlcyEKCj4gICNkZWZpbmUgTVQ2Mzk3X1JUQ19CQVNFCQkweGUwMDAKPiAgI2RlZmluZSBNVDYz
OTdfUlRDX1NJWkUJCTB4M2UKPiAgCj4gLSNkZWZpbmUgTVQ2MzIzX0NJRF9DT0RFCQkweDIzCj4g
LSNkZWZpbmUgTVQ2MzkxX0NJRF9DT0RFCQkweDkxCj4gLSNkZWZpbmUgTVQ2Mzk3X0NJRF9DT0RF
CQkweDk3CgpDSURfQ09ERSBpcyBhIGJpdCBjcnlwdGljLgoKV2h5IG5vdCB1c2UgKl9DSElQX0lE
IGluc3RlYWQ/CgpbLi4uXQoKPiArc3RhdGljIGNvbnN0IHN0cnVjdCBjaGlwX2RhdGEgbXQ2MzIz
X2NvcmUgPSB7Cj4gKwkuY2lkX2FkZHIgPSBNVDYzMjNfQ0lELAo+ICt9OwoKRG9lcyB0aGUgY2hp
cCBJRCBhZGRyZXNzIGNoYW5nZSBmcm9tIGRldmljZSB0byBkZXZpY2U/CgpJZiBub3QsIHlvdSBj
YW4gZ2V0IHJpZCBvZiBhbGwgb2YgdGhpcyBob29wIGp1bXBpbmcuCgotLSAKTGVlIEpvbmVzIFvm
nY7nkLzmlq9dCkxpbmFybyBTZXJ2aWNlcyBUZWNobmljYWwgTGVhZApMaW5hcm8ub3JnIOKUgiBP
cGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKRm9sbG93IExpbmFybzogRmFjZWJvb2sg
fCBUd2l0dGVyIHwgQmxvZwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtYXJtLWtlcm5lbAo=
