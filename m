Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC211C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:07:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AEC8222A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W1missY4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AEC8222A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-ID:From:To:Subject:MIME-Version
	:References:In-Reply-To:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/cVrw2g11icShIvQuK2LBIr5Mm++d7SfUJcXZFxFJYo=; b=W1missY4jt58ZO
	okTA5DnwQKPZeFwBeDCSFqDcEBRlh+IOL+wJGLepVILzstx6U35hePe3A22lgKbgtFoMLMGqQ5Wlg
	0DeJL3latPkoZRy5R7TBh1gP65tQCuw+/vWajT+0F8TuCvkIvkXcGZDS7YXpSwzZKVn3RHwhpQUwm
	H/xpBKEHrKv+2XqJ+27k+4iL4MSThyAKwXnqSq73YrQZHaSqlSwrol2meSWC7XmzqmXKuiU4w6c1G
	aTDpZl8jCPvo7ozxdYe4aSSee+e9r924dGEoxltYHqMAJXhMZVSJkkQ7RwVZpPKFIjCtiTHyQf+kt
	Ehl0A0b/JOHI9aU9BS8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gurGM-0003Hl-FB; Sat, 16 Feb 2019 04:07:38 +0000
Received: from terminus.zytor.com ([198.137.202.136] helo=mail.zytor.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gurGJ-0003HQ-MT
 for linux-arm-kernel@lists.infradead.org; Sat, 16 Feb 2019 04:07:37 +0000
Received: from [IPv6:2601:646:8680:2bb1:4d04:7df8:9f95:eec1]
 ([IPv6:2601:646:8680:2bb1:4d04:7df8:9f95:eec1])
 (authenticated bits=0)
 by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x1G477Q71484064
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Fri, 15 Feb 2019 20:07:09 -0800
Date: Fri, 15 Feb 2019 20:06:56 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20190214101429.GD32494@hirez.programming.kicks-ass.net>
References: <1c2429a4-9df9-40a3-98e0-51577de4bd6a@arm.com>
 <20190213131720.GU32494@hirez.programming.kicks-ass.net>
 <20190213140025.GB6346@brain-police>
 <20190213142524.GW32494@hirez.programming.kicks-ass.net>
 <dd33cc20-f335-0e4c-e3f4-02497ecc3710@arm.com>
 <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
 <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net>
 <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
To: Peter Zijlstra <peterz@infradead.org>,
 Andy Lutomirski <luto@amacapital.net>
From: hpa@zytor.com
Message-ID: <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_200735_765216_858E8AF0 
X-CRM114-Status: GOOD (  13.18  )
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
Cc: dvlasenk@redhat.com, Julien Thierry <julien.thierry@arm.com>,
 catalin.marinas@arm.com, jpoimboe@redhat.com,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 valentin.schneider@arm.com, mingo@redhat.com, james.morse@arm.com,
 luto@kernel.org, brgerst@gmail.com, bp@alien8.de, tglx@linutronix.de,
 torvalds@linux-foundation.org, Ingo Molnar <mingo@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRmVicnVhcnkgMTQsIDIwMTkgMjoxNDoyOSBBTSBQU1QsIFBldGVyIFppamxzdHJhIDxwZXRl
cnpAaW5mcmFkZWFkLm9yZz4gd3JvdGU6Cj5PbiBXZWQsIEZlYiAxMywgMjAxOSBhdCAwMjo0OTo0
N1BNIC0wODAwLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6Cj4KPj4gRG8gd2UgbmVlZCB0byBiYWNr
cG9ydCB0aGlzIHRoaW5nPwo+Cj5Qb3NzaWJseSwganVzdCB0byBiZSBzYWZlLgo+Cj4+IFRoZSBw
cm9ibGVtIGNhbuKAmXQgYmUgdG9vIHdpZGVzcHJlYWQgb3Igd2Ugd291bGQgaGF2ZSBoZWFyZCBv
ZiBpdAo+YmVmb3JlLgo+Cj5ZZXMsIHNvIGZhciB3ZSd2ZSBiZWVuIGx1Y2t5Lgo+Cj4tLS0KPlN1
YmplY3Q6IHNjaGVkL3g4NjogU2F2ZSBbRVJdRkxBR1Mgb24gY29udGV4dCBzd2l0Y2gKPkZyb206
IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4KPkRhdGU6IFRodSBGZWIgMTQg
MTA6MzA6NTIgQ0VUIDIwMTkKPgo+RWZmZWN0aXZlbHkgcmV2ZXJ0IGNvbW1pdDoKPgo+ICAyYzc1
NzdhNzU4MzcgKCJzY2hlZC94ODZfNjQ6IERvbid0IHNhdmUgZmxhZ3Mgb24gY29udGV4dCBzd2l0
Y2giKQo+Cj5TcGVjaWZpY2FsbHkgYmVjYXVzZSBTTUFQIHVzZXMgRkxBR1MuQUMgd2hpY2ggaW52
YWxpZGF0ZXMgdGhlIGNsYWltCj50aGF0IHRoZSBrZXJuZWwgaGFzIGNsZWFuIGZsYWdzLgo+Cj5J
biBwYXJ0aWN1bGFyOyB3aGlsZSBwcmVlbXB0aW9uIGZyb20gaW50ZXJydXB0IHJldHVybiBpcyBm
aW5lICh0aGUKPklSRVQgZnJhbWUgb24gdGhlIGV4Y2VwdGlvbiBzdGFjayBjb250YWlucyBGTEFH
UykgaXQgYnJlYWtzIGFueSBjb2RlCj50aGF0IGRvZXMgc3luY2hvbm91cyBzY2hlZHVsaW5nLCBp
bmNsdWRpbmcgcHJlZW1wdF9lbmFibGUoKS4KPgo+VGhpcyBoYXMgYmVjb21lIGEgc2lnbmlmaWNh
bnQgaXNzdWUgZXZlciBzaW5jZSBjb21taXQ6Cj4KPjViMjRhN2EyYWEyMCAoIkFkZCAndW5zYWZl
JyB1c2VyIGFjY2VzcyBmdW5jdGlvbnMgZm9yIGJhdGNoZWQKPmFjY2Vzc2VzIikKPgo+cHJvdmlk
ZWQgZm9yIG1lYW5zIG9mIGhhdmluZyAnbm9ybWFsJyBDIGNvZGUgYmV0d2VlbiBTVEFDIC8gQ0xB
QywKPmV4cG9zaW5nIHRoZSBGTEFHUy5BQyBzdGF0ZS4gU28gZmFyIHRoaXMgaGFzbid0IGxlZCB0
byB0cm91YmxlLAo+aG93ZXZlciBmaXggaXQgYmVmb3JlIGl0IGNvbWVzIGFwYXJ0Lgo+Cj5GaXhl
czogNWIyNGE3YTJhYTIwICgiQWRkICd1bnNhZmUnIHVzZXIgYWNjZXNzIGZ1bmN0aW9ucyBmb3Ig
YmF0Y2hlZAo+YWNjZXNzZXMiKQo+QWNrZWQtYnk6IEFuZHkgTHV0b21pcnNraSA8bHV0b0BhbWFj
YXBpdGFsLm5ldD4KPlJlcG9ydGVkLWJ5OiBKdWxpZW4gVGhpZXJyeSA8anVsaWVuLnRoaWVycnlA
YXJtLmNvbT4KPlNpZ25lZC1vZmYtYnk6IFBldGVyIFppamxzdHJhIChJbnRlbCkgPHBldGVyekBp
bmZyYWRlYWQub3JnPgo+LS0tCj4gYXJjaC94ODYvZW50cnkvZW50cnlfMzIuUyAgICAgICAgfCAg
ICAyICsrCj4gYXJjaC94ODYvZW50cnkvZW50cnlfNjQuUyAgICAgICAgfCAgICAyICsrCj4gYXJj
aC94ODYvaW5jbHVkZS9hc20vc3dpdGNoX3RvLmggfCAgICAxICsKPiAzIGZpbGVzIGNoYW5nZWQs
IDUgaW5zZXJ0aW9ucygrKQo+Cj4tLS0gYS9hcmNoL3g4Ni9lbnRyeS9lbnRyeV8zMi5TCj4rKysg
Yi9hcmNoL3g4Ni9lbnRyeS9lbnRyeV8zMi5TCj5AQCAtNjUwLDYgKzY1MCw3IEBAIEVOVFJZKF9f
c3dpdGNoX3RvX2FzbSkKPiAJcHVzaGwJJWVieAo+IAlwdXNobAklZWRpCj4gCXB1c2hsCSVlc2kK
PisJcHVzaGZsCj4gCj4gCS8qIHN3aXRjaCBzdGFjayAqLwo+IAltb3ZsCSVlc3AsIFRBU0tfdGhy
ZWFkc3AoJWVheCkKPkBAIC02NzIsNiArNjczLDcgQEAgRU5UUlkoX19zd2l0Y2hfdG9fYXNtKQo+
ICNlbmRpZgo+IAo+IAkvKiByZXN0b3JlIGNhbGxlZS1zYXZlZCByZWdpc3RlcnMgKi8KPisJcG9w
ZmwKPiAJcG9wbAklZXNpCj4gCXBvcGwJJWVkaQo+IAlwb3BsCSVlYngKPi0tLSBhL2FyY2gveDg2
L2VudHJ5L2VudHJ5XzY0LlMKPisrKyBiL2FyY2gveDg2L2VudHJ5L2VudHJ5XzY0LlMKPkBAIC0y
OTEsNiArMjkxLDcgQEAgRU5UUlkoX19zd2l0Y2hfdG9fYXNtKQo+IAlwdXNocQklcjEzCj4gCXB1
c2hxCSVyMTQKPiAJcHVzaHEJJXIxNQo+KwlwdXNoZnEKPiAKPiAJLyogc3dpdGNoIHN0YWNrICov
Cj4gCW1vdnEJJXJzcCwgVEFTS190aHJlYWRzcCglcmRpKQo+QEAgLTMxMyw2ICszMTQsNyBAQCBF
TlRSWShfX3N3aXRjaF90b19hc20pCj4gI2VuZGlmCj4gCj4gCS8qIHJlc3RvcmUgY2FsbGVlLXNh
dmVkIHJlZ2lzdGVycyAqLwo+Kwlwb3BmcQo+IAlwb3BxCSVyMTUKPiAJcG9wcQklcjE0Cj4gCXBv
cHEJJXIxMwo+LS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vc3dpdGNoX3RvLmgKPisrKyBiL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL3N3aXRjaF90by5oCj5AQCAtNDAsNiArNDAsNyBAQCBhc21saW5r
YWdlIHZvaWQgcmV0X2Zyb21fZm9yayh2b2lkKTsKPiAgKiBvcmRlciBvZiB0aGUgZmllbGRzIG11
c3QgbWF0Y2ggdGhlIGNvZGUgaW4gX19zd2l0Y2hfdG9fYXNtKCkuCj4gICovCj4gc3RydWN0IGlu
YWN0aXZlX3Rhc2tfZnJhbWUgewo+Kwl1bnNpZ25lZCBsb25nIGZsYWdzOwo+ICNpZmRlZiBDT05G
SUdfWDg2XzY0Cj4gCXVuc2lnbmVkIGxvbmcgcjE1Owo+IAl1bnNpZ25lZCBsb25nIHIxNDsKClRo
aXMgaW1wbGllcyB3ZSBpbnZva2Ugc2NoZWR1bGUgLS0gYSByZXN0cmljdGVkIG9wZXJhdGlvbiAo
Y29uc2lkZXIgbWF5X3NsZWVwKSBkdXJpbmcgZXhlY3V0aW9uIG9mIFNUQUMtZW5hYmxlZCBjb2Rl
LCBidXQgKm5vdCogYXMgYW4gZXhjZXB0aW9uIG9yIGludGVycnVwdCwgc2luY2UgdGhvc2UgcHJl
c2VydmUgdGhlIGZsYWdzLgoKSSBoYXZlIHNlcmlvdXMgY29uY2VybnMgYWJvdXQgdGhpcy4gVGhp
cyBpcyBtb3JlIG9yIGxlc3Mgc2F5aW5nIHRoYXQgd2UgaGF2ZSBsZWZ0IGFuIHVubGltaXRlZCBn
YXAgYW5kIGhhdmUgaGFkIEFDIGVzY2FwZS4KCkRvZXMgKmFueW9uZSogc2VlIGEgbmVlZCB0byBh
bGxvdyB0aGlzPyBJIGdvdCBhIHF1ZXN0aW9uIGF0IExQQyBmcm9tIHNvbWVvbmUgYWJvdXQgdGhp
cywgYW5kIHdoYXQgdGhleSB3ZXJlIHRyeWluZyB0byBkbyBvbmNlIGFsbCB0aGUgbGF5ZXJzIGhh
ZCBiZWVuIHVud291bmQgd2FzIHNvIGZhciBkb3duIHRoZSB3cm9uZyB0cmFjayBmb3IgYSByb290
IHByb2JsZW0gdGhhdCBhY3R1YWxseSBoYXMgYSB2ZXJ5IHNpbXBsZSBzb2x1dGlvbi4KCi0tIApT
ZW50IGZyb20gbXkgQW5kcm9pZCBkZXZpY2Ugd2l0aCBLLTkgTWFpbC4gUGxlYXNlIGV4Y3VzZSBt
eSBicmV2aXR5LgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtYXJtLWtlcm5lbAo=
