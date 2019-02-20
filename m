Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DE6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:56:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC4A92147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cR0CLcQP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC4A92147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:
	From:In-Reply-To:References:MIME-Version:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mQQNA2YHxStp9mSfhm718FqYWGaWOVKo0FzoQrrwCws=; b=cR0CLcQP/Qi22M
	EdJ5sbeO8Rdtn1OztatYG1XbFTT9JhtnzYA6LueoZiFABCRy0vbStFKPsz2BWBt5gXpB1FhyOTaHP
	4Q/eODpFugRfplraOHGtvWNN3OZxeimYYken7tZw5EgsbhaKeVns4gVEqHbdmaTnTCy7qCp90oKwG
	kND48fX2uf1D5lrso5hj9SVIFJMlNiQlLG72qDATXPft0y/A79yLJRB2LBEph7vLgcIc/acTu+Cks
	K9jzNSeT7u/FGQQr3Soqb98eiR0dt5MALHjJtwhvTlVJ1fXsPQr/AUL7U8tf4IedQ6fUPTgBDreAo
	yD80q1xmlHGA/dfDRcMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwSMd-0008H6-Eg; Wed, 20 Feb 2019 13:56:43 +0000
Received: from mail-wr1-f68.google.com ([209.85.221.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwSMa-0008GX-11; Wed, 20 Feb 2019 13:56:42 +0000
Received: by mail-wr1-f68.google.com with SMTP id f14so26174684wrg.1;
 Wed, 20 Feb 2019 05:56:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc:content-transfer-encoding;
 bh=mr2SnelbiJUUghAwbgCBMha1QF1gvL4tCn0WX03/2GA=;
 b=hj2tq3TqmKm3YZBYK8ZT+9Uz3lBztZlvTGe78Fo8zGUgWipsSWpMYnW50KqlsVFOLG
 BSLc2uOzDT4CG4Vtdj4685/TTyyG3BpV2yIJMNnC7XDVbXN3Nwnr3gBD2zWM1Mcyc7iM
 qYGMNPzK76tuwgcTeXq2f0v7NA56OPgJxSHnGy5lGu+5ixe6eoG5t/XagPZovqLJ1Id5
 SS9rT2mv+1RPaSO8BoAeC2wNs9qVT2Ep+c4YRyk38Yz82u+JNO7W4GrbGQcSVXBKtbHN
 RCXqHzKRFwtIMtmPSUYlL2fguWA4Gmm8XW+dSTKmOib/tmpefMtrESS3MHJaWm4bd5ne
 zlEw==
X-Gm-Message-State: AHQUAuYdvpv1iMa9gh3Pf7MaAgkLD3wH0soHZs8tVWvHzQ0VluiCCcSV
 5lVSoUvOlAX3JDdf4rLhsyRBO2hkyt/VPj0XTL4=
X-Google-Smtp-Source: AHgI3IYBtbJJWNE6Xq/xTWlMIowgeujfUGTLg6tdqk/fmeF5vWf3j/so314W4MCUDohhZ1t8o2GPd4SqoPmlpNSeMKQ=
X-Received: by 2002:a5d:49cf:: with SMTP id t15mr23193693wrs.94.1550670997475; 
 Wed, 20 Feb 2019 05:56:37 -0800 (PST)
MIME-Version: 1.0
References: <20190216151826.11584-1-tiny.windzz@gmail.com>
 <CGME20190216152219epcas4p3ec89de91f9e158da7cc7cfeefb6e113e@epcas4p3.samsung.com>
 <20190216151826.11584-2-tiny.windzz@gmail.com>
 <9e7f9e6d-3b53-35f2-e945-13895385af31@samsung.com>
In-Reply-To: <9e7f9e6d-3b53-35f2-e945-13895385af31@samsung.com>
From: MyungJoo Ham <myungjoo.ham@samsung.com>
Date: Wed, 20 Feb 2019 22:55:59 +0900
Message-ID: <CAJ0PZbQ808ztVzWyq_cTAD5o276y-t+0Lih2a5jOv05585VTEg@mail.gmail.com>
Subject: Re: [PATCH 1/3] PM / devfreq: rk3399_dmc: remove unneeded semicolon
To: Chanwoo Choi <cw00.choi@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_055640_084282_4A601D3C 
X-CRM114-Status: GOOD (  15.03  )
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
Reply-To: myungjoo.ham@gmail.com
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Linux PM list <linux-pm@vger.kernel.org>, Yangtao Li <tiny.windzz@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
 linux-rockchip@lists.infradead.org, Kyungmin Park <kyungmin.park@samsung.com>,
 Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBGZWIgMTgsIDIwMTkgYXQgMTA6MDkgQU0gQ2hhbndvbyBDaG9pIDxjdzAwLmNob2lA
c2Ftc3VuZy5jb20+IHdyb3RlOgo+Cj4gSGksCj4KPiBPbiAxOS4gMi4gMTcuIOyYpOyghCAxMjox
OCwgWWFuZ3RhbyBMaSB3cm90ZToKPiA+IFRoZSBzZW1pY29sb24gaXMgdW5uZWVkZWQsIHNvIHJl
bW92ZSBpdC4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBZYW5ndGFvIExpIDx0aW55LndpbmR6ekBn
bWFpbC5jb20+Cj4gPiAtLS0KPiA+ICBkcml2ZXJzL2RldmZyZXEvcmszMzk5X2RtYy5jIHwgMiAr
LQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+ID4K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RldmZyZXEvcmszMzk5X2RtYy5jIGIvZHJpdmVycy9k
ZXZmcmVxL3JrMzM5OV9kbWMuYwo+ID4gaW5kZXggZTc5NWFkMmIzZjZiLi5hMjI4ZGFkMmJlZTQg
MTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2RldmZyZXEvcmszMzk5X2RtYy5jCj4gPiArKysgYi9k
cml2ZXJzL2RldmZyZXEvcmszMzk5X2RtYy5jCj4gPiBAQCAtMzIyLDcgKzMyMiw3IEBAIHN0YXRp
YyBpbnQgcmszMzk5X2RtY2ZyZXFfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikK
PiA+Cj4gPiAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiQ2Fubm90IGdldCB0aGUgY2xrIGRt
Y19jbGtcbiIpOwo+ID4gICAgICAgICAgICAgICByZXR1cm4gUFRSX0VSUihkYXRhLT5kbWNfY2xr
KTsKPiA+IC0gICAgIH07Cj4gPiArICAgICB9Cj4gPgo+ID4gICAgICAgZGF0YS0+ZWRldiA9IGRl
dmZyZXFfZXZlbnRfZ2V0X2VkZXZfYnlfcGhhbmRsZShkZXYsIDApOwo+ID4gICAgICAgaWYgKElT
X0VSUihkYXRhLT5lZGV2KSkKPiA+Cj4KPiBSZXZpZXdlZC1ieTogQ2hhbndvbyBDaG9pIDxjdzAw
LmNob2lAc2Ftc3VuZy5jb20+CgpBY2tlZC1ieTogTXl1bmdKb28gSGFtIDxteXVuZ2pvby5oYW1A
c2Ftc3VuZy5jb20+CgpNZXJnZWQuCgo+Cj4gLS0KPiBCZXN0IFJlZ2FyZHMsCj4gQ2hhbndvbyBD
aG9pCj4gU2Ftc3VuZyBFbGVjdHJvbmljcwoKCi0tIApNeXVuZ0pvbyBIYW0sIFBoLkQuClMvVyBD
ZW50ZXIsIFNhbXN1bmcgRWxlY3Ryb25pY3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
