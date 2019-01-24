Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBA3C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:32:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9FB92184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ORJb1NTD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IkPXeLhb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9FB92184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=etsK5GLSMPgKrR2ajx8VGpmTHV0xfSetu6PLS4gvZ5I=; b=ORJb1NTDgC+CKt
	nyN+3vlj2foE0BP4lCcwgA9eu+0kppJYqV2zW49RCoN8rNS81q762vrHlj5UNShANyKo7ec3sqaq0
	3Bc7/UUEAo38TCywvuxqKNxwvG1WbM9JbY4KMeeqQwDUhgSsaTwY5ALUYMOC9VpvGgNYAGNtecHSb
	0l8aimwYv3mlG2Yq5Un9sv6kFL+7oJZIQCGUgcZ4rX8RG9XZ6KDUpa5hk/DcAtwCuFUmiOvxL86oD
	yNElPceZ/p+Jd9PK//dGX1JNg8ioYeNqInjXQCLhLoU0Ywv13WOh/efdL3NiomyYacj2duh3XaqtV
	gHd1RxT9hKc2ojt21yRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmeBL-00032s-FV; Thu, 24 Jan 2019 12:32:31 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmeBH-00032M-SE
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 12:32:29 +0000
Received: by mail-it1-x144.google.com with SMTP id g85so4673618ita.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 04:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=F3VCMZYQHk+dES8GD4GKOvmgry3BxujfQ36g2qotYKM=;
 b=IkPXeLhb1v9yYKDcPuLTMPUQj9ccjp3XoBOC2aHGBCMCfYCC0dV8d86WGbJdw5cd+1
 E9lplTFs8WOUx58H8eY27S56/H0ij+Tvs29ymM8MDuYh7ayaZcEF0J//J67I4gNuK848
 IHNOmRCQU3kIRZepoSy7DiZDrh55MyfMtNSJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=F3VCMZYQHk+dES8GD4GKOvmgry3BxujfQ36g2qotYKM=;
 b=X8p8ZObCjaODLJk6VJYZqHw93Bz8Fq+7ytSKBj/BO6D1SZfspO3H82ZSk5lVDdNczH
 9W6BaM01SCi6vT1RszQ1vEvoNrJds/ecB7I8OG7+x74xnTFd+A4W8M0t4TsPUHtNBsoG
 iLM5BQ9MK7kTIt0+Vpn5o/ZFe9+0IfOzv8FNzveJ49oMvkYFdqIcpN8S6ECn/+xrFOdl
 Sjv8lgkGVCnBhdq7nnfEYcVoAZn6IDZS60GTynUhwHJPI3zFXHx2Hhc3SDNJ6a+4QP9Q
 UVPcAKn+5IHPO45GBXIUwZiFM/8y0lMst8dYt3QZwFmg5JM1WIhjyj08JTlHtYgVw8HD
 vxoA==
X-Gm-Message-State: AJcUukceYk1PEotxqNgK+xLW9urYvqKoeyO+CGiTdpRxAyWpHJC30pHe
 mhDpz+GP1Vga9J8v0qVa1/IRiFp7v243IgPeAIJGXg==
X-Google-Smtp-Source: ALg8bN4wjFbIakhtj0hnxuyWDDz7O+TaM/72FWY+jIkiG/4A0F/DjIMahcH8mdOOmVBlMssD84C5+NWBZsm2sEGLI5c=
X-Received: by 2002:a05:660c:4b:: with SMTP id
 p11mr1298530itk.71.1548333146518; 
 Thu, 24 Jan 2019 04:32:26 -0800 (PST)
MIME-Version: 1.0
References: <20190124120658.30288-1-ard.biesheuvel@linaro.org>
 <3cca35a9-c71c-a100-b29d-31ba0d1d10b1@amd.com>
In-Reply-To: <3cca35a9-c71c-a100-b29d-31ba0d1d10b1@amd.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 24 Jan 2019 13:32:15 +0100
Message-ID: <CAKv+Gu9OG3O4+4F2nioaQ-3U-1kwRBr5KVj-1gD1ZEsUx_Ud5A@mail.gmail.com>
Subject: Re: [PATCH] drm: enable uncached DMA optimization for ARM and arm64
To: "Koenig, Christian" <Christian.Koenig@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_043227_909613_8428CA82 
X-CRM114-Status: GOOD (  17.57  )
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
Cc: "Zhou, David\(ChunMing\)" <David1.Zhou@amd.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Carsten Haitzler <Carsten.Haitzler@arm.com>, David Airlie <airlied@linux.ie>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 dri-devel <dri-devel@lists.freedesktop.org>, "Daenzer,
 Michel" <Michel.Daenzer@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Will Deacon <will.deacon@arm.com>, Christoph Hellwig <hch@infradead.org>,
 "Zhang, Jerry" <Jerry.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Michael Ellerman <mpe@ellerman.id.au>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, Sean Paul <sean@poorly.run>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVGh1LCAyNCBKYW4gMjAxOSBhdCAxMzozMSwgS29lbmlnLCBDaHJpc3RpYW4KPENocmlzdGlh
bi5Lb2VuaWdAYW1kLmNvbT4gd3JvdGU6Cj4KPiBBbSAyNC4wMS4xOSB1bSAxMzowNiBzY2hyaWVi
IEFyZCBCaWVzaGV1dmVsOgo+ID4gVGhlIERSTSBkcml2ZXIgc3RhY2sgaXMgZGVzaWduZWQgdG8g
d29yayB3aXRoIGNhY2hlIGNvaGVyZW50IGRldmljZXMKPiA+IG9ubHksIGJ1dCBwZXJtaXRzIGFu
IG9wdGltaXphdGlvbiB0byBiZSBlbmFibGVkIGluIHNvbWUgY2FzZXMsIHdoZXJlCj4gPiBmb3Ig
c29tZSBidWZmZXJzLCBib3RoIHRoZSBDUFUgYW5kIHRoZSBHUFUgdXNlIHVuY2FjaGVkIG1hcHBp
bmdzLAo+ID4gcmVtb3ZpbmcgdGhlIG5lZWQgZm9yIERNQSBzbm9vcGluZyBhbmQgYWxsb2NhdGlv
biBpbiB0aGUgQ1BVIGNhY2hlcy4KPiA+Cj4gPiBUaGUgdXNlIG9mIHVuY2FjaGVkIEdQVSBtYXBw
aW5ncyByZWxpZXMgb24gdGhlIGNvcnJlY3QgaW1wbGVtZW50YXRpb24KPiA+IG9mIHRoZSBQQ0ll
IE5vU25vb3AgVExQIGF0dHJpYnV0ZSBieSB0aGUgcGxhdGZvcm0sIG90aGVyd2lzZSB0aGUgR1BV
Cj4gPiB3aWxsIHVzZSBjYWNoZWQgbWFwcGluZ3Mgbm9uZXRoZWxlc3MuIE9uIHg4NiBwbGF0Zm9y
bXMsIHRoaXMgZG9lcyBub3QKPiA+IHNlZW0gdG8gbWF0dGVyLCBhcyB1bmNhY2hlZCBDUFUgbWFw
cGluZ3Mgd2lsbCBzbm9vcCB0aGUgY2FjaGVzIGluIGFueQo+ID4gY2FzZS4gSG93ZXZlciwgb24g
QVJNIGFuZCBhcm02NCwgZW5hYmxpbmcgdGhpcyBvcHRpbWl6YXRpb24gb24gYQo+ID4gcGxhdGZv
cm0gd2hlcmUgTm9Tbm9vcCBpcyBpZ25vcmVkIHJlc3VsdHMgaW4gbG9zcyBvZiBjb2hlcmVuY3ks
IHdoaWNoCj4gPiBicmVha3MgY29ycmVjdCBvcGVyYXRpb24gb2YgdGhlIGRldmljZS4gU2luY2Ug
d2UgaGF2ZSBubyB3YXkgb2YKPiA+IGRldGVjdGluZyB3aGV0aGVyIE5vU25vb3Agd29ya3Mgb3Ig
bm90LCBqdXN0IGRpc2FibGUgdGhpcwo+ID4gb3B0aW1pemF0aW9uIGVudGlyZWx5IGZvciBBUk0g
YW5kIGFybTY0Lgo+ID4KPiA+IENjOiBDaHJpc3RpYW4gS29lbmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+Cj4gPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29t
Pgo+ID4gQ2M6IERhdmlkIFpob3UgPERhdmlkMS5aaG91QGFtZC5jb20+Cj4gPiBDYzogSHVhbmcg
UnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KPiA+IENjOiBKdW53ZWkgWmhhbmcgPEplcnJ5LlpoYW5n
QGFtZC5jb20+Cj4gPiBDYzogTWljaGVsIERhZW56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+
Cj4gPiBDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgo+ID4gQ2M6IERhbmllbCBW
ZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPiA+IENjOiBNYWFydGVuIExhbmtob3JzdCA8bWFhcnRl
bi5sYW5raG9yc3RAbGludXguaW50ZWwuY29tPgo+ID4gQ2M6IE1heGltZSBSaXBhcmQgPG1heGlt
ZS5yaXBhcmRAYm9vdGxpbi5jb20+Cj4gPiBDYzogU2VhbiBQYXVsIDxzZWFuQHBvb3JseS5ydW4+
Cj4gPiBDYzogTWljaGFlbCBFbGxlcm1hbiA8bXBlQGVsbGVybWFuLmlkLmF1Pgo+ID4gQ2M6IEJl
bmphbWluIEhlcnJlbnNjaG1pZHQgPGJlbmhAa2VybmVsLmNyYXNoaW5nLm9yZz4KPiA+IENjOiBX
aWxsIERlYWNvbiA8d2lsbC5kZWFjb25AYXJtLmNvbT4KPiA+IENjOiBDaHJpc3RvcGggSGVsbHdp
ZyA8aGNoQGluZnJhZGVhZC5vcmc+Cj4gPiBDYzogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlA
YXJtLmNvbT4KPiA+IENjOiBhbWQtZ2Z4IGxpc3QgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnPgo+ID4gQ2M6IGRyaS1kZXZlbCA8ZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4K
PiA+IFJlcG9ydGVkLWJ5OiBDYXJzdGVuIEhhaXR6bGVyIDxDYXJzdGVuLkhhaXR6bGVyQGFybS5j
b20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBBcmQgQmllc2hldXZlbCA8YXJkLmJpZXNoZXV2ZWxAbGlu
YXJvLm9yZz4KPgo+IFRoZSBzdWJqZWN0IGxpbmUgc2hvdWxkIHByb2JhYmx5IHJlYWQgImRpc2Fi
bGUgdW5jYWNoZWQuLi4iLgo+CgpVZ2gsIG9mIGNvdXJzZSAuLi4KCj4gV2l0aCB0aGF0IGZpeGVk
IHRoZSBwYXRjaCBpcyBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZwo+IDxjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20+Lgo+CgpUaGFua3MuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
