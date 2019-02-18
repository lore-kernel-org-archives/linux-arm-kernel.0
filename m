Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C25FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:12:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D6EE2184A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Oy4g34lb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UVPP6vyO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D6EE2184A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JuO72n1EpZtZw3D99dJ1RSZhYTSdVMKBthh4klPEPkY=; b=Oy4g34lbikQlvy
	GaGEIV1pmDQFiihF1GJgV8xSDhg+N2n0M3owQ5BDUGXNKIUoyq06VM2qtCARZoFapAxzWaP+/ieMR
	EhdsSTOHcIjzm3nwDnWhXkEreyABiTJknG3451JgsYqVVCi3ydD5o9UBByZE3dRBjeci38RppMB0L
	NR16ceZF0aLJBKe+kMFGkia+uwPETU4GHEnDPuXc8urBmaMwl3sKL2NWlbEfnabjrsNVCUackaFCn
	CJmLXpULTmUDsFvSS/L9vsdCUE0QSpMMXb1BiMWgDASdGod+KhPxx7g6+CTxgfVOaMCLK3/LOJPIn
	0aDIovVAwehLTYHPw+hA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gve2Z-0002AQ-Fa; Mon, 18 Feb 2019 08:12:39 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gve2V-00029e-HC
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 08:12:37 +0000
Received: by mail-ot1-x341.google.com with SMTP id b3so26862220otp.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 00:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=A/GWwL8QsoA/seKkkwP2J9Rz4+w3VPL6GFqZWoskLzA=;
 b=UVPP6vyO6mqbqmeag02MDV50meAuUyc/reRiyqD1HAshwhNPf9m48CWFS4i3Rr9vO/
 BpNN6Njm93uloF2GJG9SIM2gSBDEm6FlB1ashfnnP4Ok7i3fPBX4q8sZII/qgvzwZsP4
 ZqTK6tGqVw76f0WNbdW+Mzo24B7GwYgAH0fsMTfZYFb3AcqFn+ItpQoWaTKNfhBwUNeD
 HL6/B/x7tJAeGQmUy9/6+RYdW96hMUoBBOwFmMEBJg78mWEAL/q/wwS8mpfuC8JKOS5I
 phd4wECfsq9dVBSuUhnSVV77/6dyNitmUM8ssZs40jXA79dRSkOapDwzTiY8zy3nAVRz
 Xipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=A/GWwL8QsoA/seKkkwP2J9Rz4+w3VPL6GFqZWoskLzA=;
 b=f3JxatkHo0gvD+GCeWE6723YyFJW0ifn3ReOPKtXXE/QgDAS1rARhvBCZVpyauTbfa
 JhzMkuk62ZsCVu/p9cMLwzxviCP9Tq4bY8k4vZLNSUVl4lGYpHqTeo+WHH15lL+LZ4yZ
 X62gUzhr74phICGR02mW2Bmwp1sGLPi3suAXE2DShViRZIKuHT1zhHO7ZA71H5oHw4x/
 bK3jC008hSIG9DhyE7pcAAWoZXbcx4HPD/ub8fpXn/8femvLdB2Rv6EmX/L3KoHgwElE
 djVa6iOlPK+yr8bO8agcXkovOjCyTkC1VnkgzDcVVdidyBi6R7ADYp02q4HI4Z+Pq1oG
 5zww==
X-Gm-Message-State: AHQUAubqvM8dYVZaA4+b4uD4PZx5SRqh6bl/SQljyuw5B/6R0QXPdn18
 9QxE/7oHd7AHLQbYMFVCk3A5mOo8NnwTbGBDDoCHqQ==
X-Google-Smtp-Source: AHgI3IbBhU0uXZ3HcV9Mi3MayiF/4EjW2u7ivl66FSIeVS6rpMai7dtp6S21GB5UJuNrejIUHtbT/e8YX+ykhhFSMzY=
X-Received: by 2002:a9d:635a:: with SMTP id y26mr13090952otk.27.1550477554190; 
 Mon, 18 Feb 2019 00:12:34 -0800 (PST)
MIME-Version: 1.0
References: <20190214145231.8750-1-brgl@bgdev.pl>
 <20190214145231.8750-34-brgl@bgdev.pl>
 <681a7831-8c20-d634-a1cb-04064e3077b8@lechnology.com>
In-Reply-To: <681a7831-8c20-d634-a1cb-04064e3077b8@lechnology.com>
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Mon, 18 Feb 2019 09:12:23 +0100
Message-ID: <CAMpxmJXvqTCYCHwJujx=A4Ga+bZP+fKpJTf++FkmYdQHR5HJew@mail.gmail.com>
Subject: Re: [PATCH v4 33/37] ARM: davinci: cp-intc: use readl/writel_relaxed()
To: David Lechner <david@lechnology.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_001235_627941_6B4239BA 
X-CRM114-Status: GOOD (  15.56  )
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
Cc: Jason Cooper <jason@lakedaemon.net>, Kevin Hilman <khilman@kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sekhar Nori <nsekhar@ti.com>,
 LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

bmllZHouLCAxNyBsdXQgMjAxOSBvIDExOjAxIERhdmlkIExlY2huZXIgPGRhdmlkQGxlY2hub2xv
Z3kuY29tPiBuYXBpc2HFgihhKToKPgo+IE9uIDIvMTQvMTkgODo1MiBBTSwgQmFydG9zeiBHb2xh
c3pld3NraSB3cm90ZToKPiA+IEZyb206IEJhcnRvc3ogR29sYXN6ZXdza2kgPGJnb2xhc3pld3Nr
aUBiYXlsaWJyZS5jb20+Cj4gPgo+ID4gUmFwbGFjZSBhbGwgY2FsbHMgdG8gX19yYXdfcmVhZGwo
KSAmIF9fcmF3X3dyaXRlbCgpIHdpdGggcmVhZGxfcmVsYXhlZCgpCj4KPiBzL1JhcGxhY2UvUmVw
bGFjZS8KPgo+ID4gYW5kIHdyaXRlbF9yZWxheGVkKCkgcmVzcGVjdGl2ZWx5LiBJdCdzIHNhZmUg
dG8gZG8gYXMgdGhlcmUncyBubwo+ID4gZW5kaWFubmVzcyBjb252ZXJzaW9uIGJlaW5nIGRvbmUg
aW4gdGhlIGNvZGUuCj4KPiBTaG91bGQgdGhpcyBiZSBjb21iaW5lZCB3aXRoIHBhdGNoIDE0LzM3
Pwo+CgpObywgdGhpcyBpcyBmb3IgY3AtaW50YyBhbmQgdGhlIG90aGVyIG9uZSBpcyBmb3IgYWlu
dGMuIEknZCBrZWVwIHRoZW0gc2VwYXJhdGUuCgpCYXJ0Cgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6
IEJhcnRvc3ogR29sYXN6ZXdza2kgPGJnb2xhc3pld3NraUBiYXlsaWJyZS5jb20+Cj4gPiAtLS0K
PiA+ICAgYXJjaC9hcm0vbWFjaC1kYXZpbmNpL2NwX2ludGMuYyB8IDQgKystLQo+ID4gICAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+ID4KPiA+IGRpZmYg
LS1naXQgYS9hcmNoL2FybS9tYWNoLWRhdmluY2kvY3BfaW50Yy5jIGIvYXJjaC9hcm0vbWFjaC1k
YXZpbmNpL2NwX2ludGMuYwo+ID4gaW5kZXggMWJmMTFmYThiZTc2Li5mODhiN2YwOTc4YWEgMTAw
NjQ0Cj4gPiAtLS0gYS9hcmNoL2FybS9tYWNoLWRhdmluY2kvY3BfaW50Yy5jCj4gPiArKysgYi9h
cmNoL2FybS9tYWNoLWRhdmluY2kvY3BfaW50Yy5jCj4gPiBAQCAtNDUsMTMgKzQ1LDEzIEBAIHN0
YXRpYyBzdHJ1Y3QgaXJxX2RvbWFpbiAqZGF2aW5jaV9jcF9pbnRjX2lycV9kb21haW47Cj4gPgo+
ID4gICBzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGludCBkYXZpbmNpX2NwX2ludGNfcmVhZCh1bnNp
Z25lZCBpbnQgb2Zmc2V0KQo+ID4gICB7Cj4gPiAtICAgICByZXR1cm4gX19yYXdfcmVhZGwoZGF2
aW5jaV9jcF9pbnRjX2Jhc2UgKyBvZmZzZXQpOwo+ID4gKyAgICAgcmV0dXJuIHJlYWRsX3JlbGF4
ZWQoZGF2aW5jaV9jcF9pbnRjX2Jhc2UgKyBvZmZzZXQpOwo+ID4gICB9Cj4gPgo+ID4gICBzdGF0
aWMgaW5saW5lIHZvaWQgZGF2aW5jaV9jcF9pbnRjX3dyaXRlKHVuc2lnbmVkIGxvbmcgdmFsdWUs
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQg
b2Zmc2V0KQo+ID4gICB7Cj4gPiAtICAgICBfX3Jhd193cml0ZWwodmFsdWUsIGRhdmluY2lfY3Bf
aW50Y19iYXNlICsgb2Zmc2V0KTsKPiA+ICsgICAgIHdyaXRlbF9yZWxheGVkKHZhbHVlLCBkYXZp
bmNpX2NwX2ludGNfYmFzZSArIG9mZnNldCk7Cj4gPiAgIH0KPiA+Cj4gPiAgIHN0YXRpYyB2b2lk
IGRhdmluY2lfY3BfaW50Y19hY2tfaXJxKHN0cnVjdCBpcnFfZGF0YSAqZCkKPiA+CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
