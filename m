Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53948C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:07:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B2CF21019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pGAiaep+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G0g2R31a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B2CF21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5QJk3SVs7FrNhicG/QLF3BMC6OzCd9qBz8/nuwCxJ5I=; b=pGAiaep+mx6njR
	cQTaPS5mZqEzLnVUCOCBaTevDvyV9nBeshzCo7ThtgPqt8wn3O6Vh3B+F9zvotnuTWcuhRHcsjMz/
	54xfYaLxI64XXxYB5mOSkna2hT20cIFTPfRpFn9Avc4qmOwtJg7Iz1y3+hmr9URIuQNQ7sAjzd7xe
	Jh7FQ3QEnC2dcdoI6th4eZz/vfzWOEWY9y14gIOZEHEBPeQIKTzr2xS347msweTKfba9fJC5BV3Ho
	gP+r0jr1csA3poYZm3Wuj3Tw84ulHjct5GOKzqPrwb/DwyqQamRHhwFsFVkdQl/balG8cHKGLN/We
	XSWpUu3/bXEFnHtTauww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm3GV-0005fC-Fr; Tue, 22 Jan 2019 21:07:23 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm3GR-0005eq-Li
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 21:07:21 +0000
Received: by mail-it1-x141.google.com with SMTP id w18so24017188ite.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 13:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bXRiTXzBLLRaOR+poEfIT/sh53Mi/Fp2YF7rqrlJr5c=;
 b=G0g2R31asSIFQRdJGb1kihSACoeQHh7yIqhoxZX4Z6/Yj0Xdr/wB/g976tzB17fHMu
 Bw3gArsZoV2vkBU+2OwuTvP/J602Qd8Ayq9OLPprpSG1yan+/TJ3CKhVudf2LLBtp5MO
 m468a+ybi2EybtFmGMx7XFD8qC3C+MrDrCu4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bXRiTXzBLLRaOR+poEfIT/sh53Mi/Fp2YF7rqrlJr5c=;
 b=Ip7MFvUJNdcEw1PbIZQjWF8/yoV9w2IXOdQBMc92IaGOLK12Kj+8TYSLjoEd5XSplp
 dbhizuqPzvZ6B8aSJXsIuMbGu4pwLuOyJlMhXA6reKa/xrMUv8Ja5mQWYgrVBX2Dwmby
 MOypQi6om/GtszffJ2p2jKBEFjJSpHHcT0XBU5bP+JVCMerIJ0pkHZOsk+IKVSfyaYis
 4r9d6/nFXtOLIpYJxKb7/oWAorwj+82zmdUee/hDnycOSszl1uxfhG+kbOgsVkFKiogJ
 q5YsD8xF9q6RKL+im00h9qfxKhyrJFFW2o34OWh7pwDki82yQVihQH1YSSNgB11l5ddp
 45xQ==
X-Gm-Message-State: AJcUukf3/SIHY0Cts9ajS5akSaExnIsPgH9lERXte1F4cAwiq5Owi2c3
 B1GxU6oaU1AW0CnQDqsgdF//XHscHh5jYJEVCzsY2Q==
X-Google-Smtp-Source: ALg8bN6/Q9U1Xs5xpTRgOS2vFbu9WQ6NRIRleN6PO13tCnVK3wA2x1AfQ5qladFBE4O1p/KDuaC46sgWLbwP0LAzleM=
X-Received: by 2002:a02:734b:: with SMTP id a11mr19908341jae.62.1548191238829; 
 Tue, 22 Jan 2019 13:07:18 -0800 (PST)
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
 <CAKv+Gu99zHqcQtj6TiOXAr3Qa6WWhKem+DHVA_mAQ0-Bc0Vbqw@mail.gmail.com>
 <047667fd-17be-1c37-5d2a-26768cfd6ab8@daenzer.net>
 <CAKv+Gu_VBd8agHASc5RS0eCgyXP64Lt_i4yPuBjKwGQ+5Lpd5Q@mail.gmail.com>
 <CADnq5_O1uxCrSksfF127AZTfbmdukxmqGdh2Ee0zM6CqgG_Mhg@mail.gmail.com>
In-Reply-To: <CADnq5_O1uxCrSksfF127AZTfbmdukxmqGdh2Ee0zM6CqgG_Mhg@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 22 Jan 2019 22:07:07 +0100
Message-ID: <CAKv+Gu-4uYh_HD_5Ry_L80Nf5zpRhT4oJYhhG5_8g3gSzBs2tg@mail.gmail.com>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
To: Alex Deucher <alexdeucher@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_130719_756583_F1DFDD37 
X-CRM114-Status: GOOD (  30.89  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Christoph Hellwig <hch@infradead.org>, David Airlie <airlied@linux.ie>,
 Huang Rui <ray.huang@amd.com>, dri-devel <dri-devel@lists.freedesktop.org>,
 Junwei Zhang <Jerry.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Sean Paul <sean@poorly.run>, Christian Koenig <christian.koenig@amd.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCAyMiBKYW4gMjAxOSBhdCAyMTo1NiwgQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBn
bWFpbC5jb20+IHdyb3RlOgo+Cj4gT24gVHVlLCBKYW4gMjIsIDIwMTkgYXQgNDoxOSBBTSBBcmQg
Qmllc2hldXZlbAo+IDxhcmQuYmllc2hldXZlbEBsaW5hcm8ub3JnPiB3cm90ZToKPiA+Cj4gPiBP
biBNb24sIDIxIEphbiAyMDE5IGF0IDIwOjA0LCBNaWNoZWwgRMOkbnplciA8bWljaGVsQGRhZW56
ZXIubmV0PiB3cm90ZToKPiA+ID4KPiA+ID4gT24gMjAxOS0wMS0yMSA3OjI4IHAubS4sIEFyZCBC
aWVzaGV1dmVsIHdyb3RlOgo+ID4gPiA+IE9uIE1vbiwgMjEgSmFuIDIwMTkgYXQgMTk6MjQsIE1p
Y2hlbCBEw6RuemVyIDxtaWNoZWxAZGFlbnplci5uZXQ+IHdyb3RlOgo+ID4gPiA+PiBPbiAyMDE5
LTAxLTIxIDc6MjAgcC5tLiwgQXJkIEJpZXNoZXV2ZWwgd3JvdGU6Cj4gPiA+ID4+PiBPbiBNb24s
IDIxIEphbiAyMDE5IGF0IDE5OjA0LCBNaWNoZWwgRMOkbnplciA8bWljaGVsQGRhZW56ZXIubmV0
PiB3cm90ZToKPiA+ID4gPj4+PiBPbiAyMDE5LTAxLTIxIDY6NTkgcC5tLiwgQXJkIEJpZXNoZXV2
ZWwgd3JvdGU6Cj4gPiA+ID4+Pj4+IE9uIE1vbiwgMjEgSmFuIDIwMTkgYXQgMTg6NTUsIE1pY2hl
bCBEw6RuemVyIDxtaWNoZWxAZGFlbnplci5uZXQ+IHdyb3RlOgo+ID4gPiA+Pj4+Pj4gT24gMjAx
OS0wMS0yMSA1OjMwIHAubS4sIEFyZCBCaWVzaGV1dmVsIHdyb3RlOgo+ID4gPiA+Pj4+Pj4+IE9u
IE1vbiwgMjEgSmFuIDIwMTkgYXQgMTc6MjIsIENocmlzdG9waCBIZWxsd2lnIDxoY2hAaW5mcmFk
ZWFkLm9yZz4gd3JvdGU6Cj4gPiA+ID4+Pj4+Pj4KPiA+ID4gPj4+Pj4+Pj4gVW50aWwgdGhhdCBo
YXBwZW5zIHdlIHNob3VsZCBqdXN0IGNoYW5nZSB0aGUgZHJpdmVyIGlmZGVmcyB0byBkZWZhdWx0
Cj4gPiA+ID4+Pj4+Pj4+IHRoZSBoYWNrcyB0byBvZmYgYW5kIG9ubHkgZW5hYmxlIHRoZW0gb24g
c2V0dXBzIHdoZXJlIHdlIDEwMCUKPiA+ID4gPj4+Pj4+Pj4gcG9zaXRpdmVseSBrbm93IHRoYXQg
dGhleSBhY3R1YWxseSB3b3JrLiAgQW5kIGRvY3VtZW50IHRoYXQgZmFjdAo+ID4gPiA+Pj4+Pj4+
PiBpbiBiaWcgZmF0IGNvbW1lbnRzLgo+ID4gPiA+Pj4+Pj4+Cj4gPiA+ID4+Pj4+Pj4gV2VsbCwg
YXMgSSBtZW50aW9uZWQgaW4gbXkgY29tbWl0IGxvZyBhcyB3ZWxsLCBpZiB3ZSBkZWZhdWx0IHRv
IG9mZgo+ID4gPiA+Pj4+Pj4+IHVubGVzcyBDT05GSUdfWDg2LCB3ZSBtYXkgYnJlYWsgd29ya2lu
ZyBzZXR1cHMgb24gTUlQUyBhbmQgUG93ZXIgd2hlcmUKPiA+ID4gPj4+Pj4+PiB0aGUgZGV2aWNl
IGlzIGluIGZhY3Qgbm9uLWNhY2hlIGNvaGVyZW50LCBhbmQgcmVsaWVzIG9uIHRoaXMKPiA+ID4g
Pj4+Pj4+PiAnb3B0aW1pemF0aW9uJyB0byBnZXQgdGhpbmdzIHdvcmtpbmcuCj4gPiA+ID4+Pj4+
Pgo+ID4gPiA+Pj4+Pj4gRldJVywgdGhlIGFtZGdwdSBkcml2ZXIgZG9lc24ndCByZWx5IG9uIG5v
bi1zbm9vcGVkIHRyYW5zZmVycyBmb3IKPiA+ID4gPj4+Pj4+IGNvcnJlY3QgYmFzaWMgb3BlcmF0
aW9uICh0aGUgc2NlbmFyaW8gQ2hyaXN0aWFuIGJyb3VnaHQgdXAgaXMgYSB2ZXJ5Cj4gPiA+ID4+
Pj4+PiBzcGVjaWFsaXplZCB1c2UtY2FzZSksIHNvIHRoYXQgc2hvdWxkbid0IGJlIGFuIGlzc3Vl
Lgo+ID4gPiA+Pj4+Pgo+ID4gPiA+Pj4+PiBUaGUgcG9pbnQgaXMgdGhhdCB0aGlzIGlzIG9ubHkg
dHJ1ZSBmb3IgeDg2Lgo+ID4gPiA+Pj4+Pgo+ID4gPiA+Pj4+PiBPbiBvdGhlciBhcmNoaXRlY3R1
cmVzLCB0aGUgdXNlIG9mIG5vbi1jYWNoZWQgbWFwcGluZ3Mgb24gdGhlIENQVSBzaWRlCj4gPiA+
ID4+Pj4+IG1lYW5zIHRoYXQgeW91IC9kby8gcmVseSBvbiBub24tc25vb3BlZCB0cmFuc2ZlcnMs
IHNpbmNlIGlmIHRob3NlCj4gPiA+ID4+Pj4+IHRyYW5zZmVycyB0dXJuIG91dCBub3QgdG8gc25v
b3AgaW5hZHZlcnRlbnRseSwgdGhlIGFjY2Vzc2VzIGFyZQo+ID4gPiA+Pj4+PiBpbmNvaGVyZW50
IHdpdGggdGhlIENQVSdzIHZpZXcgb2YgbWVtb3J5Lgo+ID4gPiA+Pj4+Cj4gPiA+ID4+Pj4gVGhl
IGRyaXZlciBnZW5lcmFsbHkgb25seSB1c2VzIG5vbi1jYWNoZWQgbWFwcGluZ3MgaWYKPiA+ID4g
Pj4+PiBkcm1fYXJjaC9kZXZpY2VfY2FuX3djX21lbW9yeSByZXR1cm5zIHRydWUuCj4gPiA+ID4+
Pgo+ID4gPiA+Pj4gSW5kZWVkLiBBbmQgc28gd2Ugc2hvdWxkIHRha2UgY2FyZSB0byBvbmx5IHJl
dHVybiAndHJ1ZScgZnJvbSB0aGF0Cj4gPiA+ID4+PiBmdW5jdGlvbiBpZiBpdCBpcyBndWFyYW50
ZWVkIHRoYXQgbm9uLWNhY2hlZCBDUFUgbWFwcGluZ3MgYXJlIGNvaGVyZW50Cj4gPiA+ID4+PiB3
aXRoIHRoZSBtYXBwaW5ncyB1c2VkIGJ5IHRoZSBHUFUsIGVpdGhlciBiZWNhdXNlIHRoYXQgaXMg
YWx3YXlzIHRoZQo+ID4gPiA+Pj4gY2FzZSAobGlrZSBvbiB4ODYpLCBvciBiZWNhdXNlIHdlIGtu
b3cgdGhhdCB0aGUgcGxhdGZvcm0gaW4gcXVlc3Rpb24KPiA+ID4gPj4+IGltcGxlbWVudHMgTm9T
bm9vcCBjb3JyZWN0bHkgdGhyb3VnaG91dCB0aGUgaW50ZXJjb25uZWN0Lgo+ID4gPiA+Pj4KPiA+
ID4gPj4+IFdoYXQgc2VlbXMgdG8gYmUgY29tcGxpY2F0aW5nIG1hdHRlcnMgaXMgdGhhdCBpbiBz
b21lIGNhc2VzLCB0aGUKPiA+ID4gPj4+IGRldmljZSBpcyBub24tY2FjaGUgY29oZXJlbnQgdG8g
YmVnaW4gd2l0aCwgc28gcmVnYXJkbGVzcyBvZiB3aGV0aGVyCj4gPiA+ID4+PiB0aGUgTm9Tbm9v
cCBhdHRyaWJ1dGUgaXMgdXNlZCBvciBub3QsIHRob3NlIGFjY2Vzc2VzIHdpbGwgbm90IHNub29w
IGluCj4gPiA+ID4+PiB0aGUgY2FjaGVzIGFuZCBiZSBjb2hlcmVudCB3aXRoIHRoZSBub24tY2Fj
aGVkIG1hcHBpbmdzIHVzZWQgYnkgdGhlCj4gPiA+ID4+PiBDUFUuIFNvIGlmIHdlIHJlc3RyaWN0
IHRoaXMgb3B0aW1pemF0aW9uIFtvbiBub24tWDg2XSB0byBwbGF0Zm9ybXMKPiA+ID4gPj4+IHRo
YXQgYXJlIGtub3duIHRvIGltcGxlbWVudCBOb1Nub29wIGNvcnJlY3RseSwgd2UgbWF5IGJyZWFr
IHBsYXRmb3Jtcwo+ID4gPiA+Pj4gdGhhdCBhcmUgaW1wbGljaXRseSBOb1Nub29wIGFsbCB0aGUg
dGltZS4KPiA+ID4gPj4KPiA+ID4gPj4gU2luY2UgdGhlIGRyaXZlciBnZW5lcmFsbHkgZG9lc24n
dCByZWx5IG9uIG5vbi1zbm9vcGVkIGFjY2Vzc2VzIGZvcgo+ID4gPiA+PiBjb3JyZWN0bmVzcywg
dGhhdCBjb3VsZG4ndCAiYnJlYWsiIGFueXRoaW5nIHRoYXQgaGFzbid0IGFsd2F5cyBiZWVuIGJy
b2tlbi4KPiA+ID4gPgo+ID4gPiA+IEFnYWluLCB0aGF0IGlzIG9ubHkgdHJ1ZSBvbiB4ODYuCj4g
PiA+ID4KPiA+ID4gPiBPbiBvdGhlciBhcmNoaXRlY3R1cmVzLCBETUEgd3JpdGVzIGZyb20gdGhl
IGRldmljZSBtYXkgYWxsb2NhdGUgaW4gdGhlCj4gPiA+ID4gY2FjaGVzLCBhbmQgYmUgaW52aXNp
YmxlIHRvIHRoZSBDUFUgd2hlbiBpdCB1c2VzIG5vbi1jYWNoZWQgbWFwcGluZ3MuCj4gPiA+Cj4g
PiA+IExldCBtZSB0cnkgb25lIGxhc3QgdGltZToKPiA+ID4KPiA+ID4gSWYgZHJtX2FyY2hfY2Fu
X3djX21lbW9yeSByZXR1cm5zIGZhbHNlLCB0aGUgZHJpdmVyIGZhbGxzIGJhY2sgdG8gdGhlCj4g
PiA+IG5vcm1hbCBtb2RlIG9mIG9wZXJhdGlvbiwgdXNpbmcgYSBjYWNoZWFibGUgQ1BVIG1hcHBp
bmcgYW5kIHNub29wZWQgR1BVCj4gPiA+IHRyYW5zZmVycywgZXZlbiBpZiB1c2Vyc3BhY2UgYXNr
cyAoYXMgYSBwZXJmb3JtYW5jZSBvcHRpbWl6YXRpb24pIGZvciBhCj4gPiA+IHdyaXRlLWNvbWJp
bmVkIENQVSBtYXBwaW5nIGFuZCBub24tc25vb3BlZCBHUFUgdHJhbnNmZXJzIHZpYQo+ID4gPiBB
TURHUFVfR0VNX0NSRUFURV9DUFVfR1RUX1VTV0MuCj4gPgo+ID4gQW5vdGhlciBxdWVzdGlvbjog
d2hlbiB1c2Vyc3BhY2UgcmVxdWVzdHMgZm9yIHN1Y2ggYSBtYXBwaW5nIHRvIGJlCj4gPiBjcmVh
dGVkLCBkb2VzIHRoaXMgaW52b2x2ZSBwYWdlcyB0aGF0IGFyZSBtYXBwZWQgY2FjaGVhYmxlIGlu
dG8gdGhlCj4gPiB1c2VybGFuZCBwcm9jZXNzPwo+Cj4gQU1ER1BVX0dFTV9DUkVBVEVfQ1BVX0dU
VF9VU1dDIG1lYW5zIHRoZSBidWZmZXIgc2hvdWxkIGJlIHVuY2FjaGVkIGFuZAo+IHdyaXRlIGNv
bWJpbmVkIGZyb20gdGhlIENQVSdzIHBlcnNwZWN0aXZlIChoZW5jZSB0aGUgJ0NQVScgaW4gdGhl
IGZsYWcKPiBuYW1lKS4gIE9uIHRoZSBHUFUgc2lkZSBpZiB0aGF0IGZsYWcgaXMgc2V0LCB3ZSBk
byBhbiBub24tc25vb3BlZCBHUFUKPiBtYXBwaW5nIGZvciBiZXR0ZXIgcGVyZm9ybWFuY2UgaWYg
dGhlIGJ1ZmZlciBlbmRzIHVwIGdldHRpbmcgbWFwcGVkCj4gaW50byB0aGUgR1BVJ3MgYWRkcmVz
cyBzcGFjZSBmb3IgR1BVIGFjY2Vzcy4KPgoKWWVzLCBzbyBtdWNoIHdhcyBjbGVhci4gQW5kIHRo
ZSByZWFzb24gdGhpcyBicmVha3Mgb24gc29tZSBhcm02NApzeXN0ZW1zIGlzIGJlY2F1c2UKYSkg
bm9uLXNub29wZWQgUENJZSBUTFAgYXR0cmlidXRlcyBtYXkgYmUgaWdub3JlZCwgYW5kCmIpIG5v
bi14ODYgQ1BVcyBkbyBub3Qgc25vb3AgdGhlIGNhY2hlcyB3aGVuIGFjY2Vzc2luZyB1bmNhY2hl
ZCBtYXBwaW5ncy4KCkkgZG9uJ3QgdGhpbmsgdGhlcmUgaXMgYWN0dWFsbHkgYW55IGRpc2FncmVl
bWVudCBvbiB0aGlzIHBhcnQuIEFuZCBJCnRoaW5rIG15IHBhdGNoIGlzIHJlYXNvbmFibGUsIG9u
bHkgQ2hyaXN0b3BoIGlzIG9iamVjdGluZyB0byBpdCBvbiB0aGUKZ3JvdW5kcyB0aGF0IGRyaXZl
cnMgc2hvdWxkIG5vdCBnbyBhcm91bmQgdGhlIERNQSBBUEkgYW5kIGNyZWF0ZQp2bWFwKClzIG9m
IERNQSBwYWdlcyB3aXRoIHNlbGYgY2hvc2VuIGF0dHJpYnV0ZXMuCgpXaGF0IEkgYW0gdHJ5aW5n
IHRvIGZpZ3VyZSBvdXQgaXMgd2h5IHRoZSBjb2hlcmVuY3kgcHJvYmxlbSBleGlzdHM6Ci0gaXQg
Y291bGQgYmUgdGhhdCB0aGUgZGV2aWNlIGlzIHJlYWRpbmcgdXNpbmcgY2FjaGVkIG1hcHBpbmdz
IGFuZApzZWVzIHN0YWxlIGNsZWFuIGNhY2hlbGluZXMgdGhhdCBzaGFkb3cgZGF0YSB3cml0dGVu
IGJ5IHRoZSBDUFUgdXNpbmcKdW5jYWNoZWQgbWFwcGluZ3MKLSBvciB0aGUgZGV2aWNlIGlzIHdy
aXRpbmcgd2l0aCBjYWNoZWQgbWFwcGluZ3MsIHJlc3VsdGluZyBpbiBkYXRhIHRvCmJlIGFsbG9j
YXRlZCB0aGVyZSwgYnV0IHRoZSBDUFUgZG9lcyBub3Qgc2VlIGl0IGJlY2F1c2UgaXQgcmVhZHMg
dXNpbmcKdW5jYWNoZWQgbWFwcGluZ3MuCgpJbiB0aGUgZm9ybWVyIGNhc2UsIEkgd291bGQgZXhw
ZWN0IGNhY2hlIGludmFsaWRhdGlvbiByaWdodCBhZnRlciB0aGUKdm1hcCgpIHRvIGJlIHN1ZmZp
Y2llbnQsIGJ1dCBpbiB0aGUgbGF0dGVyIGNhc2UsIGl0IGlzIGEgYml0IG1vcmUKZGlmZmljdWx0
IHByb2JhYmx5LgoKU28gbXkgcXVlc3Rpb24gd2FzIHdoZXRoZXIgdGhlcmUgYXJlIGNhY2hlYWJs
ZSBhbGlhc2VzIGZvciB0aG9zZQp1bmNhY2hlZCB2bWFwKClzIGJlaW5nIHVzZWQ/CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVs
IG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
