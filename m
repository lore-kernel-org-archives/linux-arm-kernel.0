Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8214C316A5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:28:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ED4921726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RqqWYWkD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="At2DcbcQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED4921726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AZND7IX2rxrKecHL9ez5lSJX/aZcnHKpNLj4hDC5TnI=; b=RqqWYWkDs3EIP4
	sGTdE+3nVgVJbsbKWxqq00oewhJYM2nMyoZqnknN4Pe5WpK6lh9+no0B+JiqIjkQyARIZnFyIkTLX
	56qSGfgJ+dAURt2hH2g6XEwa+9JQYZphjaEAWS1jHbn503/jwjlUDroxCEVFIuRDtX+QM7lyVokzy
	BJc7/9u0lGEjO/TCNW8V4I7Fd2REMgVu3bEMbu4sLaJ1wki6I4E23evEcpBsyj6K9uBjYa/kkZ1e1
	q5FsB3UaA39+gn6jDpVWj99ayAUzF5JEALfKp/4NmieZfk/cq0X7zb+WUFbsIL5Tp49guIcym/Kbv
	LWW4miVZy0Fy6Jxa3OzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gleJS-0003k3-59; Mon, 21 Jan 2019 18:28:46 +0000
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gleJO-0003jg-Pt
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 18:28:44 +0000
Received: by mail-io1-xd42.google.com with SMTP id s22so17101699ioc.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 10:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=cjZ5Vxrrg39jcD2RwsLl+XciRWqrJDP2EHI7an4ZI08=;
 b=At2DcbcQUOgl+eCZ1BsYQ0X5ljSIRpcifYQx2jRYqh4h6fCsnn8QY/fx8b/1ywjX0e
 L/jZ5QjtAN2NH5b1Rbt4kLrHvDVUCwowX8AyO2AYDEqX250Me9p9QWcKxz9ZUZEhoNZi
 R5QGfUGEuASEP+OLz5DAjDgzIVeKhxsxviZcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cjZ5Vxrrg39jcD2RwsLl+XciRWqrJDP2EHI7an4ZI08=;
 b=CUGaaVGvsE8jZc4pdEJjvd8AA7ttSKdHN2Ux1yAGwqB0m7qTTFAgFS2h62QVQZyv90
 Li9IXwKwsVdbvo4pWLWMbsoqTAtCVstgjh2XD3xv0k/7soGeKPjo2V+ww0u4U2L0gJKL
 vHys2D2obM1IO2rewTNBPNUFN4EyW9jdBKUHRABWwG6RiUtPClu2hXbyG5piaBQsg7/p
 QvowjSAwilI6cKC6UMbL4h/miZ5s4goXoanlkJ6h+ORSZkIWrIQ+bQ0U1QT9EH2MUcBX
 hPL5vxidmUHY6P1KRAasRVYBhzFmfY0HcInWKj0XMVih/Oz/6AAKWnJ1+WZcaTcalM6P
 WhOQ==
X-Gm-Message-State: AJcUukd+JHAYuBR/FauvZMd3KG+h10LAPDYCc0w7gGn3mL7PJ013J+RM
 b8I5GbXJJ6/QtwkKAD36K2KXjOmpo5kDp8m4mOcGOQ==
X-Google-Smtp-Source: ALg8bN7L/mGV1rcOL5b/ftEwv+cqJaT9ZIqxkpGx05uQu8yKMYQswwAgRvB/FZ1DUJZwoNeBmdrbxfsoZz69nvGBmr4=
X-Received: by 2002:a5e:c206:: with SMTP id v6mr18094736iop.60.1548095321815; 
 Mon, 21 Jan 2019 10:28:41 -0800 (PST)
MIME-Version: 1.0
References: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
 <20190121150734.GA30582@infradead.org>
 <CAKv+Gu-hR=uieOeg7QheA5yfAycUoi2vjZsDUvROKVjW4eUNqw@mail.gmail.com>
 <20190121155908.GA8084@infradead.org>
 <CAKv+Gu8LzS9OgvVnzUT8BZWVgDmx4OfqNiPSf+8=riY_LByN-g@mail.gmail.com>
 <20190121162238.GA17651@infradead.org>
 <CAKv+Gu-5V-UjP_YzZBCEsa+o_G6BRSVw2ZimYGNEfRGf-aRPNg@mail.gmail.com>
 <59ccf85d-b99d-b5c8-ea87-66c2a892e197@daenzer.net>
 <CAKv+Gu8OkbHwY5UBxahpQpM_gKh2331pQ6o-4YyJdLurbFNHvw@mail.gmail.com>
 <ccc775d3-3053-ab79-dac8-4feb28e8e690@daenzer.net>
 <CAKv+Gu-9VKL5RjScbKss4YfH1Cb8WbXmzU_0UsStnoXJcML7Rg@mail.gmail.com>
 <850b6aee-0040-c333-b125-45211c18ada5@daenzer.net>
In-Reply-To: <850b6aee-0040-c333-b125-45211c18ada5@daenzer.net>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 21 Jan 2019 19:28:30 +0100
Message-ID: <CAKv+Gu99zHqcQtj6TiOXAr3Qa6WWhKem+DHVA_mAQ0-Bc0Vbqw@mail.gmail.com>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_102842_844473_4A669D1E 
X-CRM114-Status: GOOD (  21.88  )
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
Cc: David Zhou <David1.Zhou@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>,
 David Airlie <airlied@linux.ie>, Huang Rui <ray.huang@amd.com>,
 dri-devel <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Michael Ellerman <mpe@ellerman.id.au>, Junwei Zhang <Jerry.Zhang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Sean Paul <sean@poorly.run>,
 Christian Koenig <christian.koenig@amd.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCAyMSBKYW4gMjAxOSBhdCAxOToyNCwgTWljaGVsIETDpG56ZXIgPG1pY2hlbEBkYWVu
emVyLm5ldD4gd3JvdGU6Cj4KPiBPbiAyMDE5LTAxLTIxIDc6MjAgcC5tLiwgQXJkIEJpZXNoZXV2
ZWwgd3JvdGU6Cj4gPiBPbiBNb24sIDIxIEphbiAyMDE5IGF0IDE5OjA0LCBNaWNoZWwgRMOkbnpl
ciA8bWljaGVsQGRhZW56ZXIubmV0PiB3cm90ZToKPiA+Pgo+ID4+IE9uIDIwMTktMDEtMjEgNjo1
OSBwLm0uLCBBcmQgQmllc2hldXZlbCB3cm90ZToKPiA+Pj4gT24gTW9uLCAyMSBKYW4gMjAxOSBh
dCAxODo1NSwgTWljaGVsIETDpG56ZXIgPG1pY2hlbEBkYWVuemVyLm5ldD4gd3JvdGU6Cj4gPj4+
Pgo+ID4+Pj4gT24gMjAxOS0wMS0yMSA1OjMwIHAubS4sIEFyZCBCaWVzaGV1dmVsIHdyb3RlOgo+
ID4+Pj4+IE9uIE1vbiwgMjEgSmFuIDIwMTkgYXQgMTc6MjIsIENocmlzdG9waCBIZWxsd2lnIDxo
Y2hAaW5mcmFkZWFkLm9yZz4gd3JvdGU6Cj4gPj4+Pj4KPiA+Pj4+Pj4gVW50aWwgdGhhdCBoYXBw
ZW5zIHdlIHNob3VsZCBqdXN0IGNoYW5nZSB0aGUgZHJpdmVyIGlmZGVmcyB0byBkZWZhdWx0Cj4g
Pj4+Pj4+IHRoZSBoYWNrcyB0byBvZmYgYW5kIG9ubHkgZW5hYmxlIHRoZW0gb24gc2V0dXBzIHdo
ZXJlIHdlIDEwMCUKPiA+Pj4+Pj4gcG9zaXRpdmVseSBrbm93IHRoYXQgdGhleSBhY3R1YWxseSB3
b3JrLiAgQW5kIGRvY3VtZW50IHRoYXQgZmFjdAo+ID4+Pj4+PiBpbiBiaWcgZmF0IGNvbW1lbnRz
Lgo+ID4+Pj4+Cj4gPj4+Pj4gV2VsbCwgYXMgSSBtZW50aW9uZWQgaW4gbXkgY29tbWl0IGxvZyBh
cyB3ZWxsLCBpZiB3ZSBkZWZhdWx0IHRvIG9mZgo+ID4+Pj4+IHVubGVzcyBDT05GSUdfWDg2LCB3
ZSBtYXkgYnJlYWsgd29ya2luZyBzZXR1cHMgb24gTUlQUyBhbmQgUG93ZXIgd2hlcmUKPiA+Pj4+
PiB0aGUgZGV2aWNlIGlzIGluIGZhY3Qgbm9uLWNhY2hlIGNvaGVyZW50LCBhbmQgcmVsaWVzIG9u
IHRoaXMKPiA+Pj4+PiAnb3B0aW1pemF0aW9uJyB0byBnZXQgdGhpbmdzIHdvcmtpbmcuCj4gPj4+
Pgo+ID4+Pj4gRldJVywgdGhlIGFtZGdwdSBkcml2ZXIgZG9lc24ndCByZWx5IG9uIG5vbi1zbm9v
cGVkIHRyYW5zZmVycyBmb3IKPiA+Pj4+IGNvcnJlY3QgYmFzaWMgb3BlcmF0aW9uICh0aGUgc2Nl
bmFyaW8gQ2hyaXN0aWFuIGJyb3VnaHQgdXAgaXMgYSB2ZXJ5Cj4gPj4+PiBzcGVjaWFsaXplZCB1
c2UtY2FzZSksIHNvIHRoYXQgc2hvdWxkbid0IGJlIGFuIGlzc3VlLgo+ID4+Pj4KPiA+Pj4KPiA+
Pj4gVGhlIHBvaW50IGlzIHRoYXQgdGhpcyBpcyBvbmx5IHRydWUgZm9yIHg4Ni4KPiA+Pj4KPiA+
Pj4gT24gb3RoZXIgYXJjaGl0ZWN0dXJlcywgdGhlIHVzZSBvZiBub24tY2FjaGVkIG1hcHBpbmdz
IG9uIHRoZSBDUFUgc2lkZQo+ID4+PiBtZWFucyB0aGF0IHlvdSAvZG8vIHJlbHkgb24gbm9uLXNu
b29wZWQgdHJhbnNmZXJzLCBzaW5jZSBpZiB0aG9zZQo+ID4+PiB0cmFuc2ZlcnMgdHVybiBvdXQg
bm90IHRvIHNub29wIGluYWR2ZXJ0ZW50bHksIHRoZSBhY2Nlc3NlcyBhcmUKPiA+Pj4gaW5jb2hl
cmVudCB3aXRoIHRoZSBDUFUncyB2aWV3IG9mIG1lbW9yeS4KPiA+Pgo+ID4+IFRoZSBkcml2ZXIg
Z2VuZXJhbGx5IG9ubHkgdXNlcyBub24tY2FjaGVkIG1hcHBpbmdzIGlmCj4gPj4gZHJtX2FyY2gv
ZGV2aWNlX2Nhbl93Y19tZW1vcnkgcmV0dXJucyB0cnVlLgo+ID4+Cj4gPgo+ID4gSW5kZWVkLiBB
bmQgc28gd2Ugc2hvdWxkIHRha2UgY2FyZSB0byBvbmx5IHJldHVybiAndHJ1ZScgZnJvbSB0aGF0
Cj4gPiBmdW5jdGlvbiBpZiBpdCBpcyBndWFyYW50ZWVkIHRoYXQgbm9uLWNhY2hlZCBDUFUgbWFw
cGluZ3MgYXJlIGNvaGVyZW50Cj4gPiB3aXRoIHRoZSBtYXBwaW5ncyB1c2VkIGJ5IHRoZSBHUFUs
IGVpdGhlciBiZWNhdXNlIHRoYXQgaXMgYWx3YXlzIHRoZQo+ID4gY2FzZSAobGlrZSBvbiB4ODYp
LCBvciBiZWNhdXNlIHdlIGtub3cgdGhhdCB0aGUgcGxhdGZvcm0gaW4gcXVlc3Rpb24KPiA+IGlt
cGxlbWVudHMgTm9Tbm9vcCBjb3JyZWN0bHkgdGhyb3VnaG91dCB0aGUgaW50ZXJjb25uZWN0Lgo+
ID4KPiA+IFdoYXQgc2VlbXMgdG8gYmUgY29tcGxpY2F0aW5nIG1hdHRlcnMgaXMgdGhhdCBpbiBz
b21lIGNhc2VzLCB0aGUKPiA+IGRldmljZSBpcyBub24tY2FjaGUgY29oZXJlbnQgdG8gYmVnaW4g
d2l0aCwgc28gcmVnYXJkbGVzcyBvZiB3aGV0aGVyCj4gPiB0aGUgTm9Tbm9vcCBhdHRyaWJ1dGUg
aXMgdXNlZCBvciBub3QsIHRob3NlIGFjY2Vzc2VzIHdpbGwgbm90IHNub29wIGluCj4gPiB0aGUg
Y2FjaGVzIGFuZCBiZSBjb2hlcmVudCB3aXRoIHRoZSBub24tY2FjaGVkIG1hcHBpbmdzIHVzZWQg
YnkgdGhlCj4gPiBDUFUuIFNvIGlmIHdlIHJlc3RyaWN0IHRoaXMgb3B0aW1pemF0aW9uIFtvbiBu
b24tWDg2XSB0byBwbGF0Zm9ybXMKPiA+IHRoYXQgYXJlIGtub3duIHRvIGltcGxlbWVudCBOb1Nu
b29wIGNvcnJlY3RseSwgd2UgbWF5IGJyZWFrIHBsYXRmb3Jtcwo+ID4gdGhhdCBhcmUgaW1wbGlj
aXRseSBOb1Nub29wIGFsbCB0aGUgdGltZS4KPgo+IFNpbmNlIHRoZSBkcml2ZXIgZ2VuZXJhbGx5
IGRvZXNuJ3QgcmVseSBvbiBub24tc25vb3BlZCBhY2Nlc3NlcyBmb3IKPiBjb3JyZWN0bmVzcywg
dGhhdCBjb3VsZG4ndCAiYnJlYWsiIGFueXRoaW5nIHRoYXQgaGFzbid0IGFsd2F5cyBiZWVuIGJy
b2tlbi4KPgoKQWdhaW4sIHRoYXQgaXMgb25seSB0cnVlIG9uIHg4Ni4KCk9uIG90aGVyIGFyY2hp
dGVjdHVyZXMsIERNQSB3cml0ZXMgZnJvbSB0aGUgZGV2aWNlIG1heSBhbGxvY2F0ZSBpbiB0aGUK
Y2FjaGVzLCBhbmQgYmUgaW52aXNpYmxlIHRvIHRoZSBDUFUgd2hlbiBpdCB1c2VzIG5vbi1jYWNo
ZWQgbWFwcGluZ3MuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1hcm0ta2VybmVsCg==
