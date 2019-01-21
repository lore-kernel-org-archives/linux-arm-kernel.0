Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E210CC31680
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:20:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC27521019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GzvNd0LB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hm0rROjl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC27521019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yFym45tTQPM2Hrsqgh1NPGwhuvNO6Og9DZIUy21udtA=; b=GzvNd0LB9eoa25
	3SjwtBu+Xze0Hwb+mRcmUzmBfDHqf41oYUKBbs+Yx+3G8mqd3njtbiXba63TdHJu2TMwPBnV+Qjxp
	O2toDBO/LviL/4wsN47waHFiH7bpC1YAww69o9DZCeY2wry7CpuqLOZOn1eMqGfkR6lqxr7DRMfjz
	jqfNBcaAgH+/w9oS+9sTBadweg2gtJEGJ42MUCWgPEzOzLw8JAKXXLichtrpGjBy9OoB+/53kqVwp
	9HsNFPuuD8eB/mDbT8as9n7Z6Jf2x/qzrqO2P91A3t1tXcNK/Nvh5geOoE2xxv5/5rIbwamGZGl4S
	kH01skEKXWJhoUszXELg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gleBF-0001EV-He; Mon, 21 Jan 2019 18:20:17 +0000
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gleBC-0001DH-Nu
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 18:20:16 +0000
Received: by mail-io1-xd41.google.com with SMTP id c2so17068051iom.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 10:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=XJhOepUD6NaSayAfqLhlWuoQ/QOfSBGfPNnmKMxehZg=;
 b=hm0rROjlNQsH4JlgreRAtYafeQOWAtKoXTVjMjrT2SrfdjWwsbs0/cM1Df/2551mCD
 aB2NIwGh6PtkU4LJqNiUnC9ccd/MxSvVZmUe7p8qihObwBXmx5bizvR6D4nwZRxbSzcD
 TRkcVrpj1W7hRzWFBQLCKatfPlpTT5EgcAThI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XJhOepUD6NaSayAfqLhlWuoQ/QOfSBGfPNnmKMxehZg=;
 b=pP8Zz7BUZY/ypYqc/w69bUFUcEwY3enEJMG8wq21pFnadR3CuxRVsC330uO0tJTdf3
 +862Q28kIK2Uea/u318b1pI+e4FK9+DZ6/3Jf2QxxqGi5y0Bnuy0M0+O9JvHGhblTXz6
 GFFfPCvFum1TByzTZPxLRNh+JmTT4aoY6POIQ4shUez86ZtqbkdaZe3G7ft8idm8JX4G
 73zpDJCCohCXB2KRJgXNOJ+iFKDoWKKLYK4y4w6V0Nb23l2LB+k9aJeb/UzTfBjg2Im5
 cO8uONmX3lM26J1BSGBtgP0kRMpXW/BoL0GnLa838tAgqoPTzEDtxgV0/3qb63IUQrbX
 F0Fg==
X-Gm-Message-State: AJcUukdFbGK3rrkPaaYFN8t2mcL+hQx1NdFx3AsbdvrRviJ3eDBVPcGG
 S5NiLmd40JIXk/M+3QKA7U4/Osk5K0Bqu+54jVF8Xg==
X-Google-Smtp-Source: ALg8bN5ByDojMvNCkHvw+nhvxmX81xfCKgkECLG9m3o1l96NamrDv7X9AAf2gib9QfeBaMtuqMM1y6vwNZwwjFWF5UE=
X-Received: by 2002:a6b:5d01:: with SMTP id r1mr16371109iob.170.1548094813483; 
 Mon, 21 Jan 2019 10:20:13 -0800 (PST)
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
In-Reply-To: <ccc775d3-3053-ab79-dac8-4feb28e8e690@daenzer.net>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 21 Jan 2019 19:20:02 +0100
Message-ID: <CAKv+Gu-9VKL5RjScbKss4YfH1Cb8WbXmzU_0UsStnoXJcML7Rg@mail.gmail.com>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_102014_789909_136B2C9D 
X-CRM114-Status: GOOD (  19.91  )
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

T24gTW9uLCAyMSBKYW4gMjAxOSBhdCAxOTowNCwgTWljaGVsIETDpG56ZXIgPG1pY2hlbEBkYWVu
emVyLm5ldD4gd3JvdGU6Cj4KPiBPbiAyMDE5LTAxLTIxIDY6NTkgcC5tLiwgQXJkIEJpZXNoZXV2
ZWwgd3JvdGU6Cj4gPiBPbiBNb24sIDIxIEphbiAyMDE5IGF0IDE4OjU1LCBNaWNoZWwgRMOkbnpl
ciA8bWljaGVsQGRhZW56ZXIubmV0PiB3cm90ZToKPiA+Pgo+ID4+IE9uIDIwMTktMDEtMjEgNToz
MCBwLm0uLCBBcmQgQmllc2hldXZlbCB3cm90ZToKPiA+Pj4gT24gTW9uLCAyMSBKYW4gMjAxOSBh
dCAxNzoyMiwgQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBpbmZyYWRlYWQub3JnPiB3cm90ZToKPiA+
Pj4KPiA+Pj4+IFVudGlsIHRoYXQgaGFwcGVucyB3ZSBzaG91bGQganVzdCBjaGFuZ2UgdGhlIGRy
aXZlciBpZmRlZnMgdG8gZGVmYXVsdAo+ID4+Pj4gdGhlIGhhY2tzIHRvIG9mZiBhbmQgb25seSBl
bmFibGUgdGhlbSBvbiBzZXR1cHMgd2hlcmUgd2UgMTAwJQo+ID4+Pj4gcG9zaXRpdmVseSBrbm93
IHRoYXQgdGhleSBhY3R1YWxseSB3b3JrLiAgQW5kIGRvY3VtZW50IHRoYXQgZmFjdAo+ID4+Pj4g
aW4gYmlnIGZhdCBjb21tZW50cy4KPiA+Pj4KPiA+Pj4gV2VsbCwgYXMgSSBtZW50aW9uZWQgaW4g
bXkgY29tbWl0IGxvZyBhcyB3ZWxsLCBpZiB3ZSBkZWZhdWx0IHRvIG9mZgo+ID4+PiB1bmxlc3Mg
Q09ORklHX1g4Niwgd2UgbWF5IGJyZWFrIHdvcmtpbmcgc2V0dXBzIG9uIE1JUFMgYW5kIFBvd2Vy
IHdoZXJlCj4gPj4+IHRoZSBkZXZpY2UgaXMgaW4gZmFjdCBub24tY2FjaGUgY29oZXJlbnQsIGFu
ZCByZWxpZXMgb24gdGhpcwo+ID4+PiAnb3B0aW1pemF0aW9uJyB0byBnZXQgdGhpbmdzIHdvcmtp
bmcuCj4gPj4KPiA+PiBGV0lXLCB0aGUgYW1kZ3B1IGRyaXZlciBkb2Vzbid0IHJlbHkgb24gbm9u
LXNub29wZWQgdHJhbnNmZXJzIGZvcgo+ID4+IGNvcnJlY3QgYmFzaWMgb3BlcmF0aW9uICh0aGUg
c2NlbmFyaW8gQ2hyaXN0aWFuIGJyb3VnaHQgdXAgaXMgYSB2ZXJ5Cj4gPj4gc3BlY2lhbGl6ZWQg
dXNlLWNhc2UpLCBzbyB0aGF0IHNob3VsZG4ndCBiZSBhbiBpc3N1ZS4KPiA+Pgo+ID4KPiA+IFRo
ZSBwb2ludCBpcyB0aGF0IHRoaXMgaXMgb25seSB0cnVlIGZvciB4ODYuCj4gPgo+ID4gT24gb3Ro
ZXIgYXJjaGl0ZWN0dXJlcywgdGhlIHVzZSBvZiBub24tY2FjaGVkIG1hcHBpbmdzIG9uIHRoZSBD
UFUgc2lkZQo+ID4gbWVhbnMgdGhhdCB5b3UgL2RvLyByZWx5IG9uIG5vbi1zbm9vcGVkIHRyYW5z
ZmVycywgc2luY2UgaWYgdGhvc2UKPiA+IHRyYW5zZmVycyB0dXJuIG91dCBub3QgdG8gc25vb3Ag
aW5hZHZlcnRlbnRseSwgdGhlIGFjY2Vzc2VzIGFyZQo+ID4gaW5jb2hlcmVudCB3aXRoIHRoZSBD
UFUncyB2aWV3IG9mIG1lbW9yeS4KPgo+IFRoZSBkcml2ZXIgZ2VuZXJhbGx5IG9ubHkgdXNlcyBu
b24tY2FjaGVkIG1hcHBpbmdzIGlmCj4gZHJtX2FyY2gvZGV2aWNlX2Nhbl93Y19tZW1vcnkgcmV0
dXJucyB0cnVlLgo+CgpJbmRlZWQuIEFuZCBzbyB3ZSBzaG91bGQgdGFrZSBjYXJlIHRvIG9ubHkg
cmV0dXJuICd0cnVlJyBmcm9tIHRoYXQKZnVuY3Rpb24gaWYgaXQgaXMgZ3VhcmFudGVlZCB0aGF0
IG5vbi1jYWNoZWQgQ1BVIG1hcHBpbmdzIGFyZSBjb2hlcmVudAp3aXRoIHRoZSBtYXBwaW5ncyB1
c2VkIGJ5IHRoZSBHUFUsIGVpdGhlciBiZWNhdXNlIHRoYXQgaXMgYWx3YXlzIHRoZQpjYXNlIChs
aWtlIG9uIHg4NiksIG9yIGJlY2F1c2Ugd2Uga25vdyB0aGF0IHRoZSBwbGF0Zm9ybSBpbiBxdWVz
dGlvbgppbXBsZW1lbnRzIE5vU25vb3AgY29ycmVjdGx5IHRocm91Z2hvdXQgdGhlIGludGVyY29u
bmVjdC4KCldoYXQgc2VlbXMgdG8gYmUgY29tcGxpY2F0aW5nIG1hdHRlcnMgaXMgdGhhdCBpbiBz
b21lIGNhc2VzLCB0aGUKZGV2aWNlIGlzIG5vbi1jYWNoZSBjb2hlcmVudCB0byBiZWdpbiB3aXRo
LCBzbyByZWdhcmRsZXNzIG9mIHdoZXRoZXIKdGhlIE5vU25vb3AgYXR0cmlidXRlIGlzIHVzZWQg
b3Igbm90LCB0aG9zZSBhY2Nlc3NlcyB3aWxsIG5vdCBzbm9vcCBpbgp0aGUgY2FjaGVzIGFuZCBi
ZSBjb2hlcmVudCB3aXRoIHRoZSBub24tY2FjaGVkIG1hcHBpbmdzIHVzZWQgYnkgdGhlCkNQVS4g
U28gaWYgd2UgcmVzdHJpY3QgdGhpcyBvcHRpbWl6YXRpb24gW29uIG5vbi1YODZdIHRvIHBsYXRm
b3Jtcwp0aGF0IGFyZSBrbm93biB0byBpbXBsZW1lbnQgTm9Tbm9vcCBjb3JyZWN0bHksIHdlIG1h
eSBicmVhayBwbGF0Zm9ybXMKdGhhdCBhcmUgaW1wbGljaXRseSBOb1Nub29wIGFsbCB0aGUgdGlt
ZS4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4
LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFy
bS1rZXJuZWwK
