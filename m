Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876AEC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:37:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F5152081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c7jFrwAU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F5152081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=X4SkmbPwQyh3imQ0Lnh5Tj4k7N4CH9UzcW112ZqUpLg=; b=c7jFrwAU1dX5pCrqvxtrmyiB3
	CHCM5lE1kgh5a11ULXQbq85ExcwLCcf2lFu2VIqWekR6UUFB0rNU5+AG7M4zFR/jmN3HN0w+8nNo4
	co/h5SkCaa0VzklZdArGZzNkTda0iBXNWk2fVl+YrX4Zw3iiZ1aqZGlfZSYufq8jjZmRzmBioCx4h
	qJwdslgUV5qD4BIt1ILjhFl2JE+Pt4QRoGM0/ObBEi6+oGGta5nykX8Rjj/DZCCzXwfr2Uy4EPkaP
	o2S0eD4KBjiiJO9k2SmtsOTR8mpzKpDyAd5ABI6d1UzAspLxedNO7CuL86qFtTkFUPO9Ql7YkU1Sm
	E5UugSyKg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWdXq-0007tU-16; Tue, 11 Dec 2018 08:37:34 +0000
Received: from mail-sz2.amlogic.com ([211.162.65.114])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWdWz-0007X6-Bh; Tue, 11 Dec 2018 08:36:42 +0000
Received: from [10.28.18.115] (10.28.18.115) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Tue, 11 Dec
 2018 16:36:47 +0800
Subject: Re: [PATCH v7 2/2] mtd: rawnand: meson: add support for Amlogic NAND
 flash controller
To: Miquel Raynal <miquel.raynal@bootlin.com>
References: <1542386439-30166-1-git-send-email-jianxin.pan@amlogic.com>
 <1542386439-30166-3-git-send-email-jianxin.pan@amlogic.com>
 <20181207102456.1dc67e07@xps13>
 <823825a3-86fb-9a20-ae29-85cc52d44093@amlogic.com>
 <20181210123809.5ade45c4@bbrezillon>
 <79a797c2-f37f-7f7c-e907-2d3c2283ec2d@amlogic.com>
 <20181210155057.38788656@xps13>
 <d60bac6f-732d-0ddc-2644-17f650dfa885@amlogic.com>
 <20181211085445.68e57e0e@xps13>
From: Liang Yang <liang.yang@amlogic.com>
Message-ID: <356aed95-518d-7cd0-4337-184f181472ad@amlogic.com>
Date: Tue, 11 Dec 2018 16:36:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181211085445.68e57e0e@xps13>
Content-Language: en-US
X-Originating-IP: [10.28.18.115]
X-ClientProxiedBy: mail-sz2.amlogic.com (10.28.11.6) To mail-sz2.amlogic.com
 (10.28.11.6)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_003641_402542_81C27639 
X-CRM114-Status: GOOD (  16.84  )
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
Cc: Rob Herring <robh@kernel.org>, Hanjie Lin <hanjie.lin@amlogic.com>,
 Victor Wan <victor.wan@amlogic.com>, Jianxin Pan <jianxin.pan@amlogic.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Richard Weinberger <richard@nod.at>, Neil Armstrong <narmstrong@baylibre.com>,
 Yixun Lan <yixun.lan@amlogic.com>, linux-kernel@vger.kernel.org,
 Boris Brezillon <boris.brezillon@bootlin.com>, Jian Hu <jian.hu@amlogic.com>,
 linux-mtd@lists.infradead.org, Kevin Hilman <khilman@baylibre.com>,
 Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgTWlxdWVsLAoKVGhhbmtzIGZvciB5b3VyIHF1aWNrbHkgcmVwbHkuCgpPbiAyMDE4LzEyLzEx
IDE1OjU0LCBNaXF1ZWwgUmF5bmFsIHdyb3RlOgo+IEhpIExpYW5nLAo+IAo+IExpYW5nIFlhbmcg
PGxpYW5nLnlhbmdAYW1sb2dpYy5jb20+IHdyb3RlIG9uIFR1ZSwgMTEgRGVjIDIwMTggMDk6NTY6
MjUKPiArMDgwMDoKPiAKPj4gSGkgTWlxdWVsLAo+Pgo+PiBPbiAyMDE4LzEyLzEwIDIyOjUwLCBN
aXF1ZWwgUmF5bmFsIHdyb3RlOgo+Pj4gSGkgTGlhbmcsCj4+Pgo+Pj4gTGlhbmcgWWFuZyA8bGlh
bmcueWFuZ0BhbWxvZ2ljLmNvbT4gd3JvdGUgb24gTW9uLCAxMCBEZWMgMjAxOCAyMDoxMjozOQo+
Pj4gKzA4MDA6Cj4+PiAgICAKPj4+PiBPbiAyMDE4LzEyLzEwIDE5OjM4LCBCb3JpcyBCcmV6aWxs
b24gd3JvdGU6Cj4+Pj4+IE9uIE1vbiwgMTAgRGVjIDIwMTggMTk6MjM6NDYgKzA4MDAKPj4+Pj4g
TGlhbmcgWWFuZyA8bGlhbmcueWFuZ0BhbWxvZ2ljLmNvbT4gd3JvdGU6Cj4+Pj4+ICAgICA+Pj4+
Pj4gKwkJCW10ZC0+ZWNjX3N0YXRzLmZhaWxlZCsrOwo+Pj4+Pj4+PiArCQkJY29udGludWU7Cj4+
Pj4+Pj4+ICsJCX0KPj4+Pj4+Pj4gKwkJbXRkLT5lY2Nfc3RhdHMuY29ycmVjdGVkICs9IEVDQ19F
UlJfQ05UKCppbmZvKTsKPj4+Pj4+Pj4gKwkJYml0ZmxpcHMgPSBtYXhfdCh1MzIsIGJpdGZsaXBz
LCBFQ0NfRVJSX0NOVCgqaW5mbykpOwo+Pj4+Pj4+PiArCX0KPj4+Pj4+Pgo+Pj4+Pj4+IEFyZSB5
b3Ugc3VyZSB5b3UgaGFuZGxlIGNvcnJlY3RseSBlbXB0eSBwYWdlcyB3aXRoIGJmPwo+Pj4+Pj4+
ICAgICAgPj4gaWYgc2NyYW1ibGUgaXMgZW5hYmxlLCBpIHdvdWxkIHNheSB5ZXMgaGVyZS4KPj4+
Pj4+IHdoZW4gc2NyYW1ibGUgaXMgZGlzYWJsZWQsIGkgYW0gY29uc2lkZXJpbmcgaG93IHRvIHVz
ZSB0aGUgaGVscGVyCj4+Pj4+PiBuYW5kX2NoZWNrX2VyYXNlZF9lY2NfY2h1bmssIGJ1dCBpdCBz
ZWVtcyB0aGF0IGkgY2FuJ3QgZ2V0IHRoZSBlY2MKPj4+Pj4+IGJ5dGVzIHdoaWNoIGlzIGNhY3Vs
YXRlZCBieSBlY2MgZW5naW5lLmJ5IHRoZSB3YXksIG5mYyBkbWEgZG9lc24ndCBzZW5kCj4+Pj4+
PiBvdXQgdGhlIGVjYyBwYXJpdHkgYnl0ZXMuCj4+Pj4+Cj4+Pj4+IEV2ZW4gaWYgdGhlIEVDQyBl
bmdpbmUgaXMgZGlzYWJsZWQ/Cj4+Pj4+ICAgICA+PiBOby4KPj4+PiBXaGVuIEVDQyBlbmdpbmUg
aXMgZGlzYWJsZWQsIGl0IGNhbiByZWFkIHRoZSBlY2MgcGFyaXR5IGJ5dGVzIDsgYnV0IHRoZXJl
IGlzIGFub3RoZXIgcHJvYmxlbSB0aGF0IGkgbmVlZCB0byBjb25zaWRlciBob3cgY29kZSBzdHJ1
Y3QgbG9va3MgYmV0dGVyIHdoZW4gcmVhZGluZyBlcnJvciB3aXRoIGVjYyBvcGVuZWQgYW5kIHRo
ZW4gdHJ5IHRvIHJhdyByZWFkLgo+Pj4+IElzIHRoZXJlIGEgZ29vZCBpZGVhPwo+Pj4KPj4+IFdo
ZW4gcmVhZGluZyB3aXRoIEVDQyBlbmFibGVkLCBpbiBjYXNlIG9mIHVuY29ycmVjdGFibGUgZXJy
b3IgeW91Cj4+PiBtdXN0IHJlLXJlYWQgd2l0aG91dCBFQ0MsIHRoZW4gY2hlY2sgaWYgdGhlIHBh
Z2UgaXMgZW1wdHkgb3Igbm90IHdpdGgKPj4+IHRoZSBjb3JlIGhlbHBlcnMgKG5hbmRfY2hlY2tf
ZXJhc2VkXyooKSkuCj4+Pgo+Pj4gSXMgdGhpcyB3aGF0IHlvdSBtZWFudD8KPj4+ICAgIAo+PiB5
ZXMuIHdoZW4gdW5jb3JyZWN0YWJsZSBFQ0MgZXJyb3IsIGkgbmVlZCBmaXJzdGx5IHJlYWQgb3V0
IHRoZSBFQ0MgYnl0ZXMgd2l0aG91dCBFQ0MgZW5naW5lIGFuZCB0aGVuIHVzZSB0aGUgaGVscGVy
IG5hbmRfY2hlY2tfZXJhc2VkX2VjY19jaHVuayB0byBjaGVjayBpZiBibGFuayBwYWdlLgo+PiBP
ZiBjb3Vyc2UsIHRoZSBwcmVjb25kaXRpb24gaXMgd2l0aG91dCBzY3JhbWJsZXIsIG9yIHRoZSBi
bGFuZCBwYWdlIGNhbiBiZSBkZXRlY3RlZCBieSBtZXNvbiBORkMuCj4gCj4gQSBzdXBwb3NlIHlv
dSBtZWFudCAiYmxhbmsgcGFnZSI/IElmIHllcywgdGhlbiB5b3UgZG9uJ3QgbmVlZCB0aGUKPiBo
ZWxwZXIgdG8gY2hlY2sgZm9yIG9ubHktMHhGRiBwYWdlcy4gSWYgdGhlIGNvbnRyb2xsZXIgdGVs
bHMgeW91IGlmIHRoZQo+IHBhZ2Ugd2FzIGJsYW5rLCB0aGVuIGp1c3QgY2hlY2sgZm9yIHRoYXQg
Yml0Lgo+IAoKaSB0aGluayBub3QuIHdlIG5lZWQgdG8gcmV0dXJuIGJhY2sgdGhlIHByZXZpb3Vz
IHByb2JsZW0gdGhhdCBob3cgaSBjYW4gCmdldCB0aGUgYml0ZmxpcHMgb2Ygb25lIGJsYW5rIHBh
Z2UuIGkgdGhpbmsgaSBuZWVkIHRoZSBoZWxwZXIuCgo+IAo+IFRoYW5rcywKPiBNaXF1w6hsCj4g
Cj4gLgo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbAo=
