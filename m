Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116B0C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:02:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC63E20B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uaUc0GPF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DWVz58AX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC63E20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5AI3cTCzVQB+d/hLWR71S0+si14HD0AM05bqFTZV+Jc=; b=uaUc0GPFE1oUSI
	CIVfNAjs6misHr+qFC1RZOR8PnFFWiIdgge9wWYRagw5pijD5VKO7yYiOGp7BuA4VHLARuSaVH7LA
	l4g19fFNpfFSoNTEedtZXCHIbABmNWyhRicjzMF9lO2Nfnv8hJ/OmbjtPThWEZCbj+4MhC/6ZGrhZ
	NKDq/K2bd7zfWAEreJvGBz1uEJgZsqsM789e81vJ0Drp1HnhYVI81V4TqOEAxbUDlpgheKmM3FMRz
	PFgerTD5ojm1ik9B9ng3zR3jrhExTV09HdWZxXk4LsLPgkx6o0D44P+l0zUWGw3O22FUy4hI6T7+X
	lPlc8dGOagAWfcznodLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp9AX-0000WM-Qv; Thu, 31 Jan 2019 10:02:01 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp9AT-0000Vg-Gu
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 10:01:59 +0000
Received: by mail-wm1-x342.google.com with SMTP id y139so1777552wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 02:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=CDc/1G//BLGGopklIxuWKTJaFf+TxcjGlh453cFYSFk=;
 b=DWVz58AXH3vdiNPpIvICNWCw/ImKQhiGeFpWQkVlZaRepwqnWYTD2QWspOkkGnKdpz
 0c8KHzyrwYek9/LJay/+qYKDhT3uWYspXTnkfpszTCx5rOCUQaCo8dPJsTLM5Pa4T/L/
 YNKrRrutFbJZj1xnOHLBh/O1W0VigxuHZdvqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=CDc/1G//BLGGopklIxuWKTJaFf+TxcjGlh453cFYSFk=;
 b=NF8ADrjpurIobLwn/3gUykPit9mYk/RurXmlRs2wOIEWLEL0X51W/h52gA2B1X3gc5
 Ain6T2E+uI9IuKH8B1FrYsCYw7iBPQLRXiM4kHlYYjsR2/yQKogdIYrQ7vpkF04ivbC1
 8J2Vwkcpyt4TBUYCJf3uurXWT2QoWqUHfyrTKDFa9q8rjduhsTGN5PNphMgSLheeLywX
 fW2yPR+J0X58gp9qK6NyyDx+DTs/cFkNTCzpPn4jz9xik+eMXBhgBOWDYsOVblTaOHD3
 EV3AKwPXOs7oso9Z5bhaOACkheoE7U9DD5bYMVM1dqJyt7FzfNg2OXvmFHwby6bxFK30
 ESJA==
X-Gm-Message-State: AJcUukcBge3jlQOkSTj65abhCPBlNCB9n2dwuLUWhiugEfmwIK0YT4A5
 xfxVQyhjLxrVwZg2reZPE4RxJQ==
X-Google-Smtp-Source: ALg8bN7ZdAF+crje5IcNy+QU1s8G/u5MU/at78CbChuCoCQvMfQWuHBVZMPCjqK8Hln1E6IGWAkQUw==
X-Received: by 2002:a1c:6243:: with SMTP id w64mr28198677wmb.153.1548928915409; 
 Thu, 31 Jan 2019 02:01:55 -0800 (PST)
Received: from dell ([2.27.35.198])
 by smtp.gmail.com with ESMTPSA id k128sm7878891wmd.37.2019.01.31.02.01.54
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 31 Jan 2019 02:01:54 -0800 (PST)
Date: Thu, 31 Jan 2019 10:01:53 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Pi-Hsun Shih <pihsun@chromium.org>
Subject: Re: [PATCH 4/6] mfd: Add support for the MediaTek MT6358 PMIC
Message-ID: <20190131100153.GJ4701@dell>
References: <1548839891-20932-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1548839891-20932-5-git-send-email-hsin-hsiung.wang@mediatek.com>
 <CANdKZ0csqmTFj7+03yRAM25z4jGEQYQvOuSWggDY81spGqhgfA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANdKZ0csqmTFj7+03yRAM25z4jGEQYQvOuSWggDY81spGqhgfA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_020157_562473_26F6C13F 
X-CRM114-Status: GOOD (  18.73  )
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
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, srv_heupstream@mediatek.com,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 open list <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVGh1LCAzMSBKYW4gMjAxOSwgUGktSHN1biBTaGloIHdyb3RlOgoKPiBPbiBXZWQsIEphbiAz
MCwgMjAxOSBhdCA1OjE5IFBNIEhzaW4tSHNpdW5nIFdhbmcKPiA8aHNpbi1oc2l1bmcud2FuZ0Bt
ZWRpYXRlay5jb20+IHdyb3RlOgo+ID4KPiA+IFRoaXMgYWRkcyBzdXBwb3J0IGZvciB0aGUgTWVk
aWFUZWsgTVQ2MzU4IFBNSUMuIFRoaXMgaXMgYQo+ID4gbXVsdGlmdW5jdGlvbiBkZXZpY2Ugd2l0
aCB0aGUgZm9sbG93aW5nIHN1YiBtb2R1bGVzOgo+ID4KPiA+IC0gUmVndWxhdG9yCj4gPiAtIFJU
Qwo+ID4gLSBDb2RlYwo+ID4gLSBJbnRlcnJ1cHQKPiA+Cj4gPiBJdCBpcyBpbnRlcmZhY2VkIHRv
IHRoZSBob3N0IGNvbnRyb2xsZXIgdXNpbmcgU1BJIGludGVyZmFjZQo+ID4gYnkgYSBwcm9wcmll
dGFyeSBoYXJkd2FyZSBjYWxsZWQgUE1JQyB3cmFwcGVyIG9yIHB3cmFwLgo+ID4gTVQ2MzU4IE1G
RCBpcyBhIGNoaWxkIGRldmljZSBvZiB0aGUgcHdyYXAuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTog
SHNpbi1Ic2l1bmcgV2FuZyA8aHNpbi1oc2l1bmcud2FuZ0BtZWRpYXRlay5jb20+Cj4gPiAtLS0K
PiA+ICBkcml2ZXJzL21mZC9NYWtlZmlsZSAgICAgICAgICAgICAgICAgfCAgICAyICstCj4gPiAg
ZHJpdmVycy9tZmQvbXQ2MzU4LWlycS5jICAgICAgICAgICAgIHwgIDIzNiArKysrKwo+ID4gIGRy
aXZlcnMvbWZkL210NjM5Ny1jb3JlLmMgICAgICAgICAgICB8ICAgNjIgKy0KPiA+ICBpbmNsdWRl
L2xpbnV4L21mZC9tdDYzNTgvY29yZS5oICAgICAgfCAgMTU4ICsrKwo+ID4gIGluY2x1ZGUvbGlu
dXgvbWZkL210NjM1OC9yZWdpc3RlcnMuaCB8IDE5MjYgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKwo+ID4gIGluY2x1ZGUvbGludXgvbWZkL210NjM5Ny9jb3JlLmggICAgICB8ICAg
IDMgKwo+ID4gIDYgZmlsZXMgY2hhbmdlZCwgMjM4NSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL21mZC9tdDYzNTgtaXJxLmMKPiA+
ICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC9tZmQvbXQ2MzU4L2NvcmUuaAo+ID4g
IGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2xpbnV4L21mZC9tdDYzNTgvcmVnaXN0ZXJzLmgK
ClsxMDAncyAoaHVuZHJlZHMpIG9mIGxpbmVzIG9mIGNvZGUgY3V0XQoKPiA+ICtzdGF0aWMgY29u
c3Qgc3RydWN0IG1mZF9jZWxsIG10NjM1OF9kZXZzW10gPSB7Cj4gPiArICAgICAgIHsKPiA+ICsg
ICAgICAgICAgICAgICAubmFtZSA9ICJtdDYzNTgtcmVndWxhdG9yIiwKPiA+ICsgICAgICAgICAg
ICAgICAub2ZfY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDYzNTgtcmVndWxhdG9yIgo+ID4gKyAg
ICAgICB9LCB7Cj4gPiArICAgICAgICAgICAgICAgLm5hbWUgPSAibXQ2Mzk3LXJ0YyIsCj4gCj4g
U2hvdWxkIHRoaXMgYmUgIm10NjM1OC1ydGMiPwoKWzEwMDAncyAodGhvdXNhbmRzKSBvZiBsaW5l
cyBvZiBjb2RlIGN1dF0KCldoZW4gcmVwbHlpbmcgdG8gYSBwYXRjaCwgZXNwZWNpYWxseSBvbmUg
YXMgbGFyZ2UgYXMgdGhpcywgeW91IHNob3VsZApjdXQgYWxsIG9mIHRoZSBpcnJlbGV2YW50IHF1
b3Rlcy4gIFB1dCBhbm90aGVyIHdheSwgeW91IHNob3VsZCBvbmx5CnF1b3RlIHdoYXQgeW91IGFy
ZSByZXBseWluZyB0bywgYW5kIG1heWJlIGEgc21hbGwgc2VjdGlvbiBiZWZvcmUvYWZ0ZXIKdG8g
a2VlcCB0aGUgY29udGV4dC4KCi0tIApMZWUgSm9uZXMgW+adjueQvOaWr10KTGluYXJvIFNlcnZp
Y2VzIFRlY2huaWNhbCBMZWFkCkxpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZv
ciBBUk0gU29DcwpGb2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBCbG9nCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2Vy
bmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVs
Cg==
