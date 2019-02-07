Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA1BC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:33:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 732832077B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vfge897G";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRtYtlJg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 732832077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6G38Wnh/+u2XxsuqSquAfDRBnUyL0C4krpXz+IGgTFg=; b=Vfge897GzG0T6P
	neEdVcprdXuX8bLJJOLkISOKro4O+tpL6cuJghWuABil1OyLSlFP5EuiZDA0dJmRMtTReOIsJ6KBT
	Nr8h3tkyzdTP8TPT/gWy/RVIo8otsQ50WUemiM1GHbeJ1K+ESZx3lqsapiVL3nxcXv8uwYrBy2ICt
	mtEUl6xFSU4ZIQjexF79GGkE4skbT4FMbzbQI61bBoUWQd+HKQ5LZdUxsBs1D1FBjuD8+svRuREBW
	ZVC+UUGyKpwdyNgCdM4ssOwHJNG3JGIyMzVn1JciF/fjpcRx1kU5eBSexEFpeiOcDHVgNnSvlR3df
	Jdy8iex8Q9UXpmgM/lPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grlgZ-0005U6-9b; Thu, 07 Feb 2019 15:33:55 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grlgV-0005Tf-QT
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 15:33:53 +0000
Received: by mail-wm1-x341.google.com with SMTP id d15so292139wmb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 07:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=NtuwhjcSa9WVQeIYC9YHkLkUJWc3nvD6vkG9KV6JWdY=;
 b=pRtYtlJgtzYwAmX0OMJSPoXh1rSAMRchSEO52oFCMher2tyZO7fEQ8Dnaf/XY64gT9
 Oxfd12yOrNyFC4LKNqi+VljU4XtPdWVqI560CPpyhXV2PfK23yBAdUJpL0QTLQxGuLUy
 2y5+VDdZ8cmtc/ZOgxNXtypsZ0hEkWo5NzRE0/VUe3tiuAbYStRW5vnyXAXscbKI+iBl
 14zoKXHWWyc4db/xBQKmchFivYoGAm5KxAwpZusoLqFW0usotQI8uGL/uT+/aT7nkgil
 bzp9gwbyZpZ8zNorFcjDwo9psu39He2ZFwi2N8sniGALFYPsm/HnLniiZvuB3Fz6gTpq
 eO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NtuwhjcSa9WVQeIYC9YHkLkUJWc3nvD6vkG9KV6JWdY=;
 b=Wxl5sYRq5FNFF3gx+Y5P8HSFahFt0kJ/FF/A07Gb6zO0r4BsZpLf4u+MKqeHILgg5/
 /YX0Gz7/584sLVijLRd+ZvsmfYFOSUtJu9Drt7UpD7g11tSN1TTJIr5eBqgXZeF4xR7H
 INLoB41VDe4prErphGpZguA/42BHE9A8i7Hh3yby/dssD4AB5JrLwPDVlLWy4In0cd/9
 RJV06J+QZszzlQUim4tjLrKr9wA+UIpKFJ2MOeLNSH57uUYwVR1+rnadcS8zHlE/GiiC
 UC/38mVjGnvODG8hPHvKE1o3OvqalSHNkv4cDVDG3lqEq2HeO9SBkNy4PaokWUNXAOJz
 kPFQ==
X-Gm-Message-State: AHQUAuYtdwWsGc71QdjqV6jknBIRljh/HkmSQQUFxez/YgQuY3BZSenI
 2VOjRHwnYbUN5OC1OTf94l8STRUOVZzpKtSgcgM=
X-Google-Smtp-Source: AHgI3IYV6uDpkiX/nqZkwTgLnsJSdxh6XdGYoFmQESC1hqUJhvkNLrxL3/tA7F52i0Pw0MWyEQNx5QoimoF0bW1LOac=
X-Received: by 2002:a1c:9e4a:: with SMTP id h71mr8129497wme.82.1549553629575; 
 Thu, 07 Feb 2019 07:33:49 -0800 (PST)
MIME-Version: 1.0
References: <20190124120658.30288-1-ard.biesheuvel@linaro.org>
 <3cca35a9-c71c-a100-b29d-31ba0d1d10b1@amd.com>
 <CAKv+Gu9OG3O4+4F2nioaQ-3U-1kwRBr5KVj-1gD1ZEsUx_Ud5A@mail.gmail.com>
 <CADnq5_PETD6umm9Df7OZ9BdaV5MZutmhN+HTAnVkcRLg5=TNWw@mail.gmail.com>
 <CAKv+Gu-Yk1iEe+cF30ee7R+hcrke9XH9MdTeERA2P-0s2QpaLw@mail.gmail.com>
 <961e758d-b0a0-8f6c-a8fa-c3047e058706@gmail.com>
 <CAKv+Gu_faPAf+0NBTNM03EUH4-_0vWbPfDQneshps5vbaU4R_Q@mail.gmail.com>
 <CAKv+Gu-4=1r8X8BUvRjcTwgxj=sZpZLyY3ABBZyzh-RsSm1eXg@mail.gmail.com>
 <f6bdd647-722b-8145-92d4-3f6c52f8a74c@gmail.com>
 <CAKv+Gu8oCAcnoo6=UikRGJQHW63JmY21y1qZteaNmh_F7HnOEQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu8oCAcnoo6=UikRGJQHW63JmY21y1qZteaNmh_F7HnOEQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 7 Feb 2019 10:33:37 -0500
Message-ID: <CADnq5_NnY2Ktw0sLGnp7x3kc6NpwPnznHUzRK=5X2n6p1843Yg@mail.gmail.com>
Subject: Re: [PATCH] drm: enable uncached DMA optimization for ARM and arm64
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_073351_886121_DD8B88EA 
X-CRM114-Status: GOOD (  22.25  )
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
Cc: "Daenzer, Michel" <Michel.Daenzer@amd.com>,
 Carsten Haitzler <Carsten.Haitzler@arm.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Will Deacon <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Christoph Hellwig <hch@infradead.org>, David Airlie <airlied@linux.ie>, "Huang,
 Ray" <Ray.Huang@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang,
 Jerry" <Jerry.Zhang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Sean Paul <sean@poorly.run>, "Koenig, Christian" <christian.koenig@amd.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVGh1LCBGZWIgNywgMjAxOSBhdCAxMDoyMCBBTSBBcmQgQmllc2hldXZlbAo8YXJkLmJpZXNo
ZXV2ZWxAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBPbiBXZWQsIDYgRmViIDIwMTkgYXQgMTk6Mzgs
IENocmlzdGlhbiBLw7ZuaWcKPiA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+IHdy
b3RlOgo+ID4KPiA+IEFtIDA2LjAyLjE5IHVtIDE4OjIzIHNjaHJpZWIgQXJkIEJpZXNoZXV2ZWw6
Cj4gPiA+IE9uIEZyaSwgMjUgSmFuIDIwMTkgYXQgMTE6MzUsIEFyZCBCaWVzaGV1dmVsIDxhcmQu
Ymllc2hldXZlbEBsaW5hcm8ub3JnPiB3cm90ZToKPiA+ID4+IE9uIEZyaSwgMjUgSmFuIDIwMTkg
YXQgMTI6MzAsIENocmlzdGlhbiBLw7ZuaWcKPiA+ID4+IDxja29lbmlnLmxlaWNodHp1bWVya2Vu
QGdtYWlsLmNvbT4gd3JvdGU6Cj4gPiA+Pj4gQW0gMjUuMDEuMTkgdW0gMDk6NDMgc2NocmllYiBB
cmQgQmllc2hldXZlbDoKPiA+ID4+Pj4gT24gVGh1LCAyNCBKYW4gMjAxOSBhdCAxNTowMSwgQWxl
eCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+IHdyb3RlOgo+ID4gPj4+Pj4gT24gVGh1
LCBKYW4gMjQsIDIwMTkgYXQgOTowMCBBTSBBcmQgQmllc2hldXZlbAo+ID4gPj4+Pj4gPGFyZC5i
aWVzaGV1dmVsQGxpbmFyby5vcmc+IHdyb3RlOgo+ID4gPj4+Pj4+IE9uIFRodSwgMjQgSmFuIDIw
MTkgYXQgMTM6MzEsIEtvZW5pZywgQ2hyaXN0aWFuCj4gPiA+Pj4+Pj4gPENocmlzdGlhbi5Lb2Vu
aWdAYW1kLmNvbT4gd3JvdGU6Cj4gPiA+Pj4+Pj4+IEFtIDI0LjAxLjE5IHVtIDEzOjA2IHNjaHJp
ZWIgQXJkIEJpZXNoZXV2ZWw6Cj4gPiA+Pj4+Pj4+PiBUaGUgRFJNIGRyaXZlciBzdGFjayBpcyBk
ZXNpZ25lZCB0byB3b3JrIHdpdGggY2FjaGUgY29oZXJlbnQgZGV2aWNlcwo+ID4gPj4+Pj4+Pj4g
b25seSwgYnV0IHBlcm1pdHMgYW4gb3B0aW1pemF0aW9uIHRvIGJlIGVuYWJsZWQgaW4gc29tZSBj
YXNlcywgd2hlcmUKPiA+ID4+Pj4+Pj4+IGZvciBzb21lIGJ1ZmZlcnMsIGJvdGggdGhlIENQVSBh
bmQgdGhlIEdQVSB1c2UgdW5jYWNoZWQgbWFwcGluZ3MsCj4gPiA+Pj4+Pj4+PiByZW1vdmluZyB0
aGUgbmVlZCBmb3IgRE1BIHNub29waW5nIGFuZCBhbGxvY2F0aW9uIGluIHRoZSBDUFUgY2FjaGVz
Lgo+ID4gPj4+Pj4+Pj4KPiA+ID4+Pj4+Pj4+IFRoZSB1c2Ugb2YgdW5jYWNoZWQgR1BVIG1hcHBp
bmdzIHJlbGllcyBvbiB0aGUgY29ycmVjdCBpbXBsZW1lbnRhdGlvbgo+ID4gPj4+Pj4+Pj4gb2Yg
dGhlIFBDSWUgTm9Tbm9vcCBUTFAgYXR0cmlidXRlIGJ5IHRoZSBwbGF0Zm9ybSwgb3RoZXJ3aXNl
IHRoZSBHUFUKPiA+ID4+Pj4+Pj4+IHdpbGwgdXNlIGNhY2hlZCBtYXBwaW5ncyBub25ldGhlbGVz
cy4gT24geDg2IHBsYXRmb3JtcywgdGhpcyBkb2VzIG5vdAo+ID4gPj4+Pj4+Pj4gc2VlbSB0byBt
YXR0ZXIsIGFzIHVuY2FjaGVkIENQVSBtYXBwaW5ncyB3aWxsIHNub29wIHRoZSBjYWNoZXMgaW4g
YW55Cj4gPiA+Pj4+Pj4+PiBjYXNlLiBIb3dldmVyLCBvbiBBUk0gYW5kIGFybTY0LCBlbmFibGlu
ZyB0aGlzIG9wdGltaXphdGlvbiBvbiBhCj4gPiA+Pj4+Pj4+PiBwbGF0Zm9ybSB3aGVyZSBOb1Nu
b29wIGlzIGlnbm9yZWQgcmVzdWx0cyBpbiBsb3NzIG9mIGNvaGVyZW5jeSwgd2hpY2gKPiA+ID4+
Pj4+Pj4+IGJyZWFrcyBjb3JyZWN0IG9wZXJhdGlvbiBvZiB0aGUgZGV2aWNlLiBTaW5jZSB3ZSBo
YXZlIG5vIHdheSBvZgo+ID4gPj4+Pj4+Pj4gZGV0ZWN0aW5nIHdoZXRoZXIgTm9Tbm9vcCB3b3Jr
cyBvciBub3QsIGp1c3QgZGlzYWJsZSB0aGlzCj4gPiA+Pj4+Pj4+PiBvcHRpbWl6YXRpb24gZW50
aXJlbHkgZm9yIEFSTSBhbmQgYXJtNjQuCj4gPiA+Pj4+Pj4+Pgo+ID4gPj4+Pj4+Pj4gQ2M6IENo
cmlzdGlhbiBLb2VuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiA+ID4+Pj4+Pj4+IENj
OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gPiA+Pj4+Pj4+PiBD
YzogRGF2aWQgWmhvdSA8RGF2aWQxLlpob3VAYW1kLmNvbT4KPiA+ID4+Pj4+Pj4+IENjOiBIdWFu
ZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgo+ID4gPj4+Pj4+Pj4gQ2M6IEp1bndlaSBaaGFuZyA8
SmVycnkuWmhhbmdAYW1kLmNvbT4KPiA+ID4+Pj4+Pj4+IENjOiBNaWNoZWwgRGFlbnplciA8bWlj
aGVsLmRhZW56ZXJAYW1kLmNvbT4KPiA+ID4+Pj4+Pj4+IENjOiBEYXZpZCBBaXJsaWUgPGFpcmxp
ZWRAbGludXguaWU+Cj4gPiA+Pj4+Pj4+PiBDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xs
LmNoPgo+ID4gPj4+Pj4+Pj4gQ2M6IE1hYXJ0ZW4gTGFua2hvcnN0IDxtYWFydGVuLmxhbmtob3Jz
dEBsaW51eC5pbnRlbC5jb20+Cj4gPiA+Pj4+Pj4+PiBDYzogTWF4aW1lIFJpcGFyZCA8bWF4aW1l
LnJpcGFyZEBib290bGluLmNvbT4KPiA+ID4+Pj4+Pj4+IENjOiBTZWFuIFBhdWwgPHNlYW5AcG9v
cmx5LnJ1bj4KPiA+ID4+Pj4+Pj4+IENjOiBNaWNoYWVsIEVsbGVybWFuIDxtcGVAZWxsZXJtYW4u
aWQuYXU+Cj4gPiA+Pj4+Pj4+PiBDYzogQmVuamFtaW4gSGVycmVuc2NobWlkdCA8YmVuaEBrZXJu
ZWwuY3Jhc2hpbmcub3JnPgo+ID4gPj4+Pj4+Pj4gQ2M6IFdpbGwgRGVhY29uIDx3aWxsLmRlYWNv
bkBhcm0uY29tPgo+ID4gPj4+Pj4+Pj4gQ2M6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAaW5mcmFk
ZWFkLm9yZz4KPiA+ID4+Pj4+Pj4+IENjOiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0u
Y29tPgo+ID4gPj4+Pj4+Pj4gQ2M6IGFtZC1nZnggbGlzdCA8YW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmc+Cj4gPiA+Pj4+Pj4+PiBDYzogZHJpLWRldmVsIDxkcmktZGV2ZWxAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnPgo+ID4gPj4+Pj4+Pj4gUmVwb3J0ZWQtYnk6IENhcnN0ZW4gSGFpdHpsZXIg
PENhcnN0ZW4uSGFpdHpsZXJAYXJtLmNvbT4KPiA+ID4+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEFy
ZCBCaWVzaGV1dmVsIDxhcmQuYmllc2hldXZlbEBsaW5hcm8ub3JnPgo+ID4gPj4+Pj4+PiBUaGUg
c3ViamVjdCBsaW5lIHNob3VsZCBwcm9iYWJseSByZWFkICJkaXNhYmxlIHVuY2FjaGVkLi4uIi4K
PiA+ID4+Pj4+Pj4KPiA+ID4+Pj4+PiBVZ2gsIG9mIGNvdXJzZSAuLi4KPiA+ID4+Pj4+Pgo+ID4g
Pj4+Pj4+PiBXaXRoIHRoYXQgZml4ZWQgdGhlIHBhdGNoIGlzIFJldmlld2VkLWJ5OiBDaHJpc3Rp
YW4gS8O2bmlnCj4gPiA+Pj4+Pj4+IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Lgo+ID4gPj4+
Pj4+Pgo+ID4gPj4+Pj4gU2FtZToKPiA+ID4+Pj4+IFJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIg
PGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gPiA+Pj4+Pgo+ID4gPj4+PiBUaGFua3MgYWxs
Cj4gPiA+Pj4+Cj4gPiA+Pj4+IFNob3VsZCBJIHJlc2VuZCB0aGUgcGF0Y2ggd2l0aCB0aGUgc3Vi
amVjdCBjb3JyZWN0ZWQ/Cj4gPiA+Pj4gSSB3aWxsIHVwZGF0ZSB0aGUgc3ViamVjdCBsaW5lIGFu
ZCBwdXNoIGl0IHVwc3RyZWFtIHRocm91Z2gKPiA+ID4+PiBkcm0tbWlzYy1uZXh0IGlmIG5vYm9k
eSBvYmplY3RzLgo+ID4gPj4+Cj4gPiA+PiBXb25kZXJmdWwsIHRoYW5rcy4KPiA+ID4gSGkgQ2hy
aXN0aWFuLAo+ID4gPgo+ID4gPiBBcmUgeW91IHN0aWxsIHBsYW5uaW5nIHRvIG1lcmdlIHRoaXMg
Zm9yIHY1LjE/Cj4gPgo+ID4gTXkgYmFkLCBvbmx5IHB1c2hlZCB0aGlzIHRvIG91ciBpbnRlcm5h
bCBicmFuY2gsIGJ1dCBmb3Jnb3Qgb3V0Cj4gPiBkcm0tbWlzYy1uZXh0Lgo+ID4KPiA+IEZpeGVk
IG5vdywgdGhhbmtzIGZvciB0aGUgcmVtaW5kZXIuCj4gPgo+Cj4gVGhhbmtzLAo+Cj4gRG9lcyBh
bnlvbmUgbWluZCBpZiBJIHByb3Bvc2UgdGhpcyBwYXRjaCBmb3IgYmFja3BvcnRpbmcgdG8gdjQu
MTkgb3IKPiBlYXJsaWVyIG9uY2UgaXQgZ2V0cyBtZXJnZWQgZm9yIHY1LjE/CgpHbyBmb3IgaXQu
ICBJIHdhcyBnb2luZyB0byBzdWdnZXN0IHRoYXQgdGhpcyBzaG91bGQgcHJvYmFibHkgZ28gdG8g
c3RhYmxlLgoKQWxleAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtYXJtLWtlcm5lbAo=
