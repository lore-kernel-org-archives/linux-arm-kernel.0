Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFF1C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:43:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 879B12184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sU7vWHk1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f1ggZk85"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 879B12184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ARD1gwBBKNKUVfvGVrhKkVjTkKeEHs/njHbCM66ogBc=; b=sU7vWHk1XWiNkk
	FZB3VwX74AP2E++K+9BUgWzoJDgkCSWzrE7+xprxP0bgAJ1BMCYNzDgezP0P0m8ZxOyWGmcAxlavM
	/68CGFGJiTE6NYU4IZqTQ2ikcwTEJ5KgEgfHm/FpuuxSY4lxMbMUPWkBdlSq5ITr1Sgo5tfV7wvHr
	s5nEQgUcwgAXfWjNDlDAnLHmigmi7r5nLU37A+E9TxcWClhijivd1TDl0TR1wIB/ZtuuBG4bvOUHU
	qvTOe7yPp8IqakkuPbcr040VcSUrnEbKffVxy3ikJBddngdzW1RyK4RRVUO+2DGN9s3vXhGGG9IWH
	J0QspuedOV6dnDF8QhQA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmx5B-0008Jb-9A; Fri, 25 Jan 2019 08:43:25 +0000
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmx57-0008J3-Df
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 08:43:23 +0000
Received: by mail-io1-xd43.google.com with SMTP id f4so7139734ion.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 00:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5C27t5i/Kxs7sqw0V4cwfbsTRjCbPSa4Pe/4IHFM4IU=;
 b=f1ggZk859V6w+zigTYcibT8r3QHPSARkxS5C9jTf8Sm2bH8BmAd0PedGXdK0Jc6EHp
 yrxCRVZfrGCkCosLH5cD7gD4aEqBABGyzT4GMdU0JmcXZIeCqUWCdwYS67AIFos/X6N9
 /Zc7r7Bogu+Zx0ac2BDv9+u0w22QbsOHfWPVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5C27t5i/Kxs7sqw0V4cwfbsTRjCbPSa4Pe/4IHFM4IU=;
 b=ZNxzy1pda8KMP6wvmYvcLB3Y+AaUR4DbJn9EG6lCSGjdRf3TATA9DIkxo4E4qsi9LL
 FTHfT0Mno9oElG67YhrSsVzNznkAMUj5eQHRnCm4ZC3BssGcTpi3fe4938TP8FYFbWBJ
 6itfkxBGryvtbIPtzTIdKLznyc6/LAMic4rDVl9cJogBwASICs9Ll4GVoBLOHfabmY8Z
 +nZr7LtupDnvBuQqK+cZ07fOxLZd8MowcxKlskwcEpEgsJerf7j6o8e7eEWJAs+VXPAD
 1sh3t7iDOXpRGQBH+3Sb+Zak4A+KDm9FqI1q9nySbFjgWcLKwntaz2CZ1Exl0ECl7Cva
 qhHA==
X-Gm-Message-State: AHQUAubBEklCqvfmPkpAvVrNoovdm9U6ZvL4VoDhDuWlrdoZZLC0/DPJ
 gnWXo9krJTZJH+/kMsGIp6V6uTBzlwqSCN71NwW9Bg==
X-Google-Smtp-Source: ALg8bN5l9hoVLJ+wkvRk2hidT/8N4aAJXqPZqBu3XHVW+oJcDKWoAZNhZUcSg4D4tAC3NuYfT+OocgJdVTPjrPTfN9I=
X-Received: by 2002:a5d:8410:: with SMTP id i16mr5987962ion.173.1548405798631; 
 Fri, 25 Jan 2019 00:43:18 -0800 (PST)
MIME-Version: 1.0
References: <20190124120658.30288-1-ard.biesheuvel@linaro.org>
 <3cca35a9-c71c-a100-b29d-31ba0d1d10b1@amd.com>
 <CAKv+Gu9OG3O4+4F2nioaQ-3U-1kwRBr5KVj-1gD1ZEsUx_Ud5A@mail.gmail.com>
 <CADnq5_PETD6umm9Df7OZ9BdaV5MZutmhN+HTAnVkcRLg5=TNWw@mail.gmail.com>
In-Reply-To: <CADnq5_PETD6umm9Df7OZ9BdaV5MZutmhN+HTAnVkcRLg5=TNWw@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 25 Jan 2019 09:43:07 +0100
Message-ID: <CAKv+Gu-Yk1iEe+cF30ee7R+hcrke9XH9MdTeERA2P-0s2QpaLw@mail.gmail.com>
Subject: Re: [PATCH] drm: enable uncached DMA optimization for ARM and arm64
To: Alex Deucher <alexdeucher@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_004321_474005_AAED24A6 
X-CRM114-Status: GOOD (  19.37  )
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

T24gVGh1LCAyNCBKYW4gMjAxOSBhdCAxNTowMSwgQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBn
bWFpbC5jb20+IHdyb3RlOgo+Cj4gT24gVGh1LCBKYW4gMjQsIDIwMTkgYXQgOTowMCBBTSBBcmQg
Qmllc2hldXZlbAo+IDxhcmQuYmllc2hldXZlbEBsaW5hcm8ub3JnPiB3cm90ZToKPiA+Cj4gPiBP
biBUaHUsIDI0IEphbiAyMDE5IGF0IDEzOjMxLCBLb2VuaWcsIENocmlzdGlhbgo+ID4gPENocmlz
dGlhbi5Lb2VuaWdAYW1kLmNvbT4gd3JvdGU6Cj4gPiA+Cj4gPiA+IEFtIDI0LjAxLjE5IHVtIDEz
OjA2IHNjaHJpZWIgQXJkIEJpZXNoZXV2ZWw6Cj4gPiA+ID4gVGhlIERSTSBkcml2ZXIgc3RhY2sg
aXMgZGVzaWduZWQgdG8gd29yayB3aXRoIGNhY2hlIGNvaGVyZW50IGRldmljZXMKPiA+ID4gPiBv
bmx5LCBidXQgcGVybWl0cyBhbiBvcHRpbWl6YXRpb24gdG8gYmUgZW5hYmxlZCBpbiBzb21lIGNh
c2VzLCB3aGVyZQo+ID4gPiA+IGZvciBzb21lIGJ1ZmZlcnMsIGJvdGggdGhlIENQVSBhbmQgdGhl
IEdQVSB1c2UgdW5jYWNoZWQgbWFwcGluZ3MsCj4gPiA+ID4gcmVtb3ZpbmcgdGhlIG5lZWQgZm9y
IERNQSBzbm9vcGluZyBhbmQgYWxsb2NhdGlvbiBpbiB0aGUgQ1BVIGNhY2hlcy4KPiA+ID4gPgo+
ID4gPiA+IFRoZSB1c2Ugb2YgdW5jYWNoZWQgR1BVIG1hcHBpbmdzIHJlbGllcyBvbiB0aGUgY29y
cmVjdCBpbXBsZW1lbnRhdGlvbgo+ID4gPiA+IG9mIHRoZSBQQ0llIE5vU25vb3AgVExQIGF0dHJp
YnV0ZSBieSB0aGUgcGxhdGZvcm0sIG90aGVyd2lzZSB0aGUgR1BVCj4gPiA+ID4gd2lsbCB1c2Ug
Y2FjaGVkIG1hcHBpbmdzIG5vbmV0aGVsZXNzLiBPbiB4ODYgcGxhdGZvcm1zLCB0aGlzIGRvZXMg
bm90Cj4gPiA+ID4gc2VlbSB0byBtYXR0ZXIsIGFzIHVuY2FjaGVkIENQVSBtYXBwaW5ncyB3aWxs
IHNub29wIHRoZSBjYWNoZXMgaW4gYW55Cj4gPiA+ID4gY2FzZS4gSG93ZXZlciwgb24gQVJNIGFu
ZCBhcm02NCwgZW5hYmxpbmcgdGhpcyBvcHRpbWl6YXRpb24gb24gYQo+ID4gPiA+IHBsYXRmb3Jt
IHdoZXJlIE5vU25vb3AgaXMgaWdub3JlZCByZXN1bHRzIGluIGxvc3Mgb2YgY29oZXJlbmN5LCB3
aGljaAo+ID4gPiA+IGJyZWFrcyBjb3JyZWN0IG9wZXJhdGlvbiBvZiB0aGUgZGV2aWNlLiBTaW5j
ZSB3ZSBoYXZlIG5vIHdheSBvZgo+ID4gPiA+IGRldGVjdGluZyB3aGV0aGVyIE5vU25vb3Agd29y
a3Mgb3Igbm90LCBqdXN0IGRpc2FibGUgdGhpcwo+ID4gPiA+IG9wdGltaXphdGlvbiBlbnRpcmVs
eSBmb3IgQVJNIGFuZCBhcm02NC4KPiA+ID4gPgo+ID4gPiA+IENjOiBDaHJpc3RpYW4gS29lbmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gPiA+ID4gQ2M6IEFsZXggRGV1Y2hlciA8YWxl
eGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiA+ID4gPiBDYzogRGF2aWQgWmhvdSA8RGF2aWQxLlpo
b3VAYW1kLmNvbT4KPiA+ID4gPiBDYzogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KPiA+
ID4gPiBDYzogSnVud2VpIFpoYW5nIDxKZXJyeS5aaGFuZ0BhbWQuY29tPgo+ID4gPiA+IENjOiBN
aWNoZWwgRGFlbnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4KPiA+ID4gPiBDYzogRGF2aWQg
QWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgo+ID4gPiA+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5p
ZWxAZmZ3bGwuY2g+Cj4gPiA+ID4gQ2M6IE1hYXJ0ZW4gTGFua2hvcnN0IDxtYWFydGVuLmxhbmto
b3JzdEBsaW51eC5pbnRlbC5jb20+Cj4gPiA+ID4gQ2M6IE1heGltZSBSaXBhcmQgPG1heGltZS5y
aXBhcmRAYm9vdGxpbi5jb20+Cj4gPiA+ID4gQ2M6IFNlYW4gUGF1bCA8c2VhbkBwb29ybHkucnVu
Pgo+ID4gPiA+IENjOiBNaWNoYWVsIEVsbGVybWFuIDxtcGVAZWxsZXJtYW4uaWQuYXU+Cj4gPiA+
ID4gQ2M6IEJlbmphbWluIEhlcnJlbnNjaG1pZHQgPGJlbmhAa2VybmVsLmNyYXNoaW5nLm9yZz4K
PiA+ID4gPiBDYzogV2lsbCBEZWFjb24gPHdpbGwuZGVhY29uQGFybS5jb20+Cj4gPiA+ID4gQ2M6
IENocmlzdG9waCBIZWxsd2lnIDxoY2hAaW5mcmFkZWFkLm9yZz4KPiA+ID4gPiBDYzogUm9iaW4g
TXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4KPiA+ID4gPiBDYzogYW1kLWdmeCBsaXN0IDxh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4KPiA+ID4gPiBDYzogZHJpLWRldmVsIDxkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPgo+ID4gPiA+IFJlcG9ydGVkLWJ5OiBDYXJzdGVu
IEhhaXR6bGVyIDxDYXJzdGVuLkhhaXR6bGVyQGFybS5jb20+Cj4gPiA+ID4gU2lnbmVkLW9mZi1i
eTogQXJkIEJpZXNoZXV2ZWwgPGFyZC5iaWVzaGV1dmVsQGxpbmFyby5vcmc+Cj4gPiA+Cj4gPiA+
IFRoZSBzdWJqZWN0IGxpbmUgc2hvdWxkIHByb2JhYmx5IHJlYWQgImRpc2FibGUgdW5jYWNoZWQu
Li4iLgo+ID4gPgo+ID4KPiA+IFVnaCwgb2YgY291cnNlIC4uLgo+ID4KPiA+ID4gV2l0aCB0aGF0
IGZpeGVkIHRoZSBwYXRjaCBpcyBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZwo+ID4gPiA8
Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPi4KPiA+ID4KPgo+IFNhbWU6Cj4gUmV2aWV3ZWQtYnk6
IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPgoKVGhhbmtzIGFsbAoK
U2hvdWxkIEkgcmVzZW5kIHRoZSBwYXRjaCB3aXRoIHRoZSBzdWJqZWN0IGNvcnJlY3RlZD8KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1r
ZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJu
ZWwK
