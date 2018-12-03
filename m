Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653BFC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:11:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3735C20661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lIiuhuMK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="UDdBo4QE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3735C20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JXiMFKCvWLEqgBIdULnH4sRjCiGKiYSH8DQXCmwD7Vo=; b=lIiuhuMKzlQzNn
	8T4Vm9MDhuZ0eFmX6KUCXlP/0dNd4pXuxPufZwZ5xVAxRk95q8qigjw+Sk71FGRO4YWAeDiR/a1Rv
	bsRKWtIDs6xEOYKhwTyG1ksnNTT9+BaPOAbWjOoe16lv+w7rBLVKpDCkEaML4kdcS+cXykz+ggRgg
	7NAkHCbpH6ONcXy/KNoggCuHkJjVD5LebAtJkFo6Hbba5UCKybb0RTb52z8ifR1MCyTSJFwpAiTD1
	QSm/QGllqmbDxcScp/oBTCcZ6SPD+candF88QuH4oiejJzrk6yr6bghgKHFuYaXz2ylsJez/BoUig
	XSb44ndvv3YOcxqcX8tA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTrkp-0000p9-O7; Mon, 03 Dec 2018 17:11:31 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTrkm-0000nW-LW
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 17:11:30 +0000
Received: by mail-it1-x143.google.com with SMTP id h65so9669459ith.3
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 09:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jZwHL+KrX7TIdnyTLQq0LYgZtjFjZYEP2+6PVqizCAc=;
 b=UDdBo4QEvg4n5FgfTMd+S4wJ/fav7viUpLtZns6RHd16/RRIWwxW0ZxVrNLElepXCx
 xLni/K+julKub2yzycDFRbjlSfNyPSkqILNYUr7ekYopSUfVnnns1iQm9/kdqQ43N3J4
 qJWbryRksRVuuLn7L94PD09YtM5LZd82uGHRUS7TA+i34NrYz6IyjlgXCLtpPyn4RVS+
 u75cULYljUy63l1INcTTjutxVJQJsYnpCzE4CxqOCVYkn0ALBkDTpntefu+9yPuZIlJ4
 bwxUrsoXR4zLtHHjvVadC7ZtSjCLDYGN3qItETaVFIMS3ykJaRR7FER4hptInOmslJcO
 6peg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jZwHL+KrX7TIdnyTLQq0LYgZtjFjZYEP2+6PVqizCAc=;
 b=L3rs9xe8ukNFYxXRnuUFJt6XTKTr1JUxaAik6E+in83X4zlCmazglDEY4hsE/T6k5f
 dyABT16Ua5gwHW0gPm1tjJArqlE052iidKJFD1yhbQZJteXfEPKppldtqxFjRpTOzxB+
 5dFKFdErY9e9MZFt/YLdQt6IhQ1xDHfSF/KzIxw1axre+JE74h7jWBBJ2DwVKO8cSiPb
 6Sh0y3nnOIYH1mDZaaOapKe1Q7Ef2LVtv+/68043BGxeX6PX8ZjQn9BIL5QUbrcbLVFU
 5KG/5gBUtsH232T3ZJ36l1lQr8gYk9GJ5MImK95FanlCHoBDPYgZq40QivMw+ba0VXOB
 Ya/g==
X-Gm-Message-State: AA+aEWYUevbXktmAQO9oZdkXrxRiieqA3WYpcDUIhaQY1iIw6bDF0FUH
 3TNdRlTBy5HONbCLZ3XT31dG2FbBfJBsjKdRQOyb2A==
X-Google-Smtp-Source: AFSGD/WWJlUM2Jfyl1jhFGTE9tmWu7X5SRFwCf/5eQ1tF2y0c6odiUtr1QqJ6xjOzrmCr3nS079A4Wmo96qOZpUEH4w=
X-Received: by 2002:a24:6e88:: with SMTP id w130mr8198378itc.103.1543857077051; 
 Mon, 03 Dec 2018 09:11:17 -0800 (PST)
MIME-Version: 1.0
References: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
 <20181121033652.12247-7-manivannan.sadhasivam@linaro.org>
 <CAL_JsqJ=88ORdgbRDn+VWk9=ydShidqwOxdAMfDbH4W2drnXzA@mail.gmail.com>
In-Reply-To: <CAL_JsqJ=88ORdgbRDn+VWk9=ydShidqwOxdAMfDbH4W2drnXzA@mail.gmail.com>
From: Olof Johansson <olof@lixom.net>
Date: Mon, 3 Dec 2018 09:11:05 -0800
Message-ID: <CAOesGMgSxwcmBLDvxsvcCJ9-NvJ3-wK8fZBZV2ZNuzAa1idi3w@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] arm: dts: Add devicetree for OrangePi 2G IoT
 board
To: Rob Herring <robh+dt@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_091128_710754_762D473E 
X-CRM114-Status: GOOD (  16.02  )
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
Cc: DTML <devicetree@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>,
 Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LinusW <linus.walleij@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Amit Kucheria <amit.kucheria@linaro.org>, linux-serial@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
 overseas.sales@unisoc.com, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
 zhao_steven@263.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBEZWMgMywgMjAxOCBhdCA3OjU0IEFNIFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5l
bC5vcmc+IHdyb3RlOgo+Cj4gT24gVHVlLCBOb3YgMjAsIDIwMTggYXQgOTozOCBQTSBNYW5pdmFu
bmFuIFNhZGhhc2l2YW0KPiA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+IHdyb3Rl
Ogo+ID4KPiA+IEFkZCBpbml0aWFsIGRldmljZXRyZWUgc3VwcG9ydCBmb3IgT3JhbmdlUGkgMkcg
SW9UIGJvYXJkIGZyb20gWHVubG9uZy4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZWFzIEbD
pHJiZXIgPGFmYWVyYmVyQHN1c2UuZGU+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBNYW5pdmFubmFuIFNh
ZGhhc2l2YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPgo+ID4gLS0tCj4gPiAg
YXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgIHwgIDIgKwo+ID4g
IC4uLi9ib290L2R0cy9yZGE4ODEwcGwtb3JhbmdlcGktMmctaW90LmR0cyAgICB8IDQwICsrKysr
KysrKysrKysrKysrKysKPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDQyIGluc2VydGlvbnMoKykKPiA+
ICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0vYm9vdC9kdHMvcmRhODgxMHBsLW9yYW5nZXBp
LTJnLWlvdC5kdHMKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZp
bGUgYi9hcmNoL2FybS9ib290L2R0cy9NYWtlZmlsZQo+ID4gaW5kZXggYjBlOTY2ZDYyNWI5Li5h
MGZkYWQ4ZjEwZGQgMTAwNjQ0Cj4gPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9NYWtlZmlsZQo+
ID4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUKPiA+IEBAIC04MDYsNiArODA2LDgg
QEAgZHRiLSQoQ09ORklHX0FSQ0hfUUNPTSkgKz0gXAo+ID4gICAgICAgICBxY29tLW1zbTg5NzQt
c29ueS14cGVyaWEtY2FzdG9yLmR0YiBcCj4gPiAgICAgICAgIHFjb20tbXNtODk3NC1zb255LXhw
ZXJpYS1ob25hbWkuZHRiIFwKPiA+ICAgICAgICAgcWNvbS1tZG05NjE1LXdwODU0OC1tYW5nb2gt
Z3JlZW4uZHRiCj4gPiArZHRiLSQoQ09ORklHX0FSQ0hfUkRBKSArPSBcCj4gPiArICAgICAgIHJk
YTg4MTBwbC1vcmFuZ2VwaS0yZy1pb3QuZHRiCj4gPiAgZHRiLSQoQ09ORklHX0FSQ0hfUkVBTFZJ
RVcpICs9IFwKPgo+IFF1ZXN0aW9uIGZvciBBcm5kL09sb2Y6IGNhbiB3ZSAqcGxlYXNlKiBzdGFy
dCBwdXR0aW5nIG5ldyBTb0MgZmFtaWxpZXMKPiBpbiBzdWItZGlycz8KCkkgdGhpbmsgd2UncmUg
YXQgYSBwb2ludCB3aGVyZSBpdCdzIGJlY29taW5nIHF1aXRlIGF3a3dhcmQgdG8ga2VlcCBpdApp
biBhIGZsYXQgZGlyZWN0b3J5LCB5ZXMuCgpCZXN0IHdheSB0byBoYW5kbGUgdGhpcyBpcyB1c3Vh
bGx5IHJpZ2h0IGJlZm9yZSB0aGUgY2xvc2luZyBvZiBhIG1lcmdlCndpbmRvdywgc28gbGV0J3Mg
ZG8gaXQgdGhlbi4gSXQnbGwgYmUgYSBjb25mbGljdC1yaWRkZW4gbWVzcyBpZiB3ZSB0cnkKdG8g
c3RhZ2Ugc29tZXRoaW5nIGluIC1uZXh0LCBzbyBJJ2QgcmF0aGVyIGp1c3QgZG8gaXQgZGlyZWN0
bHkgaW4gb3VyCnRyZWUgYXMgYSBvbmUtc2hvdCB0aGluZy4KCgotT2xvZgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWls
aW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
