Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B9DC316A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:24:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9866921736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ol78BgM1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9866921736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dV9QMhwWiV8ue+ch/83NOciv9JgoZSNuWy7EjraNxhQ=; b=ol78BgM1B4Z6qu
	1E4FhsNaert5lbVFlQh1NFx8ul+MhUj+2NlODrxFL2A7fyhdDm6nlRiXw0CbXBkqG08qYT9CCSiGF
	55CvMZtdSnul3tXnkCUdmKDH8HjG6oi3+VhBcpCLIsOVWzL5iSB+gJBjUhe+lxiYcKXHVTmidbKkY
	XjeE/s6BW7w8dSi5sl5bLLlF/lQMvukxeEpC5dwkLxuKTLSWEXuIXAZbQUcX4jaUnoLzyb3uuKWLD
	cTjkbggBOfh6+QTjzz7jZlylBRt8Rq+C+9GoOsadmqvisMURHhnlnMjPyROJN3ukSQQOulmImOonM
	779hXYpJHTCG+vFeXZQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gleEu-0001bK-Fs; Mon, 21 Jan 2019 18:24:04 +0000
Received: from mail.netline.ch ([148.251.143.178]
 helo=netline-mail3.netline.ch)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gleEr-0001aO-6P
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 18:24:03 +0000
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 5163F2A6055;
 Mon, 21 Jan 2019 19:24:00 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id C19kKYSv5mEf; Mon, 21 Jan 2019 19:23:59 +0100 (CET)
Received: from thor (39.1.199.178.dynamic.wline.res.cust.swisscom.ch
 [178.199.1.39])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id 480BE2A6054;
 Mon, 21 Jan 2019 19:23:59 +0100 (CET)
Received: from [::1] by thor with esmtp (Exim 4.92-RC4)
 (envelope-from <michel@daenzer.net>)
 id 1gleEo-0002pr-UR; Mon, 21 Jan 2019 19:23:58 +0100
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
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
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Openpgp: preference=signencrypt
Autocrypt: addr=michel@daenzer.net; prefer-encrypt=mutual; keydata=
 mQGiBDsehS8RBACbsIQEX31aYSIuEKxEnEX82ezMR8z3LG8ktv1KjyNErUX9Pt7AUC7W3W0b
 LUhu8Le8S2va6hi7GfSAifl0ih3k6Bv1Itzgnd+7ZmSrvCN8yGJaHNQfAevAuEboIb+MaVHo
 9EMJj4ikOcRZCmQWw7evu/D9uQdtkCnRY9iJiAGxbwCguBHtpoGMxDOINCr5UU6qt+m4O+UD
 /355ohBBzzyh49lTj0kTFKr0Ozd20G2FbcqHgfFL1dc1MPyigej2gLga2osu2QY0ObvAGkOu
 WBi3LTY8Zs8uqFGDC4ZAwMPoFy3yzu3ne6T7d/68rJil0QcdQjzzHi6ekqHuhst4a+/+D23h
 Za8MJBEcdOhRhsaDVGAJSFEQB1qLBACOs0xN+XblejO35gsDSVVk8s+FUUw3TSWJBfZa3Imp
 V2U2tBO4qck+wqbHNfdnU/crrsHahjzBjvk8Up7VoY8oT+z03sal2vXEonS279xN2B92Tttr
 AgwosujguFO/7tvzymWC76rDEwue8TsADE11ErjwaBTs8ZXfnN/uAANgPLQjTWljaGVsIERh
 ZW56ZXIgPG1pY2hlbEBkYWVuemVyLm5ldD6IXgQTEQIAHgUCQFXxJgIbAwYLCQgHAwIDFQID
 AxYCAQIeAQIXgAAKCRBaga+OatuyAIrPAJ9ykonXI3oQcX83N2qzCEStLNW47gCeLWm/QiPY
 jqtGUnnSbyuTQfIySkK5AQ0EOx6FRRAEAJZkcvklPwJCgNiw37p0GShKmFGGqf/a3xZZEpjI
 qNxzshFRFneZze4f5LhzbX1/vIm5+ZXsEWympJfZzyCmYPw86QcFxyZflkAxHx9LeD+89Elx
 bw6wT0CcLvSv8ROfU1m8YhGbV6g2zWyLD0/naQGVb8e4FhVKGNY2EEbHgFBrAAMGA/0VktFO
 CxFBdzLQ17RCTwCJ3xpyP4qsLJH0yCoA26rH2zE2RzByhrTFTYZzbFEid3ddGiHOBEL+bO+2
 GNtfiYKmbTkj1tMZJ8L6huKONaVrASFzLvZa2dlc2zja9ZSksKmge5BOTKWgbyepEc5qxSju
 YsYrX5xfLgTZC5abhhztpYhGBBgRAgAGBQI7HoVFAAoJEFqBr45q27IAlscAn2Ufk2d6/3p4
 Cuyz/NX7KpL2dQ8WAJ9UD5JEakhfofed8PSqOM7jOO3LCA==
Message-ID: <850b6aee-0040-c333-b125-45211c18ada5@daenzer.net>
Date: Mon, 21 Jan 2019 19:23:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-9VKL5RjScbKss4YfH1Cb8WbXmzU_0UsStnoXJcML7Rg@mail.gmail.com>
Content-Language: en-CA
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_102401_537776_E40A7F4C 
X-CRM114-Status: GOOD (  18.41  )
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

T24gMjAxOS0wMS0yMSA3OjIwIHAubS4sIEFyZCBCaWVzaGV1dmVsIHdyb3RlOgo+IE9uIE1vbiwg
MjEgSmFuIDIwMTkgYXQgMTk6MDQsIE1pY2hlbCBEw6RuemVyIDxtaWNoZWxAZGFlbnplci5uZXQ+
IHdyb3RlOgo+Pgo+PiBPbiAyMDE5LTAxLTIxIDY6NTkgcC5tLiwgQXJkIEJpZXNoZXV2ZWwgd3Jv
dGU6Cj4+PiBPbiBNb24sIDIxIEphbiAyMDE5IGF0IDE4OjU1LCBNaWNoZWwgRMOkbnplciA8bWlj
aGVsQGRhZW56ZXIubmV0PiB3cm90ZToKPj4+Pgo+Pj4+IE9uIDIwMTktMDEtMjEgNTozMCBwLm0u
LCBBcmQgQmllc2hldXZlbCB3cm90ZToKPj4+Pj4gT24gTW9uLCAyMSBKYW4gMjAxOSBhdCAxNzoy
MiwgQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBpbmZyYWRlYWQub3JnPiB3cm90ZToKPj4+Pj4KPj4+
Pj4+IFVudGlsIHRoYXQgaGFwcGVucyB3ZSBzaG91bGQganVzdCBjaGFuZ2UgdGhlIGRyaXZlciBp
ZmRlZnMgdG8gZGVmYXVsdAo+Pj4+Pj4gdGhlIGhhY2tzIHRvIG9mZiBhbmQgb25seSBlbmFibGUg
dGhlbSBvbiBzZXR1cHMgd2hlcmUgd2UgMTAwJQo+Pj4+Pj4gcG9zaXRpdmVseSBrbm93IHRoYXQg
dGhleSBhY3R1YWxseSB3b3JrLiAgQW5kIGRvY3VtZW50IHRoYXQgZmFjdAo+Pj4+Pj4gaW4gYmln
IGZhdCBjb21tZW50cy4KPj4+Pj4KPj4+Pj4gV2VsbCwgYXMgSSBtZW50aW9uZWQgaW4gbXkgY29t
bWl0IGxvZyBhcyB3ZWxsLCBpZiB3ZSBkZWZhdWx0IHRvIG9mZgo+Pj4+PiB1bmxlc3MgQ09ORklH
X1g4Niwgd2UgbWF5IGJyZWFrIHdvcmtpbmcgc2V0dXBzIG9uIE1JUFMgYW5kIFBvd2VyIHdoZXJl
Cj4+Pj4+IHRoZSBkZXZpY2UgaXMgaW4gZmFjdCBub24tY2FjaGUgY29oZXJlbnQsIGFuZCByZWxp
ZXMgb24gdGhpcwo+Pj4+PiAnb3B0aW1pemF0aW9uJyB0byBnZXQgdGhpbmdzIHdvcmtpbmcuCj4+
Pj4KPj4+PiBGV0lXLCB0aGUgYW1kZ3B1IGRyaXZlciBkb2Vzbid0IHJlbHkgb24gbm9uLXNub29w
ZWQgdHJhbnNmZXJzIGZvcgo+Pj4+IGNvcnJlY3QgYmFzaWMgb3BlcmF0aW9uICh0aGUgc2NlbmFy
aW8gQ2hyaXN0aWFuIGJyb3VnaHQgdXAgaXMgYSB2ZXJ5Cj4+Pj4gc3BlY2lhbGl6ZWQgdXNlLWNh
c2UpLCBzbyB0aGF0IHNob3VsZG4ndCBiZSBhbiBpc3N1ZS4KPj4+Pgo+Pj4KPj4+IFRoZSBwb2lu
dCBpcyB0aGF0IHRoaXMgaXMgb25seSB0cnVlIGZvciB4ODYuCj4+Pgo+Pj4gT24gb3RoZXIgYXJj
aGl0ZWN0dXJlcywgdGhlIHVzZSBvZiBub24tY2FjaGVkIG1hcHBpbmdzIG9uIHRoZSBDUFUgc2lk
ZQo+Pj4gbWVhbnMgdGhhdCB5b3UgL2RvLyByZWx5IG9uIG5vbi1zbm9vcGVkIHRyYW5zZmVycywg
c2luY2UgaWYgdGhvc2UKPj4+IHRyYW5zZmVycyB0dXJuIG91dCBub3QgdG8gc25vb3AgaW5hZHZl
cnRlbnRseSwgdGhlIGFjY2Vzc2VzIGFyZQo+Pj4gaW5jb2hlcmVudCB3aXRoIHRoZSBDUFUncyB2
aWV3IG9mIG1lbW9yeS4KPj4KPj4gVGhlIGRyaXZlciBnZW5lcmFsbHkgb25seSB1c2VzIG5vbi1j
YWNoZWQgbWFwcGluZ3MgaWYKPj4gZHJtX2FyY2gvZGV2aWNlX2Nhbl93Y19tZW1vcnkgcmV0dXJu
cyB0cnVlLgo+Pgo+IAo+IEluZGVlZC4gQW5kIHNvIHdlIHNob3VsZCB0YWtlIGNhcmUgdG8gb25s
eSByZXR1cm4gJ3RydWUnIGZyb20gdGhhdAo+IGZ1bmN0aW9uIGlmIGl0IGlzIGd1YXJhbnRlZWQg
dGhhdCBub24tY2FjaGVkIENQVSBtYXBwaW5ncyBhcmUgY29oZXJlbnQKPiB3aXRoIHRoZSBtYXBw
aW5ncyB1c2VkIGJ5IHRoZSBHUFUsIGVpdGhlciBiZWNhdXNlIHRoYXQgaXMgYWx3YXlzIHRoZQo+
IGNhc2UgKGxpa2Ugb24geDg2KSwgb3IgYmVjYXVzZSB3ZSBrbm93IHRoYXQgdGhlIHBsYXRmb3Jt
IGluIHF1ZXN0aW9uCj4gaW1wbGVtZW50cyBOb1Nub29wIGNvcnJlY3RseSB0aHJvdWdob3V0IHRo
ZSBpbnRlcmNvbm5lY3QuCj4gCj4gV2hhdCBzZWVtcyB0byBiZSBjb21wbGljYXRpbmcgbWF0dGVy
cyBpcyB0aGF0IGluIHNvbWUgY2FzZXMsIHRoZQo+IGRldmljZSBpcyBub24tY2FjaGUgY29oZXJl
bnQgdG8gYmVnaW4gd2l0aCwgc28gcmVnYXJkbGVzcyBvZiB3aGV0aGVyCj4gdGhlIE5vU25vb3Ag
YXR0cmlidXRlIGlzIHVzZWQgb3Igbm90LCB0aG9zZSBhY2Nlc3NlcyB3aWxsIG5vdCBzbm9vcCBp
bgo+IHRoZSBjYWNoZXMgYW5kIGJlIGNvaGVyZW50IHdpdGggdGhlIG5vbi1jYWNoZWQgbWFwcGlu
Z3MgdXNlZCBieSB0aGUKPiBDUFUuIFNvIGlmIHdlIHJlc3RyaWN0IHRoaXMgb3B0aW1pemF0aW9u
IFtvbiBub24tWDg2XSB0byBwbGF0Zm9ybXMKPiB0aGF0IGFyZSBrbm93biB0byBpbXBsZW1lbnQg
Tm9Tbm9vcCBjb3JyZWN0bHksIHdlIG1heSBicmVhayBwbGF0Zm9ybXMKPiB0aGF0IGFyZSBpbXBs
aWNpdGx5IE5vU25vb3AgYWxsIHRoZSB0aW1lLgoKU2luY2UgdGhlIGRyaXZlciBnZW5lcmFsbHkg
ZG9lc24ndCByZWx5IG9uIG5vbi1zbm9vcGVkIGFjY2Vzc2VzIGZvcgpjb3JyZWN0bmVzcywgdGhh
dCBjb3VsZG4ndCAiYnJlYWsiIGFueXRoaW5nIHRoYXQgaGFzbid0IGFsd2F5cyBiZWVuIGJyb2tl
bi4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAg
ICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAg
ICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGlu
ZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
