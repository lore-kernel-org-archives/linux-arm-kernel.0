Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5C0C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:20:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2D5920848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T5i90n1f";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ea8Zh87J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D5920848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bdUG1yle1spPn55JUSL4Iyz58Ik9FtaN457oClNrka0=; b=T5i90n1f7aNlul
	XsGpQS24kdxMdwFeN1f8H/XecSHQNipmMfd7kiaUhVY40Qak+lAoNyJep9b5Cwcy6uglRjjZWzBiq
	7JjOgY0v17K/Bff/pkRVgxCXlsdRvbF9I/tvbsO8HmCviLH07i3cQSnOhwil2D54CvMNzRgyckN4E
	D3TPyNAlz3BEN//wZEmT4MCybajp2/F68h1RUI9bUmurW2AmF2XM1RnYT9JlNe5tw96gMkCTTXKix
	XA1pPUSwMrX+Wd63fghHJs3ralYEs1sguuZkqAJTFXrtjRpdOlw7iJALpYU7mZZgZMyJvH6nWGPtp
	5orCOK2FyHjZxKwjJToQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTnD6-000173-Oa; Mon, 03 Dec 2018 12:20:24 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTnCr-00086A-8U
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 12:20:12 +0000
Received: by mail-wm1-x344.google.com with SMTP id y139so5544569wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 04:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=OzA+3GaaikIL6wv3q3MdMGfegRkRGor8XZDTMohQWx4=;
 b=ea8Zh87Jym6k2fqcstUYxCuciNIPimhX8g4B0MElxgMAq3stT+z+LCki2UbBChwBRE
 jhbJU9TlZ24RkzlDgN/hMVGbXNrD1gPH/b4SEfG0u7m7j3saX+YsU6XsDp6059agy9fg
 l7s7eBx85YiNUHP2mOuJRkA1KwFAQ3A0eU928=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=OzA+3GaaikIL6wv3q3MdMGfegRkRGor8XZDTMohQWx4=;
 b=NNL0H7zR9Dizlz6IRaVfu46X837anwPgZrYBpz+cIky+8o5z2DAc8ZWrWOaWXD2gFQ
 i5O26u3cRK/TdGu8mMxWiCHLiwC8gTOE2wViE5A0IhKAdZS4trte7DkzqaG4KQRdh/rt
 ixnySzfvbEWVE0QVHYjDPG8esAS5HIwCtS2qmXQT/mHwvhRmd/wTvTCK/jNqCGA5cZKk
 efTkxIf9nPuY6DfOabmo9zXaweG6m7Onl+E4/p+w1ZV5u3Vpn+XC/XhmIyKi9hFGZDrg
 yZeBbC7mpTzCGKXOk+pu4ndPgarKnpUdgtmjF7aXj279EX5/1S2VkLlM8vgMVZAKJ+PP
 YPYg==
X-Gm-Message-State: AA+aEWZiX1JSRrxGGekjIxPRm1UfnCm+jTFNQx5M2jza4ypnSePMbd6N
 KJN2fzDZl178KrgZV5a8LlYB3w==
X-Google-Smtp-Source: AFSGD/Ubj58mbWiG4F1lV87M8767muODU3LyeDsnIxQw+fiLFQL9Bm6raOAL8E1O+SGccTwNxz9Bug==
X-Received: by 2002:a1c:c7cd:: with SMTP id x196mr8015596wmf.12.1543839593878; 
 Mon, 03 Dec 2018 04:19:53 -0800 (PST)
Received: from dell ([2.31.167.218])
 by smtp.gmail.com with ESMTPSA id 129sm6454794wmd.18.2018.12.03.04.19.52
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 04:19:53 -0800 (PST)
Date: Mon, 3 Dec 2018 12:19:51 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v5 0/9] clk: clkdev: managed clk lookup and provider
 registrations
Message-ID: <20181203121951.GP26661@dell>
References: <cover.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_042009_302103_4DD12636 
X-CRM114-Status: GOOD (  12.72  )
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
Cc: david.brown@linaro.org, rafael.j.wysocki@intel.com,
 linux-clk@vger.kernel.org, b.zolnierkie@samsung.com, sboyd@kernel.org,
 linux-kernel@vger.kernel.org, mturquette@baylibre.com,
 mazziesaccount@gmail.com, linux-doc@vger.kernel.org, linux@armlinux.org.uk,
 krzk@kernel.org, akshu.agrawal@amd.com, cw00.choi@samsung.com,
 djkurtz@chromium.org, pavel@ucw.cz, pombredanne@nexb.com,
 andy.gross@linaro.org, andrew.smirnov@gmail.com, sjhuang@iluvatar.ai,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

PiBTZXJpZXMgYWRkIGJkNzE4MzcvYmQ3MTgzNyBQTUlDIGNsb2NrIHN1cHBvcnQgKyBtYW5hZ2Vk
IGludGVyZmFjZXMKClsuLi5dCgo+IE1hdHRpIFZhaXR0aW5lbiAoOSk6Cj4gICBjbGtkZXY6IGFk
ZCBtYW5hZ2VkIGNsa2RldiBsb29rdXAgcmVnaXN0cmF0aW9uCj4gICBjbGs6IG9mX2NsayAtIGFk
ZCBtYW5hZ2VkIHByb3ZpZGVyIHJlZ2lzdHJhdGlvbnMKPiAgIGNsazogY2xrLW1heDc3Njg2OiBD
bGVhbiBjbGtkZXYgbG9va3VwIGxlYWsgYW5kIHVzZSBkZXZtCj4gICBjbGs6IGNsay1zdDogYXZv
aWQgY2xrZGV2IGxvb2t1cCBsZWFrIGF0IHJlbW92ZQo+ICAgY2xrOiBjbGstaGk2NTV4OiBGcmVl
IG9mX3Byb3ZpZGVyIGF0IHJlbW92ZQo+ICAgY2xrOiByazgwODogdXNlIG1hbmFnZWQgdmVyc2lv
biBvZiBvZl9wcm92aWRlciByZWdpc3RyYXRpb24KPiAgIGNsazogY2xrLXR3bDYwNDA6IEZyZWUg
b2ZfcHJvdmlkZXIgYXQgcmVtb3ZlCj4gICBjbGs6IGFwY3MtbXNtODkxNjogc2ltcGxpZnkgcHJv
YmUgY2xlYW51cCBieSB1c2luZyBkZXZtCj4gICBjbGs6IGJkNzE4eDc6IEluaXRpYWwgc3VwcG9y
dCBmb3IgUk9ITSBiZDcxODM3L2JkNzE4NDcgUE1JQyBjbG9jawo+IAo+ICBEb2N1bWVudGF0aW9u
L2RyaXZlci1tb2RlbC9kZXZyZXMudHh0IHwgICAyICsKPiAgZHJpdmVycy9jbGsvS2NvbmZpZyAg
ICAgICAgICAgICAgICAgICB8ICAgNyArKwo+ICBkcml2ZXJzL2Nsay9NYWtlZmlsZSAgICAgICAg
ICAgICAgICAgIHwgICAxICsKPiAgZHJpdmVycy9jbGsvY2xrLWJkNzE4eDcuYyAgICAgICAgICAg
ICB8IDEzMSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gIGRyaXZlcnMvY2xr
L2Nsay1oaTY1NXguYyAgICAgICAgICAgICAgfCAgIDQgKy0KPiAgZHJpdmVycy9jbGsvY2xrLW1h
eDc3Njg2LmMgICAgICAgICAgICB8ICAyOSArKy0tLS0tLQo+ICBkcml2ZXJzL2Nsay9jbGstcms4
MDguYyAgICAgICAgICAgICAgIHwgIDE1ICstLS0KPiAgZHJpdmVycy9jbGsvY2xrLXR3bDYwNDAu
YyAgICAgICAgICAgICB8ICAgNSArLQo+ICBkcml2ZXJzL2Nsay9jbGsuYyAgICAgICAgICAgICAg
ICAgICAgIHwgIDY1ICsrKysrKysrKysrKysrLS0tCj4gIGRyaXZlcnMvY2xrL2Nsa2Rldi5jICAg
ICAgICAgICAgICAgICAgfCAxMjIgKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQo+ICBk
cml2ZXJzL2Nsay9xY29tL2FwY3MtbXNtODkxNi5jICAgICAgIHwgICA1ICstCj4gIGRyaXZlcnMv
Y2xrL3g4Ni9jbGstc3QuYyAgICAgICAgICAgICAgfCAgIDMgKy0KPiAgaW5jbHVkZS9saW51eC9j
bGstcHJvdmlkZXIuaCAgICAgICAgICB8ICAxMSArKysKPiAgaW5jbHVkZS9saW51eC9jbGtkZXYu
aCAgICAgICAgICAgICAgICB8ICAgNCArKwo+ICAxNCBmaWxlcyBjaGFuZ2VkLCAzMjUgaW5zZXJ0
aW9ucygrKSwgNzkgZGVsZXRpb25zKC0pCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2Ns
ay9jbGstYmQ3MTh4Ny5jCgpZb3UndmUgc2VuZCBtZSBhIGNvdmVyIGxldHRlciBhbmQgbm8gcGF0
Y2hlcy4KCkkgc3VnZ2VzdCB0aGF0IEkgc2hvdWxkIG5vdCBiZSBvbiB0aGUgYWRkcmVzc2VlIGxp
c3QgYXQgYWxsIGZvciB0aGlzLgoKLS0gCkxlZSBKb25lcyBb5p2O55C85pavXQpMaW5hcm8gU2Vy
dmljZXMgVGVjaG5pY2FsIExlYWQKTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUg
Zm9yIEFSTSBTb0NzCkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1r
ZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJu
ZWwK
