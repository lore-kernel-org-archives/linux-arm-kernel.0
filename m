Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762F6C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:23:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 435CD2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l686oR+B";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SCvzvdVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 435CD2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PZeKbigRtxjlyzxMRk5AqGsP2ol90VuROq7GRQUSQ5Q=; b=l686oR+B1JI/Ll
	j6197a5rixeicE0ZKRBCxdzEUsRrA1T/Jhgep9UGvJhd/TImeZ86nBETgVH/N3Jc7ZCsCRuktxxrP
	MYRMyiYAS0FY87wMyHfLC/XKlSGd1engHkFtwEIYTl3TEDkeXKMVDXQKXVH0jhFRK7c/qFqVZdWwm
	SVxsyxFLQ+WgmTyd68A1Fo7MXpVar0BFctnrrJhVgqhZK3vRS0uicn4aibcSuG16DfMNmvvE2j8rB
	tyOwsZ9TrJKmdqv2Xluy496g0XR/h/J7oFM81h4gWKLrTGQH3n2uPtjFKL4Wy94h6VW/WrM5gyU/S
	4CyGP563XRUbjmeRNH8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grQv4-00056E-El; Wed, 06 Feb 2019 17:23:30 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grQv1-0004x9-6Q
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 17:23:28 +0000
Received: by mail-ed1-x542.google.com with SMTP id r15so5107305eds.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 06 Feb 2019 09:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=JvcKwIWlny3ttJZ1xLAWt497mnvC18dJy450P90yM2w=;
 b=SCvzvdVOhvlAy67voL7FYAvyuejhJl4vSCGdpxJlOMsY+8wabGiSJZA1uUaEPZSzJz
 6TsIIgrJRKv/aNHU8vW8J4FSe1X/Xw6iDZGBqG5c9rNEd3BJoQQdQNmcLBMKscJmUJ7b
 4Z10Md+g3Fr53D5TOrI3G/vYYXS+OP3EFKsm48qVNtslHNlAiWabEvqagd43sg8AF2q3
 L+kGfJBklnwUrC2dsnIJdEFK79ARloXzeMalaaUpT1yxSYeZtxYpLj6STdegY+D3w6wa
 0AbFdVPqaCQaS+PpizEmsAudri2P7nzy7+k9j/2bfYw1FnGwmkdaoZAXYxcVWAk7nYqB
 TLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=JvcKwIWlny3ttJZ1xLAWt497mnvC18dJy450P90yM2w=;
 b=TMQ/AA6mXIgFtugo/HtWfXtqfzDul/WdAxi3GcFTFNgRt8YqinzHPGncYovqwPkYKv
 N3PtysnYvHIaWEBa7NzDgbzGnQx9Xt1VPBkwkZoO3eY+r0hKCvxkENnRTQZMexCGXuNj
 VDo/13hVLV6uIaFVUAmTIPqofA8q8yVILPmXE93MOn9Zs+ITpVO4G6cyR5dC/Ghg7YC3
 p+egYP1O3MDbQF8z24htzj6DHRaapsfqZhe5Mvbqwylhw8XoN99eDIHE9WbNDHYpF66G
 Lyj+rU0FlfU0HqtVFYklLE5rd9PviCBvL0bwcQWbpnRLW76TtNcT5lactxlh959vp6Da
 CZxw==
X-Gm-Message-State: AHQUAuZg6mZCYMgP+LtagoeChZkxtSdIRYbHhXXUE9kwT9xzPQEC0APM
 8Hx+jx6OwvDi/e1WPA3+590SM/V6cJDuDMpEUQomyA==
X-Google-Smtp-Source: AHgI3IZ2bjGbksxVz6NccXNkBWqH4dgXoKknycBdJ4EIDM0+e5f+SVWZ2Q00jPjLBtxS5vmnti5hpj28QUnju70CS7U=
X-Received: by 2002:a17:906:b38a:: with SMTP id
 o10mr3789264ejz.217.1549473804836; 
 Wed, 06 Feb 2019 09:23:24 -0800 (PST)
MIME-Version: 1.0
References: <20190124120658.30288-1-ard.biesheuvel@linaro.org>
 <3cca35a9-c71c-a100-b29d-31ba0d1d10b1@amd.com>
 <CAKv+Gu9OG3O4+4F2nioaQ-3U-1kwRBr5KVj-1gD1ZEsUx_Ud5A@mail.gmail.com>
 <CADnq5_PETD6umm9Df7OZ9BdaV5MZutmhN+HTAnVkcRLg5=TNWw@mail.gmail.com>
 <CAKv+Gu-Yk1iEe+cF30ee7R+hcrke9XH9MdTeERA2P-0s2QpaLw@mail.gmail.com>
 <961e758d-b0a0-8f6c-a8fa-c3047e058706@gmail.com>
 <CAKv+Gu_faPAf+0NBTNM03EUH4-_0vWbPfDQneshps5vbaU4R_Q@mail.gmail.com>
In-Reply-To: <CAKv+Gu_faPAf+0NBTNM03EUH4-_0vWbPfDQneshps5vbaU4R_Q@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 6 Feb 2019 17:23:13 +0000
Message-ID: <CAKv+Gu-4=1r8X8BUvRjcTwgxj=sZpZLyY3ABBZyzh-RsSm1eXg@mail.gmail.com>
Subject: Re: [PATCH] drm: enable uncached DMA optimization for ARM and arm64
To: "Koenig, Christian" <christian.koenig@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_092327_244341_B47D48AD 
X-CRM114-Status: GOOD (  19.33  )
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
Cc: Will Deacon <will.deacon@arm.com>,
 Carsten Haitzler <Carsten.Haitzler@arm.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Michael Ellerman <mpe@ellerman.id.au>, David Airlie <airlied@linux.ie>,
 "Daenzer, Michel" <Michel.Daenzer@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Christoph Hellwig <hch@infradead.org>, "Zhang, Jerry" <Jerry.Zhang@amd.com>,
 "Huang, Ray" <Ray.Huang@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexdeucher@gmail.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, Sean Paul <sean@poorly.run>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCAyNSBKYW4gMjAxOSBhdCAxMTozNSwgQXJkIEJpZXNoZXV2ZWwgPGFyZC5iaWVzaGV1
dmVsQGxpbmFyby5vcmc+IHdyb3RlOgo+Cj4gT24gRnJpLCAyNSBKYW4gMjAxOSBhdCAxMjozMCwg
Q2hyaXN0aWFuIEvDtm5pZwo+IDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3Jv
dGU6Cj4gPgo+ID4gQW0gMjUuMDEuMTkgdW0gMDk6NDMgc2NocmllYiBBcmQgQmllc2hldXZlbDoK
PiA+ID4gT24gVGh1LCAyNCBKYW4gMjAxOSBhdCAxNTowMSwgQWxleCBEZXVjaGVyIDxhbGV4ZGV1
Y2hlckBnbWFpbC5jb20+IHdyb3RlOgo+ID4gPj4gT24gVGh1LCBKYW4gMjQsIDIwMTkgYXQgOTow
MCBBTSBBcmQgQmllc2hldXZlbAo+ID4gPj4gPGFyZC5iaWVzaGV1dmVsQGxpbmFyby5vcmc+IHdy
b3RlOgo+ID4gPj4+IE9uIFRodSwgMjQgSmFuIDIwMTkgYXQgMTM6MzEsIEtvZW5pZywgQ2hyaXN0
aWFuCj4gPiA+Pj4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4gd3JvdGU6Cj4gPiA+Pj4+IEFt
IDI0LjAxLjE5IHVtIDEzOjA2IHNjaHJpZWIgQXJkIEJpZXNoZXV2ZWw6Cj4gPiA+Pj4+PiBUaGUg
RFJNIGRyaXZlciBzdGFjayBpcyBkZXNpZ25lZCB0byB3b3JrIHdpdGggY2FjaGUgY29oZXJlbnQg
ZGV2aWNlcwo+ID4gPj4+Pj4gb25seSwgYnV0IHBlcm1pdHMgYW4gb3B0aW1pemF0aW9uIHRvIGJl
IGVuYWJsZWQgaW4gc29tZSBjYXNlcywgd2hlcmUKPiA+ID4+Pj4+IGZvciBzb21lIGJ1ZmZlcnMs
IGJvdGggdGhlIENQVSBhbmQgdGhlIEdQVSB1c2UgdW5jYWNoZWQgbWFwcGluZ3MsCj4gPiA+Pj4+
PiByZW1vdmluZyB0aGUgbmVlZCBmb3IgRE1BIHNub29waW5nIGFuZCBhbGxvY2F0aW9uIGluIHRo
ZSBDUFUgY2FjaGVzLgo+ID4gPj4+Pj4KPiA+ID4+Pj4+IFRoZSB1c2Ugb2YgdW5jYWNoZWQgR1BV
IG1hcHBpbmdzIHJlbGllcyBvbiB0aGUgY29ycmVjdCBpbXBsZW1lbnRhdGlvbgo+ID4gPj4+Pj4g
b2YgdGhlIFBDSWUgTm9Tbm9vcCBUTFAgYXR0cmlidXRlIGJ5IHRoZSBwbGF0Zm9ybSwgb3RoZXJ3
aXNlIHRoZSBHUFUKPiA+ID4+Pj4+IHdpbGwgdXNlIGNhY2hlZCBtYXBwaW5ncyBub25ldGhlbGVz
cy4gT24geDg2IHBsYXRmb3JtcywgdGhpcyBkb2VzIG5vdAo+ID4gPj4+Pj4gc2VlbSB0byBtYXR0
ZXIsIGFzIHVuY2FjaGVkIENQVSBtYXBwaW5ncyB3aWxsIHNub29wIHRoZSBjYWNoZXMgaW4gYW55
Cj4gPiA+Pj4+PiBjYXNlLiBIb3dldmVyLCBvbiBBUk0gYW5kIGFybTY0LCBlbmFibGluZyB0aGlz
IG9wdGltaXphdGlvbiBvbiBhCj4gPiA+Pj4+PiBwbGF0Zm9ybSB3aGVyZSBOb1Nub29wIGlzIGln
bm9yZWQgcmVzdWx0cyBpbiBsb3NzIG9mIGNvaGVyZW5jeSwgd2hpY2gKPiA+ID4+Pj4+IGJyZWFr
cyBjb3JyZWN0IG9wZXJhdGlvbiBvZiB0aGUgZGV2aWNlLiBTaW5jZSB3ZSBoYXZlIG5vIHdheSBv
Zgo+ID4gPj4+Pj4gZGV0ZWN0aW5nIHdoZXRoZXIgTm9Tbm9vcCB3b3JrcyBvciBub3QsIGp1c3Qg
ZGlzYWJsZSB0aGlzCj4gPiA+Pj4+PiBvcHRpbWl6YXRpb24gZW50aXJlbHkgZm9yIEFSTSBhbmQg
YXJtNjQuCj4gPiA+Pj4+Pgo+ID4gPj4+Pj4gQ2M6IENocmlzdGlhbiBLb2VuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4KPiA+ID4+Pj4+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5k
ZXVjaGVyQGFtZC5jb20+Cj4gPiA+Pj4+PiBDYzogRGF2aWQgWmhvdSA8RGF2aWQxLlpob3VAYW1k
LmNvbT4KPiA+ID4+Pj4+IENjOiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgo+ID4gPj4+
Pj4gQ2M6IEp1bndlaSBaaGFuZyA8SmVycnkuWmhhbmdAYW1kLmNvbT4KPiA+ID4+Pj4+IENjOiBN
aWNoZWwgRGFlbnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KPiA+ID4+Pj4+IENjOiBEYXZp
ZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+Cj4gPiA+Pj4+PiBDYzogRGFuaWVsIFZldHRlciA8
ZGFuaWVsQGZmd2xsLmNoPgo+ID4gPj4+Pj4gQ2M6IE1hYXJ0ZW4gTGFua2hvcnN0IDxtYWFydGVu
Lmxhbmtob3JzdEBsaW51eC5pbnRlbC5jb20+Cj4gPiA+Pj4+PiBDYzogTWF4aW1lIFJpcGFyZCA8
bWF4aW1lLnJpcGFyZEBib290bGluLmNvbT4KPiA+ID4+Pj4+IENjOiBTZWFuIFBhdWwgPHNlYW5A
cG9vcmx5LnJ1bj4KPiA+ID4+Pj4+IENjOiBNaWNoYWVsIEVsbGVybWFuIDxtcGVAZWxsZXJtYW4u
aWQuYXU+Cj4gPiA+Pj4+PiBDYzogQmVuamFtaW4gSGVycmVuc2NobWlkdCA8YmVuaEBrZXJuZWwu
Y3Jhc2hpbmcub3JnPgo+ID4gPj4+Pj4gQ2M6IFdpbGwgRGVhY29uIDx3aWxsLmRlYWNvbkBhcm0u
Y29tPgo+ID4gPj4+Pj4gQ2M6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAaW5mcmFkZWFkLm9yZz4K
PiA+ID4+Pj4+IENjOiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPgo+ID4gPj4+
Pj4gQ2M6IGFtZC1nZnggbGlzdCA8YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+Cj4gPiA+
Pj4+PiBDYzogZHJpLWRldmVsIDxkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPgo+ID4g
Pj4+Pj4gUmVwb3J0ZWQtYnk6IENhcnN0ZW4gSGFpdHpsZXIgPENhcnN0ZW4uSGFpdHpsZXJAYXJt
LmNvbT4KPiA+ID4+Pj4+IFNpZ25lZC1vZmYtYnk6IEFyZCBCaWVzaGV1dmVsIDxhcmQuYmllc2hl
dXZlbEBsaW5hcm8ub3JnPgo+ID4gPj4+PiBUaGUgc3ViamVjdCBsaW5lIHNob3VsZCBwcm9iYWJs
eSByZWFkICJkaXNhYmxlIHVuY2FjaGVkLi4uIi4KPiA+ID4+Pj4KPiA+ID4+PiBVZ2gsIG9mIGNv
dXJzZSAuLi4KPiA+ID4+Pgo+ID4gPj4+PiBXaXRoIHRoYXQgZml4ZWQgdGhlIHBhdGNoIGlzIFJl
dmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnCj4gPiA+Pj4+IDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+Lgo+ID4gPj4+Pgo+ID4gPj4gU2FtZToKPiA+ID4+IFJldmlld2VkLWJ5OiBBbGV4IERl
dWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gPiA+Pgo+ID4gPiBUaGFua3MgYWxs
Cj4gPiA+Cj4gPiA+IFNob3VsZCBJIHJlc2VuZCB0aGUgcGF0Y2ggd2l0aCB0aGUgc3ViamVjdCBj
b3JyZWN0ZWQ/Cj4gPgo+ID4gSSB3aWxsIHVwZGF0ZSB0aGUgc3ViamVjdCBsaW5lIGFuZCBwdXNo
IGl0IHVwc3RyZWFtIHRocm91Z2gKPiA+IGRybS1taXNjLW5leHQgaWYgbm9ib2R5IG9iamVjdHMu
Cj4gPgo+Cj4gV29uZGVyZnVsLCB0aGFua3MuCgpIaSBDaHJpc3RpYW4sCgpBcmUgeW91IHN0aWxs
IHBsYW5uaW5nIHRvIG1lcmdlIHRoaXMgZm9yIHY1LjE/CgpUaGFua3MsCkFyZC4KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
