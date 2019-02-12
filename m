Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F610C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:41:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13380222C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WVuLtUTd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICqcvFON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13380222C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SZ1m9r5TNGbqd4k1VjiAQP2uR9DlmXFMEzECDapn46Y=; b=WVuLtUTdV/Arly
	eORuurFVznu8d+kxi6mcBn5Mfi/1SYCt9VVcBcWzoif/Hs83vCBpXGpy7KxIgTbFh7DUoYr6JHSRD
	HQf8jdP0L4YXF8sioBuEyRLDgt7rxHKoddz2gC7wd04K5nx0waarEzEv9AvQ2bYstwcMZidFMPvrc
	an78GwzOSLAmbe+q3yHiCWhVgcRjznhZB4/gH2IX6Un+57UztxHqwfWOPl6LhdL9/Qz47SpGZu6ib
	I9W/kv/obmIXGg4RNH1bsvsSBhzBjsRFqUPFohWDWV4GAvuUg6Lh+canXR5jTbh+MO2R875RAkC3M
	aJK6x04RpXAPlptjK9Pg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtc3N-0007tA-O8; Tue, 12 Feb 2019 17:41:05 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtc3J-0007sg-Mz
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 17:41:03 +0000
Received: by mail-wr1-x444.google.com with SMTP id f14so3703932wrg.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 09:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YnLvRw9RaPoLOPBbxQEcuTU7gQILlzbwqlFbkMK1C88=;
 b=ICqcvFONieXI2ZLIoXDHhIcT3PG9fvgk4FuDKh3u/SksAtBFPX9XMjtpf+6hErRVzY
 5VOW6jU7ZnNH3Lty8qx2/u+r1iKkq4Y0PT56K3A/nbGsgWMofURHRc5roA3DHR2mn78E
 tTiUXFCd4swRe6UGgEQgFiBBc77ALFbjEmw7TrrtqOm4R3fQcj5nCBAMlcdXEU6Gh/A7
 T306LxUQKJ2zk7CvcBwyvhXip9mBXYQcFL1K50KVsdJpsOUrEKAsovy08crLSUopNtOO
 F/DSwDyk6KG0GneMZ9+UcgeonlvdULlIR5HT/fu8biHan1u6qkJzKLPLQ13WdpHyuOqC
 eH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YnLvRw9RaPoLOPBbxQEcuTU7gQILlzbwqlFbkMK1C88=;
 b=eqKQKBKjRa5bKpyqqAzS4IaflxX22eDpZVIZFcBLaAnM/kV0P3QEsTV23FANcEAiEJ
 U11rab9ddwany7o/9mmFEb3m/R8myYyCi+w1i9A/42xcJcBrRKaCyiyhDRstSnvMQ8gQ
 Hr3vQ3vLalnQ2Mc6geGtXt17xRDwSVku95T9RjhSytNGGXHhFK/Qm6RsfM+k1dCIPBNI
 sagiXaiwlaE5mSKnZzbx8eEt3LVWKul+tT6QznPp0C6rwvL2pWJTFcNm/6Go+ADZz9Ex
 qggLrOYJCxihOS0zG/S3H2Gs9xtYze8YOwqh32cqQBP/J6gUat9KzJMNxCGfhepZHs9D
 gBcQ==
X-Gm-Message-State: AHQUAuaFAzWj/C9cPYE4rA+lwWt7fUVJ24BiuJVXKPlX+DPq2nF9WjBb
 J1UJe0FOuDhTIhkMwbxXYjI=
X-Google-Smtp-Source: AHgI3IbemB+UWRIpSc6wfWKk7HsFQ0oBbyp61ZnT0K5v6cbCYLYTTROj5FmV7J5NYQoBP0BtI0Avfw==
X-Received: by 2002:adf:ba8d:: with SMTP id p13mr3977217wrg.53.1549993259789; 
 Tue, 12 Feb 2019 09:40:59 -0800 (PST)
Received: from jernej-laptop.localnet (APN-123-243-40-gprs.simobil.net.
 [46.123.243.40])
 by smtp.gmail.com with ESMTPSA id n3sm3578193wmf.46.2019.02.12.09.40.56
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 12 Feb 2019 09:40:58 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v3 2/2] media: cedrus: Add H264 decoding support
Date: Tue, 12 Feb 2019 18:40:56 +0100
Message-ID: <3363003.VFAkYA4tHV@jernej-laptop>
In-Reply-To: <20190212124713.cqms5jofw433nx6m@flea>
References: <cover.d3bb4d93da91ed5668025354ee1fca656e7d5b8b.1549895062.git-series.maxime.ripard@bootlin.com>
 <5a31f5596c04390d76bf34fdb8b71b6a96306943.camel@collabora.com>
 <20190212124713.cqms5jofw433nx6m@flea>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_094101_777750_286A15E3 
X-CRM114-Status: GOOD (  16.13  )
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
 linux-kernel@vger.kernel.org, tfiga@chromium.org,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, hans.verkuil@cisco.com,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 sakari.ailus@linux.intel.com, nicolas.dufresne@collabora.com,
 Ezequiel Garcia <ezequiel@collabora.com>, posciak@chromium.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RG5lIHRvcmVrLCAxMi4gZmVicnVhciAyMDE5IG9iIDEzOjQ3OjEzIENFVCBqZSBNYXhpbWUgUmlw
YXJkIG5hcGlzYWwoYSk6Cj4gT24gTW9uLCBGZWIgMTEsIDIwMTkgYXQgMDQ6NDg6MTdQTSAtMDMw
MCwgRXplcXVpZWwgR2FyY2lhIHdyb3RlOgo+ID4gT24gTW9uLCAyMDE5LTAyLTExIGF0IDE1OjM5
ICswMTAwLCBNYXhpbWUgUmlwYXJkIHdyb3RlOgo+ID4gPiBJbnRyb2R1Y2Ugc29tZSBiYXNpYyBI
MjY0IGRlY29kaW5nIHN1cHBvcnQgaW4gY2VkcnVzLiBTbyBmYXIsIG9ubHkgdGhlCj4gPiA+IGJh
c2VsaW5lIHByb2ZpbGUgdmlkZW9zIGhhdmUgYmVlbiB0ZXN0ZWQsIGFuZCBzb21lIG1vcmUgYWR2
YW5jZWQKPiA+ID4gZmVhdHVyZXMKPiA+ID4gdXNlZCBpbiBoaWdoZXIgcHJvZmlsZXMgYXJlIG5v
dCBldmVuIGltcGxlbWVudGVkLgo+ID4gPiAKPiA+ID4gU2lnbmVkLW9mZi1ieTogTWF4aW1lIFJp
cGFyZCA8bWF4aW1lLnJpcGFyZEBib290bGluLmNvbT4KPiA+IAo+ID4gWy4uXQo+ID4gCj4gPiA+
ICtzdGF0aWMgdm9pZCBfY2VkcnVzX3dyaXRlX3JlZl9saXN0KHN0cnVjdCBjZWRydXNfY3R4ICpj
dHgsCj4gPiA+ICsJCQkJICAgc3RydWN0IGNlZHJ1c19ydW4gKnJ1biwKPiA+ID4gKwkJCQkgICBj
b25zdCB1OCAqcmVmX2xpc3QsIHU4IApudW1fcmVmLAo+ID4gPiArCQkJCSAgIGVudW0gY2VkcnVz
X2gyNjRfc3JhbV9vZmYgc3JhbSkKPiA+ID4gK3sKPiA+ID4gKwljb25zdCBzdHJ1Y3QgdjRsMl9j
dHJsX2gyNjRfZGVjb2RlX3BhcmFtICpkZWNvZGUgPQo+ID4gPiBydW4tPmgyNjQuZGVjb2RlX3Bh
cmFtOyArCXN0cnVjdCB2YjJfcXVldWUgKmNhcF9xID0KPiA+ID4gJmN0eC0+ZmgubTJtX2N0eC0+
Y2FwX3FfY3R4LnE7Cj4gPiA+ICsJY29uc3Qgc3RydWN0IHZiMl9idWZmZXIgKmRzdF9idWYgPSAm
cnVuLT5kc3QtPnZiMl9idWY7Cj4gPiA+ICsJc3RydWN0IGNlZHJ1c19kZXYgKmRldiA9IGN0eC0+
ZGV2Owo+ID4gPiArCXU4IHNyYW1fYXJyYXlbQ0VEUlVTX01BWF9SRUZfSURYXTsKPiA+ID4gKwl1
bnNpZ25lZCBpbnQgc2l6ZSwgaTsKPiA+ID4gKwo+ID4gPiArCW1lbXNldChzcmFtX2FycmF5LCAw
LCBzaXplb2Yoc3JhbV9hcnJheSkpOwo+ID4gPiArCj4gPiA+ICsJZm9yIChpID0gMDsgaSA8IG51
bV9yZWY7IGkrKykgewo+ID4gPiArCQljb25zdCBzdHJ1Y3QgdjRsMl9oMjY0X2RwYl9lbnRyeSAq
ZHBiOwo+ID4gPiArCQljb25zdCBzdHJ1Y3QgY2VkcnVzX2J1ZmZlciAqY2VkcnVzX2J1ZjsKPiA+
ID4gKwkJY29uc3Qgc3RydWN0IHZiMl92NGwyX2J1ZmZlciAqcmVmX2J1ZjsKPiA+ID4gKwkJdW5z
aWduZWQgaW50IHBvc2l0aW9uOwo+ID4gPiArCQlpbnQgYnVmX2lkeDsKPiA+ID4gKwkJdTggZHBi
X2lkeDsKPiA+ID4gKwo+ID4gPiArCQlkcGJfaWR4ID0gcmVmX2xpc3RbaV07Cj4gPiA+ICsJCWRw
YiA9ICZkZWNvZGUtPmRwYltkcGJfaWR4XTsKPiA+ID4gKwo+ID4gPiArCQlpZiAoIShkcGItPmZs
YWdzICYgVjRMMl9IMjY0X0RQQl9FTlRSWV9GTEFHX0FDVElWRSkpCj4gPiA+ICsJCQljb250aW51
ZTsKPiA+ID4gKwo+ID4gPiArCQlpZiAoZHN0X2J1Zi0+dGltZXN0YW1wID09IGRwYi0+dGltZXN0
YW1wKQo+ID4gPiArCQkJYnVmX2lkeCA9IGRzdF9idWYtPmluZGV4Owo+ID4gPiArCQllbHNlCj4g
PiA+ICsJCQlidWZfaWR4ID0gdmIyX2ZpbmRfdGltZXN0YW1wKGNhcF9xLCBkcGItCj50aW1lc3Rh
bXAsIDApOwo+ID4gPiArCj4gPiA+ICsJCWlmIChidWZfaWR4IDwgMCkKPiA+ID4gKwkJCWNvbnRp
bnVlOwo+ID4gPiArCj4gPiA+ICsJCXJlZl9idWYgPSB0b192YjJfdjRsMl9idWZmZXIoY3R4LT5k
c3RfYnVmc1tidWZfaWR4XSk7Cj4gPiA+ICsJCWNlZHJ1c19idWYgPSB2YjJfdjRsMl90b19jZWRy
dXNfYnVmZmVyKHJlZl9idWYpOwo+ID4gPiArCQlwb3NpdGlvbiA9IGNlZHJ1c19idWYtPmNvZGVj
LmgyNjQucG9zaXRpb247Cj4gPiA+ICsKPiA+ID4gKwkJc3JhbV9hcnJheVtpXSB8PSBwb3NpdGlv
biA8PCAxOwo+ID4gPiArCQlpZiAocmVmX2J1Zi0+ZmllbGQgPT0gVjRMMl9GSUVMRF9CT1RUT00p
Cj4gPiA+ICsJCQlzcmFtX2FycmF5W2ldIHw9IEJJVCgwKTsKPiA+ID4gKwl9Cj4gPiA+ICsKPiA+
ID4gKwlzaXplID0gbWluKCh1bnNpZ25lZCBpbnQpQUxJR04obnVtX3JlZiwgNCksIHNpemVvZihz
cmFtX2FycmF5KSk7Cj4gPiAKPiA+IFBlcmhhcHMgcy91bnNpZ25lZCBpbnQvc2l6ZV90LCBzbyB0
aGUgYXJndW1lbnRzIHRvIG1pbigpIGhhdmUgdGhlIHNhbWUKPiA+IHR5cGU/Cj4gPiAKPiA+IE90
aGVyd2lzZSwgSSBnb3QgdGhpcyB3YXJuaW5nOgo+ID4gCj4gPiAvaG9tZS96ZXRhL3JlcG9zL2xp
bnV4L21lZGlhX3RyZWUvZHJpdmVycy9zdGFnaW5nL21lZGlhL3N1bnhpL2NlZHJ1cy9jZWRydQo+
ID4gc19oMjY0LmM6IEluIGZ1bmN0aW9uIOKAmF9jZWRydXNfd3JpdGVfcmVmX2xpc3TigJk6Cj4g
PiAvaG9tZS96ZXRhL3JlcG9zL2xpbnV4L21lZGlhX3RyZWUvaW5jbHVkZS9saW51eC9rZXJuZWwu
aDo4NDY6Mjk6IHdhcm5pbmc6Cj4gPiBjb21wYXJpc29uIG9mIGRpc3RpbmN0IHBvaW50ZXIgdHlw
ZXMgbGFja3MgYSBjYXN0PiAKPiA+ICAgICghIShzaXplb2YoKHR5cGVvZih4KSAqKTEgPT0gKHR5
cGVvZih5KSAqKTEpKSkKPiAKPiBTdHJhbmdlLCBJIGRpZG4ndCBub3RpY2UgYW55IHdhcm5pbmcu
IEknbGwgbWFrZSBzdXJlIHRvIGZpeCBpdC4KCkkgZ3Vlc3MgdGhpcyBpcyBvbmUgb2YgdGhvc2Ug
d2FybmluZ3Mgd2hpY2ggcG9wcyBvdXQgb25seSBvbiA2NC1iaXQgcGxhdGZvcm1zLgoKQmVzdCBy
ZWdhcmRzLApKZXJuZWoKCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
