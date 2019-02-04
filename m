Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D698DC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:30:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A929F2083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eoPjRVsa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A929F2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-ID:From:To:Subject:MIME-Version
	:References:In-Reply-To:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iTD+inB9xCg86DbEK8S7EExqpK3itwVBHk1vdWNeMGs=; b=eoPjRVsacjpbW6
	y84EfpkPq9hSxecOvrBiw3fdoOOIJz17YpHVnIsYUg/bbHkpmnLNk8KZIFbmGozmfctfTMCWQpV8Z
	TrMYUd6ng1sxGMXvjTc/lDkikgv7P1k356mLZM9LLxn+ziLyAF7za0eXKMOMedWi6B+01p2ZqTLJ/
	aOtArCa/DUwEGQTc2GHP+Otcip4QGgw81LniDh6Ta8ak4Y2bdC1Tl/ihGXTRx4adGQrQlW7VhhTIk
	v8JGViRye6UzbBQntSptsnqSYz5c+FKz1r87BlGm/jpZGafvc63V2ky7UffKvvItwl99WzVO9tLRn
	csJMtXqZI9DX8tG+gdXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqh8T-0003S6-Kg; Mon, 04 Feb 2019 16:30:17 +0000
Received: from haggis.mythic-beasts.com ([2a00:1098:0:86:1000:0:2:1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqh8P-0003Rk-Cv
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 16:30:15 +0000
Received: from [199.195.250.187] (port=45014 helo=hermes.aosc.io)
 by haggis.mythic-beasts.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.90_1)
 (envelope-from <icenowy@aosc.io>)
 id 1gqh8B-0002D4-M2; Mon, 04 Feb 2019 16:30:04 +0000
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender:
 icenowy@aosc.io)
 by hermes.aosc.io (Postfix) with ESMTPSA id EF0C06A034;
 Mon,  4 Feb 2019 16:29:29 +0000 (UTC)
Date: Tue, 05 Feb 2019 00:28:21 +0800
In-Reply-To: <CA+E=qVfTfJ9E29gz83tdVGx5_KGWSQVJOAxKTzC+-n7=gdj0cA@mail.gmail.com>
References: <20190203185501.8958-1-anarsoul@gmail.com>
 <20190203185501.8958-7-anarsoul@gmail.com>
 <20190204142036.vd42nvyjnjr5yeoi@flea>
 <CA+E=qVfTfJ9E29gz83tdVGx5_KGWSQVJOAxKTzC+-n7=gdj0cA@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH RESEND v2 06/12] drm/sun4i: rgb: Add 1% tolerance to dclk
 frequency check when bridge is connected
To: linux-arm-kernel@lists.infradead.org,
 Vasily Khoruzhick <anarsoul@gmail.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>
From: Icenowy Zheng <icenowy@aosc.io>
Message-ID: <0F6CBEA4-6DB6-40F1-A2FD-65101AF64F1F@aosc.io>
X-BlackCat-Spam-Score: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_083013_438794_0BBE5492 
X-CRM114-Status: GOOD (  17.33  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 Archit Taneja <architt@codeaurora.org>, David Airlie <airlied@linux.ie>,
 Chen-Yu Tsai <wens@csie.org>, dri-devel <dri-devel@lists.freedesktop.org>,
 Andrzej Hajda <a.hajda@samsung.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Rob Herring <robh+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Daniel Vetter <daniel@ffwll.ch>, Sean Paul <seanpaul@chromium.org>,
 arm-linux <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Cgrkuo4gMjAxOeW5tDLmnIg15pelIEdNVCswODowMCDkuIrljYgxMjoyNjo0MywgVmFzaWx5IEto
b3J1emhpY2sgPGFuYXJzb3VsQGdtYWlsLmNvbT4g5YaZ5YiwOgo+T24gTW9uLCBGZWIgNCwgMjAx
OSBhdCA2OjIwIEFNIE1heGltZSBSaXBhcmQKPjxtYXhpbWUucmlwYXJkQGJvb3RsaW4uY29tPiB3
cm90ZToKPj4KPj4gSGksCj4+Cj4+IE9uIFN1biwgRmViIDAzLCAyMDE5IGF0IDEwOjU0OjU1QU0g
LTA4MDAsIFZhc2lseSBLaG9ydXpoaWNrIHdyb3RlOgo+PiA+IENsb2NrIHJhdGUgY2hlY2sgdGhh
dCB3YXMgYWRkZWQgaW4gY29tbWl0IGJiNDNkNDBkN2M4MyAoImRybS9zdW40aToKPnJnYjoKPj4g
PiBWYWxpZGF0ZSB0aGUgY2xvY2sgcmF0ZSIpIHByZXZlbnRzIHNvbWUgcGFuZWwgYW5kIGJyaWRn
ZXMgZnJvbQo+d29ya2luZyB3aXRoCj4+ID4gc3VuNGkgZHJpdmVyLgo+PiA+Cj4+ID4gVW5mb3J0
dW5hdGVseSwgZG90Y2xvY2sgZnJlcXVlbmN5IGZvciBzb21lIG1vZGVzIGFyZSBub3QgYWNoaWV2
YWJsZQo+b24KPj4gPiBzdW54aSBoYXJkd2FyZSwgYW5kIHRoZXJlJ3MgYSBzbGlnaHQgZGV2aWF0
aW9uIGluIHJhdGUgcmV0dXJuZWQgYnkKPj4gPiBjbGtfcm91bmRfcmF0ZSgpLCBzbyB0aGV5IGZh
aWwgdGhpcyBjaGVjay4KPj4gPgo+PiA+IEV4cGVyaW1lbnRzIHNob3cgdGhhdCBwYW5lbHMgYW5k
IGJyaWRnZXMgd29yayBmaW5lIHdpdGggdGhpcyBzbGlnaHQKPj4gPiBkZXZpYXRpb24sIGUuZy4g
UGluZWJvb2sgdGhhdCB1c2VzIEFOWDYzNDUgYnJpZGdlIHdpdGggNzY4cCBlRFAKPnBhbmVsCj4+
ID4gcmVxdWVzdHMgNzMgTUh6LCBnZXRzIDcyLjI5Nk1IeiBpbnN0ZWFkICgwLjk2JSBkaWZmZXJl
bmNlKSBhbmQKPndvcmtzIGp1c3QKPj4gPiBmaW5lLgo+PiA+Cj4+ID4gVGhpcyBwYXRjaCBhZGRz
IGEgMSUgdG9sZXJlbmNlIHRvIHRoZSBkb3QgY2xvY2sgY2hlY2sgd2hlbiBicmlkZ2UKPmlzCj4+
ID4gY29ubmVjdGVkLgo+PiA+Cj4+ID4gU2lnbmVkLW9mZi1ieTogVmFzaWx5IEtob3J1emhpY2sg
PGFuYXJzb3VsQGdtYWlsLmNvbT4KPj4KPj4gSSdtIG5vdCBzdXJlIHdlIHdhbnQgdG8gbWFrZSBl
eGNlcHRpb25zIGZvciBhbGwgdGhlIGhhcmR3YXJlCj4+IGNvbWJpbmF0aW9uIHdlIGZhY2UsIGJ1
dCB3ZSBzaG91bGQgZ28gZm9yIHNvbWV0aGluZyBtb3JlIGdlbmVyaWMgKGFuZAo+PiBlYXNpZXIg
dG8gbWFpbnRhaW4gaW5zdGVhZCkuCj4+Cj4+IElJUkMsIGZyb20gdGhlIHByZXZpb3VzIGRpc2N1
c3Npb24sIEhETUkgaGFkIGEgdG9sZXJhbmN5IHJlcXVpcmVtZW50Cj4+IGluIHRoZSBzdGFuZGFy
ZC4gRG8geW91IGtub3cgaWYgdGhlcmUncyBzdWNoIGEgdGhpbmcgZm9yIGVEUD8gVGhhdAo+PiB3
b3VsZCBzb2x2ZSB0aGUgaXNzdWUgZm9yIGFsbCB0aGUgZURQIGRpc3BsYXlzIGF0IG9uY2UuCj4K
PkkgZG9uJ3QgaGF2ZSBhY2Nlc3MgdG8gZURQIHN0YW5kYXJkIC0gdmVzYS5vcmcgc2F5cyBpdCdz
IGF2YWlsYWJsZSB0bwo+bWVtYmVycyBvbmx5LgoKVHJ5IG91dCB0byBncmFiIGFuIG9sZCB2ZXJz
aW9uPwoKSSByZW1lbWJlciAxLjAgaXMgb3Blbi4KCj4KPj4gTWF4aW1lCj4+Cj4+IC0tCj4+IE1h
eGltZSBSaXBhcmQsIEJvb3RsaW4KPj4gRW1iZWRkZWQgTGludXggYW5kIEtlcm5lbCBlbmdpbmVl
cmluZwo+PiBodHRwczovL2Jvb3RsaW4uY29tCj4KPl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCj5saW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAo+bGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCj5odHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwKCi0tIArkvb/nlKggSy05IE1h
aWwg5Y+R6YCB6Ieq5oiR55qEQW5kcm9pZOiuvuWkh+OAggoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QK
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
