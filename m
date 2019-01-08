Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71BDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:38:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CF5D20827
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Faw2bBtC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF5D20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MTbwk8oHX1R3v61XqJB9dyzVM4mWJ+fC2AvPQ8MNqvs=; b=Faw2bBtCkxiOVN
	BbrRIOhz8CJIrKMxZ1PvpNaWuY8AH7ou213pVxzFG+p3K81cfNwDaMF7aPQtpq/9WIrlPqPNHajxN
	KYqJYkyV/K3L5Q8Bh+Lla5MrbvcmZt8HC7ncsAQDDs4+K9TRbs9Tzpat82JdjHxQq+g54vE/8vM9v
	OgpXMCPuI3FmaUaqoVq53gOAk0l28cKLASdNwjB4B+/z1l4jT2QcnbLdsBX8qxCUD0DwBgrVRXVhh
	gvxKnKkVihzx/MNUhyluewf6TVCdp1GGc9TDyAmGf+qSib8FWe7OxdCV/eMlqOm8+FkSRBFrWyGHa
	ap1WCrIWEOlryLoG4RKQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggvKq-0006d1-Qr; Tue, 08 Jan 2019 17:38:40 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggvKl-0006bZ-Rs; Tue, 08 Jan 2019 17:38:38 +0000
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32]
 helo=diego.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1ggvKd-0001RJ-RZ; Tue, 08 Jan 2019 18:38:27 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH 1/4] phy: rockchip-inno-usb2: fix misspelling and
 kernel-doc documentation.
Date: Tue, 08 Jan 2019 18:38:26 +0100
Message-ID: <35160832.xjWYcIOf1W@diego>
In-Reply-To: <CAFqH_50tz1Toi6L1Ju5imyMRPzN1bDg7mxzcLrJWvdxOwknfdw@mail.gmail.com>
References: <20180815095934.11205-1-enric.balletbo@collabora.com>
 <2908229.jFki8unlfB@phil>
 <CAFqH_50tz1Toi6L1Ju5imyMRPzN1bDg7mxzcLrJWvdxOwknfdw@mail.gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_093836_049489_D6183368 
X-CRM114-Status: GOOD (  16.30  )
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
Cc: kernel@collabora.com, Alexandru Stan <amstan@chromium.org>,
 Guenter Roeck <groeck@google.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 kieran.bingham@ideasonboard.com,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Kishon Vijay Abraham I <kishon@ti.com>, Benson Leung <bleung@chromium.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgRW5yaWMsCgpBbSBEaWVuc3RhZywgOC4gSmFudWFyIDIwMTksIDE4OjM1OjM4IENFVCBzY2hy
aWViIEVucmljIEJhbGxldGJvIFNlcnJhOgo+IEhpIEhlaWtvIGFuZCBhbGwsCj4gCj4gTWlzc2F0
Z2UgZGUgSGVpa28gU3R1ZWJuZXIgPGhlaWtvQHNudGVjaC5kZT4gZGVsIGRpYSBkYy4sIDE1IGTi
gJlhZy4KPiAKPiAyMDE4IGEgbGVzIDEyOjMxOgo+ID4gQW0gTWl0dHdvY2gsIDE1LiBBdWd1c3Qg
MjAxOCwgMTE6NTk6MzEgQ0VTVCBzY2hyaWViIEVucmljIEJhbGxldGJvIGkgClNlcnJhOgo+ID4g
PiBGaXggdGhlIHR5cG8gZmxhc2UgLT4gZmFsc2UgYW5kIGNsZWFuIHVwIHRoZSBrZXJuZWwtZG9j
IGRvY3VtZW50YXRpb24gaW4KPiA+ID4gcGh5LXJvY2tjaGlwLWlubm8udXNiMi5jIGFuZCBmaXgg
dGhlIGZvbGxvd2luZyB3YXJuaW5ncyB3aGVuCj4gPiA+IGRvY3VtZW50YXRpb24KPiA+ID4gaXMg
YnVpbHQuCj4gPiA+IAo+ID4gPiAgIDo1ODogd2FybmluZzogbWlzc2luZyBpbml0aWFsIHNob3J0
IGRlc2NyaXB0aW9uCj4gPiA+ICAgOjY5OiB3YXJuaW5nOiBjYW5ub3QgdW5kZXJzdGFuZCBmdW5j
dGlvbiBwcm90b3R5cGU6ICdlbnVtCj4gPiA+ICAgOnVzYl9jaGdfc3RhdGUgJwo+ID4gPiAgIDo5
Nzogd2FybmluZzogbWlzc2luZyBpbml0aWFsIHNob3J0IGRlc2NyaXB0aW9uCj4gPiA+ICAgOjEz
Njogd2FybmluZzogY2Fubm90IHVuZGVyc3RhbmQgZnVuY3Rpb24gcHJvdG90eXBlOiAnc3RydWN0
Cj4gPiA+ICAgOnJvY2tjaGlwX3VzYjJwaHlfcG9ydF9jZmcgJyAxNTc6IHdhcm5pbmc6IGNhbm5v
dCB1bmRlcnN0YW5kIGZ1bmN0aW9uCj4gPiA+ICAgOnByb3RvdHlwZTogJ3N0cnVjdCByb2NrY2hp
cF91c2IycGh5X2NmZyAnIDE2Mzogd2FybmluZzogRnVuY3Rpb24KPiA+ID4gICA6cGFyYW1ldGVy
IG9yIG1lbWJlciAncG9ydF9jZmdzJyBub3QgZGVzY3JpYmVkIGluCj4gPiA+ICAgOidyb2NrY2hp
cF91c2IycGh5X2NmZycgMTg3OiB3YXJuaW5nOiBjYW5ub3QgdW5kZXJzdGFuZCBmdW5jdGlvbgo+
ID4gPiAgIDpwcm90b3R5cGU6ICdzdHJ1Y3Qgcm9ja2NoaXBfdXNiMnBoeV9wb3J0ICcgMjA0OiB3
YXJuaW5nOiBGdW5jdGlvbgo+ID4gPiAgIDpwYXJhbWV0ZXIgb3IgbWVtYmVyICdwb3J0X2NmZycg
bm90IGRlc2NyaWJlZCBpbgo+ID4gPiAgIDoncm9ja2NoaXBfdXNiMnBoeV9wb3J0JyAyMDc6IHdh
cm5pbmc6IG1pc3NpbmcgaW5pdGlhbCBzaG9ydAo+ID4gPiAgIDpkZXNjcmlwdGlvbgo+ID4gPiAg
IDoyMzQ6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ2Rldicgbm90IGRl
c2NyaWJlZCBpbgo+ID4gPiAgIDoncm9ja2NoaXBfdXNiMnBoeScgMjM0OiB3YXJuaW5nOiBGdW5j
dGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyCj4gPiA+ICAgOidjbGs0ODBtX2h3JyBub3QgZGVzY3Jp
YmVkIGluICdyb2NrY2hpcF91c2IycGh5Jz4gPiAKPiA+ID4gU2lnbmVkLW9mZi1ieTogRW5yaWMg
QmFsbGV0Ym8gaSBTZXJyYSA8ZW5yaWMuYmFsbGV0Ym9AY29sbGFib3JhLmNvbT4KPiA+IAo+ID4g
UmV2aWV3ZWQtYnk6IEhlaWtvIFN0dWVibmVyIDxoZWlrb0BzbnRlY2guZGU+Cj4gCj4gSSBpbmNs
dWRlZCB0aGlzIHBhdGNoIGluIHRoZXNlIHNlcmllcyBiZWNhdXNlIEkgZm91bmQgdGhlIGVycm9y
cyB3aGVuCj4gSSB3YXMgd29ya2luZyBvbiB0aGlzLiBCdXQgdGhpcyBwYXRjaCBkb2Vzbid0IHJl
YWxseSBkZXBlbmQgb24gdGhlCj4gb3RoZXIgcGF0Y2hlcyBhbmQgcHJvYmFibHkgSSBzaG91bGQg
aGF2ZSBoYWQgdG8gc2VuZCBpbmRlcGVuZGVudGx5LiBJCj4gYW0gcGxhbm5pbmcgdG8gc2VuZCBh
IG5ldyB2ZXJzaW9uIG9mIHRoZXNlIHNlcmllcyBleGNsdWRpbmcgdGhpcwo+IHBhdGNoLiBJIHRo
aW5rIHRoYXQgdGhlIHBhdGNoIGNhbiBiZSBhbHJlYWR5IHBpY2tlZCAoc3RpbGwgYXBwbGllcwo+
IGNsZWFubHkgYW5kIGlzIGZpbmUgdG8gcGljaz8pIG9yIGRvIHlvdSBwcmVmZXIgSSByZXNlbmQ/
CgpJIHdvdWxkIHJlc2VuZCBpdC4KClRoZSBwYXRjaCBpcyBmcm9tIGF1Z3VzdCAyMDE4LCBzbyBJ
J2QgZ3Vlc3MgS2lzaG9uIHdvbid0IGhhdmUgaXQgaW4gaGlzCmluYm94IGFueW1vcmUsIHNvIGEg
cmVzZW5kIG1heSBiZSBlYXNpZXIgZm9yIGV2ZXJ5b25lLgoKCkhlaWtvCgoKCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1h
aWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
