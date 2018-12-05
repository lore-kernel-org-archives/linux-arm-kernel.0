Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE29C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:12:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 791ED20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pSb8mFWO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mxNqAucm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 791ED20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TI0vFvOAOpTIPCdoQf91j+aCtrj6UgrM/y8+48C85gY=; b=pSb8mFWOglHdZW
	VTRJzW89Rmj2tPhIzIm+1aRPbuDyRAPMC+TM5tknJnfdjGxBv7kdwu3vixeePCGprL9mJfdLUf5hu
	qlBTf9QqGoGKe+LDV3Yfhqfe9VkFB6WS/5CooJSw95VLrTU+Q20LUcZqjEyuaih64r3vja6wH2eIC
	1Ysc+k2MdNAfrAJNV8on5PoII7QhCoAhshddSNMKtzl7XKiQ/OYNvXRZIDNRfl3WX0fbIC5s9RvFV
	bNVPSu3CVzaL6xNs5NWsqmRk9E4Sf+s3hJO+8XB0WfddGL/lEh85wIQ0JSt9o38gbrnU8uV/Hj5/T
	puq8oZe+asvP/LlQvcjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gULjv-0001Td-2z; Wed, 05 Dec 2018 01:12:35 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gULjr-0001Sk-TV
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 01:12:33 +0000
Received: by mail-pf1-x444.google.com with SMTP id y126so9123815pfb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 17:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:subject:in-reply-to:references:date:message-id:mime-version
 :content-transfer-encoding;
 bh=huMzzg9M5IKQF8pp+XWvd6Y/O8piGr2fBzs2L4BaH2Q=;
 b=mxNqAucmO4xPN5bms8oNBx4Z6YNIezG0yId1Q6TKgMed9TEwanu6H9ry+hBQti60FD
 9BFZPJWOetOaoyltBP/emZqg6hLiZx/giWwbrwYOvxbJ5Dbu1w15Weo9KHqqP279Y0lI
 oGwvWESsaEV44KX3K+Mt5fLFnUklKIpH0DgNSK9b5rpgXaRflKZBncs2Xdy2Y5MV38gt
 0ZHS7lR22XoU54phJxZV86mTeSirFus1P5o3VIaKvsiP6pKx2kYDZNM4u8rkf7DM2c6t
 0GA7n+84UIXW2Dbegp3ePdm8KE2K8vBunbs+rfWr75/Pg7tvbuPMBrFKFn1tJEA1ILVQ
 Ttng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:in-reply-to:references:date
 :message-id:mime-version:content-transfer-encoding;
 bh=huMzzg9M5IKQF8pp+XWvd6Y/O8piGr2fBzs2L4BaH2Q=;
 b=ZutALbvpaCxSJ9d7VWS38hdimdfzrn6zu7NDexXMzgXNGQ+Lr6hTbP2fyiQnfYEZ2y
 b+EN/prF+p9At8wGDBsp4XogpKFUQ16iTJTSBLNcwTXduIH/OSZ9p18/KARM44z7O8LI
 k9w8HxIHS9FafPlNnl/Ie64y5rQNQZKIcz0gWGFsxoUSzfvBt8Iqf1EQYBDt94OFD9YV
 wMe3bXv6bEhXGHhWe4fE9XYmRTCcrI4iJf9aiNxLAz5XCpfvcUPKimmhOlvJy7pFljEW
 fQ7y8+OnbiBe9mEUVTzdSGRkmjU4GmFS259HFQhzonweJe70eVWzw7aDmJYY8fIkYSjl
 EWHQ==
X-Gm-Message-State: AA+aEWbAczfMba0b3taeDqtPsYI3n1QSYexXxGhLdc2tjd/V4sTC89+F
 3lUsEFWS2zzFOOvM7WZDrwh1plv4Pzg=
X-Google-Smtp-Source: AFSGD/UvwCPupdAH7RMbAszqTm5uaO07k3VoyZbiTvS7lln6phXHkcnPDf3kfpq/wXY4q2j+ilNsmg==
X-Received: by 2002:a62:4255:: with SMTP id p82mr22078398pfa.13.1543972340941; 
 Tue, 04 Dec 2018 17:12:20 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net.
 [71.197.186.152]) by smtp.googlemail.com with ESMTPSA id
 x27sm26839549pfe.178.2018.12.04.17.12.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 04 Dec 2018 17:12:20 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
 Carlo Caione <ccaione@baylibre.com>, robh+dt@kernel.org, mark.rutland@arm.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, martin.blumenstingl@googlemail.com
Subject: Re: [PATCH 1/2] arm64: dts: meson: Fix IRQ trigger type for macirq
In-Reply-To: <5C06DB0D.3010306@baylibre.com>
References: <20181204160447.27869-1-ccaione@baylibre.com>
 <20181204160447.27869-2-ccaione@baylibre.com> <5C06DB0D.3010306@baylibre.com>
Date: Tue, 04 Dec 2018 17:12:19 -0800
Message-ID: <7hin08bwuk.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_171231_952539_5BD35CC4 
X-CRM114-Status: GOOD (  11.23  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

TmVpbCBBcm1zdHJvbmcgPG5hcm1zdHJvbmdAYmF5bGlicmUuY29tPiB3cml0ZXM6Cgo+IEhpIENh
cmxvLAo+Cj4gTGUgMDQvMTIvMjAxOCAxNzowNCwgQ2FybG8gQ2Fpb25lIGEgw6ljcml0IDoKPj4g
QSBsb25nIHJ1bm5pbmcgc3RyZXNzIHRlc3Qgb24gYSBjdXN0b20gYm9hcmQgc2hpcHBpbmcgYW4g
QVhHIFNvQ3MgYW5kIGEKPj4gUmVhbHRlayBSVEw4MjExRiBQSFkgcmV2ZWFsZWQgdGhhdCBhZnRl
ciBhIGZldyBob3VycyB0aGUgY29ubmVjdGlvbgo+PiBzcGVlZCB3b3VsZCBkcm9wIGRyYXN0aWNh
bGx5LCBmcm9tIH4xMDAwTWJwcyB0byB+M01icHMuIEF0IHRoZSBzYW1lIHRpbWUKPj4gdGhlICdt
YWNpcnEnIChldGgwKSBJUlEgd291bGQgc3RvcCBiZWluZyB0cmlnZ2VyZWQgYXQgYWxsIGFuZCBh
cwo+PiBjb25zZXF1ZW5jZSB0aGUgR01BQyBJUlFzIG5ldmVyIEFDS2VkLgo+PiAKPj4gQWZ0ZXIg
YSBwYWluZnVsIGludmVzdGlnYXRpb24gdGhlIHByb2JsZW0gc2VlbWVkIHRvIGJlIGR1ZSB0byBh
IHdyb25nCj4+IGRlZmluZWQgSVJRIHR5cGUgZm9yIHRoZSBHTUFDIElSUSB0aGF0IHNob3VsZCBi
ZSBMRVZFTF9ISUdIIGluc3RlYWQgb2YKPj4gRURHRV9SSVNJTkcuCj4KPiBUaGlzIGlzIGEgZ29v
ZCBuZXdzICEKPgo+IEtldmluLAo+IFdoYXQncyB0aGUgYmVzdCBwcm9jZWR1cmUgaGVyZSB0byBt
YWtlIGl0IGFwcGx5IG9uIHRoZSA0LjE5LCA0LjE0IGFuZCA0Ljkgc3RhYmxlCj4gdHJlZXMgPyBm
b3IgNC4xNCBhbmQgNC45IGl0IHdpbGwgbmVlZCB0byBiZSByZXdvcmtlZCB0byBhcHBseSBjb3Jy
ZWN0bHkuCgpBZGRpbmcgYSBGaXhlczogdGFnIHdoZXJlIHRoZSBvcmlnaW5hbCBidWcgd2FzIGlu
dHJvZHVjZSBpcyB0aGUgYmVzdCB3YXkKZm9yIGl0IHRvIGF1dG9tYXRpY2FsbHkgZ2V0IGFwcGxp
ZWQuCgpIb3dldmVyLCBpZiByZXdvcmsgaXMgcmVxdWlyZWQsIHRoYXQgd2lsbCBoYXZlIHRvIGJl
IG1hbnVhbGx5IGRvbmUgYW5kCnNlbnQgdG8gdGhlIHN0YWJsZSBsaXN0LgoKS2V2aW4KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
