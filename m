Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F97C282C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:17:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E11CA218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 14:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V4o08dJg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P2UUrLzG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfrK273v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11CA218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hiyssoOVut/3y9gK/CMWD6sq9DkYozvW+hHBJU8Vkls=; b=V4o08dJgTRc4r7
	f5RWLJwxdOQYGcvjioikAMxUskSwPEQSQFw3MvUgiW+DAaazkrFdqsSR/67V+sSKMIdSlIUIU609P
	YmKrtGnzGx37+w1Z1JWPHAXnI/IBjxXqSCkC+VsqaQa0FzGs5+aND39w7PCB0E+XTUCVifu+EOdXq
	mNKj5MdMJPC412c7qH5/+Pg/Xm6zaQ4D13GcHJTfNaHuLJpueybcef+9XVd8tJcqmq3VXsI3AsfS0
	YPA/2MHF0AO1uhXypKgaVTcIeGd9PbgZBpgYzAQ6U9+HNFnB1rfqrOvguPeeMzmgevJ3gircjlgQg
	/j6zRW9wds1eY7aWT0Zw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmfp0-0003gR-Jy; Thu, 24 Jan 2019 14:17:34 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmfoz-0003Zs-7J
 for linux-arm-kernel@bombadil.infradead.org; Thu, 24 Jan 2019 14:17:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Zly3uJj3nfd6LGkHaexN+XCtlqBu6G31R9osIiXcn5Y=; b=P2UUrLzGSR0MbW0TaXlo3TDVOc
 R/MHt2/GJ523QSxfppmkErLmE36xQoLv4kAgopsI0byqS6Uvw6Ig2C6W29nxc4MmyZL5TqHJUC6It
 g+Bl9fK0AlzUKfG6zN/cREFpA1TabOE8TAn9woe3jpkeHGV41rzydpQ/wFgve2BQ/YrmAtNV0IjXK
 hOB9xzlczafYQqGVMorSr5IVNpTybk9Dph64WsGE0ZVXaqlhgtgdcwGNlsuKufQHVsJPXoLJO6180
 M7Mq3T4hlpqrGZ/1pseuISK9AhQkRylHHo/SfEhSPBXHCrfl4hmCBI+I9JAKj1mGt0mIYvRGYYccO
 AReeVdLQ==;
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmfZn-0004LA-AR
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 14:01:53 +0000
Received: by mail-wm1-x342.google.com with SMTP id n190so3262756wmd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 06:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Zly3uJj3nfd6LGkHaexN+XCtlqBu6G31R9osIiXcn5Y=;
 b=XfrK273vOJhFqVOf+1SgApy2Ctx3xStj+i54ORpCNbe8b7lmTkF4tOKmiZ6lis2+hC
 LsTHR17+hOdKX0h1SuhMnDFRP9jkCIzMZoNFEf4sreZzv+0czlzetDK6E0F7Cgho/7FG
 d42/ZluW2dpJ6LyFMJjupX6yO8G3OWftd4S17aIPb1zUH49AUqlHJD8gdPwwSDnxRT+t
 B5csQ74gc2Yp8mzwCzyF74+uiPxyDAQcc0PFDznl8O2KAodX0FadGK3CsZLDa3UuUKyD
 J40QmN9Xi/eudPMhRf/EX2ZJRI4j5gFambT3MdTajwP/5QsRQKHXcwnC+rCjzuki15PU
 BD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Zly3uJj3nfd6LGkHaexN+XCtlqBu6G31R9osIiXcn5Y=;
 b=HbFHjXTrAyFfjL38f0mmXqPT3+tWikLbU8t8TfKrdR8mw3dCjNMgojRqSPkRA8ce4E
 MjB0d/VMn1DMrW8QkVE5kIF0qFk+by4Ul0rKkmFFLnpBA5fqQiYnXc32Uh+jHYKQyKw9
 uTprKtyZ0la4qDyCvhRWyvSCrEQGFmeiMOCRJ18QbngtmsUDscKyGyoIRo/ZNYCSY6+F
 4sBIgNPdDFEQyh1yu8xeqMrjMtUJYkqsjlIT/u03FuxusWc6NeaDTzH5UGwDkQ/aL6Jm
 1sw8PmIBD/gPOdvcYu41rIdinOefcG4uQs1iuioO40SZG1ISek0BzE169cDBvKUhq2Ks
 Mhhw==
X-Gm-Message-State: AJcUukfyElK+Nqr1TdAbH7Z1IRMp3Cm2FVdXARzYCAvA+ExiVHfTtJOP
 Dvh06IeyzSLISwo5tWz8uj/NZIKxq1QghV6VDHM=
X-Google-Smtp-Source: ALg8bN4yXpHJwSOtUBiqISJ2R6T42zvZijTklQrw9xVkchJxEkh4WkGurfcpm+rih+t/nm+kp2hUROmX7VwwqDnwDH0=
X-Received: by 2002:a1c:c87:: with SMTP id 129mr2653509wmm.116.1548338509915; 
 Thu, 24 Jan 2019 06:01:49 -0800 (PST)
MIME-Version: 1.0
References: <20190124120658.30288-1-ard.biesheuvel@linaro.org>
 <3cca35a9-c71c-a100-b29d-31ba0d1d10b1@amd.com>
 <CAKv+Gu9OG3O4+4F2nioaQ-3U-1kwRBr5KVj-1gD1ZEsUx_Ud5A@mail.gmail.com>
In-Reply-To: <CAKv+Gu9OG3O4+4F2nioaQ-3U-1kwRBr5KVj-1gD1ZEsUx_Ud5A@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 24 Jan 2019 09:01:37 -0500
Message-ID: <CADnq5_PETD6umm9Df7OZ9BdaV5MZutmhN+HTAnVkcRLg5=TNWw@mail.gmail.com>
Subject: Re: [PATCH] drm: enable uncached DMA optimization for ARM and arm64
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_140151_357268_A92B82A4 
X-CRM114-Status: GOOD (  26.45  )
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
Cc: "Zhou, David\(ChunMing\)" <David1.Zhou@amd.com>, "Daenzer,
 Michel" <Michel.Daenzer@amd.com>, Carsten Haitzler <Carsten.Haitzler@arm.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, "Zhang,
 Jerry" <Jerry.Zhang@amd.com>, Christoph Hellwig <hch@infradead.org>,
 David Airlie <airlied@linux.ie>, "Huang, Ray" <Ray.Huang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Michael Ellerman <mpe@ellerman.id.au>, Will Deacon <will.deacon@arm.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, Sean Paul <sean@poorly.run>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVGh1LCBKYW4gMjQsIDIwMTkgYXQgOTowMCBBTSBBcmQgQmllc2hldXZlbAo8YXJkLmJpZXNo
ZXV2ZWxAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBPbiBUaHUsIDI0IEphbiAyMDE5IGF0IDEzOjMx
LCBLb2VuaWcsIENocmlzdGlhbgo+IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+IHdyb3RlOgo+
ID4KPiA+IEFtIDI0LjAxLjE5IHVtIDEzOjA2IHNjaHJpZWIgQXJkIEJpZXNoZXV2ZWw6Cj4gPiA+
IFRoZSBEUk0gZHJpdmVyIHN0YWNrIGlzIGRlc2lnbmVkIHRvIHdvcmsgd2l0aCBjYWNoZSBjb2hl
cmVudCBkZXZpY2VzCj4gPiA+IG9ubHksIGJ1dCBwZXJtaXRzIGFuIG9wdGltaXphdGlvbiB0byBi
ZSBlbmFibGVkIGluIHNvbWUgY2FzZXMsIHdoZXJlCj4gPiA+IGZvciBzb21lIGJ1ZmZlcnMsIGJv
dGggdGhlIENQVSBhbmQgdGhlIEdQVSB1c2UgdW5jYWNoZWQgbWFwcGluZ3MsCj4gPiA+IHJlbW92
aW5nIHRoZSBuZWVkIGZvciBETUEgc25vb3BpbmcgYW5kIGFsbG9jYXRpb24gaW4gdGhlIENQVSBj
YWNoZXMuCj4gPiA+Cj4gPiA+IFRoZSB1c2Ugb2YgdW5jYWNoZWQgR1BVIG1hcHBpbmdzIHJlbGll
cyBvbiB0aGUgY29ycmVjdCBpbXBsZW1lbnRhdGlvbgo+ID4gPiBvZiB0aGUgUENJZSBOb1Nub29w
IFRMUCBhdHRyaWJ1dGUgYnkgdGhlIHBsYXRmb3JtLCBvdGhlcndpc2UgdGhlIEdQVQo+ID4gPiB3
aWxsIHVzZSBjYWNoZWQgbWFwcGluZ3Mgbm9uZXRoZWxlc3MuIE9uIHg4NiBwbGF0Zm9ybXMsIHRo
aXMgZG9lcyBub3QKPiA+ID4gc2VlbSB0byBtYXR0ZXIsIGFzIHVuY2FjaGVkIENQVSBtYXBwaW5n
cyB3aWxsIHNub29wIHRoZSBjYWNoZXMgaW4gYW55Cj4gPiA+IGNhc2UuIEhvd2V2ZXIsIG9uIEFS
TSBhbmQgYXJtNjQsIGVuYWJsaW5nIHRoaXMgb3B0aW1pemF0aW9uIG9uIGEKPiA+ID4gcGxhdGZv
cm0gd2hlcmUgTm9Tbm9vcCBpcyBpZ25vcmVkIHJlc3VsdHMgaW4gbG9zcyBvZiBjb2hlcmVuY3ks
IHdoaWNoCj4gPiA+IGJyZWFrcyBjb3JyZWN0IG9wZXJhdGlvbiBvZiB0aGUgZGV2aWNlLiBTaW5j
ZSB3ZSBoYXZlIG5vIHdheSBvZgo+ID4gPiBkZXRlY3Rpbmcgd2hldGhlciBOb1Nub29wIHdvcmtz
IG9yIG5vdCwganVzdCBkaXNhYmxlIHRoaXMKPiA+ID4gb3B0aW1pemF0aW9uIGVudGlyZWx5IGZv
ciBBUk0gYW5kIGFybTY0Lgo+ID4gPgo+ID4gPiBDYzogQ2hyaXN0aWFuIEtvZW5pZyA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPgo+ID4gPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1
Y2hlckBhbWQuY29tPgo+ID4gPiBDYzogRGF2aWQgWmhvdSA8RGF2aWQxLlpob3VAYW1kLmNvbT4K
PiA+ID4gQ2M6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+Cj4gPiA+IENjOiBKdW53ZWkg
WmhhbmcgPEplcnJ5LlpoYW5nQGFtZC5jb20+Cj4gPiA+IENjOiBNaWNoZWwgRGFlbnplciA8bWlj
aGVsLmRhZW56ZXJAYW1kLmNvbT4KPiA+ID4gQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51
eC5pZT4KPiA+ID4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPiA+ID4gQ2M6
IE1hYXJ0ZW4gTGFua2hvcnN0IDxtYWFydGVuLmxhbmtob3JzdEBsaW51eC5pbnRlbC5jb20+Cj4g
PiA+IENjOiBNYXhpbWUgUmlwYXJkIDxtYXhpbWUucmlwYXJkQGJvb3RsaW4uY29tPgo+ID4gPiBD
YzogU2VhbiBQYXVsIDxzZWFuQHBvb3JseS5ydW4+Cj4gPiA+IENjOiBNaWNoYWVsIEVsbGVybWFu
IDxtcGVAZWxsZXJtYW4uaWQuYXU+Cj4gPiA+IENjOiBCZW5qYW1pbiBIZXJyZW5zY2htaWR0IDxi
ZW5oQGtlcm5lbC5jcmFzaGluZy5vcmc+Cj4gPiA+IENjOiBXaWxsIERlYWNvbiA8d2lsbC5kZWFj
b25AYXJtLmNvbT4KPiA+ID4gQ2M6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAaW5mcmFkZWFkLm9y
Zz4KPiA+ID4gQ2M6IFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFybS5jb20+Cj4gPiA+IENj
OiBhbWQtZ2Z4IGxpc3QgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPgo+ID4gPiBDYzog
ZHJpLWRldmVsIDxkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPgo+ID4gPiBSZXBvcnRl
ZC1ieTogQ2Fyc3RlbiBIYWl0emxlciA8Q2Fyc3Rlbi5IYWl0emxlckBhcm0uY29tPgo+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBBcmQgQmllc2hldXZlbCA8YXJkLmJpZXNoZXV2ZWxAbGluYXJvLm9yZz4K
PiA+Cj4gPiBUaGUgc3ViamVjdCBsaW5lIHNob3VsZCBwcm9iYWJseSByZWFkICJkaXNhYmxlIHVu
Y2FjaGVkLi4uIi4KPiA+Cj4KPiBVZ2gsIG9mIGNvdXJzZSAuLi4KPgo+ID4gV2l0aCB0aGF0IGZp
eGVkIHRoZSBwYXRjaCBpcyBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZwo+ID4gPGNocmlz
dGlhbi5rb2VuaWdAYW1kLmNvbT4uCj4gPgoKU2FtZToKUmV2aWV3ZWQtYnk6IEFsZXggRGV1Y2hl
ciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KCj4KPiBUaGFua3MuCj4gX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlz
dAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAps
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
