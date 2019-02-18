Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CF2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 07:16:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65C7F218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 07:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iI3/xd/K";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="amahnuco"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C7F218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ndVTsSLd6Sg+FvhuWqWfZOVjitFr/oGp1qaetZL7A2s=; b=iI3/xd/KawNMqZ
	sA/VqgSkT1zMWJdnoGRgMNf/bTZCHLB9fLFNXVrIwVwDzOwqQQsSIHW4k/C+1RZAKN1CRq1rZDW5+
	2wBlemZv3kkriNu6dVylzz2Go5OQilJnt8cRRLLCeEOn2Q7C+XTbRuXDLcaRQ7IPD9tURMg9AAeX2
	3Uq5pgX7mdt0aLkyFq1CW78stSGpin31YgK7i+FJLOfe1uIikFMxWo6iZv2EfzoPgRpKbD25rsLzj
	q5xF2ZN7ScyIuIR/SLcLE73F+uwy3vGBPhfhAjUKnPRfvHo/Zh0bj14+0M2kZUh758E2n93IVuWOU
	8tSmAu3wx74j+ER9xohw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvdAf-00065s-6d; Mon, 18 Feb 2019 07:16:57 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvdAc-000657-1l
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 07:16:55 +0000
Received: by mail-lf1-x141.google.com with SMTP id j1so11477119lfb.10
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 17 Feb 2019 23:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=MrCJfbWEvY8UqQtRDkniGJZ0cbNL2PRJAjsu/EVV424=;
 b=amahnucoF9bA+GD17kQ7JZadHPg1FZUKXJA9DtrHiGWlS6T0HPDMG/KL4RKdTejmoc
 eBmdpEZvdKn6rmx2iP0g3JmExxvLdeb/PqGz5mvttmWL7flI0ITnOHaU78SrjJfjoZZh
 0EPGRaLtXQu2phYYrfWdFs0C59G7cl50/4MJt27wlQtxirmD9w8ZW4AgV75UtUZRLKCR
 sQGhg9UYRh4GnpB9M+pA2BRNWdE/w7RG4IhpDkwyVdP8rdlvuiMpXf7e9gPcp984YDP0
 kPO+Eoqmn8lpRwb5ELhmHvxTXBakx4RlfOONLouOW7wFKhIX2Cf0+9AGJc/hEjmnv8A8
 QD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MrCJfbWEvY8UqQtRDkniGJZ0cbNL2PRJAjsu/EVV424=;
 b=Zvk/3Ym/VT7NCnxQW9qFWUQ/YA3Z4HP5KLdh+r4F1S8OIvq1TAPQrv1RN+TOIfzWRE
 I0psQl59v+dTvK4WQVW3Y+Goox9vdOamSVXG0tVA7fNuFaaxCke8lwuVNwNV9WY1vm59
 VZzG9XxS2YBcIMDsrRHXFX972eSY3naYMle9pFs/ZKkZmserfmcb8fOv4p9De9hW9v68
 rEE2FvKLhQXHKyO0k2QNZvbmhiYgkSLUw0MMDrq+ilc1QNfAwS1vJhEqUjpjad7RbGlU
 OoG+2iW5nYpcIg9szsznLUS0siRsjQuqJcSp41mlopAKWS6Gh28zXNgLcrXWlJcagRAZ
 kVtQ==
X-Gm-Message-State: AHQUAub2ZGTiG6LD9mE4574RYtkRON9XXB9oRTPQn3sfcDtuGkXutmTY
 SrvzGulUswEqpZsMJcRva8DPl1Kjp78oDD/cZameNQ==
X-Google-Smtp-Source: AHgI3IZrOXxhPELLvdT1B0VSqr0CgwnFFiYY5LE4SUAs1mx+aPZyKlIfcA5zDKSb4Kr8OeWB24KuebDSlF9cvo0kwDk=
X-Received: by 2002:a19:5611:: with SMTP id k17mr12339458lfb.168.1550474211741; 
 Sun, 17 Feb 2019 23:16:51 -0800 (PST)
MIME-Version: 1.0
References: <20190203214205.13594-1-linus.walleij@linaro.org>
 <20190203214205.13594-5-linus.walleij@linaro.org>
 <ffc97649-bfc2-e411-149f-cd5ed9e8c77e@arm.com>
 <CACRpkdZK7OU9rb-qw9tTjJLNvfQG-VmN_VBXUz9DPqVV11zuww@mail.gmail.com>
 <20190211221156.10036ad8@why.wild-wind.fr.eu.org> <m3k1hxvan4.fsf@t19.piap.pl>
In-Reply-To: <m3k1hxvan4.fsf@t19.piap.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 18 Feb 2019 08:16:39 +0100
Message-ID: <CACRpkdYuvZEPzmeKo552g4DR3wxQZtw24jX3ONbmdoD_6bUSPw@mail.gmail.com>
Subject: Re: [PATCH 04/17 v1] irqchip: Add driver for IXP4xx
To: =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_231654_104742_1ACAB53E 
X-CRM114-Status: GOOD (  11.74  )
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
Cc: Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>,
 Marc Zyngier <marc.zyngier@arm.com>, Tim Harvey <tharvey@gateworks.com>,
 Olof Johansson <olof@lixom.net>, Thomas Gleixner <tglx@linutronix.de>,
 Imre Kaloz <kaloz@openwrt.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBGZWIgMTgsIDIwMTkgYXQgODowNiBBTSBLcnp5c3p0b2YgSGHFgmFzYSA8a2hhbGFz
YUBwaWFwLnBsPiB3cm90ZToKPiBNYXJjIFp5bmdpZXIgPG1hcmMuenluZ2llckBhcm0uY29tPiB3
cml0ZXM6Cj4KPiA+IEl0J3Mgc3BlbGxlZCBCRTMyISA7LSkgSSB2YWd1ZWx5IHJlbWVtYmVyIGRv
aW5nIHNvbWUgb2YgdGhhdCBvbiB2dWxjYW4sCj4gPiBidXQgdGhhdCdzIGEgZGVjYWRlIGFnbywg
YW5kIEkndmUgcGFnZWQgaXQgb3V0Li4uIDstKQo+Cj4gUmlnaHQuIEl0J3MgYWxzbyBjYWxsZWQg
dmFsdWUtcHJlc2VydmluZyAod2hlcmUgdGhlICJ2YWx1ZSIgbXVzdCAzMi1iaXQKPiBhbmQgYWxp
Z25lZCBvbiAzMi1iaXQgYm91bmRhcnkpIG9yIChkb3VibGUpIHdvcmQgaW52YXJpYW50Lgo+Cj4g
U2luY2UgbW9zdCBvZiB0aGVzZSBhY2Nlc3NlcyBhcmUgbmF0dXJhbCAzMi1iaXQgcmVnaXN0ZXJz
IGFuZCAoYWxtb3N0KQo+IG5vbmUgYXJlIEFTQ0lJL2J5dGUtc3R5bGUsIGl0IG1ha2VzIHNlbnNl
LiBJSVJDIHRoZSBQQ0kgaGFzIGl0cyBvd24KPiBydWxlcywgdGhvdWdoLgoKSUlVQyBQQ0kgc2hv
dWxkIGFsd2F5cyBiZSBMRSBhbmQgcmVhZGwoKSB3cml0ZWwoKSBhbHdheXMgcmVhZC93cml0ZQpp
biBMRS4gQnV0IEkgc2VlIFBDSSBvbiB0aGUgSVhQNHh4IGlzIGEgc3BlY2lhbCBoaXN0b3J5IHNv
IEkgYW0gZ29pbmcgdG8KZXhwZXJpZW5jZSBpdCBpbiBhbGwgaXRzIGdsb3J5IG5vdyB0aGF0IEkg
c3RhcnQgbG9va2luZyBhdCBpdC4KClRoYW5rcywKTGludXMgV2FsbGVpagoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWls
aW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
