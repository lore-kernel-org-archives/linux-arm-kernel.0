Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5861BC31680
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:59:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B1982089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PRzV7O41";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WMRhZXc0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B1982089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3gxg0Mkia5VGC5FA72HDCbngjWkRsEhRAHQRtpmqT2k=; b=PRzV7O41+O/Q+/
	6oNwNSQGNcnDs1vTt6xoWfXZWu7putpqzIVws1AJCqzYNGkxhdP0MPmr8m2rgb6dAe1KhHmi2Lhbn
	WgC1wmqbL1uRUl3VOoj5bZdToVsvIsm5iNPd2+vZJeWh5W33lYf6mRgvXomBVP1eMXkDXOgiiadvT
	BPhxm17RsTYQGgsVXx10iNcDN6jgpKn1Tg48MWV//AMevZlt0ujSCAcxPR7GIrDdEYVzCzFJ6P2dF
	HI86EIuIV4OQtiXOTcSY33DqzePjGB90fTK0MR/us9b/Cz0oBzTb6nF60lWdK0lIOjI+PRvwaXfB8
	7wPSE0Zh48yvAh/aXsRw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gldr2-0007He-NS; Mon, 21 Jan 2019 17:59:24 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gldr0-0007HI-3A
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 17:59:23 +0000
Received: by mail-it1-x144.google.com with SMTP id b5so16398873iti.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 09:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GIkKZS9024nvngV6e2KIorYK3XJmAI8zh9FUlk87wCM=;
 b=WMRhZXc0UjFFWdsPF5yVyvY4vVSav9F0z0zPtSiW7IOPv9kh5948WERCDs5DGh3hMk
 lm1Labs/Qzygsebmyx+r5zGHAfVxPKJQv7rPRLbDKlvdtl7Sy/xUwFJF9C6M2ePKqBFn
 6aDTC8AZztniu4pmAMtevm9JLMXa+7Aq30OX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GIkKZS9024nvngV6e2KIorYK3XJmAI8zh9FUlk87wCM=;
 b=VXXzHohgXwXvsh0oiz8pK+HWI/Xd5zZnZVWmPuiwmWHikYWGDLUQAwX4vmjNJSLxeY
 6ABWeJ97nCsesI7B5lDeVpdM1t4At7y3b6VZLvJOnO4nRJ45UHNmMEL6CagxQAvqneiA
 hbgSoUFgfgiJqhBv64uxpcAJx3wX1ktUNAnWScR0NMHcpulvC2GbUdQoaV6YhYv2jwgH
 ACUq8FabHj9c18Rh+vB/nxX2kb40VSNX0iTlIjJStTa9SOZjVbveMYPRPd8GRfCBEzEY
 zhLBicpXPIJeOS6Lltb7ZRXP741PPfhtaNmFrC+7EvYQ9RuMFWnjl6BEHI12/vRO/drA
 kvPg==
X-Gm-Message-State: AJcUukcnrN/XQ7gkP4Y166tvHyinh3gwwjK1MCQLnrX9+UwBqTaIv7Vp
 LE2BhIGWS3ACpG5zBWuT7w9IpFkIunfUxejOYUi6qQ==
X-Google-Smtp-Source: ALg8bN5/MqM7BpuFo7CWNk6ZT0kxRzlT1oWjjnVQX37laAUT7VGktD1Giho0GQi7FYskMQsT0Kk2rKQ0kQG7DqZhdI0=
X-Received: by 2002:a24:710:: with SMTP id f16mr220842itf.121.1548093561061;
 Mon, 21 Jan 2019 09:59:21 -0800 (PST)
MIME-Version: 1.0
References: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
 <20190121150734.GA30582@infradead.org>
 <CAKv+Gu-hR=uieOeg7QheA5yfAycUoi2vjZsDUvROKVjW4eUNqw@mail.gmail.com>
 <20190121155908.GA8084@infradead.org>
 <CAKv+Gu8LzS9OgvVnzUT8BZWVgDmx4OfqNiPSf+8=riY_LByN-g@mail.gmail.com>
 <20190121162238.GA17651@infradead.org>
 <CAKv+Gu-5V-UjP_YzZBCEsa+o_G6BRSVw2ZimYGNEfRGf-aRPNg@mail.gmail.com>
 <59ccf85d-b99d-b5c8-ea87-66c2a892e197@daenzer.net>
In-Reply-To: <59ccf85d-b99d-b5c8-ea87-66c2a892e197@daenzer.net>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 21 Jan 2019 18:59:10 +0100
Message-ID: <CAKv+Gu8OkbHwY5UBxahpQpM_gKh2331pQ6o-4YyJdLurbFNHvw@mail.gmail.com>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_095922_150554_8C965631 
X-CRM114-Status: GOOD (  14.68  )
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
Cc: David Zhou <David1.Zhou@amd.com>, Michel Daenzer <michel.daenzer@amd.com>,
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

T24gTW9uLCAyMSBKYW4gMjAxOSBhdCAxODo1NSwgTWljaGVsIETDpG56ZXIgPG1pY2hlbEBkYWVu
emVyLm5ldD4gd3JvdGU6Cj4KPiBPbiAyMDE5LTAxLTIxIDU6MzAgcC5tLiwgQXJkIEJpZXNoZXV2
ZWwgd3JvdGU6Cj4gPiBPbiBNb24sIDIxIEphbiAyMDE5IGF0IDE3OjIyLCBDaHJpc3RvcGggSGVs
bHdpZyA8aGNoQGluZnJhZGVhZC5vcmc+IHdyb3RlOgo+ID4KPiA+PiBVbnRpbCB0aGF0IGhhcHBl
bnMgd2Ugc2hvdWxkIGp1c3QgY2hhbmdlIHRoZSBkcml2ZXIgaWZkZWZzIHRvIGRlZmF1bHQKPiA+
PiB0aGUgaGFja3MgdG8gb2ZmIGFuZCBvbmx5IGVuYWJsZSB0aGVtIG9uIHNldHVwcyB3aGVyZSB3
ZSAxMDAlCj4gPj4gcG9zaXRpdmVseSBrbm93IHRoYXQgdGhleSBhY3R1YWxseSB3b3JrLiAgQW5k
IGRvY3VtZW50IHRoYXQgZmFjdAo+ID4+IGluIGJpZyBmYXQgY29tbWVudHMuCj4gPgo+ID4gV2Vs
bCwgYXMgSSBtZW50aW9uZWQgaW4gbXkgY29tbWl0IGxvZyBhcyB3ZWxsLCBpZiB3ZSBkZWZhdWx0
IHRvIG9mZgo+ID4gdW5sZXNzIENPTkZJR19YODYsIHdlIG1heSBicmVhayB3b3JraW5nIHNldHVw
cyBvbiBNSVBTIGFuZCBQb3dlciB3aGVyZQo+ID4gdGhlIGRldmljZSBpcyBpbiBmYWN0IG5vbi1j
YWNoZSBjb2hlcmVudCwgYW5kIHJlbGllcyBvbiB0aGlzCj4gPiAnb3B0aW1pemF0aW9uJyB0byBn
ZXQgdGhpbmdzIHdvcmtpbmcuCj4KPiBGV0lXLCB0aGUgYW1kZ3B1IGRyaXZlciBkb2Vzbid0IHJl
bHkgb24gbm9uLXNub29wZWQgdHJhbnNmZXJzIGZvcgo+IGNvcnJlY3QgYmFzaWMgb3BlcmF0aW9u
ICh0aGUgc2NlbmFyaW8gQ2hyaXN0aWFuIGJyb3VnaHQgdXAgaXMgYSB2ZXJ5Cj4gc3BlY2lhbGl6
ZWQgdXNlLWNhc2UpLCBzbyB0aGF0IHNob3VsZG4ndCBiZSBhbiBpc3N1ZS4KPgoKVGhlIHBvaW50
IGlzIHRoYXQgdGhpcyBpcyBvbmx5IHRydWUgZm9yIHg4Ni4KCk9uIG90aGVyIGFyY2hpdGVjdHVy
ZXMsIHRoZSB1c2Ugb2Ygbm9uLWNhY2hlZCBtYXBwaW5ncyBvbiB0aGUgQ1BVIHNpZGUKbWVhbnMg
dGhhdCB5b3UgL2RvLyByZWx5IG9uIG5vbi1zbm9vcGVkIHRyYW5zZmVycywgc2luY2UgaWYgdGhv
c2UKdHJhbnNmZXJzIHR1cm4gb3V0IG5vdCB0byBzbm9vcCBpbmFkdmVydGVudGx5LCB0aGUgYWNj
ZXNzZXMgYXJlCmluY29oZXJlbnQgd2l0aCB0aGUgQ1BVJ3MgdmlldyBvZiBtZW1vcnkuCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2Vy
bmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVs
Cg==
