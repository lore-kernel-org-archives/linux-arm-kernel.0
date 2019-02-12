Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1152C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:47:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F94D20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O53RSrJ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F94D20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aLv2cF/winOPs7HgU6RQXFlDPy7el0Eop+3wjXxoulI=; b=O53RSrJ3QEllbZ
	hNMUNwzXDwmo1fCYfPbFcpsiaI6I9zIXO9K64l1wbUoTtJ5HdQggd5FnKTzsRy7HCseqzsygvT47v
	FMhzT229U6guTXHPSDX5E2IRR71rZuXW/inRAst5ao2UEFaYoFXGW/AT8TDVM79MFNB/C9yp9znMX
	Ej+BxtgyiXrD1EI0bafpl81exJ/BMB/VnSUwqbaD6AhGtpBNeSkchlhHKP28Ss9M+iaMAfvytieMX
	S77o/Cp9sC5TZr9v5shGZoVpqV5o3T5CzUp33OmX2ncY8MUq4BSOCvDZ5JFWcEOtM0uh1b1yV1/Ce
	gQMnDnrvTAbsFdjAkIrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtXTD-0004rD-8f; Tue, 12 Feb 2019 12:47:27 +0000
Received: from relay10.mail.gandi.net ([217.70.178.230])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtXT8-0004qR-RP
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 12:47:25 +0000
Received: from localhost (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr
 [90.88.30.68]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay10.mail.gandi.net (Postfix) with ESMTPSA id B38EE24000D;
 Tue, 12 Feb 2019 12:47:13 +0000 (UTC)
Date: Tue, 12 Feb 2019 13:47:13 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Ezequiel Garcia <ezequiel@collabora.com>
Subject: Re: [PATCH v3 2/2] media: cedrus: Add H264 decoding support
Message-ID: <20190212124713.cqms5jofw433nx6m@flea>
References: <cover.d3bb4d93da91ed5668025354ee1fca656e7d5b8b.1549895062.git-series.maxime.ripard@bootlin.com>
 <4c00e1ab1e70adb1d94db59c37393250ca3791c5.1549895062.git-series.maxime.ripard@bootlin.com>
 <5a31f5596c04390d76bf34fdb8b71b6a96306943.camel@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5a31f5596c04390d76bf34fdb8b71b6a96306943.camel@collabora.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_044723_186140_6C557313 
X-CRM114-Status: GOOD (  12.47  )
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
Cc: linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, acourbot@chromium.org,
 jonas@kwiboo.se, jenskuske@gmail.com, linux-sunxi@googlegroups.com,
 linux-kernel@vger.kernel.org, jernej.skrabec@gmail.com, tfiga@chromium.org,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, hans.verkuil@cisco.com,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 sakari.ailus@linux.intel.com, nicolas.dufresne@collabora.com,
 posciak@chromium.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBGZWIgMTEsIDIwMTkgYXQgMDQ6NDg6MTdQTSAtMDMwMCwgRXplcXVpZWwgR2FyY2lh
IHdyb3RlOgo+IE9uIE1vbiwgMjAxOS0wMi0xMSBhdCAxNTozOSArMDEwMCwgTWF4aW1lIFJpcGFy
ZCB3cm90ZToKPiA+IEludHJvZHVjZSBzb21lIGJhc2ljIEgyNjQgZGVjb2Rpbmcgc3VwcG9ydCBp
biBjZWRydXMuIFNvIGZhciwgb25seSB0aGUKPiA+IGJhc2VsaW5lIHByb2ZpbGUgdmlkZW9zIGhh
dmUgYmVlbiB0ZXN0ZWQsIGFuZCBzb21lIG1vcmUgYWR2YW5jZWQgZmVhdHVyZXMKPiA+IHVzZWQg
aW4gaGlnaGVyIHByb2ZpbGVzIGFyZSBub3QgZXZlbiBpbXBsZW1lbnRlZC4KPiA+IAo+ID4gU2ln
bmVkLW9mZi1ieTogTWF4aW1lIFJpcGFyZCA8bWF4aW1lLnJpcGFyZEBib290bGluLmNvbT4KPiBb
Li5dCj4gCj4gCj4gPiArc3RhdGljIHZvaWQgX2NlZHJ1c193cml0ZV9yZWZfbGlzdChzdHJ1Y3Qg
Y2VkcnVzX2N0eCAqY3R4LAo+ID4gKwkJCQkgICBzdHJ1Y3QgY2VkcnVzX3J1biAqcnVuLAo+ID4g
KwkJCQkgICBjb25zdCB1OCAqcmVmX2xpc3QsIHU4IG51bV9yZWYsCj4gPiArCQkJCSAgIGVudW0g
Y2VkcnVzX2gyNjRfc3JhbV9vZmYgc3JhbSkKPiA+ICt7Cj4gPiArCWNvbnN0IHN0cnVjdCB2NGwy
X2N0cmxfaDI2NF9kZWNvZGVfcGFyYW0gKmRlY29kZSA9IHJ1bi0+aDI2NC5kZWNvZGVfcGFyYW07
Cj4gPiArCXN0cnVjdCB2YjJfcXVldWUgKmNhcF9xID0gJmN0eC0+ZmgubTJtX2N0eC0+Y2FwX3Ff
Y3R4LnE7Cj4gPiArCWNvbnN0IHN0cnVjdCB2YjJfYnVmZmVyICpkc3RfYnVmID0gJnJ1bi0+ZHN0
LT52YjJfYnVmOwo+ID4gKwlzdHJ1Y3QgY2VkcnVzX2RldiAqZGV2ID0gY3R4LT5kZXY7Cj4gPiAr
CXU4IHNyYW1fYXJyYXlbQ0VEUlVTX01BWF9SRUZfSURYXTsKPiA+ICsJdW5zaWduZWQgaW50IHNp
emUsIGk7Cj4gPiArCj4gPiArCW1lbXNldChzcmFtX2FycmF5LCAwLCBzaXplb2Yoc3JhbV9hcnJh
eSkpOwo+ID4gKwo+ID4gKwlmb3IgKGkgPSAwOyBpIDwgbnVtX3JlZjsgaSsrKSB7Cj4gPiArCQlj
b25zdCBzdHJ1Y3QgdjRsMl9oMjY0X2RwYl9lbnRyeSAqZHBiOwo+ID4gKwkJY29uc3Qgc3RydWN0
IGNlZHJ1c19idWZmZXIgKmNlZHJ1c19idWY7Cj4gPiArCQljb25zdCBzdHJ1Y3QgdmIyX3Y0bDJf
YnVmZmVyICpyZWZfYnVmOwo+ID4gKwkJdW5zaWduZWQgaW50IHBvc2l0aW9uOwo+ID4gKwkJaW50
IGJ1Zl9pZHg7Cj4gPiArCQl1OCBkcGJfaWR4Owo+ID4gKwo+ID4gKwkJZHBiX2lkeCA9IHJlZl9s
aXN0W2ldOwo+ID4gKwkJZHBiID0gJmRlY29kZS0+ZHBiW2RwYl9pZHhdOwo+ID4gKwo+ID4gKwkJ
aWYgKCEoZHBiLT5mbGFncyAmIFY0TDJfSDI2NF9EUEJfRU5UUllfRkxBR19BQ1RJVkUpKQo+ID4g
KwkJCWNvbnRpbnVlOwo+ID4gKwo+ID4gKwkJaWYgKGRzdF9idWYtPnRpbWVzdGFtcCA9PSBkcGIt
PnRpbWVzdGFtcCkKPiA+ICsJCQlidWZfaWR4ID0gZHN0X2J1Zi0+aW5kZXg7Cj4gPiArCQllbHNl
Cj4gPiArCQkJYnVmX2lkeCA9IHZiMl9maW5kX3RpbWVzdGFtcChjYXBfcSwgZHBiLT50aW1lc3Rh
bXAsIDApOwo+ID4gKwo+ID4gKwkJaWYgKGJ1Zl9pZHggPCAwKQo+ID4gKwkJCWNvbnRpbnVlOwo+
ID4gKwo+ID4gKwkJcmVmX2J1ZiA9IHRvX3ZiMl92NGwyX2J1ZmZlcihjdHgtPmRzdF9idWZzW2J1
Zl9pZHhdKTsKPiA+ICsJCWNlZHJ1c19idWYgPSB2YjJfdjRsMl90b19jZWRydXNfYnVmZmVyKHJl
Zl9idWYpOwo+ID4gKwkJcG9zaXRpb24gPSBjZWRydXNfYnVmLT5jb2RlYy5oMjY0LnBvc2l0aW9u
Owo+ID4gKwo+ID4gKwkJc3JhbV9hcnJheVtpXSB8PSBwb3NpdGlvbiA8PCAxOwo+ID4gKwkJaWYg
KHJlZl9idWYtPmZpZWxkID09IFY0TDJfRklFTERfQk9UVE9NKQo+ID4gKwkJCXNyYW1fYXJyYXlb
aV0gfD0gQklUKDApOwo+ID4gKwl9Cj4gPiArCj4gPiArCXNpemUgPSBtaW4oKHVuc2lnbmVkIGlu
dClBTElHTihudW1fcmVmLCA0KSwgc2l6ZW9mKHNyYW1fYXJyYXkpKTsKPiAKPiBQZXJoYXBzIHMv
dW5zaWduZWQgaW50L3NpemVfdCwgc28gdGhlIGFyZ3VtZW50cyB0byBtaW4oKSBoYXZlIHRoZSBz
YW1lIHR5cGU/Cj4gCj4gT3RoZXJ3aXNlLCBJIGdvdCB0aGlzIHdhcm5pbmc6Cj4gCj4gL2hvbWUv
emV0YS9yZXBvcy9saW51eC9tZWRpYV90cmVlL2RyaXZlcnMvc3RhZ2luZy9tZWRpYS9zdW54aS9j
ZWRydXMvY2VkcnVzX2gyNjQuYzogSW4gZnVuY3Rpb24g4oCYX2NlZHJ1c193cml0ZV9yZWZfbGlz
dOKAmToKPiAvaG9tZS96ZXRhL3JlcG9zL2xpbnV4L21lZGlhX3RyZWUvaW5jbHVkZS9saW51eC9r
ZXJuZWwuaDo4NDY6Mjk6IHdhcm5pbmc6IGNvbXBhcmlzb24gb2YgZGlzdGluY3QgcG9pbnRlciB0
eXBlcyBsYWNrcyBhIGNhc3QKPiAgICAoISEoc2l6ZW9mKCh0eXBlb2YoeCkgKikxID09ICh0eXBl
b2YoeSkgKikxKSkpCgpTdHJhbmdlLCBJIGRpZG4ndCBub3RpY2UgYW55IHdhcm5pbmcuIEknbGwg
bWFrZSBzdXJlIHRvIGZpeCBpdC4KClRoYW5rcyEKTWF4aW1lCgotLSAKTWF4aW1lIFJpcGFyZCwg
Qm9vdGxpbgpFbWJlZGRlZCBMaW51eCBhbmQgS2VybmVsIGVuZ2luZWVyaW5nCmh0dHBzOi8vYm9v
dGxpbi5jb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LWFybS1rZXJuZWwK
