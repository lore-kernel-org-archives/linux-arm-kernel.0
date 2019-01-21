Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027C8C31681
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:04:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6E1220861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p+JrdByT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E1220861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BwE+SIkRpK3TYGIVUdfmmoY111JP2nC23uecRmHCP/U=; b=p+JrdByTiTHxq3
	HOGsNR/0macMqFvMKsqCL0wDizx2H/K0prX854vYPf30+aM83KHFhd5t/aD+09dXqc+sXJlEXungE
	Cfmg4bCSHDBzQkQU/5I1dLIfig/Sfw7Q6UHlU5/yedjeu22rbPzGEKonYhmkrobzYY67UWv+cxOG4
	sK4985CPrLxCoOw54IqP+eHb4jsW658sl5GwlKpBal3YjIl6yoJwZzB4AIR4O9cNBfGLgmWixLfzf
	1mch9KSpZXC+0UXG+BmjNhcFi60rgIwRG383c4XRQS18FO/pz3aGmz3+zZ+0QaVtxNalrlatwe3bR
	k0tpdmPp1yvSagSDqUXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glesP-0005rw-A3; Mon, 21 Jan 2019 19:04:53 +0000
Received: from mail.netline.ch ([148.251.143.178]
 helo=netline-mail3.netline.ch)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glesK-0005qx-MH
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 19:04:51 +0000
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 43A562A6055;
 Mon, 21 Jan 2019 20:04:44 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id dHAATxsRZUT5; Mon, 21 Jan 2019 20:04:43 +0100 (CET)
Received: from thor (39.1.199.178.dynamic.wline.res.cust.swisscom.ch
 [178.199.1.39])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id 871E62A6054;
 Mon, 21 Jan 2019 20:04:42 +0100 (CET)
Received: from [::1] by thor with esmtp (Exim 4.92-RC4)
 (envelope-from <michel@daenzer.net>)
 id 1glesE-0003AO-4C; Mon, 21 Jan 2019 20:04:42 +0100
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
 <850b6aee-0040-c333-b125-45211c18ada5@daenzer.net>
 <CAKv+Gu99zHqcQtj6TiOXAr3Qa6WWhKem+DHVA_mAQ0-Bc0Vbqw@mail.gmail.com>
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
Message-ID: <047667fd-17be-1c37-5d2a-26768cfd6ab8@daenzer.net>
Date: Mon, 21 Jan 2019 20:04:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu99zHqcQtj6TiOXAr3Qa6WWhKem+DHVA_mAQ0-Bc0Vbqw@mail.gmail.com>
Content-Language: en-CA
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_110449_027141_1642EDCE 
X-CRM114-Status: GOOD (  17.53  )
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

T24gMjAxOS0wMS0yMSA3OjI4IHAubS4sIEFyZCBCaWVzaGV1dmVsIHdyb3RlOgo+IE9uIE1vbiwg
MjEgSmFuIDIwMTkgYXQgMTk6MjQsIE1pY2hlbCBEw6RuemVyIDxtaWNoZWxAZGFlbnplci5uZXQ+
IHdyb3RlOgo+PiBPbiAyMDE5LTAxLTIxIDc6MjAgcC5tLiwgQXJkIEJpZXNoZXV2ZWwgd3JvdGU6
Cj4+PiBPbiBNb24sIDIxIEphbiAyMDE5IGF0IDE5OjA0LCBNaWNoZWwgRMOkbnplciA8bWljaGVs
QGRhZW56ZXIubmV0PiB3cm90ZToKPj4+PiBPbiAyMDE5LTAxLTIxIDY6NTkgcC5tLiwgQXJkIEJp
ZXNoZXV2ZWwgd3JvdGU6Cj4+Pj4+IE9uIE1vbiwgMjEgSmFuIDIwMTkgYXQgMTg6NTUsIE1pY2hl
bCBEw6RuemVyIDxtaWNoZWxAZGFlbnplci5uZXQ+IHdyb3RlOgo+Pj4+Pj4gT24gMjAxOS0wMS0y
MSA1OjMwIHAubS4sIEFyZCBCaWVzaGV1dmVsIHdyb3RlOgo+Pj4+Pj4+IE9uIE1vbiwgMjEgSmFu
IDIwMTkgYXQgMTc6MjIsIENocmlzdG9waCBIZWxsd2lnIDxoY2hAaW5mcmFkZWFkLm9yZz4gd3Jv
dGU6Cj4+Pj4+Pj4KPj4+Pj4+Pj4gVW50aWwgdGhhdCBoYXBwZW5zIHdlIHNob3VsZCBqdXN0IGNo
YW5nZSB0aGUgZHJpdmVyIGlmZGVmcyB0byBkZWZhdWx0Cj4+Pj4+Pj4+IHRoZSBoYWNrcyB0byBv
ZmYgYW5kIG9ubHkgZW5hYmxlIHRoZW0gb24gc2V0dXBzIHdoZXJlIHdlIDEwMCUKPj4+Pj4+Pj4g
cG9zaXRpdmVseSBrbm93IHRoYXQgdGhleSBhY3R1YWxseSB3b3JrLiAgQW5kIGRvY3VtZW50IHRo
YXQgZmFjdAo+Pj4+Pj4+PiBpbiBiaWcgZmF0IGNvbW1lbnRzLgo+Pj4+Pj4+Cj4+Pj4+Pj4gV2Vs
bCwgYXMgSSBtZW50aW9uZWQgaW4gbXkgY29tbWl0IGxvZyBhcyB3ZWxsLCBpZiB3ZSBkZWZhdWx0
IHRvIG9mZgo+Pj4+Pj4+IHVubGVzcyBDT05GSUdfWDg2LCB3ZSBtYXkgYnJlYWsgd29ya2luZyBz
ZXR1cHMgb24gTUlQUyBhbmQgUG93ZXIgd2hlcmUKPj4+Pj4+PiB0aGUgZGV2aWNlIGlzIGluIGZh
Y3Qgbm9uLWNhY2hlIGNvaGVyZW50LCBhbmQgcmVsaWVzIG9uIHRoaXMKPj4+Pj4+PiAnb3B0aW1p
emF0aW9uJyB0byBnZXQgdGhpbmdzIHdvcmtpbmcuCj4+Pj4+Pgo+Pj4+Pj4gRldJVywgdGhlIGFt
ZGdwdSBkcml2ZXIgZG9lc24ndCByZWx5IG9uIG5vbi1zbm9vcGVkIHRyYW5zZmVycyBmb3IKPj4+
Pj4+IGNvcnJlY3QgYmFzaWMgb3BlcmF0aW9uICh0aGUgc2NlbmFyaW8gQ2hyaXN0aWFuIGJyb3Vn
aHQgdXAgaXMgYSB2ZXJ5Cj4+Pj4+PiBzcGVjaWFsaXplZCB1c2UtY2FzZSksIHNvIHRoYXQgc2hv
dWxkbid0IGJlIGFuIGlzc3VlLgo+Pj4+Pgo+Pj4+PiBUaGUgcG9pbnQgaXMgdGhhdCB0aGlzIGlz
IG9ubHkgdHJ1ZSBmb3IgeDg2Lgo+Pj4+Pgo+Pj4+PiBPbiBvdGhlciBhcmNoaXRlY3R1cmVzLCB0
aGUgdXNlIG9mIG5vbi1jYWNoZWQgbWFwcGluZ3Mgb24gdGhlIENQVSBzaWRlCj4+Pj4+IG1lYW5z
IHRoYXQgeW91IC9kby8gcmVseSBvbiBub24tc25vb3BlZCB0cmFuc2ZlcnMsIHNpbmNlIGlmIHRo
b3NlCj4+Pj4+IHRyYW5zZmVycyB0dXJuIG91dCBub3QgdG8gc25vb3AgaW5hZHZlcnRlbnRseSwg
dGhlIGFjY2Vzc2VzIGFyZQo+Pj4+PiBpbmNvaGVyZW50IHdpdGggdGhlIENQVSdzIHZpZXcgb2Yg
bWVtb3J5Lgo+Pj4+Cj4+Pj4gVGhlIGRyaXZlciBnZW5lcmFsbHkgb25seSB1c2VzIG5vbi1jYWNo
ZWQgbWFwcGluZ3MgaWYKPj4+PiBkcm1fYXJjaC9kZXZpY2VfY2FuX3djX21lbW9yeSByZXR1cm5z
IHRydWUuCj4+Pgo+Pj4gSW5kZWVkLiBBbmQgc28gd2Ugc2hvdWxkIHRha2UgY2FyZSB0byBvbmx5
IHJldHVybiAndHJ1ZScgZnJvbSB0aGF0Cj4+PiBmdW5jdGlvbiBpZiBpdCBpcyBndWFyYW50ZWVk
IHRoYXQgbm9uLWNhY2hlZCBDUFUgbWFwcGluZ3MgYXJlIGNvaGVyZW50Cj4+PiB3aXRoIHRoZSBt
YXBwaW5ncyB1c2VkIGJ5IHRoZSBHUFUsIGVpdGhlciBiZWNhdXNlIHRoYXQgaXMgYWx3YXlzIHRo
ZQo+Pj4gY2FzZSAobGlrZSBvbiB4ODYpLCBvciBiZWNhdXNlIHdlIGtub3cgdGhhdCB0aGUgcGxh
dGZvcm0gaW4gcXVlc3Rpb24KPj4+IGltcGxlbWVudHMgTm9Tbm9vcCBjb3JyZWN0bHkgdGhyb3Vn
aG91dCB0aGUgaW50ZXJjb25uZWN0Lgo+Pj4KPj4+IFdoYXQgc2VlbXMgdG8gYmUgY29tcGxpY2F0
aW5nIG1hdHRlcnMgaXMgdGhhdCBpbiBzb21lIGNhc2VzLCB0aGUKPj4+IGRldmljZSBpcyBub24t
Y2FjaGUgY29oZXJlbnQgdG8gYmVnaW4gd2l0aCwgc28gcmVnYXJkbGVzcyBvZiB3aGV0aGVyCj4+
PiB0aGUgTm9Tbm9vcCBhdHRyaWJ1dGUgaXMgdXNlZCBvciBub3QsIHRob3NlIGFjY2Vzc2VzIHdp
bGwgbm90IHNub29wIGluCj4+PiB0aGUgY2FjaGVzIGFuZCBiZSBjb2hlcmVudCB3aXRoIHRoZSBu
b24tY2FjaGVkIG1hcHBpbmdzIHVzZWQgYnkgdGhlCj4+PiBDUFUuIFNvIGlmIHdlIHJlc3RyaWN0
IHRoaXMgb3B0aW1pemF0aW9uIFtvbiBub24tWDg2XSB0byBwbGF0Zm9ybXMKPj4+IHRoYXQgYXJl
IGtub3duIHRvIGltcGxlbWVudCBOb1Nub29wIGNvcnJlY3RseSwgd2UgbWF5IGJyZWFrIHBsYXRm
b3Jtcwo+Pj4gdGhhdCBhcmUgaW1wbGljaXRseSBOb1Nub29wIGFsbCB0aGUgdGltZS4KPj4KPj4g
U2luY2UgdGhlIGRyaXZlciBnZW5lcmFsbHkgZG9lc24ndCByZWx5IG9uIG5vbi1zbm9vcGVkIGFj
Y2Vzc2VzIGZvcgo+PiBjb3JyZWN0bmVzcywgdGhhdCBjb3VsZG4ndCAiYnJlYWsiIGFueXRoaW5n
IHRoYXQgaGFzbid0IGFsd2F5cyBiZWVuIGJyb2tlbi4KPiAKPiBBZ2FpbiwgdGhhdCBpcyBvbmx5
IHRydWUgb24geDg2Lgo+IAo+IE9uIG90aGVyIGFyY2hpdGVjdHVyZXMsIERNQSB3cml0ZXMgZnJv
bSB0aGUgZGV2aWNlIG1heSBhbGxvY2F0ZSBpbiB0aGUKPiBjYWNoZXMsIGFuZCBiZSBpbnZpc2li
bGUgdG8gdGhlIENQVSB3aGVuIGl0IHVzZXMgbm9uLWNhY2hlZCBtYXBwaW5ncy4KCkxldCBtZSB0
cnkgb25lIGxhc3QgdGltZToKCklmIGRybV9hcmNoX2Nhbl93Y19tZW1vcnkgcmV0dXJucyBmYWxz
ZSwgdGhlIGRyaXZlciBmYWxscyBiYWNrIHRvIHRoZQpub3JtYWwgbW9kZSBvZiBvcGVyYXRpb24s
IHVzaW5nIGEgY2FjaGVhYmxlIENQVSBtYXBwaW5nIGFuZCBzbm9vcGVkIEdQVQp0cmFuc2ZlcnMs
IGV2ZW4gaWYgdXNlcnNwYWNlIGFza3MgKGFzIGEgcGVyZm9ybWFuY2Ugb3B0aW1pemF0aW9uKSBm
b3IgYQp3cml0ZS1jb21iaW5lZCBDUFUgbWFwcGluZyBhbmQgbm9uLXNub29wZWQgR1BVIHRyYW5z
ZmVycyB2aWEKQU1ER1BVX0dFTV9DUkVBVEVfQ1BVX0dUVF9VU1dDLiBUaGlzIG5vcm1hbCBtb2Rl
IG9mIG9wZXJhdGlvbiBpcyBhbHNvCnVzZWQgZm9yIHRoZSByaW5nIGJ1ZmZlcnMgYXQgdGhlIGhl
YXJ0IG9mIHRoZSBkcml2ZXIncyBvcGVyYXRpb24uIElmCnRoZXJlIGlzIGEgcGxhdGZvcm0gd2hl
cmUgdGhpcyBub3JtYWwgbW9kZSBvZiBvcGVyYXRpb24gZG9lc24ndCB3b3JrLAp0aGUgZHJpdmVy
IGNvdWxkIG5ldmVyIGhhdmUgd29ya2VkIHJlbGlhYmx5IG9uIHRoYXQgcGxhdGZvcm0sIHNpbmNl
CmJlZm9yZSBBTURHUFVfR0VNX0NSRUFURV9DUFVfR1RUX1VTV0Mgb3IgZHJtX2FyY2hfY2FuX3dj
X21lbW9yeSBldmVuCmV4aXN0ZWQuCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAg
ICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdh
cmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxv
cGVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsCg==
