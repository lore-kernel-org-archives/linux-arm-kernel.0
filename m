Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606D7C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:01:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2723D21872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="srH3eFVQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m0bZv4kP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2723D21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pUEmL8JrhIoIGzxBbjLinPuAei7nfLbyHkzymsElo9g=; b=srH3eFVQuXknyq
	TEDJYAXuptT/ueqM+hPM443jY4LVf++wdkQXSov6imAg6DPtDeYoc7y8DKWH0n5pXYlCwkSV0Brtl
	H/ltfEJJO9ZppyqJM6GH40E+LuHwg60KFUUktLHPUyTSrPL7Nr4fgza9UfJo/y/IarRtXrsaDu+pr
	vylCZlXT9HA79Vp1rYcfCfMVAtL8E26los9oM6JiSjslf389UGXYpD70S7qSL0nSN8RSzYx6yQwTJ
	BNeAmWNH3bSPJvqCPJ8vNCM/nw0B09e5KuDMm/RawoSeOaMasvqD/ntyTy6Wis0z0DMisZN2iKmY1
	zPBf/oKQV2jmlqMj6DGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grm7U-0001vT-GD; Thu, 07 Feb 2019 16:01:44 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grm7P-0001rh-QR
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 16:01:42 +0000
Received: by mail-it1-x142.google.com with SMTP id z7so965854iti.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 08:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hjrkLDzbw59klMBWTcg66mkyzILll1t5jSDgHKiAU20=;
 b=m0bZv4kPOj47D9JHiEJ2ntQTsppLxm2MnJCmL6ke+PVDfiuj6Lhkntz8vAFTP52acS
 qfNNoxCjbn+yfKDNkwdhK/0NPI/t4VhRkwaFQGBsp8Rh/IyN9KxjJTW2Buq2EPkcHxSr
 1nc1wj0M8u/ZqzcdNKzkd3Hva+zRJPdDNx76zkV76v0SzI6POZa2Xgo1eJ/ZOJxTvPKY
 FJuUnnja6OuV2Rzi7qL5Wnav5PZ77WRUuK5aRtY+GF4ysOSVikGTrKFa7dnIAeMP2B2X
 SAiv1DdQ/iSc2wYlx7UeRoVsWEkHGAVMo8GzsDV6g6Ksrz8I3muL50r8j1JhNisusKHd
 TYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hjrkLDzbw59klMBWTcg66mkyzILll1t5jSDgHKiAU20=;
 b=PMt3gl243BDyYpdZyIfqk8NH5nVYU3NFy28HsyuzlOVhEyFkvZNPw7J6fvJ5BZMMxj
 i/cxf0kACMWsDV/taSaC70DXc+FyewDPkcN5uBUvKnAtaZOh9v75V3e/oB6EujhCC5UT
 agv4PpnnGcwOzbZhGvY/SPQPpQ2YIyMdB5gTYFGGAACmBpoirfMHizeNc3MxhV3LiZHz
 FL0u+k/XSRGeYRwOQWU5BJv6AvSdhSa4gb86oSzeuTEunDkB5FGzvWKJ/k+1rJCwT48o
 ypALpFOah+rgH+mArt+qESBtgdbA8WQ6bYFG7cmdquevx9R44DZrQCJACtjfXCTrEQaK
 BerA==
X-Gm-Message-State: AHQUAuZysywHNBo2Yd6X0HzCdv+GKVJTTw62YLE/TxQM0wizSh8HFl6L
 gfal1ROyqLX7SkODYo/2DKTomtiBlIa58J1w0N+SMw==
X-Google-Smtp-Source: AHgI3IaUiQacOJtk0xlnnQ5OR0YTYWZENiYJE5CdRWYiueuFdGanCsW3J27+9Tqsxku7T3nFrJx1oQj2HZ6LVhbBBU8=
X-Received: by 2002:a05:660c:4b:: with SMTP id
 p11mr5920881itk.71.1549555298620; 
 Thu, 07 Feb 2019 08:01:38 -0800 (PST)
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
 <CADnq5_NnY2Ktw0sLGnp7x3kc6NpwPnznHUzRK=5X2n6p1843Yg@mail.gmail.com>
In-Reply-To: <CADnq5_NnY2Ktw0sLGnp7x3kc6NpwPnznHUzRK=5X2n6p1843Yg@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 7 Feb 2019 17:01:26 +0100
Message-ID: <CAKv+Gu8Db0Mox6DDpejzmma1By8LBBEv7uhcaXR3wyoty=xKEQ@mail.gmail.com>
Subject: Re: [PATCH] drm: enable uncached DMA optimization for ARM and arm64
To: Alex Deucher <alexdeucher@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_080140_090377_56C1F8C2 
X-CRM114-Status: GOOD (  24.05  )
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

T24gVGh1LCA3IEZlYiAyMDE5IGF0IDE2OjMzLCBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdt
YWlsLmNvbT4gd3JvdGU6Cj4KPiBPbiBUaHUsIEZlYiA3LCAyMDE5IGF0IDEwOjIwIEFNIEFyZCBC
aWVzaGV1dmVsCj4gPGFyZC5iaWVzaGV1dmVsQGxpbmFyby5vcmc+IHdyb3RlOgo+ID4KPiA+IE9u
IFdlZCwgNiBGZWIgMjAxOSBhdCAxOTozOCwgQ2hyaXN0aWFuIEvDtm5pZwo+ID4gPGNrb2VuaWcu
bGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiB3cm90ZToKPiA+ID4KPiA+ID4gQW0gMDYuMDIuMTkg
dW0gMTg6MjMgc2NocmllYiBBcmQgQmllc2hldXZlbDoKPiA+ID4gPiBPbiBGcmksIDI1IEphbiAy
MDE5IGF0IDExOjM1LCBBcmQgQmllc2hldXZlbCA8YXJkLmJpZXNoZXV2ZWxAbGluYXJvLm9yZz4g
d3JvdGU6Cj4gPiA+ID4+IE9uIEZyaSwgMjUgSmFuIDIwMTkgYXQgMTI6MzAsIENocmlzdGlhbiBL
w7ZuaWcKPiA+ID4gPj4gPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiB3cm90ZToK
PiA+ID4gPj4+IEFtIDI1LjAxLjE5IHVtIDA5OjQzIHNjaHJpZWIgQXJkIEJpZXNoZXV2ZWw6Cj4g
PiA+ID4+Pj4gT24gVGh1LCAyNCBKYW4gMjAxOSBhdCAxNTowMSwgQWxleCBEZXVjaGVyIDxhbGV4
ZGV1Y2hlckBnbWFpbC5jb20+IHdyb3RlOgo+ID4gPiA+Pj4+PiBPbiBUaHUsIEphbiAyNCwgMjAx
OSBhdCA5OjAwIEFNIEFyZCBCaWVzaGV1dmVsCj4gPiA+ID4+Pj4+IDxhcmQuYmllc2hldXZlbEBs
aW5hcm8ub3JnPiB3cm90ZToKPiA+ID4gPj4+Pj4+IE9uIFRodSwgMjQgSmFuIDIwMTkgYXQgMTM6
MzEsIEtvZW5pZywgQ2hyaXN0aWFuCj4gPiA+ID4+Pj4+PiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQu
Y29tPiB3cm90ZToKPiA+ID4gPj4+Pj4+PiBBbSAyNC4wMS4xOSB1bSAxMzowNiBzY2hyaWViIEFy
ZCBCaWVzaGV1dmVsOgo+ID4gPiA+Pj4+Pj4+PiBUaGUgRFJNIGRyaXZlciBzdGFjayBpcyBkZXNp
Z25lZCB0byB3b3JrIHdpdGggY2FjaGUgY29oZXJlbnQgZGV2aWNlcwo+ID4gPiA+Pj4+Pj4+PiBv
bmx5LCBidXQgcGVybWl0cyBhbiBvcHRpbWl6YXRpb24gdG8gYmUgZW5hYmxlZCBpbiBzb21lIGNh
c2VzLCB3aGVyZQo+ID4gPiA+Pj4+Pj4+PiBmb3Igc29tZSBidWZmZXJzLCBib3RoIHRoZSBDUFUg
YW5kIHRoZSBHUFUgdXNlIHVuY2FjaGVkIG1hcHBpbmdzLAo+ID4gPiA+Pj4+Pj4+PiByZW1vdmlu
ZyB0aGUgbmVlZCBmb3IgRE1BIHNub29waW5nIGFuZCBhbGxvY2F0aW9uIGluIHRoZSBDUFUgY2Fj
aGVzLgo+ID4gPiA+Pj4+Pj4+Pgo+ID4gPiA+Pj4+Pj4+PiBUaGUgdXNlIG9mIHVuY2FjaGVkIEdQ
VSBtYXBwaW5ncyByZWxpZXMgb24gdGhlIGNvcnJlY3QgaW1wbGVtZW50YXRpb24KPiA+ID4gPj4+
Pj4+Pj4gb2YgdGhlIFBDSWUgTm9Tbm9vcCBUTFAgYXR0cmlidXRlIGJ5IHRoZSBwbGF0Zm9ybSwg
b3RoZXJ3aXNlIHRoZSBHUFUKPiA+ID4gPj4+Pj4+Pj4gd2lsbCB1c2UgY2FjaGVkIG1hcHBpbmdz
IG5vbmV0aGVsZXNzLiBPbiB4ODYgcGxhdGZvcm1zLCB0aGlzIGRvZXMgbm90Cj4gPiA+ID4+Pj4+
Pj4+IHNlZW0gdG8gbWF0dGVyLCBhcyB1bmNhY2hlZCBDUFUgbWFwcGluZ3Mgd2lsbCBzbm9vcCB0
aGUgY2FjaGVzIGluIGFueQo+ID4gPiA+Pj4+Pj4+PiBjYXNlLiBIb3dldmVyLCBvbiBBUk0gYW5k
IGFybTY0LCBlbmFibGluZyB0aGlzIG9wdGltaXphdGlvbiBvbiBhCj4gPiA+ID4+Pj4+Pj4+IHBs
YXRmb3JtIHdoZXJlIE5vU25vb3AgaXMgaWdub3JlZCByZXN1bHRzIGluIGxvc3Mgb2YgY29oZXJl
bmN5LCB3aGljaAo+ID4gPiA+Pj4+Pj4+PiBicmVha3MgY29ycmVjdCBvcGVyYXRpb24gb2YgdGhl
IGRldmljZS4gU2luY2Ugd2UgaGF2ZSBubyB3YXkgb2YKPiA+ID4gPj4+Pj4+Pj4gZGV0ZWN0aW5n
IHdoZXRoZXIgTm9Tbm9vcCB3b3JrcyBvciBub3QsIGp1c3QgZGlzYWJsZSB0aGlzCj4gPiA+ID4+
Pj4+Pj4+IG9wdGltaXphdGlvbiBlbnRpcmVseSBmb3IgQVJNIGFuZCBhcm02NC4KPiA+ID4gPj4+
Pj4+Pj4KPiA+ID4gPj4+Pj4+Pj4gQ2M6IENocmlzdGlhbiBLb2VuaWcgPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4KPiA+ID4gPj4+Pj4+Pj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRl
dWNoZXJAYW1kLmNvbT4KPiA+ID4gPj4+Pj4+Pj4gQ2M6IERhdmlkIFpob3UgPERhdmlkMS5aaG91
QGFtZC5jb20+Cj4gPiA+ID4+Pj4+Pj4+IENjOiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29t
Pgo+ID4gPiA+Pj4+Pj4+PiBDYzogSnVud2VpIFpoYW5nIDxKZXJyeS5aaGFuZ0BhbWQuY29tPgo+
ID4gPiA+Pj4+Pj4+PiBDYzogTWljaGVsIERhZW56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+
Cj4gPiA+ID4+Pj4+Pj4+IENjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+Cj4gPiA+
ID4+Pj4+Pj4+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+Cj4gPiA+ID4+Pj4+
Pj4+IENjOiBNYWFydGVuIExhbmtob3JzdCA8bWFhcnRlbi5sYW5raG9yc3RAbGludXguaW50ZWwu
Y29tPgo+ID4gPiA+Pj4+Pj4+PiBDYzogTWF4aW1lIFJpcGFyZCA8bWF4aW1lLnJpcGFyZEBib290
bGluLmNvbT4KPiA+ID4gPj4+Pj4+Pj4gQ2M6IFNlYW4gUGF1bCA8c2VhbkBwb29ybHkucnVuPgo+
ID4gPiA+Pj4+Pj4+PiBDYzogTWljaGFlbCBFbGxlcm1hbiA8bXBlQGVsbGVybWFuLmlkLmF1Pgo+
ID4gPiA+Pj4+Pj4+PiBDYzogQmVuamFtaW4gSGVycmVuc2NobWlkdCA8YmVuaEBrZXJuZWwuY3Jh
c2hpbmcub3JnPgo+ID4gPiA+Pj4+Pj4+PiBDYzogV2lsbCBEZWFjb24gPHdpbGwuZGVhY29uQGFy
bS5jb20+Cj4gPiA+ID4+Pj4+Pj4+IENjOiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGluZnJhZGVh
ZC5vcmc+Cj4gPiA+ID4+Pj4+Pj4+IENjOiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0u
Y29tPgo+ID4gPiA+Pj4+Pj4+PiBDYzogYW1kLWdmeCBsaXN0IDxhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZz4KPiA+ID4gPj4+Pj4+Pj4gQ2M6IGRyaS1kZXZlbCA8ZHJpLWRldmVsQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZz4KPiA+ID4gPj4+Pj4+Pj4gUmVwb3J0ZWQtYnk6IENhcnN0ZW4gSGFp
dHpsZXIgPENhcnN0ZW4uSGFpdHpsZXJAYXJtLmNvbT4KPiA+ID4gPj4+Pj4+Pj4gU2lnbmVkLW9m
Zi1ieTogQXJkIEJpZXNoZXV2ZWwgPGFyZC5iaWVzaGV1dmVsQGxpbmFyby5vcmc+Cj4gPiA+ID4+
Pj4+Pj4gVGhlIHN1YmplY3QgbGluZSBzaG91bGQgcHJvYmFibHkgcmVhZCAiZGlzYWJsZSB1bmNh
Y2hlZC4uLiIuCj4gPiA+ID4+Pj4+Pj4KPiA+ID4gPj4+Pj4+IFVnaCwgb2YgY291cnNlIC4uLgo+
ID4gPiA+Pj4+Pj4KPiA+ID4gPj4+Pj4+PiBXaXRoIHRoYXQgZml4ZWQgdGhlIHBhdGNoIGlzIFJl
dmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnCj4gPiA+ID4+Pj4+Pj4gPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4uCj4gPiA+ID4+Pj4+Pj4KPiA+ID4gPj4+Pj4gU2FtZToKPiA+ID4gPj4+Pj4g
UmV2aWV3ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiA+
ID4gPj4+Pj4KPiA+ID4gPj4+PiBUaGFua3MgYWxsCj4gPiA+ID4+Pj4KPiA+ID4gPj4+PiBTaG91
bGQgSSByZXNlbmQgdGhlIHBhdGNoIHdpdGggdGhlIHN1YmplY3QgY29ycmVjdGVkPwo+ID4gPiA+
Pj4gSSB3aWxsIHVwZGF0ZSB0aGUgc3ViamVjdCBsaW5lIGFuZCBwdXNoIGl0IHVwc3RyZWFtIHRo
cm91Z2gKPiA+ID4gPj4+IGRybS1taXNjLW5leHQgaWYgbm9ib2R5IG9iamVjdHMuCj4gPiA+ID4+
Pgo+ID4gPiA+PiBXb25kZXJmdWwsIHRoYW5rcy4KPiA+ID4gPiBIaSBDaHJpc3RpYW4sCj4gPiA+
ID4KPiA+ID4gPiBBcmUgeW91IHN0aWxsIHBsYW5uaW5nIHRvIG1lcmdlIHRoaXMgZm9yIHY1LjE/
Cj4gPiA+Cj4gPiA+IE15IGJhZCwgb25seSBwdXNoZWQgdGhpcyB0byBvdXIgaW50ZXJuYWwgYnJh
bmNoLCBidXQgZm9yZ290IG91dAo+ID4gPiBkcm0tbWlzYy1uZXh0Lgo+ID4gPgo+ID4gPiBGaXhl
ZCBub3csIHRoYW5rcyBmb3IgdGhlIHJlbWluZGVyLgo+ID4gPgo+ID4KPiA+IFRoYW5rcywKPiA+
Cj4gPiBEb2VzIGFueW9uZSBtaW5kIGlmIEkgcHJvcG9zZSB0aGlzIHBhdGNoIGZvciBiYWNrcG9y
dGluZyB0byB2NC4xOSBvcgo+ID4gZWFybGllciBvbmNlIGl0IGdldHMgbWVyZ2VkIGZvciB2NS4x
Pwo+Cj4gR28gZm9yIGl0LiAgSSB3YXMgZ29pbmcgdG8gc3VnZ2VzdCB0aGF0IHRoaXMgc2hvdWxk
IHByb2JhYmx5IGdvIHRvIHN0YWJsZS4KPgoKRXhjZWxsZW50LiBOb3RlIHRoYXQgSSBhY3R1YWxs
eSBwcmVmZXIgc2VuZGluZyBpdCBtYW51YWxseSByYXRoZXIgdGhhbgpsZXQgR3JlZyBvciBTYXNo
YSBwaWNrIGl0IHVwIGF1dG9tYXRpY2FsbHksIGdpdmVuIHRoYXQgdGhleSBhcmUKdXN1YWxseSBh
IGJpdCB0cmlnZ2VyIGhhcHB5LCBpLmUuLCBwYXRjaGVzIHRlbmQgdG8gZ2V0IGJhY2twb3J0ZWQK
YmVmb3JlIGFueW9uZSBoYXMgaGFkIGEgY2hhbmNlIHRvIGFjdHVhbGx5IGNoZWNrIHRoYXQgaXQg
ZG9lc24ndCBicmVhawphbnl0aGluZyBpbiBtYWlubGluZS4KCkluIG90aGVyIHdvcmRzLCBwbGVh
c2UgZG9uJ3QgYWRkIGEgY2MgLXN0YWJsZSBvciBmaXhlcyB0YWcuIEkgd2lsbAp0cmFjayBpdCBt
eXNlbGYgaW5zdGVhZC4KClRoYW5rcywKQXJkLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
