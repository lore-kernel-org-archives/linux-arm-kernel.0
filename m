Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E021C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:05:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E5FD217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OKT+GMba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E5FD217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=f56J6fUgEiLPISlVOGC0LAdbQQllsusyDxy768faFqY=; b=OKT+GMbaVnrgbL
	ek1sMEqPYYcXGzNpqUNR40f4xaqeqS0ZKciYsKC+338wPlUh4jrzdzqNqBws4Erf/3kr4MhN1nleN
	//7bROq1fGBj1tbEbvgvp3fFXMwzAz35yrGU2BA2wLN/PC3BBqxRKrqKzJrR9UuYiHwYNWl4CyDDR
	8QsPHyMnWjsqv2vwmFUX2LcptIyuPOWHFTV8kADz+OugvAqZOKDd/soqv1U2wFyzj+SDjSFzbXMwD
	A6sC/YzQCzWLG7wzZNdl3lUQXBZEKqVortCB2vJUcXxlG/c7sEgfEtAc9M13rGg0ckU9leBRQ7dls
	xsP+q9O+6r8su/KcUnIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmhV5-0008OO-KL; Thu, 24 Jan 2019 16:05:07 +0000
Received: from mail.netline.ch ([148.251.143.178]
 helo=netline-mail3.netline.ch)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmhUg-0007k9-Ss
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 16:04:48 +0000
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id ED8952A6056;
 Thu, 24 Jan 2019 17:04:39 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id LeWIp6H_pu1C; Thu, 24 Jan 2019 17:04:39 +0100 (CET)
Received: from thor (39.1.199.178.dynamic.wline.res.cust.swisscom.ch
 [178.199.1.39])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id 7E6052A6054;
 Thu, 24 Jan 2019 17:04:38 +0100 (CET)
Received: from [::1] by thor with esmtp (Exim 4.92-RC4)
 (envelope-from <michel@daenzer.net>)
 id 1gmhUc-0002p1-2E; Thu, 24 Jan 2019 17:04:38 +0100
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <850b6aee-0040-c333-b125-45211c18ada5@daenzer.net>
 <CAKv+Gu_VBd8agHASc5RS0eCgyXP64Lt_i4yPuBjKwGQ+5Lpd5Q@mail.gmail.com>
 <CADnq5_O1uxCrSksfF127AZTfbmdukxmqGdh2Ee0zM6CqgG_Mhg@mail.gmail.com>
 <CAKv+Gu-4uYh_HD_5Ry_L80Nf5zpRhT4oJYhhG5_8g3gSzBs2tg@mail.gmail.com>
 <20190123071521.GB20526@infradead.org>
 <CAKv+Gu8+77uZHJ6ZYjGNcKQL8C3cT5Ree+TcTVmkQXAHV-ADyg@mail.gmail.com>
 <20190123164428.GA9367@infradead.org>
 <CAKv+Gu-9vEKu8mG-o+-4M1ZcgZmTTJVfEdNS9R27AFX8P5sqyQ@mail.gmail.com>
 <20190124091316.GA22796@infradead.org>
 <bb559f74-4b1e-d5ee-74fb-b5dcd4a128cb@amd.com>
 <CAKv+Gu_3LurSN-6w1WijPfpJpc+Pgu0YTnwTfMrXMF3-AKAnJA@mail.gmail.com>
 <953e5e5f-5d47-d6df-40df-c8c94db5447f@amd.com>
 <CAKv+Gu9umPEmB+wh54NOTYcQ14oxf7rwVAXgCqo7V2A+VwkqPA@mail.gmail.com>
 <57590a48-4629-e2a1-8673-ce9eb2ec210b@amd.com>
 <CAKv+Gu_2f0FaJ+Th7H48u4GrPX=MM9xw0fFjdwhfRrr1nhgEkA@mail.gmail.com>
 <40ad3ae7-9970-0cb9-d35c-05e128f83820@amd.com>
 <CAKv+Gu_D4FC05Rz3Oxm_dTWLaGt+a3EDecbsrge1eHY7gFXEYg@mail.gmail.com>
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
Message-ID: <66a7aa82-3ebd-55c3-0263-ee9694294896@daenzer.net>
Date: Thu, 24 Jan 2019 17:04:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu_D4FC05Rz3Oxm_dTWLaGt+a3EDecbsrge1eHY7gFXEYg@mail.gmail.com>
Content-Language: en-CA
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_080443_742231_B417F546 
X-CRM114-Status: GOOD (  17.25  )
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Christoph Hellwig <hch@infradead.org>, David Airlie <airlied@linux.ie>, "Huang,
 Ray" <Ray.Huang@amd.com>, dri-devel <dri-devel@lists.freedesktop.org>, "Zhang,
 Jerry" <Jerry.Zhang@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 Sean Paul <sean@poorly.run>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMjAxOS0wMS0yNCAxMjo0NSBwLm0uLCBBcmQgQmllc2hldXZlbCB3cm90ZToKPiBPbiBUaHUs
IDI0IEphbiAyMDE5IGF0IDEyOjM3LCBLb2VuaWcsIENocmlzdGlhbgo+IDxDaHJpc3RpYW4uS29l
bmlnQGFtZC5jb20+IHdyb3RlOgo+PiBBbSAyNC4wMS4xOSB1bSAxMjoyNiBzY2hyaWViIEFyZCBC
aWVzaGV1dmVsOgo+Pj4gT24gVGh1LCAyNCBKYW4gMjAxOSBhdCAxMjoyMywgS29lbmlnLCBDaHJp
c3RpYW4KPj4+IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+IHdyb3RlOgo+Pj4+IEFtIDI0LjAx
LjE5IHVtIDEwOjU5IHNjaHJpZWIgQXJkIEJpZXNoZXV2ZWw6Cj4+Pj4+IFtTTklQXQo+Pj4+PiBU
aGlzIGlzICpleGFjdGx5KiBteSBwb2ludCB0aGUgd2hvbGUgdGltZS4KPj4+Pj4KPj4+Pj4gVGhl
IGN1cnJlbnQgY29kZSBoYXMKPj4+Pj4KPj4+Pj4gc3RhdGljIGlubGluZSBib29sIGRybV9hcmNo
X2Nhbl93Y19tZW1vcnkodm9pZCkKPj4+Pj4gewo+Pj4+PiAjaWYgZGVmaW5lZChDT05GSUdfUFBD
KSAmJiAhZGVmaW5lZChDT05GSUdfTk9UX0NPSEVSRU5UX0NBQ0hFKQo+Pj4+PiAgICAgIHJldHVy
biBmYWxzZTsKPj4+Pj4KPj4+Pj4gd2hpY2ggbWVhbnMgdGhlIG9wdGltaXphdGlvbiBpcyBkaXNh
YmxlZCAqdW5sZXNzIHRoZSBzeXN0ZW0gaXMKPj4+Pj4gbm9uLWNhY2hlIGNvaGVyZW50Kgo+Pj4+
Pgo+Pj4+PiBTbyBpZiB5b3UgaGF2ZSByZXBvcnRzIHRoYXQgdGhlIG9wdGltaXphdGlvbiB3b3Jr
cyBvbiBzb21lIFBvd2VyUEMsIGl0Cj4+Pj4+IG11c3QgYmUgbm9uLWNhY2hlIGNvaGVyZW50IFBv
d2VyUEMsIGJlY2F1c2UgdGhhdCBpcyB0aGUgb25seSBwbGFjZQo+Pj4+PiB3aGVyZSBpdCBpcyBl
bmFibGVkIGluIHRoZSBmaXJzdCBwbGFjZS4KPj4+Pj4KPj4+Pj4+IFRoZSBvbmx5IHByb2JsZW1h
dGljIGhlcmUgYWN0dWFsbHkgc2VlbXMgdG8gYmUgQVJNLCBzbyB5b3Ugc2hvdWxkCj4+Pj4+PiBw
cm9iYWJseSBqdXN0IGFkZCBhbiAiI2lmZGVmIC4uX0FSTSByZXR1cm4gZmFsc2U7Ii4KPj4+Pj4+
Cj4+Pj4+IEFSTS9hcm02NCBkb2VzIG5vdCBoYXZlIGEgS2NvbmZpZyBzeW1ib2wgbGlrZQo+Pj4+
PiBDT05GSUdfTk9UX0NPSEVSRU5UX0NBQ0hFLCBzbyB3ZSBjYW4gb25seSBkaXNhYmxlIGl0IGV2
ZXJ5d2hlcmUuIElmCj4+Pj4+IHRoZXJlIGFyZSBub24tY29oZXJlbnQgQVJNIHN5c3RlbXMgdGhh
dCBhcmUgY3VycmVudGx5IHdvcmtpbmcgaW4gdGhlCj4+Pj4+IHNhbWUgd2F5IGFzIHRob3NlIG5v
bi1jb2hlcmVudCBQb3dlclBDIHN5c3RlbXMsIHdlIHdpbGwgYnJlYWsgdGhlbSBieQo+Pj4+PiBk
b2luZyB0aGlzLgo+Pj4+IFN1bW1pbmcgdGhlIHRoaW5ncyBJJ3ZlIHJlYWQgc28gZmFyIGZvciBB
Uk0gdXAgSSBhY3R1YWxseSB0aGluayBpdAo+Pj4+IGRlcGVuZHMgb24gYSBydW50aW1lIGNvbmZp
Z3VyYXRpb24gYW5kIG5vdCBvbiBjb21waWxlIHRpbWUgb25lLgo+Pj4+Cj4+Pj4gU28gdGhlIHdo
b2xlIGlkZWEgb2YgcHJvdmlkaW5nIHRoZSBkZXZpY2UgdG8gdGhlIGRybV8qX2Nhbl93Y19tZW1v
cnkoKQo+Pj4+IGZ1bmN0aW9uIGlzbid0IHNvIGZhciBmZXRjaGVkLgo+Pj4+Cj4+PiBUaGFuayB5
b3UuCj4+Pgo+Pj4+IEJ1dCBmb3Igbm93IEkgZG8gcHJlZmVyIHdvcmtpbmcgYW5kIHNsaWdodGx5
IHNsb3dlciBzeXN0ZW0gb3ZlciBicm9rZW4KPj4+PiBvbmUsIHNvIEkgdGhpbmsgd2Ugc2hvdWxk
IGp1c3QgZGlzYWJsZSB0aGlzIG9uIEFSTSBmb3Igbm93Lgo+Pj4+Cj4+PiBBZ2FpbiwgdGhpcyBp
cyBub3QgYWJvdXQgbm9uLWNhY2hlIGNvaGVyZW50IGJlaW5nIHNsb3dlciB3aXRob3V0IHRoZQo+
Pj4gb3B0aW1pemF0aW9uLCBpdCBpcyBhYm91dCBub24tY2FjaGUgY29oZXJlbnQgbGlrZWx5IG5v
dCB3b3JraW5nICphdAo+Pj4gYWxsKiB1bmxlc3MgdGhlIG9wdGltaXphdGlvbiBpcyBlbmFibGVk
Lgo+Pgo+PiBBcyBNaWNoZWwgdHJpZWQgdG8gZXhwbGFpbiB0aGlzIENBTidUIGhhcHBlbi4gVGhl
IG9wdGltaXphdGlvbiBpcyBhCj4+IHB1cmVseSBvcHRpb25hbCByZXF1ZXN0IGZyb20gdXNlcnNw
YWNlLgo+Pgo+IAo+IFJpZ2h0Lgo+IAo+IFNvIGluIHRoYXQgY2FzZSwgd2UgY2FuIGFzc3VtZSB0
aGF0IHRoZSBmb2xsb3dpbmcgdGVzdAo+IAo+IHN0YXRpYyBpbmxpbmUgYm9vbCBkcm1fYXJjaF9j
YW5fd2NfbWVtb3J5KHZvaWQpCj4gewo+ICNpZiBkZWZpbmVkKENPTkZJR19QUEMpICYmICFkZWZp
bmVkKENPTkZJR19OT1RfQ09IRVJFTlRfQ0FDSEUpCj4gICAgIHJldHVybiBmYWxzZTsKPiAKPiBp
cyBib2d1cywgYW5kIGl0IHdhcyBqdXN0IHVubmVjZXNzYXJ5IGNhdXRpb24gb24gdGhlIHBhcnQg
b2YgdGhlCj4gYXV0aG9yIHRvIGRpc3JlZ2FyZCBub24tY2FjaGUgY29oZXJlbnQgZGV2aWNlcy4K
ClRoaXMgaXMgZHJpdmVyLWluZGVwZW5kZW50IGNvcmUgY29kZSwgbWVhbmluZyAibm9uLXNub29w
ZWQgUENJZQp0cmFuc2ZlcnMgZG9uJ3Qgd29yayBvbiBjYWNoZSBjb2hlcmVudCBQUEMiLiBJdCBk
b2Vzbid0IGltcGx5IGFueXRoaW5nCmFib3V0IHdoZXRoZXIgb3Igbm90IGFtZGdwdSBvciBhbnkg
b3RoZXIgZHJpdmVyIHdvcmtzIG9uCm5vbi1jYWNoZS1jb2hlcmVudCBQUEMgaW4gZ2VuZXJhbC4K
CgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAg
ICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAg
ICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBs
aXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
