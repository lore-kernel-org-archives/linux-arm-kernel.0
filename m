Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360E0C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:21:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0325B2175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ueB/bfH0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YAMQIaQE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0325B2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4q0ZkGNfHpHoC9iP9Kvbf9ER1SPekZn2+hWVyWEoshg=; b=ueB/bfH0lhAZ10
	sEkf0ZfBfkMXCKi3e4lAV2kTkwOnOElzvbzgHwLydTuV5Vr+DGZodWDtuAChLJhIB1RqO2XSvObLb
	MBRkRO02HS8L4yIuAG/hLpT9NlLhPxMO44Qc/gZyL1pGQyUHdtbenv6nylT1juey32nw9K7xpDeww
	/0mwvNbbB7/cLsNzcmPSZNH0J/cLLdy7CajLB9SxUJrHkxUM9FsFkYFSKtX4nbj1ZqM4lPgObGlOn
	q/rDVcUE9yT9+jUmS2i0R0XJUteqQe8TClx7gXCFUYzdCG40gJ4H7ycTJIyg5nxMF2ZXV9DTfDHor
	dYm8i42i5rIuYV03lHfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grlTy-0001G2-Dw; Thu, 07 Feb 2019 15:20:54 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grlTl-00012p-7A
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 15:20:50 +0000
Received: by mail-it1-x141.google.com with SMTP id z7so599556iti.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 07:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=MKDXKLcR+dgm5MI2YZ/T4TCWzgNhPAx4ZCKQPhJuB2g=;
 b=YAMQIaQE5AOr3L1/X81vBik20FmLQtGeKiRlSt6wCNh5V4ulFSO+b+BRLUtqOU/czu
 NqPdh/JmLST2wpJXdnDD8Wja05ebvWVEoYZgkmimKaJLUcfCnbtBWHUOKbsaCxjDfIr9
 BnKUHb9iKS+3OC42v5XCWuQ4MOf63M42VYHlkQPzfC9CGqEjSe2xf9fQfEdVV1Qcl9mV
 2Eb4lo4ZkILMSsj3Y1MKLRHLsUC0hOvHMLAOxgoyIGq3eXm6767rhVKZtM7+8zuEcV4c
 IY0H9LfGIoawhATxWXrwo5V89UsIfsvyLcIX7rQOVDMLz7XKpU4h1hW8VA0yto9qm16r
 tvAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MKDXKLcR+dgm5MI2YZ/T4TCWzgNhPAx4ZCKQPhJuB2g=;
 b=eOnJ0smvuJdXPMD4kz5bt+wRjIfa9lKr9oSkhfwnMW03q8DAkFUbocE8LQIJXScKV9
 fZlsNHUgLavnvjsK0XOSoR069YtU0hwmjYu1tCled+/Vakq5bpIwFeDBaiHF7D/tZS14
 KcosGeOky4YiPYt5DhoN2LUW4IhLn9AN5lszWf6GsP1rBNMSE5cZCNqMjGRByt7W+Hud
 HmaHv1CO45VMfX6b5mYjuwBySjSYuTEwljMLNVMvUobdjvK+7tb/1Q7Fj8Dw+gHW6Ra0
 i6JQtVlbA26RLgUgXOzDevYsaRKYEM3ChgOZkzoAS3RHbx9ZjUIH7Wvntz/MGIx2fU0D
 vhUg==
X-Gm-Message-State: AHQUAuaL+i6TYHFmQtyt3GaJ2eFwQPxCZstaUiVUUyF4svQBIYsBmIVb
 QgIpJyvD8ycWJ0Ho+GRpzwdOSeFmI6E2NiQyIBr/0Q==
X-Google-Smtp-Source: AHgI3Ia2Gdqm31wxFLC4KEwmECNxnTEsP8FgVIkhFTeU0kACbGNCQFXB2OV11MjJeHVbbb6UVmlPALsDwRzu9oCrE0g=
X-Received: by 2002:a5e:9704:: with SMTP id w4mr1849417ioj.60.1549552839866;
 Thu, 07 Feb 2019 07:20:39 -0800 (PST)
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
In-Reply-To: <f6bdd647-722b-8145-92d4-3f6c52f8a74c@gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 7 Feb 2019 16:20:27 +0100
Message-ID: <CAKv+Gu8oCAcnoo6=UikRGJQHW63JmY21y1qZteaNmh_F7HnOEQ@mail.gmail.com>
Subject: Re: [PATCH] drm: enable uncached DMA optimization for ARM and arm64
To: "Koenig, Christian" <christian.koenig@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_072041_894520_8352B942 
X-CRM114-Status: GOOD (  18.64  )
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
 Jerry" <Jerry.Zhang@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, Sean Paul <sean@poorly.run>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gV2VkLCA2IEZlYiAyMDE5IGF0IDE5OjM4LCBDaHJpc3RpYW4gS8O2bmlnCjxja29lbmlnLmxl
aWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBBbSAwNi4wMi4xOSB1bSAxODoyMyBz
Y2hyaWViIEFyZCBCaWVzaGV1dmVsOgo+ID4gT24gRnJpLCAyNSBKYW4gMjAxOSBhdCAxMTozNSwg
QXJkIEJpZXNoZXV2ZWwgPGFyZC5iaWVzaGV1dmVsQGxpbmFyby5vcmc+IHdyb3RlOgo+ID4+IE9u
IEZyaSwgMjUgSmFuIDIwMTkgYXQgMTI6MzAsIENocmlzdGlhbiBLw7ZuaWcKPiA+PiA8Y2tvZW5p
Zy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+IHdyb3RlOgo+ID4+PiBBbSAyNS4wMS4xOSB1bSAw
OTo0MyBzY2hyaWViIEFyZCBCaWVzaGV1dmVsOgo+ID4+Pj4gT24gVGh1LCAyNCBKYW4gMjAxOSBh
dCAxNTowMSwgQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+IHdyb3RlOgo+ID4+
Pj4+IE9uIFRodSwgSmFuIDI0LCAyMDE5IGF0IDk6MDAgQU0gQXJkIEJpZXNoZXV2ZWwKPiA+Pj4+
PiA8YXJkLmJpZXNoZXV2ZWxAbGluYXJvLm9yZz4gd3JvdGU6Cj4gPj4+Pj4+IE9uIFRodSwgMjQg
SmFuIDIwMTkgYXQgMTM6MzEsIEtvZW5pZywgQ2hyaXN0aWFuCj4gPj4+Pj4+IDxDaHJpc3RpYW4u
S29lbmlnQGFtZC5jb20+IHdyb3RlOgo+ID4+Pj4+Pj4gQW0gMjQuMDEuMTkgdW0gMTM6MDYgc2No
cmllYiBBcmQgQmllc2hldXZlbDoKPiA+Pj4+Pj4+PiBUaGUgRFJNIGRyaXZlciBzdGFjayBpcyBk
ZXNpZ25lZCB0byB3b3JrIHdpdGggY2FjaGUgY29oZXJlbnQgZGV2aWNlcwo+ID4+Pj4+Pj4+IG9u
bHksIGJ1dCBwZXJtaXRzIGFuIG9wdGltaXphdGlvbiB0byBiZSBlbmFibGVkIGluIHNvbWUgY2Fz
ZXMsIHdoZXJlCj4gPj4+Pj4+Pj4gZm9yIHNvbWUgYnVmZmVycywgYm90aCB0aGUgQ1BVIGFuZCB0
aGUgR1BVIHVzZSB1bmNhY2hlZCBtYXBwaW5ncywKPiA+Pj4+Pj4+PiByZW1vdmluZyB0aGUgbmVl
ZCBmb3IgRE1BIHNub29waW5nIGFuZCBhbGxvY2F0aW9uIGluIHRoZSBDUFUgY2FjaGVzLgo+ID4+
Pj4+Pj4+Cj4gPj4+Pj4+Pj4gVGhlIHVzZSBvZiB1bmNhY2hlZCBHUFUgbWFwcGluZ3MgcmVsaWVz
IG9uIHRoZSBjb3JyZWN0IGltcGxlbWVudGF0aW9uCj4gPj4+Pj4+Pj4gb2YgdGhlIFBDSWUgTm9T
bm9vcCBUTFAgYXR0cmlidXRlIGJ5IHRoZSBwbGF0Zm9ybSwgb3RoZXJ3aXNlIHRoZSBHUFUKPiA+
Pj4+Pj4+PiB3aWxsIHVzZSBjYWNoZWQgbWFwcGluZ3Mgbm9uZXRoZWxlc3MuIE9uIHg4NiBwbGF0
Zm9ybXMsIHRoaXMgZG9lcyBub3QKPiA+Pj4+Pj4+PiBzZWVtIHRvIG1hdHRlciwgYXMgdW5jYWNo
ZWQgQ1BVIG1hcHBpbmdzIHdpbGwgc25vb3AgdGhlIGNhY2hlcyBpbiBhbnkKPiA+Pj4+Pj4+PiBj
YXNlLiBIb3dldmVyLCBvbiBBUk0gYW5kIGFybTY0LCBlbmFibGluZyB0aGlzIG9wdGltaXphdGlv
biBvbiBhCj4gPj4+Pj4+Pj4gcGxhdGZvcm0gd2hlcmUgTm9Tbm9vcCBpcyBpZ25vcmVkIHJlc3Vs
dHMgaW4gbG9zcyBvZiBjb2hlcmVuY3ksIHdoaWNoCj4gPj4+Pj4+Pj4gYnJlYWtzIGNvcnJlY3Qg
b3BlcmF0aW9uIG9mIHRoZSBkZXZpY2UuIFNpbmNlIHdlIGhhdmUgbm8gd2F5IG9mCj4gPj4+Pj4+
Pj4gZGV0ZWN0aW5nIHdoZXRoZXIgTm9Tbm9vcCB3b3JrcyBvciBub3QsIGp1c3QgZGlzYWJsZSB0
aGlzCj4gPj4+Pj4+Pj4gb3B0aW1pemF0aW9uIGVudGlyZWx5IGZvciBBUk0gYW5kIGFybTY0Lgo+
ID4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4gQ2M6IENocmlzdGlhbiBLb2VuaWcgPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4KPiA+Pj4+Pj4+PiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hl
ckBhbWQuY29tPgo+ID4+Pj4+Pj4+IENjOiBEYXZpZCBaaG91IDxEYXZpZDEuWmhvdUBhbWQuY29t
Pgo+ID4+Pj4+Pj4+IENjOiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgo+ID4+Pj4+Pj4+
IENjOiBKdW53ZWkgWmhhbmcgPEplcnJ5LlpoYW5nQGFtZC5jb20+Cj4gPj4+Pj4+Pj4gQ2M6IE1p
Y2hlbCBEYWVuemVyIDxtaWNoZWwuZGFlbnplckBhbWQuY29tPgo+ID4+Pj4+Pj4+IENjOiBEYXZp
ZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+Cj4gPj4+Pj4+Pj4gQ2M6IERhbmllbCBWZXR0ZXIg
PGRhbmllbEBmZndsbC5jaD4KPiA+Pj4+Pj4+PiBDYzogTWFhcnRlbiBMYW5raG9yc3QgPG1hYXJ0
ZW4ubGFua2hvcnN0QGxpbnV4LmludGVsLmNvbT4KPiA+Pj4+Pj4+PiBDYzogTWF4aW1lIFJpcGFy
ZCA8bWF4aW1lLnJpcGFyZEBib290bGluLmNvbT4KPiA+Pj4+Pj4+PiBDYzogU2VhbiBQYXVsIDxz
ZWFuQHBvb3JseS5ydW4+Cj4gPj4+Pj4+Pj4gQ2M6IE1pY2hhZWwgRWxsZXJtYW4gPG1wZUBlbGxl
cm1hbi5pZC5hdT4KPiA+Pj4+Pj4+PiBDYzogQmVuamFtaW4gSGVycmVuc2NobWlkdCA8YmVuaEBr
ZXJuZWwuY3Jhc2hpbmcub3JnPgo+ID4+Pj4+Pj4+IENjOiBXaWxsIERlYWNvbiA8d2lsbC5kZWFj
b25AYXJtLmNvbT4KPiA+Pj4+Pj4+PiBDYzogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBpbmZyYWRl
YWQub3JnPgo+ID4+Pj4+Pj4+IENjOiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29t
Pgo+ID4+Pj4+Pj4+IENjOiBhbWQtZ2Z4IGxpc3QgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnPgo+ID4+Pj4+Pj4+IENjOiBkcmktZGV2ZWwgPGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmc+Cj4gPj4+Pj4+Pj4gUmVwb3J0ZWQtYnk6IENhcnN0ZW4gSGFpdHpsZXIgPENhcnN0ZW4u
SGFpdHpsZXJAYXJtLmNvbT4KPiA+Pj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBBcmQgQmllc2hldXZl
bCA8YXJkLmJpZXNoZXV2ZWxAbGluYXJvLm9yZz4KPiA+Pj4+Pj4+IFRoZSBzdWJqZWN0IGxpbmUg
c2hvdWxkIHByb2JhYmx5IHJlYWQgImRpc2FibGUgdW5jYWNoZWQuLi4iLgo+ID4+Pj4+Pj4KPiA+
Pj4+Pj4gVWdoLCBvZiBjb3Vyc2UgLi4uCj4gPj4+Pj4+Cj4gPj4+Pj4+PiBXaXRoIHRoYXQgZml4
ZWQgdGhlIHBhdGNoIGlzIFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnCj4gPj4+Pj4+PiA8
Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPi4KPiA+Pj4+Pj4+Cj4gPj4+Pj4gU2FtZToKPiA+Pj4+
PiBSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+
ID4+Pj4+Cj4gPj4+PiBUaGFua3MgYWxsCj4gPj4+Pgo+ID4+Pj4gU2hvdWxkIEkgcmVzZW5kIHRo
ZSBwYXRjaCB3aXRoIHRoZSBzdWJqZWN0IGNvcnJlY3RlZD8KPiA+Pj4gSSB3aWxsIHVwZGF0ZSB0
aGUgc3ViamVjdCBsaW5lIGFuZCBwdXNoIGl0IHVwc3RyZWFtIHRocm91Z2gKPiA+Pj4gZHJtLW1p
c2MtbmV4dCBpZiBub2JvZHkgb2JqZWN0cy4KPiA+Pj4KPiA+PiBXb25kZXJmdWwsIHRoYW5rcy4K
PiA+IEhpIENocmlzdGlhbiwKPiA+Cj4gPiBBcmUgeW91IHN0aWxsIHBsYW5uaW5nIHRvIG1lcmdl
IHRoaXMgZm9yIHY1LjE/Cj4KPiBNeSBiYWQsIG9ubHkgcHVzaGVkIHRoaXMgdG8gb3VyIGludGVy
bmFsIGJyYW5jaCwgYnV0IGZvcmdvdCBvdXQKPiBkcm0tbWlzYy1uZXh0Lgo+Cj4gRml4ZWQgbm93
LCB0aGFua3MgZm9yIHRoZSByZW1pbmRlci4KPgoKVGhhbmtzLAoKRG9lcyBhbnlvbmUgbWluZCBp
ZiBJIHByb3Bvc2UgdGhpcyBwYXRjaCBmb3IgYmFja3BvcnRpbmcgdG8gdjQuMTkgb3IKZWFybGll
ciBvbmNlIGl0IGdldHMgbWVyZ2VkIGZvciB2NS4xPwoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
