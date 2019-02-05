Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD770C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:29:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BCF4207E0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xm6EyRqw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="nfrBI8vI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BCF4207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mCYJTkKUbkWmt9Ygyumw4HPwc3TTFlYkULAQe1JW+xI=; b=Xm6EyRqwEBohKx
	LuxjGIzSXTOBvLsptnhTJAkURtyUmyO3yO0UAgFBxeBpsyft4SReyuHDdbPzGi59T2z4Yd6omIBJp
	3D5xqibBup8fDy45Aw78+Pjplk64uqcfZ+tBu5GB3G8MNFvhoW79VTy1brjEoCLMwWtIZnoWFgDLH
	J5o9CgCvk5HhuuZED4XWwCB04zwl3re0NhuH2fIY82xsBSw4VQbibUgTnBTbKppWA5tXk3zDzjkqa
	3kPG6GKzYFAuk2P75dkEnAFhMptNYWbebb+P0EHwcBIiL5YOD6udko2ccHaz5gZV2UJpxcWmiDOs1
	WD2DpyxzgWfRItHUHC6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr3bA-0004Cl-GB; Tue, 05 Feb 2019 16:29:24 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr3b6-0004CJ-On
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 16:29:22 +0000
Received: by mail-it1-x141.google.com with SMTP id d11so9846362itf.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 08:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=SV1i3PXnzDh3LkMg06RuFmI8bAptTjTQLNWSI7V+BsI=;
 b=nfrBI8vIVIzdxQvYtesVBizPLq2/5gdnEtV+ZpOfP4dTu4wkzPhW33lSejHIqW0132
 O1lpAcVDbUA4ogUfOxqQtyusWUdyhCqj8K5YZeh0x9hC1qTNRKdMMLhSyQWirRN4wYfl
 HVMwWy0B+JAsO1zXmyX7xMuE2R6/XQRQYTPhyAOABrloO3ghYdu2Y9CXJIaYyL49cvjO
 if6DPx4Mepv1MyFZ2NCN1H403IY/yU73vRSmrtvnbkV0T/tUWwuhugIfpIu00K8xT0Ks
 iVRDiksziup6jvKH8cr5oW7i4wn5ZY0qlMOknKVm7Kt0so919kQ8ANLBY3vffpTMIkHb
 gnaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SV1i3PXnzDh3LkMg06RuFmI8bAptTjTQLNWSI7V+BsI=;
 b=XQ/A18YYhEFCbECVHj1Iv4w+kI5d4qblfpdN4GIXdIep6bJhpLK0G8APiPtXUC2Fdq
 FwHdN2uknd8XOqfH/pXND2PDg/C+jT7FKr39kcfalMNCsl8LpkBsVIGgUPyNQAv22swe
 r4OnX5xgQwBSIFtiusI7hYUj4G3XNhv5EJrUoR9ipuG4oLv+XxAXjpt2z2JAvGLoA1Wi
 OTAtmqlyhRwLPBge2gsttVQsub2Yn/PBWTjBvlviYk23LQ1yGuXKprEj4J0ZfyCae8UP
 xNvM+/+UHT2HxOpWXUGNRcH9TaiDm2d8pCMb6Too3owS0TYpxMB/XXgQvsJNrRWwY8bk
 Saqg==
X-Gm-Message-State: AHQUAuah+GI5I6D8/vSC41tNTcEYruDvp1nu1PFRr8QsTAdHQze0EJLL
 Igbz84i2FU7hnsK7xJWHC6nxNo7P9CovaCqgi2vw3A==
X-Google-Smtp-Source: AHgI3IbtZrZmxNH5z++voZrXoIprzBvCcyVMkYAVfA51Ap54Z9uGy1uFR81CTsa7450MjY3slf+ck6hU9VH7lMdMOas=
X-Received: by 2002:a24:f909:: with SMTP id l9mr2814397ith.74.1549384159899;
 Tue, 05 Feb 2019 08:29:19 -0800 (PST)
MIME-Version: 1.0
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-8-brgl@bgdev.pl>
 <90995667-37cd-62a9-a40e-ee104016faf9@lechnology.com>
In-Reply-To: <90995667-37cd-62a9-a40e-ee104016faf9@lechnology.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 5 Feb 2019 17:29:09 +0100
Message-ID: <CAMRc=Me67M+JPg-mxKpCnuMm6NFkL-OLrJ+5XiKztd=bmm+PKw@mail.gmail.com>
Subject: Re: [PATCH 07/35] ARM: davinci: aintc: use irq domain
To: David Lechner <david@lechnology.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_082920_800888_DA56E039 
X-CRM114-Status: GOOD (  17.33  )
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
 Marc Zyngier <marc.zyngier@arm.com>, Sekhar Nori <nsekhar@ti.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

cG9uLiwgNCBsdXQgMjAxOSBvIDIzOjQyIERhdmlkIExlY2huZXIgPGRhdmlkQGxlY2hub2xvZ3ku
Y29tPiBuYXBpc2HFgihhKToKPgo+IE9uIDEvMzEvMTkgNzozOSBBTSwgQmFydG9zeiBHb2xhc3pl
d3NraSB3cm90ZToKPiA+IEZyb206IEJhcnRvc3ogR29sYXN6ZXdza2kgPGJnb2xhc3pld3NraUBi
YXlsaWJyZS5jb20+Cj4gPgo+ID4gV2UgbmVlZCB0byBjcmVhdGUgYW4gaXJxIGRvbWFpbiBpZiB3
ZSB3YW50IHRvIHNlbGVjdCBTUEFSU0VfSVJRLiBUaGUKPiA+IGNwLWludGMgZHJpdmVyIGFscmVh
ZHkgc3VwcG9ydHMgaXQsIGJ1dCBhaW50YyBkb2Vzbid0LiBVc2UgdGhlIGhlbHBlcnMKPiA+IHBy
b3ZpZGVkIGJ5IHRoZSBnZW5lcmljIGlycSBjaGlwIGFic3RyYWN0aW9uLgo+ID4KPiA+IFNpZ25l
ZC1vZmYtYnk6IEJhcnRvc3ogR29sYXN6ZXdza2kgPGJnb2xhc3pld3NraUBiYXlsaWJyZS5jb20+
Cj4gPiAtLS0KPiA+ICAgYXJjaC9hcm0vbWFjaC1kYXZpbmNpL2lycS5jIHwgMzggKysrKysrKysr
KysrKysrKysrKysrKysrKystLS0tLS0tLS0tLQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMjcgaW5z
ZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
L21hY2gtZGF2aW5jaS9pcnEuYyBiL2FyY2gvYXJtL21hY2gtZGF2aW5jaS9pcnEuYwo+ID4gaW5k
ZXggZTUzOWJjNjVkNGVmLi5jODc0ZWEyNjk0MTEgMTAwNjQ0Cj4gPiAtLS0gYS9hcmNoL2FybS9t
YWNoLWRhdmluY2kvaXJxLmMKPiA+ICsrKyBiL2FyY2gvYXJtL21hY2gtZGF2aW5jaS9pcnEuYwo+
ID4gQEAgLTIzLDYgKzIzLDcgQEAKPiA+ICAgI2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPgo+
ID4gICAjaW5jbHVkZSA8bGludXgvaXJxLmg+Cj4gPiAgICNpbmNsdWRlIDxsaW51eC9pby5oPgo+
ID4gKyNpbmNsdWRlIDxsaW51eC9pcnFkb21haW4uaD4KPiA+Cj4gPiAgICNpbmNsdWRlIDxtYWNo
L2hhcmR3YXJlLmg+Cj4gPiAgICNpbmNsdWRlIDxtYWNoL2NwdXR5cGUuaD4KPiA+IEBAIC00Myw2
ICs0NCw3IEBACj4gPiAgICNkZWZpbmUgSVJRX0lOVFBSSTdfUkVHX09GRlNFVCAgICAgIDB4MDA0
Qwo+ID4KPiA+ICAgc3RhdGljIHZvaWQgX19pb21lbSAqZGF2aW5jaV9pbnRjX2Jhc2U7Cj4gPiAr
c3RhdGljIHN0cnVjdCBpcnFfZG9tYWluICpkYXZpbmNpX2lycV9kb21haW47Cj4gPgo+ID4gICBz
dGF0aWMgaW5saW5lIHZvaWQgZGF2aW5jaV9pcnFfd3JpdGVsKHVuc2lnbmVkIGxvbmcgdmFsdWUs
IGludCBvZmZzZXQpCj4gPiAgIHsKPiA+IEBAIC01NSwxNyArNTcsMTUgQEAgc3RhdGljIGlubGlu
ZSB1bnNpZ25lZCBsb25nIGRhdmluY2lfaXJxX3JlYWRsKGludCBvZmZzZXQpCj4gPiAgIH0KPiA+
Cj4gPiAgIHN0YXRpYyBfX2luaXQgdm9pZAo+ID4gLWRhdmluY2lfYWxsb2NfZ2Modm9pZCBfX2lv
bWVtICpiYXNlLCB1bnNpZ25lZCBpbnQgaXJxX3N0YXJ0LCB1bnNpZ25lZCBpbnQgbnVtKQo+ID4g
K2RhdmluY2lfaXJxX3NldHVwX2djKHZvaWQgX19pb21lbSAqYmFzZSwKPiA+ICsgICAgICAgICAg
ICAgICAgICB1bnNpZ25lZCBpbnQgaXJxX3N0YXJ0LCB1bnNpZ25lZCBpbnQgbnVtKQo+ID4gICB7
Cj4gPiAgICAgICBzdHJ1Y3QgaXJxX2NoaXBfZ2VuZXJpYyAqZ2M7Cj4gPiAgICAgICBzdHJ1Y3Qg
aXJxX2NoaXBfdHlwZSAqY3Q7Cj4gPgo+ID4gLSAgICAgZ2MgPSBpcnFfYWxsb2NfZ2VuZXJpY19j
aGlwKCJBSU5UQyIsIDEsIGlycV9zdGFydCwgYmFzZSwgaGFuZGxlX2VkZ2VfaXJxKTsKPiA+IC0g
ICAgIGlmICghZ2MpIHsKPiA+IC0gICAgICAgICAgICAgcHJfZXJyKCIlczogaXJxX2FsbG9jX2dl
bmVyaWNfY2hpcCBmb3IgSVJRICV1IGZhaWxlZFxuIiwKPiA+IC0gICAgICAgICAgICAgICAgICAg
IF9fZnVuY19fLCBpcnFfc3RhcnQpOwo+ID4gLSAgICAgICAgICAgICByZXR1cm47Cj4gPiAtICAg
ICB9Cj4gPiArICAgICBnYyA9IGlycV9nZXRfZG9tYWluX2dlbmVyaWNfY2hpcChkYXZpbmNpX2ly
cV9kb21haW4sIGlycV9zdGFydCk7Cj4KPiBjaGVjayBmb3IgKGdjID09IE5VTEwpIGhlcmU/Cj4K
CkkgY2FuIGFkZCBpdCwgYnV0IGl0J3Mgbm90IHJlYWxseSBuZWVkZWQuIFdlIGtub3cgd2UgcGFz
cyBjb3JyZWN0CnBhcmFtZXRlcnMgdG8gdGhpcyByb3V0aW5lIGFuZCBpZiBpdCBmYWlscywgdGhl
IHN5c3RlbSB3b24ndCBib290CmFueXdheS4KCkJhcnQKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0Cmxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
