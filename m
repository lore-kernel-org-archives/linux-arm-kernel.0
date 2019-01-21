Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A637C31680
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:19:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FE4521721
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vcct+uxx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gRv8geTm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE4521721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RKwUK+D/QZD3bv8bcTG4Lk2MLtodo096YXYHe26rugI=; b=Vcct+uxxtTIK28
	rm7gQVY0xzu5AuS/bMFkBfgTYI/7ICR1LpBhUvNcoF94gUNNLiZHjvW604lhHfpAApu2Uf3dAhE+Z
	tWq6HK6gxmbqrKoMcb/opGJwx8UV7Esojmvse0NoAA/Vs4ClbPkGvr4DpXfyyfQIdmwE/MB1md2Bd
	foyzyqf7qWd8wMGoR/44t+NEnQPj8BCnBD4avCQYWLhyvwp9nadEXmL7xhqASI22zvXT2UqPhyegX
	xZLQx0LvhpLXYugeGv4X1a+H1dQOcxLODLebPxdMwjpMv23huENMzlx++bb80gHRP1Fp4riE3kcUJ
	tXm5RXjbwty/qIfa/oEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glf6B-0004mc-1D; Mon, 21 Jan 2019 19:19:07 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glf67-0004mD-F0
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 19:19:05 +0000
Received: by mail-it1-x143.google.com with SMTP id w18so17994297ite.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 11:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=tWkTW3k+bIMa8ZNbYJt7g6YWTX7Qi5IGP7maD32/94Y=;
 b=gRv8geTmTUA+7CBmtPOuabUbz8xyJC9hAd45Png5i8B6i/eKo4xe/DwNX5hjr3u9tg
 fUl2qucOfVw1Yujnp2sPnWPtOTYnvy6iFWdgLNfk+RQjfgxI0b/er+xiyM9dpYM+JA8M
 FQrs6ycbJRiIi6idbcbpBB/7b2r7okhbckZHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tWkTW3k+bIMa8ZNbYJt7g6YWTX7Qi5IGP7maD32/94Y=;
 b=Cu97K+JQfm8fNoBXKq0TjgdDvDvL52h1Asj+49oCKRbn/kv3bLVLphjdLRnnVo9m5e
 nudg5fIfj9v71GWxXkoqVjYu2Zu4T3iQ2fkBdkZhVKO1rm8M4dWPtXr+isP1csT+KC+z
 RuBa/ymT+RQNb4tnDGXk8tqwbyEGUhrWorp8dQimJb/+VTf6ahRwIB4nsLhL3ouqnZs+
 ZL0NP0rr/cnCXiaifb+6pAm6Y8IKmYkWcK8fEGgMhjN0o1F4vqEXj/kmjuc5z4oZ0k4y
 b/vMA56gDyAuEy07TZA6Ggltq2K8uMwmHdruTBGH9TMQAfl1UG1m55sLKRqBywQ2CQpY
 HObA==
X-Gm-Message-State: AJcUukegq0VQcGrBcv/KbvwesqOl4JKH/nSvLsYL8NL1wjJdY6+ZmjZx
 CWr6Bu/PeZnZMKt8gv+6DHpIdNQPQVUpD7xX7ptcNg==
X-Google-Smtp-Source: AHgI3IaQ7V8HPG7/byRY7qZDpx0KwlvbP/JzgF9Zy0+0MAguhIlFyPtxf/9XSQUKrVWkg9APT3qNu/9KGFOCNDfu6To=
X-Received: by 2002:a24:edc4:: with SMTP id r187mr495418ith.158.1548098342336; 
 Mon, 21 Jan 2019 11:19:02 -0800 (PST)
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
In-Reply-To: <047667fd-17be-1c37-5d2a-26768cfd6ab8@daenzer.net>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 21 Jan 2019 20:18:51 +0100
Message-ID: <CAKv+Gu-gaZpKqyLt9Vft2e_zS4Xkc9+8HAYoHvuBo5C0hqL2Qw@mail.gmail.com>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_111903_499509_BEBC13A7 
X-CRM114-Status: GOOD (  26.47  )
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

T24gTW9uLCAyMSBKYW4gMjAxOSBhdCAyMDowNCwgTWljaGVsIETDpG56ZXIgPG1pY2hlbEBkYWVu
emVyLm5ldD4gd3JvdGU6Cj4KPiBPbiAyMDE5LTAxLTIxIDc6MjggcC5tLiwgQXJkIEJpZXNoZXV2
ZWwgd3JvdGU6Cj4gPiBPbiBNb24sIDIxIEphbiAyMDE5IGF0IDE5OjI0LCBNaWNoZWwgRMOkbnpl
ciA8bWljaGVsQGRhZW56ZXIubmV0PiB3cm90ZToKPiA+PiBPbiAyMDE5LTAxLTIxIDc6MjAgcC5t
LiwgQXJkIEJpZXNoZXV2ZWwgd3JvdGU6Cj4gPj4+IE9uIE1vbiwgMjEgSmFuIDIwMTkgYXQgMTk6
MDQsIE1pY2hlbCBEw6RuemVyIDxtaWNoZWxAZGFlbnplci5uZXQ+IHdyb3RlOgo+ID4+Pj4gT24g
MjAxOS0wMS0yMSA2OjU5IHAubS4sIEFyZCBCaWVzaGV1dmVsIHdyb3RlOgo+ID4+Pj4+IE9uIE1v
biwgMjEgSmFuIDIwMTkgYXQgMTg6NTUsIE1pY2hlbCBEw6RuemVyIDxtaWNoZWxAZGFlbnplci5u
ZXQ+IHdyb3RlOgo+ID4+Pj4+PiBPbiAyMDE5LTAxLTIxIDU6MzAgcC5tLiwgQXJkIEJpZXNoZXV2
ZWwgd3JvdGU6Cj4gPj4+Pj4+PiBPbiBNb24sIDIxIEphbiAyMDE5IGF0IDE3OjIyLCBDaHJpc3Rv
cGggSGVsbHdpZyA8aGNoQGluZnJhZGVhZC5vcmc+IHdyb3RlOgo+ID4+Pj4+Pj4KPiA+Pj4+Pj4+
PiBVbnRpbCB0aGF0IGhhcHBlbnMgd2Ugc2hvdWxkIGp1c3QgY2hhbmdlIHRoZSBkcml2ZXIgaWZk
ZWZzIHRvIGRlZmF1bHQKPiA+Pj4+Pj4+PiB0aGUgaGFja3MgdG8gb2ZmIGFuZCBvbmx5IGVuYWJs
ZSB0aGVtIG9uIHNldHVwcyB3aGVyZSB3ZSAxMDAlCj4gPj4+Pj4+Pj4gcG9zaXRpdmVseSBrbm93
IHRoYXQgdGhleSBhY3R1YWxseSB3b3JrLiAgQW5kIGRvY3VtZW50IHRoYXQgZmFjdAo+ID4+Pj4+
Pj4+IGluIGJpZyBmYXQgY29tbWVudHMuCj4gPj4+Pj4+Pgo+ID4+Pj4+Pj4gV2VsbCwgYXMgSSBt
ZW50aW9uZWQgaW4gbXkgY29tbWl0IGxvZyBhcyB3ZWxsLCBpZiB3ZSBkZWZhdWx0IHRvIG9mZgo+
ID4+Pj4+Pj4gdW5sZXNzIENPTkZJR19YODYsIHdlIG1heSBicmVhayB3b3JraW5nIHNldHVwcyBv
biBNSVBTIGFuZCBQb3dlciB3aGVyZQo+ID4+Pj4+Pj4gdGhlIGRldmljZSBpcyBpbiBmYWN0IG5v
bi1jYWNoZSBjb2hlcmVudCwgYW5kIHJlbGllcyBvbiB0aGlzCj4gPj4+Pj4+PiAnb3B0aW1pemF0
aW9uJyB0byBnZXQgdGhpbmdzIHdvcmtpbmcuCj4gPj4+Pj4+Cj4gPj4+Pj4+IEZXSVcsIHRoZSBh
bWRncHUgZHJpdmVyIGRvZXNuJ3QgcmVseSBvbiBub24tc25vb3BlZCB0cmFuc2ZlcnMgZm9yCj4g
Pj4+Pj4+IGNvcnJlY3QgYmFzaWMgb3BlcmF0aW9uICh0aGUgc2NlbmFyaW8gQ2hyaXN0aWFuIGJy
b3VnaHQgdXAgaXMgYSB2ZXJ5Cj4gPj4+Pj4+IHNwZWNpYWxpemVkIHVzZS1jYXNlKSwgc28gdGhh
dCBzaG91bGRuJ3QgYmUgYW4gaXNzdWUuCj4gPj4+Pj4KPiA+Pj4+PiBUaGUgcG9pbnQgaXMgdGhh
dCB0aGlzIGlzIG9ubHkgdHJ1ZSBmb3IgeDg2Lgo+ID4+Pj4+Cj4gPj4+Pj4gT24gb3RoZXIgYXJj
aGl0ZWN0dXJlcywgdGhlIHVzZSBvZiBub24tY2FjaGVkIG1hcHBpbmdzIG9uIHRoZSBDUFUgc2lk
ZQo+ID4+Pj4+IG1lYW5zIHRoYXQgeW91IC9kby8gcmVseSBvbiBub24tc25vb3BlZCB0cmFuc2Zl
cnMsIHNpbmNlIGlmIHRob3NlCj4gPj4+Pj4gdHJhbnNmZXJzIHR1cm4gb3V0IG5vdCB0byBzbm9v
cCBpbmFkdmVydGVudGx5LCB0aGUgYWNjZXNzZXMgYXJlCj4gPj4+Pj4gaW5jb2hlcmVudCB3aXRo
IHRoZSBDUFUncyB2aWV3IG9mIG1lbW9yeS4KPiA+Pj4+Cj4gPj4+PiBUaGUgZHJpdmVyIGdlbmVy
YWxseSBvbmx5IHVzZXMgbm9uLWNhY2hlZCBtYXBwaW5ncyBpZgo+ID4+Pj4gZHJtX2FyY2gvZGV2
aWNlX2Nhbl93Y19tZW1vcnkgcmV0dXJucyB0cnVlLgo+ID4+Pgo+ID4+PiBJbmRlZWQuIEFuZCBz
byB3ZSBzaG91bGQgdGFrZSBjYXJlIHRvIG9ubHkgcmV0dXJuICd0cnVlJyBmcm9tIHRoYXQKPiA+
Pj4gZnVuY3Rpb24gaWYgaXQgaXMgZ3VhcmFudGVlZCB0aGF0IG5vbi1jYWNoZWQgQ1BVIG1hcHBp
bmdzIGFyZSBjb2hlcmVudAo+ID4+PiB3aXRoIHRoZSBtYXBwaW5ncyB1c2VkIGJ5IHRoZSBHUFUs
IGVpdGhlciBiZWNhdXNlIHRoYXQgaXMgYWx3YXlzIHRoZQo+ID4+PiBjYXNlIChsaWtlIG9uIHg4
NiksIG9yIGJlY2F1c2Ugd2Uga25vdyB0aGF0IHRoZSBwbGF0Zm9ybSBpbiBxdWVzdGlvbgo+ID4+
PiBpbXBsZW1lbnRzIE5vU25vb3AgY29ycmVjdGx5IHRocm91Z2hvdXQgdGhlIGludGVyY29ubmVj
dC4KPiA+Pj4KPiA+Pj4gV2hhdCBzZWVtcyB0byBiZSBjb21wbGljYXRpbmcgbWF0dGVycyBpcyB0
aGF0IGluIHNvbWUgY2FzZXMsIHRoZQo+ID4+PiBkZXZpY2UgaXMgbm9uLWNhY2hlIGNvaGVyZW50
IHRvIGJlZ2luIHdpdGgsIHNvIHJlZ2FyZGxlc3Mgb2Ygd2hldGhlcgo+ID4+PiB0aGUgTm9Tbm9v
cCBhdHRyaWJ1dGUgaXMgdXNlZCBvciBub3QsIHRob3NlIGFjY2Vzc2VzIHdpbGwgbm90IHNub29w
IGluCj4gPj4+IHRoZSBjYWNoZXMgYW5kIGJlIGNvaGVyZW50IHdpdGggdGhlIG5vbi1jYWNoZWQg
bWFwcGluZ3MgdXNlZCBieSB0aGUKPiA+Pj4gQ1BVLiBTbyBpZiB3ZSByZXN0cmljdCB0aGlzIG9w
dGltaXphdGlvbiBbb24gbm9uLVg4Nl0gdG8gcGxhdGZvcm1zCj4gPj4+IHRoYXQgYXJlIGtub3du
IHRvIGltcGxlbWVudCBOb1Nub29wIGNvcnJlY3RseSwgd2UgbWF5IGJyZWFrIHBsYXRmb3Jtcwo+
ID4+PiB0aGF0IGFyZSBpbXBsaWNpdGx5IE5vU25vb3AgYWxsIHRoZSB0aW1lLgo+ID4+Cj4gPj4g
U2luY2UgdGhlIGRyaXZlciBnZW5lcmFsbHkgZG9lc24ndCByZWx5IG9uIG5vbi1zbm9vcGVkIGFj
Y2Vzc2VzIGZvcgo+ID4+IGNvcnJlY3RuZXNzLCB0aGF0IGNvdWxkbid0ICJicmVhayIgYW55dGhp
bmcgdGhhdCBoYXNuJ3QgYWx3YXlzIGJlZW4gYnJva2VuLgo+ID4KPiA+IEFnYWluLCB0aGF0IGlz
IG9ubHkgdHJ1ZSBvbiB4ODYuCj4gPgo+ID4gT24gb3RoZXIgYXJjaGl0ZWN0dXJlcywgRE1BIHdy
aXRlcyBmcm9tIHRoZSBkZXZpY2UgbWF5IGFsbG9jYXRlIGluIHRoZQo+ID4gY2FjaGVzLCBhbmQg
YmUgaW52aXNpYmxlIHRvIHRoZSBDUFUgd2hlbiBpdCB1c2VzIG5vbi1jYWNoZWQgbWFwcGluZ3Mu
Cj4KPiBMZXQgbWUgdHJ5IG9uZSBsYXN0IHRpbWU6Cj4KCkkgY291bGQgc2F5IHRoZSBzYW1lIDot
KQoKPiBJZiBkcm1fYXJjaF9jYW5fd2NfbWVtb3J5IHJldHVybnMgZmFsc2UsIHRoZSBkcml2ZXIg
ZmFsbHMgYmFjayB0byB0aGUKPiBub3JtYWwgbW9kZSBvZiBvcGVyYXRpb24sIHVzaW5nIGEgY2Fj
aGVhYmxlIENQVSBtYXBwaW5nIGFuZCBzbm9vcGVkIEdQVQo+IHRyYW5zZmVycywgZXZlbiBpZiB1
c2Vyc3BhY2UgYXNrcyAoYXMgYSBwZXJmb3JtYW5jZSBvcHRpbWl6YXRpb24pIGZvciBhCj4gd3Jp
dGUtY29tYmluZWQgQ1BVIG1hcHBpbmcgYW5kIG5vbi1zbm9vcGVkIEdQVSB0cmFuc2ZlcnMgdmlh
Cj4gQU1ER1BVX0dFTV9DUkVBVEVfQ1BVX0dUVF9VU1dDLgoKSSBhbSBub3QgdGFsa2luZyBhYm91
dCB0aGUgY2FzZSB3aGVyZSBkcm1fYXJjaF9jYW5fd2NfbWVtb3J5KCkgcmV0dXJucyBmYWxzZS4K
CkkgYW0gdGFsa2luZyBhYm91dCB0aGUgY2FzZSB3aGVyZSBpdCByZXR1cm5zIHRydWUsIHdoaWNo
IGlzIGN1cnJlbnRseQp0aGUgZGVmYXVsdCBmb3IgYWxsIGFyY2hpdGVjdHVyZXMsIGV4Y2VwdCBQ
b3dlciBhbmQgTUlQUyBpbiBzb21lCmNhc2VzLgoKVGhpcyBtb2RlIG9mIG9wZXJhdGlvbiBicmVh
a3MgbXkgY2FjaGUgY29oZXJlbnQgYXJtNjQgc3lzdGVtLiAoQU1EIFNlYXR0bGUpCldpdGggdGhp
cyBwYXRjaCBhcHBsaWVkLCBldmVyeXRoaW5nIHdvcmtzIGZpbmUuCgo+IFRoaXMgbm9ybWFsIG1v
ZGUgb2Ygb3BlcmF0aW9uIGlzIGFsc28KPiB1c2VkIGZvciB0aGUgcmluZyBidWZmZXJzIGF0IHRo
ZSBoZWFydCBvZiB0aGUgZHJpdmVyJ3Mgb3BlcmF0aW9uLgoKQnV0IGlzIGl0IHJlYWxseSB0aGUg
c2FtZSBtb2RlIG9mIG9wZXJhdGlvbj8gRG9lcyBpdCBhbHNvIHZtYXAoKSB0aGUKcGFnZXM/IE9y
IGRvZXMgaXQgdXNlIHRoZSBETUEgQVBJIHRvIGFsbG9jYXRlIHRoZSByaW5nIGJ1ZmZlcnM/CkJl
Y2F1c2UgaW4gdGhlIGxhdHRlciBjYXNlLCB0aGlzIHdpbGwgZ2l2ZSB5b3Ugbm9uLWNhY2hlZCBD
UFUgbWFwcGluZ3MKYXMgd2VsbCBpZiB0aGUgZGV2aWNlIGlzIG5vbi1jYWNoZSBjb2hlcmVudC4K
Cj4gSWYKPiB0aGVyZSBpcyBhIHBsYXRmb3JtIHdoZXJlIHRoaXMgbm9ybWFsIG1vZGUgb2Ygb3Bl
cmF0aW9uIGRvZXNuJ3Qgd29yaywKPiB0aGUgZHJpdmVyIGNvdWxkIG5ldmVyIGhhdmUgd29ya2Vk
IHJlbGlhYmx5IG9uIHRoYXQgcGxhdGZvcm0sIHNpbmNlCj4gYmVmb3JlIEFNREdQVV9HRU1fQ1JF
QVRFX0NQVV9HVFRfVVNXQyBvciBkcm1fYXJjaF9jYW5fd2NfbWVtb3J5IGV2ZW4KPiBleGlzdGVk
Lgo+CgpBcyBJIHNhaWQsIEkgYW0gdGFsa2luZyBhYm91dCB0aGUgY2FzZSB3aGVyZSBkcm1fYXJj
aF9jYW5fd2NfbWVtb3J5KCkKcmV0dXJucyB0cnVlIG9uIGEgY2FjaGUgY29oZXJlbnQgc3lzdGVt
LiBUaGlzIHJlbGllcyBvbiBOb1Nub29wIGJlaW5nCmltcGxlbWVudGVkIGNvcnJlY3RseSBpbiB0
aGUgcGxhdGZvcm0sIG9yIGEgQ1BVIGFyY2hpdGVjdHVyZSB0aGF0CnNub29wcyB0aGUgY2FjaGVz
IHdoZW4gZG9pbmcgdW5jYWNoZWQgbWVtb3J5IGFjY2Vzc2VzIChzdWNoIGFzIHg4NikKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
