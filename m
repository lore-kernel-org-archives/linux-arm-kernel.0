Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7FAC31681
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:04:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC29221734
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W8S32hOK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC29221734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TAO2at4XAr7/rA6Ye2c42CWEIABPOSBPc6XBpjEfW48=; b=W8S32hOKaL9zdC
	2Vo2J0tImfE6tWthyikvjxYJ1kyCll7IjOtYBpVnVZEW8/VTWh0vZjRJWBNHMrX0IVLylyIMhUmdE
	W8k+P0JurNdKubj0lZ+WnvNNkvLfCHzwthzgdTgi0r0b3squKK+hUchjVZmwt8x2t54wYZw6lfyyL
	Ir/cbxdaOoPFCHNtJUBHXCHF++9sJp+4StlxZHloHj1HheqBF2Zo0bDxScY5mFkWz4+DDI6Acc6Un
	3LnCVFE5cy4GugVi4ig6s43ZYQ4t2UvVZxG66nKZYxmHjdK30EsvCoH9188Zek7JOEmEnW6Z67j24
	J9wKn+DHSCL44r+hQdFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gldvw-0001Ki-Lw; Mon, 21 Jan 2019 18:04:28 +0000
Received: from mail.netline.ch ([148.251.143.178]
 helo=netline-mail3.netline.ch)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gldvt-0001KN-BS
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 18:04:27 +0000
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 9D1012A6055;
 Mon, 21 Jan 2019 19:04:24 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 2MoWYHLrXYp9; Mon, 21 Jan 2019 19:04:24 +0100 (CET)
Received: from thor (39.1.199.178.dynamic.wline.res.cust.swisscom.ch
 [178.199.1.39])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id 8E79B2A6054;
 Mon, 21 Jan 2019 19:04:23 +0100 (CET)
Received: from [::1] by thor with esmtp (Exim 4.92-RC4)
 (envelope-from <michel@daenzer.net>)
 id 1gldvr-0002aF-4a; Mon, 21 Jan 2019 19:04:23 +0100
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
Message-ID: <ccc775d3-3053-ab79-dac8-4feb28e8e690@daenzer.net>
Date: Mon, 21 Jan 2019 19:04:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8OkbHwY5UBxahpQpM_gKh2331pQ6o-4YyJdLurbFNHvw@mail.gmail.com>
Content-Language: en-CA
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_100425_686374_FDD5C15F 
X-CRM114-Status: GOOD (  13.91  )
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

T24gMjAxOS0wMS0yMSA2OjU5IHAubS4sIEFyZCBCaWVzaGV1dmVsIHdyb3RlOgo+IE9uIE1vbiwg
MjEgSmFuIDIwMTkgYXQgMTg6NTUsIE1pY2hlbCBEw6RuemVyIDxtaWNoZWxAZGFlbnplci5uZXQ+
IHdyb3RlOgo+Pgo+PiBPbiAyMDE5LTAxLTIxIDU6MzAgcC5tLiwgQXJkIEJpZXNoZXV2ZWwgd3Jv
dGU6Cj4+PiBPbiBNb24sIDIxIEphbiAyMDE5IGF0IDE3OjIyLCBDaHJpc3RvcGggSGVsbHdpZyA8
aGNoQGluZnJhZGVhZC5vcmc+IHdyb3RlOgo+Pj4KPj4+PiBVbnRpbCB0aGF0IGhhcHBlbnMgd2Ug
c2hvdWxkIGp1c3QgY2hhbmdlIHRoZSBkcml2ZXIgaWZkZWZzIHRvIGRlZmF1bHQKPj4+PiB0aGUg
aGFja3MgdG8gb2ZmIGFuZCBvbmx5IGVuYWJsZSB0aGVtIG9uIHNldHVwcyB3aGVyZSB3ZSAxMDAl
Cj4+Pj4gcG9zaXRpdmVseSBrbm93IHRoYXQgdGhleSBhY3R1YWxseSB3b3JrLiAgQW5kIGRvY3Vt
ZW50IHRoYXQgZmFjdAo+Pj4+IGluIGJpZyBmYXQgY29tbWVudHMuCj4+Pgo+Pj4gV2VsbCwgYXMg
SSBtZW50aW9uZWQgaW4gbXkgY29tbWl0IGxvZyBhcyB3ZWxsLCBpZiB3ZSBkZWZhdWx0IHRvIG9m
Zgo+Pj4gdW5sZXNzIENPTkZJR19YODYsIHdlIG1heSBicmVhayB3b3JraW5nIHNldHVwcyBvbiBN
SVBTIGFuZCBQb3dlciB3aGVyZQo+Pj4gdGhlIGRldmljZSBpcyBpbiBmYWN0IG5vbi1jYWNoZSBj
b2hlcmVudCwgYW5kIHJlbGllcyBvbiB0aGlzCj4+PiAnb3B0aW1pemF0aW9uJyB0byBnZXQgdGhp
bmdzIHdvcmtpbmcuCj4+Cj4+IEZXSVcsIHRoZSBhbWRncHUgZHJpdmVyIGRvZXNuJ3QgcmVseSBv
biBub24tc25vb3BlZCB0cmFuc2ZlcnMgZm9yCj4+IGNvcnJlY3QgYmFzaWMgb3BlcmF0aW9uICh0
aGUgc2NlbmFyaW8gQ2hyaXN0aWFuIGJyb3VnaHQgdXAgaXMgYSB2ZXJ5Cj4+IHNwZWNpYWxpemVk
IHVzZS1jYXNlKSwgc28gdGhhdCBzaG91bGRuJ3QgYmUgYW4gaXNzdWUuCj4+Cj4gCj4gVGhlIHBv
aW50IGlzIHRoYXQgdGhpcyBpcyBvbmx5IHRydWUgZm9yIHg4Ni4KPiAKPiBPbiBvdGhlciBhcmNo
aXRlY3R1cmVzLCB0aGUgdXNlIG9mIG5vbi1jYWNoZWQgbWFwcGluZ3Mgb24gdGhlIENQVSBzaWRl
Cj4gbWVhbnMgdGhhdCB5b3UgL2RvLyByZWx5IG9uIG5vbi1zbm9vcGVkIHRyYW5zZmVycywgc2lu
Y2UgaWYgdGhvc2UKPiB0cmFuc2ZlcnMgdHVybiBvdXQgbm90IHRvIHNub29wIGluYWR2ZXJ0ZW50
bHksIHRoZSBhY2Nlc3NlcyBhcmUKPiBpbmNvaGVyZW50IHdpdGggdGhlIENQVSdzIHZpZXcgb2Yg
bWVtb3J5LgoKVGhlIGRyaXZlciBnZW5lcmFsbHkgb25seSB1c2VzIG5vbi1jYWNoZWQgbWFwcGlu
Z3MgaWYKZHJtX2FyY2gvZGV2aWNlX2Nhbl93Y19tZW1vcnkgcmV0dXJucyB0cnVlLgoKCi0tIApF
YXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0
cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAg
ICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
