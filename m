Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12495C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:52:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D55E7208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Tog1Fy8M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D55E7208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Ak/m+G1aZHzXesmAESgdx5JzFdl92bntkVhX/6KdZoc=; b=Tog1Fy8Mv9RPTVQiIKoQn1KtC
	nD5AFfAvwyIDD5yjqNhzfXdq/9b7Ef+G17wM+szJ785KtKUHX1isSYXAFeADkBAO2GqkGFbETBLni
	WsUSJ0psCEAKEZ/Pc+Xc6EnfAGEWbtrAUSQw8fTMgsZm48ijtKVfJXe8pVcyVSzi5Q6HLhqxRK/CU
	Z7SOpzNJM8PFBLPa57dBT/LSSYj4d94/njBhs5hP6e3Q546HGlAI0rvnY1O86qD+3perBGoZiU6K6
	IDcDRUdlMj3IKn5kmPBsK1HNc9AADuU4RxBBDbJKTrr8FZWQgJH7ixc0AtdgUB5oDQFlzLz8Fx7r4
	6yWOEM0kw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUvwX-0007qM-QQ; Thu, 06 Dec 2018 15:52:01 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUvwU-0007oM-Sc
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 15:52:00 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5FA880D;
 Thu,  6 Dec 2018 07:51:46 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE2253F59C;
 Thu,  6 Dec 2018 07:51:44 -0800 (PST)
Subject: Re: dmapool regression in next
To: Tony Battersby <tonyb@cybernetics.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, tony@atomide.com
References: <20181206013054.GI6707@atomide.com>
 <CAJKOXPcoK5SsXfXjdAWPHLX2KZRCqOv61HVf2DK9wm4_m+vJ0w@mail.gmail.com>
 <09e73d24-467a-52bb-0433-a9596d4d6f02@cybernetics.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <451215b8-548a-eff7-9e96-0ff5f8cbb614@arm.com>
Date: Thu, 6 Dec 2018 15:51:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <09e73d24-467a-52bb-0433-a9596d4d6f02@cybernetics.com>
Content-Language: en-GB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_075158_931577_60811E9A 
X-CRM114-Status: GOOD (  25.11  )
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, john.garry@huawei.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
 akpm@linux-foundation.org, linux-omap@vger.kernel.org, hch@lst.de,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMDYvMTIvMjAxOCAxNToxMSwgVG9ueSBCYXR0ZXJzYnkgd3JvdGU6Cj4gT24gMTIvNi8xOCA0
OjI1IEFNLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOgo+PiBPbiBUaHUsIDYgRGVjIDIwMTgg
YXQgMDI6MzEsIFRvbnkgTGluZGdyZW4gPHRvbnlAYXRvbWlkZS5jb20+IHdyb3RlOgo+Pj4gSGks
Cj4+Pgo+Pj4gTG9va3MgbGlrZSB3aXRoIGNvbW1pdCAyNmFiZTg4ZTgzMGQgKCJtbS9kbWFwb29s
LmM6IGltcHJvdmUgc2NhbGFiaWxpdHkKPj4+IG9mIGRtYV9wb29sX2ZyZWUoKSIpIEknbSBub3cg
Z2V0dGluZyBzcGFtbWVkIHdpdGggbG90cyBvZiAiKGJhZCB2YWRkcikiCj4+PiBvbiBhdCBsZWFz
dCBvbWFwNCBwYW5kYWJvYXJkLCBzZWUgYmVsb3cuCj4+Pgo+Pj4gQW55IGlkZWFzIHdoYXQgbWln
aHQgYmUgZ29pbmcgd3Jvbmc/Cj4+Pgo+Pj4gUmVnYXJkcywKPj4+Cj4+PiBUb255Cj4+Pgo+Pj4g
ODwgLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4+PiBvbWFwLWRtYS1lbmdpbmUgNGEwNTYwMDAuZG1h
LWNvbnRyb2xsZXI6IGRtYV9wb29sX2ZyZWUgNGEwNTYwMDAuZG1hLWNvbnRyb2xsZXIsIChwdHJ2
YWwpIChiYWQgdmFkZHIpLzB4YmU4MDAwMDAKPj4+IG9tYXAtZG1hLWVuZ2luZSA0YTA1NjAwMC5k
bWEtY29udHJvbGxlcjogZG1hX3Bvb2xfZnJlZSA0YTA1NjAwMC5kbWEtY29udHJvbGxlciwgKHB0
cnZhbCkgKGJhZCB2YWRkcikvMHhiZTgwMDAxYwo+Pj4gb21hcC1kbWEtZW5naW5lIDRhMDU2MDAw
LmRtYS1jb250cm9sbGVyOiBkbWFfcG9vbF9mcmVlIDRhMDU2MDAwLmRtYS1jb250cm9sbGVyLCAo
cHRydmFsKSAoYmFkIHZhZGRyKS8weGJlODAwMDM4Cj4+PiAuLi4KPj4gSSBzZWUgaXQgYXMgd2Vs
bCBvbiBhbGwgbXkgRXh5bm9zIGJvYXJkcywgc2luY2UgeWVzdGVyZGF5J3MgbmV4dC4gSW4KPj4g
bXkgY2FzZSBpdCBpcyB0aGUgVVNCIEVIQ0kgZHJpdmVyOgo+PiBleHlub3MtZWhjaSAxMjExMDAw
MC51c2I6IGRtYV9wb29sX2ZyZWUgZWhjaV9xdGQsIChwdHJ2YWwpIChiYWQKPj4gdmFkZHIpLzB4
Yjg4NDQxODAKPj4gRnVsbCBsb2cgaGVyZToKPj4gaHR0cHM6Ly9rcnprLmV1LyMvYnVpbGRlcnMv
MS9idWlsZHMvMjkzNy9zdGVwcy8xMi9sb2dzL3NlcmlhbDAKPj4KPj4gQmVzdCByZWdhcmRzLAo+
PiBLcnp5c3p0b2YKPj4KPiBIZXJlIGlzIHRoZSBwcm90b3R5cGU6Cj4gCj4gdm9pZCBkbWFfcG9v
bF9mcmVlKHN0cnVjdCBkbWFfcG9vbCAqcG9vbCwgdm9pZCAqdmFkZHIsIGRtYV9hZGRyX3QgZG1h
KTsKPiAKPiBXaXRoIHRoZSBvbGQgY29kZSwgdGhlICdkbWEnIHZhbHVlIGhhZCB0byBiZSBjb3Jy
ZWN0IGZvciB1c2Ugd2l0aAo+IHBvb2xfZmluZF9wYWdlKCksIG9yIGVsc2UgeW91IHdvdWxkIGdl
dCBhbiBlcnJvci7CoCBJZiB0aGUgJ3ZhZGRyJyB2YWx1ZQo+IHdhcyBpbmNvcnJlY3QsIGl0IHdv
dWxkIGNvcnJ1cHQgdGhlIGRtYXBvb2wgZnJlZWxpc3QsIGJ1dCB5b3Ugd291bGRuJ3QKPiBnZXQg
YW4gZXJyb3IgdW5sZXNzIERNQVBPT0xfREVCVUcgd2FzIGVuYWJsZWQuCj4gCj4gV2l0aCBteSBw
YXRjaCBhcHBsaWVkLCAndmFkZHInIGhhcyB0byBiZSBjb3JyZWN0IGZvciB2aXJ0X3RvX3BhZ2Uo
KS7CoCBNeQo+IGNvZGUgYWxzbyBjaGVja3MgdGhhdCAnZG1hJyBpcyBjb25zaXN0ZW50IHdpdGgg
J3ZhZGRyJyBldmVuIGlmCj4gRE1BUE9PTF9ERUJVRyBpcyBkaXNhYmxlZCwgc2luY2UgdGhlIGNo
ZWNrIGlzIGZhc3QgYW5kIGl0IHdpbGwgcHJldmVudAo+IHByb2JsZW1zIGxpa2UgdGhpcyBpbiB0
aGUgZnV0dXJlLgoKVW5mb3J0dW5hdGVseSB0aGF0IGxvZ2ljIGhhcyBhIGZhdGFsIGZsYXcgLSBE
TUEgcG9vbHMgYXJlIGJhY2tlZCBieSAKZG1hX2FsbG9jX2NvaGVyZW50KCksIGFuZCB0aGVyZSBp
cyBhYnNvbHV0ZWx5IG5vIGd1YXJhbnRlZSB0aGF0IHRoZSAKbWVtb3J5IGRtYV9hbGxvY19jb2hl
cmVudCgpIHJldHVybnMgaXMgYmFja2VkIGJ5IGEgc3RydWN0IHBhZ2UgYXQgYWxsLiAKRXZlbiBp
ZiBpdCBpcywgdGhlcmUgaXMgc3RpbGwgYWJzb2x1dGVseSBubyBndWFyYW50ZWUgdGhhdCB0aGUg
dmFkZHIgCnZhbHVlIGl0IHJldHVybnMgaXMgdmFsaWQgZm9yIHZpcnRfdG9fcGFnZSgpIC0gb24g
bWFueSBzeXN0ZW1zIGl0IHdpbGwgCmJlIGluIHZtYWxsb2Mgb3Igc29tZSBhcmNoaXRlY3R1cmUt
c3BlY2lmaWMgcmVnaW9uIG9mIGFkZHJlc3Mgc3BhY2UuCgpUaGUgcHJvYmxlbSBpcyBub3QgdGhh
dCB0aGVzZSBkcml2ZXJzIGFyZSBidWdneSAodGhleSdyZSBub3QgLSB0aGUgYXJjaCAKY29kZSBp
cyByZXR1cm5pbmcgYSB2bWFsbG9jKCllZCBub24tY2FjaGVhYmxlIHJlbWFwIGluIHRoZSBmaXJz
dCBwbGFjZSksIAppdCdzIHRoYXQgMjZhYmU4OGU4MzBkIGlzIGZ1bmRhbWVudGFsbHkgdW53b3Jr
YWJsZSBhbmQgbmVlZHMgcmV2ZXJ0aW5nLiAKQXBwYXJlbnRseSB0aGUgb3JpZ2luYWwgcGF0Y2hl
cyBtYW5hZ2VkIG5vdCB0byBjYXRjaCBteSBleWUgYXMgc29tZXRoaW5nIApJIG5lZWRlZCB0byBy
ZXZpZXcsIHNvcnJ5IGFib3V0IHRoYXQgOigKClJvYmluLgoKPiAKPiBTbyBpZiBhIGJ1Z2d5IGRy
aXZlciBwYXNzZXMgaW4gYSBnb29kIHZhbHVlIGZvciAnZG1hJyBidXQgYSBiYWQgdmFsdWUKPiBm
b3IgJ3ZhZGRyJywgdGhlbiBpdCBtYXkgaGF2ZSBhcHBlYXJlZCB0byB3b3JrIHByZXZpb3VzbHkg
KGJ1dCB3aXRoCj4gcG9zc2libGUgZGF0YSBjb3JydXB0aW9uLCBkZXBlbmRpbmcgb24gdGhlIGNp
cmN1bXN0YW5jZXMpLCBidXQgbXkgcGF0Y2gKPiB3aWxsIGV4cG9zZSB0aGUgcHJvYmxlbS7CoCBZ
b3UgY2FuIGNvbmZpcm0gYnkgcmV2ZXJ0aW5nIG15IGRtYXBvb2wKPiBwYXRjaGVzIGFuZCBlbmFi
bGluZyBETUFQT09MX0RFQlVHLCB3aGljaCBpcyBhdCB0aGUgdG9wIG9mIG1tL2RtYXBvb2wuYzoK
PiAKPiAjaWYgZGVmaW5lZChDT05GSUdfREVCVUdfU0xBQikgfHwgZGVmaW5lZChDT05GSUdfU0xV
Ql9ERUJVR19PTikKPiAjZGVmaW5lIERNQVBPT0xfREVCVUcgMQo+ICNlbmRpZgo+IAo+IFRvbnkg
QmF0dGVyc2J5Cj4gCj4gCj4gCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KPiBsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAo+IGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo+IAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QK
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
