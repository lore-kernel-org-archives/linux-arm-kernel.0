Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A332C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:57:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6973721726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HzY68w7W";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YH3O+iEB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6973721726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r3F91CBtjMIMEH6NNRSW5QIXGZEHI9IyVNgsFgL6eFo=; b=HzY68w7Wz05pXO
	ccU3uzFabuuvuvmW8IiTawafwkiY//YB7StLGmr73E9kQ7NJ4tiZFiZt3HzFE4d8PIHB2SS8Zen/2
	lZxBw2Xs2vsfmx/iN4vlgvdNESmUZbL0VR7LyBlq+oK/DrnUdSW/qsZUc2mabnts+p1tJMH+lyomm
	NymVO7R1ff49Df5ShyZIpfFk1jZSI9Cy++lJ+XlhozHGCNTxONRWJviYoCY5wddIclW2Ul0lJbXuX
	a25NxLSAvWtxILdoKyu8VqcJ7AUNP+kHi9p9n641AB6yENG/DIShL2tq6nG9FDbxzVRGmqmGRfl5W
	V8TStbtUyyw08UD/vUcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm36J-0000Zu-GE; Tue, 22 Jan 2019 20:56:51 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm36F-0000ZV-Km
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 20:56:49 +0000
Received: by mail-wr1-x441.google.com with SMTP id x10so28966306wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 12:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Y1Twsy5d3FmV1GSVk5zXfwAuFbIksJY0V6VcJQIaTLs=;
 b=YH3O+iEBgPhmf6ph1isS1rSjC51CSkZqMFaI3u3FY/THDI/o7OP4/3ZlbPyayUF/qV
 XGejvGFYUw2osZqRDh5V9twu5rgnCrBWM9EuB9mppvfjPaLick34ELF6PFFXFcolI9PY
 zdYG5UMxUJt/4B13GwwUgtMxjWqB8S8lXGEPJFiDZi4sCexZO90C0bFnM8bgxGY7AKCp
 Cj4HyGUKZzf+McgYlYTCyplNMiw9JBEG1nxWAYHIHROMDZD4VDAAgHot39dF6bPKdOkg
 YYNB/uhQDqj7QRZI5BkC2rMkQpG6S5dzm1Bgz4TJrgRuq9ypHhwjExzSEfkpcA/z5spa
 h61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Y1Twsy5d3FmV1GSVk5zXfwAuFbIksJY0V6VcJQIaTLs=;
 b=k2Q/MkNr7bNkPcE2acbV9oqLUHiz14rO5MBCCkQ/pSjektQnH28/ThMXQaqg5tMz8k
 RnX3Ekv9e04Mj2JnPsK9ooAEY5SKDoyADZsKWHmKKhsfdaFhRS0msFRtpNPz+o3BY6B9
 07keFT2fSdM7g2dQoxzzVZMH5oPVGbc+m9Dlp97SuO8yGf4pfrbGO8+y0DhOd6Szrb72
 lVa3d2FYsSIkkZVVM1aAG+h/Tgvxj3inQWgSGL2pu05lhe00/b0lokvGLT997w+oSLLe
 OxJUbo85RdvTKnJep0SftrlauKuHhk1b4h0xEgzYggnigzvTYf50BwJIeX8A8ntD9qfl
 N5iA==
X-Gm-Message-State: AJcUukeaDQYaHp3SvMhmMGYJmGNI0KIDhhSLKlRVLD9LCU9zzZOwgsn0
 pIaQTykkICP2e2S45gbuMkqGD7wMYtAKwlFd2Ro=
X-Google-Smtp-Source: ALg8bN74syTrDcHW0X3XdG9wcbGqRfmlgVw7jVnXOEUeSwHcOQ+tWRWfv7XP25eVVfT15jNPAH0yiI+KFx9JJQpW9qc=
X-Received: by 2002:a5d:5351:: with SMTP id t17mr34356756wrv.288.1548190605573; 
 Tue, 22 Jan 2019 12:56:45 -0800 (PST)
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
In-Reply-To: <CAKv+Gu_VBd8agHASc5RS0eCgyXP64Lt_i4yPuBjKwGQ+5Lpd5Q@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 22 Jan 2019 15:56:33 -0500
Message-ID: <CADnq5_O1uxCrSksfF127AZTfbmdukxmqGdh2Ee0zM6CqgG_Mhg@mail.gmail.com>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_125647_684888_69EC4A8C 
X-CRM114-Status: GOOD (  25.15  )
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

T24gVHVlLCBKYW4gMjIsIDIwMTkgYXQgNDoxOSBBTSBBcmQgQmllc2hldXZlbAo8YXJkLmJpZXNo
ZXV2ZWxAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBPbiBNb24sIDIxIEphbiAyMDE5IGF0IDIwOjA0
LCBNaWNoZWwgRMOkbnplciA8bWljaGVsQGRhZW56ZXIubmV0PiB3cm90ZToKPiA+Cj4gPiBPbiAy
MDE5LTAxLTIxIDc6MjggcC5tLiwgQXJkIEJpZXNoZXV2ZWwgd3JvdGU6Cj4gPiA+IE9uIE1vbiwg
MjEgSmFuIDIwMTkgYXQgMTk6MjQsIE1pY2hlbCBEw6RuemVyIDxtaWNoZWxAZGFlbnplci5uZXQ+
IHdyb3RlOgo+ID4gPj4gT24gMjAxOS0wMS0yMSA3OjIwIHAubS4sIEFyZCBCaWVzaGV1dmVsIHdy
b3RlOgo+ID4gPj4+IE9uIE1vbiwgMjEgSmFuIDIwMTkgYXQgMTk6MDQsIE1pY2hlbCBEw6RuemVy
IDxtaWNoZWxAZGFlbnplci5uZXQ+IHdyb3RlOgo+ID4gPj4+PiBPbiAyMDE5LTAxLTIxIDY6NTkg
cC5tLiwgQXJkIEJpZXNoZXV2ZWwgd3JvdGU6Cj4gPiA+Pj4+PiBPbiBNb24sIDIxIEphbiAyMDE5
IGF0IDE4OjU1LCBNaWNoZWwgRMOkbnplciA8bWljaGVsQGRhZW56ZXIubmV0PiB3cm90ZToKPiA+
ID4+Pj4+PiBPbiAyMDE5LTAxLTIxIDU6MzAgcC5tLiwgQXJkIEJpZXNoZXV2ZWwgd3JvdGU6Cj4g
PiA+Pj4+Pj4+IE9uIE1vbiwgMjEgSmFuIDIwMTkgYXQgMTc6MjIsIENocmlzdG9waCBIZWxsd2ln
IDxoY2hAaW5mcmFkZWFkLm9yZz4gd3JvdGU6Cj4gPiA+Pj4+Pj4+Cj4gPiA+Pj4+Pj4+PiBVbnRp
bCB0aGF0IGhhcHBlbnMgd2Ugc2hvdWxkIGp1c3QgY2hhbmdlIHRoZSBkcml2ZXIgaWZkZWZzIHRv
IGRlZmF1bHQKPiA+ID4+Pj4+Pj4+IHRoZSBoYWNrcyB0byBvZmYgYW5kIG9ubHkgZW5hYmxlIHRo
ZW0gb24gc2V0dXBzIHdoZXJlIHdlIDEwMCUKPiA+ID4+Pj4+Pj4+IHBvc2l0aXZlbHkga25vdyB0
aGF0IHRoZXkgYWN0dWFsbHkgd29yay4gIEFuZCBkb2N1bWVudCB0aGF0IGZhY3QKPiA+ID4+Pj4+
Pj4+IGluIGJpZyBmYXQgY29tbWVudHMuCj4gPiA+Pj4+Pj4+Cj4gPiA+Pj4+Pj4+IFdlbGwsIGFz
IEkgbWVudGlvbmVkIGluIG15IGNvbW1pdCBsb2cgYXMgd2VsbCwgaWYgd2UgZGVmYXVsdCB0byBv
ZmYKPiA+ID4+Pj4+Pj4gdW5sZXNzIENPTkZJR19YODYsIHdlIG1heSBicmVhayB3b3JraW5nIHNl
dHVwcyBvbiBNSVBTIGFuZCBQb3dlciB3aGVyZQo+ID4gPj4+Pj4+PiB0aGUgZGV2aWNlIGlzIGlu
IGZhY3Qgbm9uLWNhY2hlIGNvaGVyZW50LCBhbmQgcmVsaWVzIG9uIHRoaXMKPiA+ID4+Pj4+Pj4g
J29wdGltaXphdGlvbicgdG8gZ2V0IHRoaW5ncyB3b3JraW5nLgo+ID4gPj4+Pj4+Cj4gPiA+Pj4+
Pj4gRldJVywgdGhlIGFtZGdwdSBkcml2ZXIgZG9lc24ndCByZWx5IG9uIG5vbi1zbm9vcGVkIHRy
YW5zZmVycyBmb3IKPiA+ID4+Pj4+PiBjb3JyZWN0IGJhc2ljIG9wZXJhdGlvbiAodGhlIHNjZW5h
cmlvIENocmlzdGlhbiBicm91Z2h0IHVwIGlzIGEgdmVyeQo+ID4gPj4+Pj4+IHNwZWNpYWxpemVk
IHVzZS1jYXNlKSwgc28gdGhhdCBzaG91bGRuJ3QgYmUgYW4gaXNzdWUuCj4gPiA+Pj4+Pgo+ID4g
Pj4+Pj4gVGhlIHBvaW50IGlzIHRoYXQgdGhpcyBpcyBvbmx5IHRydWUgZm9yIHg4Ni4KPiA+ID4+
Pj4+Cj4gPiA+Pj4+PiBPbiBvdGhlciBhcmNoaXRlY3R1cmVzLCB0aGUgdXNlIG9mIG5vbi1jYWNo
ZWQgbWFwcGluZ3Mgb24gdGhlIENQVSBzaWRlCj4gPiA+Pj4+PiBtZWFucyB0aGF0IHlvdSAvZG8v
IHJlbHkgb24gbm9uLXNub29wZWQgdHJhbnNmZXJzLCBzaW5jZSBpZiB0aG9zZQo+ID4gPj4+Pj4g
dHJhbnNmZXJzIHR1cm4gb3V0IG5vdCB0byBzbm9vcCBpbmFkdmVydGVudGx5LCB0aGUgYWNjZXNz
ZXMgYXJlCj4gPiA+Pj4+PiBpbmNvaGVyZW50IHdpdGggdGhlIENQVSdzIHZpZXcgb2YgbWVtb3J5
Lgo+ID4gPj4+Pgo+ID4gPj4+PiBUaGUgZHJpdmVyIGdlbmVyYWxseSBvbmx5IHVzZXMgbm9uLWNh
Y2hlZCBtYXBwaW5ncyBpZgo+ID4gPj4+PiBkcm1fYXJjaC9kZXZpY2VfY2FuX3djX21lbW9yeSBy
ZXR1cm5zIHRydWUuCj4gPiA+Pj4KPiA+ID4+PiBJbmRlZWQuIEFuZCBzbyB3ZSBzaG91bGQgdGFr
ZSBjYXJlIHRvIG9ubHkgcmV0dXJuICd0cnVlJyBmcm9tIHRoYXQKPiA+ID4+PiBmdW5jdGlvbiBp
ZiBpdCBpcyBndWFyYW50ZWVkIHRoYXQgbm9uLWNhY2hlZCBDUFUgbWFwcGluZ3MgYXJlIGNvaGVy
ZW50Cj4gPiA+Pj4gd2l0aCB0aGUgbWFwcGluZ3MgdXNlZCBieSB0aGUgR1BVLCBlaXRoZXIgYmVj
YXVzZSB0aGF0IGlzIGFsd2F5cyB0aGUKPiA+ID4+PiBjYXNlIChsaWtlIG9uIHg4NiksIG9yIGJl
Y2F1c2Ugd2Uga25vdyB0aGF0IHRoZSBwbGF0Zm9ybSBpbiBxdWVzdGlvbgo+ID4gPj4+IGltcGxl
bWVudHMgTm9Tbm9vcCBjb3JyZWN0bHkgdGhyb3VnaG91dCB0aGUgaW50ZXJjb25uZWN0Lgo+ID4g
Pj4+Cj4gPiA+Pj4gV2hhdCBzZWVtcyB0byBiZSBjb21wbGljYXRpbmcgbWF0dGVycyBpcyB0aGF0
IGluIHNvbWUgY2FzZXMsIHRoZQo+ID4gPj4+IGRldmljZSBpcyBub24tY2FjaGUgY29oZXJlbnQg
dG8gYmVnaW4gd2l0aCwgc28gcmVnYXJkbGVzcyBvZiB3aGV0aGVyCj4gPiA+Pj4gdGhlIE5vU25v
b3AgYXR0cmlidXRlIGlzIHVzZWQgb3Igbm90LCB0aG9zZSBhY2Nlc3NlcyB3aWxsIG5vdCBzbm9v
cCBpbgo+ID4gPj4+IHRoZSBjYWNoZXMgYW5kIGJlIGNvaGVyZW50IHdpdGggdGhlIG5vbi1jYWNo
ZWQgbWFwcGluZ3MgdXNlZCBieSB0aGUKPiA+ID4+PiBDUFUuIFNvIGlmIHdlIHJlc3RyaWN0IHRo
aXMgb3B0aW1pemF0aW9uIFtvbiBub24tWDg2XSB0byBwbGF0Zm9ybXMKPiA+ID4+PiB0aGF0IGFy
ZSBrbm93biB0byBpbXBsZW1lbnQgTm9Tbm9vcCBjb3JyZWN0bHksIHdlIG1heSBicmVhayBwbGF0
Zm9ybXMKPiA+ID4+PiB0aGF0IGFyZSBpbXBsaWNpdGx5IE5vU25vb3AgYWxsIHRoZSB0aW1lLgo+
ID4gPj4KPiA+ID4+IFNpbmNlIHRoZSBkcml2ZXIgZ2VuZXJhbGx5IGRvZXNuJ3QgcmVseSBvbiBu
b24tc25vb3BlZCBhY2Nlc3NlcyBmb3IKPiA+ID4+IGNvcnJlY3RuZXNzLCB0aGF0IGNvdWxkbid0
ICJicmVhayIgYW55dGhpbmcgdGhhdCBoYXNuJ3QgYWx3YXlzIGJlZW4gYnJva2VuLgo+ID4gPgo+
ID4gPiBBZ2FpbiwgdGhhdCBpcyBvbmx5IHRydWUgb24geDg2Lgo+ID4gPgo+ID4gPiBPbiBvdGhl
ciBhcmNoaXRlY3R1cmVzLCBETUEgd3JpdGVzIGZyb20gdGhlIGRldmljZSBtYXkgYWxsb2NhdGUg
aW4gdGhlCj4gPiA+IGNhY2hlcywgYW5kIGJlIGludmlzaWJsZSB0byB0aGUgQ1BVIHdoZW4gaXQg
dXNlcyBub24tY2FjaGVkIG1hcHBpbmdzLgo+ID4KPiA+IExldCBtZSB0cnkgb25lIGxhc3QgdGlt
ZToKPiA+Cj4gPiBJZiBkcm1fYXJjaF9jYW5fd2NfbWVtb3J5IHJldHVybnMgZmFsc2UsIHRoZSBk
cml2ZXIgZmFsbHMgYmFjayB0byB0aGUKPiA+IG5vcm1hbCBtb2RlIG9mIG9wZXJhdGlvbiwgdXNp
bmcgYSBjYWNoZWFibGUgQ1BVIG1hcHBpbmcgYW5kIHNub29wZWQgR1BVCj4gPiB0cmFuc2ZlcnMs
IGV2ZW4gaWYgdXNlcnNwYWNlIGFza3MgKGFzIGEgcGVyZm9ybWFuY2Ugb3B0aW1pemF0aW9uKSBm
b3IgYQo+ID4gd3JpdGUtY29tYmluZWQgQ1BVIG1hcHBpbmcgYW5kIG5vbi1zbm9vcGVkIEdQVSB0
cmFuc2ZlcnMgdmlhCj4gPiBBTURHUFVfR0VNX0NSRUFURV9DUFVfR1RUX1VTV0MuCj4KPiBBbm90
aGVyIHF1ZXN0aW9uOiB3aGVuIHVzZXJzcGFjZSByZXF1ZXN0cyBmb3Igc3VjaCBhIG1hcHBpbmcg
dG8gYmUKPiBjcmVhdGVkLCBkb2VzIHRoaXMgaW52b2x2ZSBwYWdlcyB0aGF0IGFyZSBtYXBwZWQg
Y2FjaGVhYmxlIGludG8gdGhlCj4gdXNlcmxhbmQgcHJvY2Vzcz8KCkFNREdQVV9HRU1fQ1JFQVRF
X0NQVV9HVFRfVVNXQyBtZWFucyB0aGUgYnVmZmVyIHNob3VsZCBiZSB1bmNhY2hlZCBhbmQKd3Jp
dGUgY29tYmluZWQgZnJvbSB0aGUgQ1BVJ3MgcGVyc3BlY3RpdmUgKGhlbmNlIHRoZSAnQ1BVJyBp
biB0aGUgZmxhZwpuYW1lKS4gIE9uIHRoZSBHUFUgc2lkZSBpZiB0aGF0IGZsYWcgaXMgc2V0LCB3
ZSBkbyBhbiBub24tc25vb3BlZCBHUFUKbWFwcGluZyBmb3IgYmV0dGVyIHBlcmZvcm1hbmNlIGlm
IHRoZSBidWZmZXIgZW5kcyB1cCBnZXR0aW5nIG1hcHBlZAppbnRvIHRoZSBHUFUncyBhZGRyZXNz
IHNwYWNlIGZvciBHUFUgYWNjZXNzLgoKQWxleAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
