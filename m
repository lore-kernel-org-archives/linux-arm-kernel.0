Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E38C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:26:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36B232147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SXP+DxMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B232147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:
	From:In-Reply-To:References:MIME-Version:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0wjAHR9dy8+KSfmwsGdwt1Wf2dSe4OzbkLhwFiFo0H4=; b=SXP+DxMCXs5JSN
	6aFUXJEoPwGTrI6G48GezJBtVrNCuM6cuunEa1S6UoXVO32yjVsaHNPwcJd/bU4wyfjZWyBDsP9Pj
	5JGktwJKvAjyy1maHWSVh323TgoDEiyIqL8RInMWAwBTMsfCyr3Dd8ZTmE4yLRW9cvuY/nTTqjUXW
	Na0w8nadHugmrvKmB9J7MD9npxitFJqSYxJOm0JC4tQ3uW/L8/PfSfk18yyhggDAeXn5LTicvLAyP
	m/NevtvMuMPtpq5LVTC8Sihu3Np9NF29+JZrYq7SWZwrLdCBgiwjFpW20MM1fwyGDY3gFj9OwiH0m
	rABgHmTo3drJVrnHy8Aw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwSpk-0006mz-5y; Wed, 20 Feb 2019 14:26:48 +0000
Received: from mail-wr1-f65.google.com ([209.85.221.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwSpP-0006V2-OE; Wed, 20 Feb 2019 14:26:35 +0000
Received: by mail-wr1-f65.google.com with SMTP id n2so14032103wrw.8;
 Wed, 20 Feb 2019 06:26:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc:content-transfer-encoding;
 bh=iqbZ6SOvJVLW9ahCsACBtF6RPfSiZozNUarfAFIeCCc=;
 b=GH6mGWjk06hxrH8kOIbfCsup+aEQErfFyfiur1dXPAnIALJBpa3qYCFgqinVJgVXpp
 vf0aOstTJBkFRYFIvuCXF31LAeReQNGaREJ0hxj490vZK3vwczw8bXZo/ldKTWW3pqrb
 WSXQzH6blwgtOZpoC1c4Wo7K1cfC8OJ8XDAHGsiEfDBl8HWfl8tbuUg1+1H03BHcQerC
 bq3OHXfBMaP8i5zUQ02RfHuNdrg13Y3UEYiJkhhGpvzhIO4Rm+/G5a21HKexRaV/AbJO
 ISXNvam3PC68qcR2gIVgT/T8aI2KHX8mx8yOfKHJ+0KSGbWlG5F5sFTmU6ViEicjzI3N
 FmFQ==
X-Gm-Message-State: AHQUAuZ+LhIUtf1z4q53xPWRq2lMRx/EGyKSqM79CILLBvs8R/43BxBo
 37Eequ4+NuNz+7DXr315PVMZr6ni2eJNyy2o8ck=
X-Google-Smtp-Source: AHgI3IYYYarY0qaQIu11oNCsNZJkPRnfMjfmjkGJsPvJ1mu1UrkvG21ek1Q2+Re5PFaKHWSenOBPDS/n932Al5iV4/s=
X-Received: by 2002:a5d:5042:: with SMTP id h2mr24742142wrt.12.1550672786290; 
 Wed, 20 Feb 2019 06:26:26 -0800 (PST)
MIME-Version: 1.0
References: <20190216151826.11584-1-tiny.windzz@gmail.com>
 <CGME20190216151918epcas1p25c2971b063cc66981fda6a67a8276585@epcas1p2.samsung.com>
 <20190216151826.11584-4-tiny.windzz@gmail.com>
 <7fe8f9ba-ffcc-55ed-38b0-f37538257c1b@samsung.com>
 <abb56481-0cc7-3d31-2dae-ba602a423811@nvidia.com>
In-Reply-To: <abb56481-0cc7-3d31-2dae-ba602a423811@nvidia.com>
From: MyungJoo Ham <myungjoo.ham@samsung.com>
Date: Wed, 20 Feb 2019 23:25:48 +0900
Message-ID: <CAJ0PZbQ9sP5Kfkzn-kFQ2NCdxEk1fRB9WqrE5XD50K9F31ymag@mail.gmail.com>
Subject: Re: [PATCH 3/3] PM / devfreq: tegra: remove unneeded variable
To: Jon Hunter <jonathanh@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_062628_187296_E8FBC223 
X-CRM114-Status: GOOD (  16.82  )
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
 LKML <linux-kernel@vger.kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org,
 linux-rockchip@lists.infradead.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBGZWIgMTgsIDIwMTkgYXQgNjo1OCBQTSBKb24gSHVudGVyIDxqb25hdGhhbmhAbnZp
ZGlhLmNvbT4gd3JvdGU6Cj4KPgo+IE9uIDE4LzAyLzIwMTkgMDA6MzgsIENoYW53b28gQ2hvaSB3
cm90ZToKPiA+IE9uIDE5LiAyLiAxNy4g7Jik7KCEIDEyOjE4LCBZYW5ndGFvIExpIHdyb3RlOgo+
ID4+IFRoaXMgdmFyaWFibGUgaXMgbm90IHVzZWQgYWZ0ZXIgaW5pdGlhbGl6YXRpb24sIHNvCj4g
Pj4gcmVtb3ZlIGl0LiBBbmQgaW4gb3JkZXIgdG8gdW5pZnkgdGhlIGNvZGUgc3R5bGUsCj4gPj4g
bW92ZSB0aGUgbG9jYXRpb24gd2hlcmUgdGhlIGRldl9nZXRfZHJ2ZGF0YSBpcyBjYWxsZWQKPiA+
PiBieSB0aGUgd2F5Lgo+ID4+Cj4gPj4gU2lnbmVkLW9mZi1ieTogWWFuZ3RhbyBMaSA8dGlueS53
aW5kenpAZ21haWwuY29tPgo+ID4+IC0tLQo+ID4+ICBkcml2ZXJzL2RldmZyZXEvdGVncmEtZGV2
ZnJlcS5jIHwgNyArKy0tLS0tCj4gPj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDUgZGVsZXRpb25zKC0pCj4gPj4KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kZXZmcmVxL3Rl
Z3JhLWRldmZyZXEuYyBiL2RyaXZlcnMvZGV2ZnJlcS90ZWdyYS1kZXZmcmVxLmMKPiA+PiBpbmRl
eCBjNTlkMmVlZTVkMzAuLmM4OWJhN2I4MzRmZiAxMDA2NDQKPiA+PiAtLS0gYS9kcml2ZXJzL2Rl
dmZyZXEvdGVncmEtZGV2ZnJlcS5jCj4gPj4gKysrIGIvZHJpdmVycy9kZXZmcmVxL3RlZ3JhLWRl
dmZyZXEuYwo+ID4+IEBAIC01NzMsMTAgKzU3Myw3IEBAIHN0YXRpYyBpbnQgdGVncmFfZ292ZXJu
b3JfZ2V0X3RhcmdldChzdHJ1Y3QgZGV2ZnJlcSAqZGV2ZnJlcSwKPiA+PiAgc3RhdGljIGludCB0
ZWdyYV9nb3Zlcm5vcl9ldmVudF9oYW5kbGVyKHN0cnVjdCBkZXZmcmVxICpkZXZmcmVxLAo+ID4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgZXZlbnQs
IHZvaWQgKmRhdGEpCj4gPj4gIHsKPiA+PiAtICAgIHN0cnVjdCB0ZWdyYV9kZXZmcmVxICp0ZWdy
YTsKPiA+PiAtICAgIGludCByZXQgPSAwOwo+ID4+IC0KPiA+PiAtICAgIHRlZ3JhID0gZGV2X2dl
dF9kcnZkYXRhKGRldmZyZXEtPmRldi5wYXJlbnQpOwo+ID4+ICsgICAgc3RydWN0IHRlZ3JhX2Rl
dmZyZXEgKnRlZ3JhID0gZGV2X2dldF9kcnZkYXRhKGRldmZyZXEtPmRldi5wYXJlbnQpOwo+ID4+
Cj4gPj4gICAgICBzd2l0Y2ggKGV2ZW50KSB7Cj4gPj4gICAgICBjYXNlIERFVkZSRVFfR09WX1NU
QVJUOgo+ID4+IEBAIC02MDAsNyArNTk3LDcgQEAgc3RhdGljIGludCB0ZWdyYV9nb3Zlcm5vcl9l
dmVudF9oYW5kbGVyKHN0cnVjdCBkZXZmcmVxICpkZXZmcmVxLAo+ID4+ICAgICAgICAgICAgICBi
cmVhazsKPiA+PiAgICAgIH0KPiA+Pgo+ID4+IC0gICAgcmV0dXJuIHJldDsKPiA+PiArICAgIHJl
dHVybiAwOwo+ID4+ICB9Cj4gPj4KPiA+PiAgc3RhdGljIHN0cnVjdCBkZXZmcmVxX2dvdmVybm9y
IHRlZ3JhX2RldmZyZXFfZ292ZXJub3IgPSB7Cj4gPj4KPiA+Cj4gPiBSZXZpZXdlZC1ieTogQ2hh
bndvbyBDaG9pIDxjdzAwLmNob2lAc2Ftc3VuZy5jb20+Cj4gPgo+Cj4gQWNrZWQtYnk6IEpvbiBI
dW50ZXIgPGpvbmF0aGFuaEBudmlkaWEuY29tPgo+Cj4gVGhhbmtzIQo+IEpvbgoKQWNrZWQtYnk6
IE15dW5nSm9vIEhhbSA8bXl1bmdqb28uaGFtQHNhbXN1bmcuY29tPgoKTWVyZ2VkLiBUaGFua3Mh
Cgo+Cj4gLS0KPiBudnB1YmxpYwoKCgotLSAKTXl1bmdKb28gSGFtLCBQaC5ELgpTL1cgQ2VudGVy
LCBTYW1zdW5nIEVsZWN0cm9uaWNzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
