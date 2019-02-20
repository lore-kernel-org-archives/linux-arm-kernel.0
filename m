Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B3CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:58:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A625120880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sSd22oM9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A625120880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:
	From:In-Reply-To:References:MIME-Version:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fYlow1rtgdOatAvNTrLMYo1/xk4x6x/5MGHMbQkdQgE=; b=sSd22oM9eK7cJX
	e+ENCY2uEc5jx2X1nWMRwX0ZTMKuISIwcum1Bqq1sbcUA6KNxVH5ugamQWcTZokCN2RRDZBd537Sk
	g1NkbQIpqrEPHY69biu/d+bAIW3JiOwfJ5k1/Y8LeLhtTKchGZXK2Y8+RvknSnUxlzIo2zaLlsDLM
	8XPc2Py15RnU8mhqwjPnkJiiWQhkY8fB58j1uVHd8f01kGV33ZI80KJaiL+JYCVKoLZFh+q+tlqcK
	B9j84TbMxQhIyRJqCHmkh7LwfvHJgF9HunhiJRV+fc4urooCbut52fP/FKvvQ+nS+SEfKt7PBXcGc
	TppK2RuuT1IiR4t4XNIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwSOS-0000ZK-AU; Wed, 20 Feb 2019 13:58:36 +0000
Received: from mail-wr1-f65.google.com ([209.85.221.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwSOL-0000R0-8w; Wed, 20 Feb 2019 13:58:30 +0000
Received: by mail-wr1-f65.google.com with SMTP id f14so26181431wrg.1;
 Wed, 20 Feb 2019 05:58:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc:content-transfer-encoding;
 bh=9gWmZamgsA69HolfNaaWEg8e9mDbjUxOCkA1kE6tmlw=;
 b=ZgfwNmfahu8giGkQN+C5OF0zChOA0tLguEUjVflSK067C74K8thXEww/RcYzeFTQsy
 i0KWMNR0oVQAh0wA6QDryoa+Nic6Lpq+wySWgeVeh8HS10pOwwaqEK94UOCJfdsjm1/j
 TRV1ojrXD5a3ru1I/LiDj/QLQ91roHFqivm2q8iANkzd4ZrbaCIYE+JVhiKxghJRtIfJ
 /cdVE5ZDLpLqVjGqlEzRCvOEFBBCdOqPJ1Fa8JMBiHKAOPKM3DvTvgp1lawlAN1PbJpP
 Fg9RFltA11gKM+0SFiim1pg0lf36LPYpdakVn1y2ecJI74r0A+1R47zcG2TOYzdVs6/9
 TXtA==
X-Gm-Message-State: AHQUAubZYpmA4TyR65AafJxuMOkWePCdBCS4og6xVirNsACosl9v2UOp
 B0LCwqSaLqkdKpsm1/abdTmVX8ZbWgzZ6wnX4ng=
X-Google-Smtp-Source: AHgI3Iat7/JFbIEG3jubX1hdHuYXOBePGIB2MNcS2gCDAizWlmp4cvnDlUS5xTQEYFyWDvYEAscp1uqyZkNB7AFdOg0=
X-Received: by 2002:a5d:6252:: with SMTP id m18mr6387918wrv.199.1550671107581; 
 Wed, 20 Feb 2019 05:58:27 -0800 (PST)
MIME-Version: 1.0
References: <20190216151826.11584-1-tiny.windzz@gmail.com>
 <CGME20190216152000epcas1p216810769e13852c4b92896348657b6d6@epcas1p2.samsung.com>
 <20190216151826.11584-3-tiny.windzz@gmail.com>
 <47edbfaa-2c2d-04d3-cf24-8368f723c6fa@samsung.com>
In-Reply-To: <47edbfaa-2c2d-04d3-cf24-8368f723c6fa@samsung.com>
From: MyungJoo Ham <myungjoo.ham@samsung.com>
Date: Wed, 20 Feb 2019 22:57:49 +0900
Message-ID: <CAJ0PZbQORXei7y2RkSTF8SQJCya=d13x9n0DBYpNby-rSccUMg@mail.gmail.com>
Subject: Re: [PATCH 2/3] PM / devfreq: rockchip-dfi: remove unneeded semicolon
To: Chanwoo Choi <cw00.choi@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_055829_311348_700D87BF 
X-CRM114-Status: GOOD (  16.62  )
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

T24gTW9uLCBGZWIgMTgsIDIwMTkgYXQgOTo0MSBBTSBDaGFud29vIENob2kgPGN3MDAuY2hvaUBz
YW1zdW5nLmNvbT4gd3JvdGU6Cj4KPiBIaSwKPgo+IE9uIDE5LiAyLiAxNy4g7Jik7KCEIDEyOjE4
LCBZYW5ndGFvIExpIHdyb3RlOgo+ID4gVGhlIHNlbWljb2xvbiBpcyB1bm5lZWRlZCwgc28gcmVt
b3ZlIGl0Lgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFlhbmd0YW8gTGkgPHRpbnkud2luZHp6QGdt
YWlsLmNvbT4KPiA+IC0tLQo+ID4gIGRyaXZlcnMvZGV2ZnJlcS9ldmVudC9yb2NrY2hpcC1kZmku
YyB8IDIgKy0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kZXZmcmVxL2V2ZW50L3JvY2tjaGlwLWRm
aS5jIGIvZHJpdmVycy9kZXZmcmVxL2V2ZW50L3JvY2tjaGlwLWRmaS5jCj4gPiBpbmRleCAyMmIx
MTMzNjNmZmMuLmZjYmY3NmViZjU1ZCAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvZGV2ZnJlcS9l
dmVudC9yb2NrY2hpcC1kZmkuYwo+ID4gKysrIGIvZHJpdmVycy9kZXZmcmVxL2V2ZW50L3JvY2tj
aGlwLWRmaS5jCj4gPiBAQCAtMjExLDcgKzIxMSw3IEBAIHN0YXRpYyBpbnQgcm9ja2NoaXBfZGZp
X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4gPiAgICAgICBpZiAoSVNfRVJS
KGRhdGEtPmNsaykpIHsKPiA+ICAgICAgICAgICAgICAgZGV2X2VycihkZXYsICJDYW5ub3QgZ2V0
IHRoZSBjbGsgZG1jX2Nsa1xuIik7Cj4gPiAgICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKGRh
dGEtPmNsayk7Cj4gPiAtICAgICB9Owo+ID4gKyAgICAgfQo+ID4KPiA+ICAgICAgIC8qIHRyeSB0
byBmaW5kIHRoZSBvcHRpb25hbCByZWZlcmVuY2UgdG8gdGhlIHBtdSBzeXNjb24gKi8KPiA+ICAg
ICAgIG5vZGUgPSBvZl9wYXJzZV9waGFuZGxlKG5wLCAicm9ja2NoaXAscG11IiwgMCk7Cj4gPgo+
Cj4gUmV2aWV3ZWQtYnk6IENoYW53b28gQ2hvaSA8Y3cwMC5jaG9pQHNhbXN1bmcuY29tPgoKQWNr
ZWQtYnk6IE15dW5nSm9vIEhhbSA8bXl1bmdqb28uaGFtQHNhbXN1bmcuY29tPgoKTWVyZ2VkLiBU
aGFua3MuCgo+Cj4gLS0KPiBCZXN0IFJlZ2FyZHMsCj4gQ2hhbndvbyBDaG9pCj4gU2Ftc3VuZyBF
bGVjdHJvbmljcwoKCgotLSAKTXl1bmdKb28gSGFtLCBQaC5ELgpTL1cgQ2VudGVyLCBTYW1zdW5n
IEVsZWN0cm9uaWNzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1hcm0ta2VybmVsCg==
