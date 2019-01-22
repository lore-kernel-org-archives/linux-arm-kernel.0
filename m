Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95636C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:38:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A4C620823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P57gBw23";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HKqDE8LF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A4C620823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C6qEsSwX5xBFjjSBCYGX+qFiaEoU39NRWBbxlTWxNys=; b=P57gBw237tX9wO
	flBjPbgt8qEOFs/snsRkOo3GSn2AkhKDmSk8wCN56XGox9C1H61DmmfXELcXE5Y/Sjvnr60N0Cu7Y
	HPRKWlq7UuqlmN+EpXSZg6EpfDGID9YuygJfcUGP0/0i7C6vji8iouAUifqIP48M/fk55GmzPm9eP
	tVWMtQYMZe4s/Ul99Gxbqn4IAWscPKIeKMh8lPkbTmgQWrCuSR+B7PWdYtGwbPzHnhRalbFGVS/ut
	+qeBlNKfe7mGWVKjxyYf5/j/gAm4qTrbjBvcUT/+CpvOVTPVPFsxKXJO+2cr+vl3G+T4AuzkVi8ap
	kyjvw0VdvWWl0mG0umbQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glrZi-0002lE-SS; Tue, 22 Jan 2019 08:38:26 +0000
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glrZe-0002bn-J1
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 08:38:25 +0000
Received: by mail-io1-xd44.google.com with SMTP id b16so18527873ior.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 22 Jan 2019 00:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=qUQTqUpTVURbew+RiiCt5ESE99xTjivED68SiV0jtLM=;
 b=HKqDE8LFlR4bcntUCzw5MakCFvbeNDgvCsz4iSgo1AZv4MlXU3MWDlW2eoMxt5jPgl
 B1WLHHhoFo0U/ljemI8Z4J4693JULpk2nLHxNNhEdhr5Wm/Y8xKiI2BaLpwYMhTOBWQe
 g/1w+snMb6corjU4aB7Pr3WUQDzxnbACZ13FM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qUQTqUpTVURbew+RiiCt5ESE99xTjivED68SiV0jtLM=;
 b=RAOEkY41ao4+gpHC5cH1sjxFXCY3y2PtmIFzOfXmzbZ51iAUDGSDTZOm62X3su0tF8
 93PMC2KGCJtbUB0EMKNpDJDDEPx6hbV0/TzMedFuV5h7gaDxozSsjnfkUAeZvh7F01hk
 SBIP4a0im9rDCzK7ZV3AkGeVkw74LXOf6hi0OLGC99AADKoYo+hPW6FCZC012ytsPOfc
 K1o1S6NDNLphao9PcjkiqGSYc7O33o/uF8NTBg8bpUHwv4DiYYhfPQ6JdFE138ZPRPO2
 uLFoV1Aj4DKeHqz3QxYmIftuUZLSerZ6j/U4lrHamJ1XbgR3Tl/ujH6buOnEbzyk+wgF
 eiAQ==
X-Gm-Message-State: AJcUukcpsNShL5/F54U2ON8qKGtEcUW2ajc97KOdkRtHe3Jw8qDldURW
 HPBD/KiwhC7UL+5cGE6Pi3ER9tJ5NBJP05ta4oUXsw==
X-Google-Smtp-Source: ALg8bN6UvlN0HUsOrry0u8K9wytWJ4FDuwAh2ipb28YCqe64kcItCGxwzZPOOJMwUUhEfDTU7KX/UKP05UpnCoB0EkA=
X-Received: by 2002:a5e:c206:: with SMTP id v6mr19395883iop.60.1548146301581; 
 Tue, 22 Jan 2019 00:38:21 -0800 (PST)
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
Date: Tue, 22 Jan 2019 09:38:10 +0100
Message-ID: <CAKv+Gu_VBd8agHASc5RS0eCgyXP64Lt_i4yPuBjKwGQ+5Lpd5Q@mail.gmail.com>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_003822_622741_6E6E31CA 
X-CRM114-Status: GOOD (  21.41  )
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
Cj4KPiBMZXQgbWUgdHJ5IG9uZSBsYXN0IHRpbWU6Cj4KPiBJZiBkcm1fYXJjaF9jYW5fd2NfbWVt
b3J5IHJldHVybnMgZmFsc2UsIHRoZSBkcml2ZXIgZmFsbHMgYmFjayB0byB0aGUKPiBub3JtYWwg
bW9kZSBvZiBvcGVyYXRpb24sIHVzaW5nIGEgY2FjaGVhYmxlIENQVSBtYXBwaW5nIGFuZCBzbm9v
cGVkIEdQVQo+IHRyYW5zZmVycywgZXZlbiBpZiB1c2Vyc3BhY2UgYXNrcyAoYXMgYSBwZXJmb3Jt
YW5jZSBvcHRpbWl6YXRpb24pIGZvciBhCj4gd3JpdGUtY29tYmluZWQgQ1BVIG1hcHBpbmcgYW5k
IG5vbi1zbm9vcGVkIEdQVSB0cmFuc2ZlcnMgdmlhCj4gQU1ER1BVX0dFTV9DUkVBVEVfQ1BVX0dU
VF9VU1dDLgoKQW5vdGhlciBxdWVzdGlvbjogd2hlbiB1c2Vyc3BhY2UgcmVxdWVzdHMgZm9yIHN1
Y2ggYSBtYXBwaW5nIHRvIGJlCmNyZWF0ZWQsIGRvZXMgdGhpcyBpbnZvbHZlIHBhZ2VzIHRoYXQg
YXJlIG1hcHBlZCBjYWNoZWFibGUgaW50byB0aGUKdXNlcmxhbmQgcHJvY2Vzcz8KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
