Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F277BC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:58:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF42F20645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jGijnC6z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhVCMlUu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF42F20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NQc+EPfZQ/PyXx0yN3LlJHsLADd3mkN4nCuHhEDhmDE=; b=jGijnC6z973P/Y
	/tWS23qtKarfrcR+P3lkAIfcxbWMVsD2QJjT1TDt3fSSky6JIF+gyTvbwBqjLaB4kOfqGKAho+0Bg
	WIIFkUpIlDtmHdEgyKxfoKMGJwl6JY+VDqLgvEoISwhSftYgGLBYgmX3k1pBYzFzL2erXWTM+jkDF
	XHCO0v2lfalN/vpbx8x2xEppwzdISk4iSggHVR2EOIgQ/MSrxOg/bJXqn3qEf9Pa6OYJb2UfjR3RJ
	hWpJfUTxrUQ45oY72ZrLJA3YjJiV4s5r8VBHNMg0G/3aOXvXCkIPnNetSTxkX/3Oy8GVVSnQY5ump
	GHk0WbvfPXpvpHYqzO8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSn3p-0004ue-9r; Fri, 30 Nov 2018 17:58:41 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSn29-0003kj-AQ
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 17:57:12 +0000
Received: by mail-wr1-x441.google.com with SMTP id q18so6116150wrx.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 09:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nJwlbZ5/IVbG7qJZyxGIp6mcgd52AsxLmPe3hosBGK8=;
 b=GhVCMlUuTVQvnwqHK2dl2lgPFzulkLtGYY/7IRdEvh7LDzunHNe8w9JzG+Z7Vfl4nu
 qS7Ae3q3KgMKsAP2nKyMnREuilIq7q4A25mCMr9+XMVp7LyJwSyzMq8MDQifDsqLEcjB
 fc6+yjOLoK+xN6m4Ou2VKVsboE7vz6g20srjeH5RHd6BByyZrUvgEmzQP6/i1k+SvvYv
 Vjv/rJwdC9ovtc5b4nl3VKcjaNEodwJQFiU4k5q+r/FXifudbrTgkhZ69QONAwGUN2kW
 +vGySR5uduoWzgaH4ZpBMQAMd6QCBbf5yVN1jbxSBbeTgg0LBC1eHcuwzOogrNW6VwXs
 dsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nJwlbZ5/IVbG7qJZyxGIp6mcgd52AsxLmPe3hosBGK8=;
 b=b+/rmqO92g7JBWFAIn4VFWWWvIIgSM/4c5a29DAAJMRuwEd/aUCKWKYCTKleGNFQ8a
 JbMTVVg+iS7F9NFKPT8/3hpvlMk1mFDRriZ8QXGn1TkjsC4Afwy4WALt4Zm13nCnhsLg
 /jOGAANV3LoklpV2JMKSYkpbFi2uhVUoVp5ZoNzvnKqgmWwd9u2NgMm6nG55nFcF1spW
 RZCNRtU66W76/FWWYbQAX5D2Vv/nL1j3adEnu+FhrXHdOuaGjTfOwK4zvtmtH+C1XwOx
 KAGJSGEdCndxypPe2gKtm7ky2M/snQRjgJptWOcPamaYzzBvPOid1K4us9VTlqMoojmR
 j8wg==
X-Gm-Message-State: AA+aEWYZIo/92xYWfsVS004GOXvUBi0bBw0b56EZYPG2wQbbaEV2cnac
 q9R9MohcXwGRuq5lJCoul4E=
X-Google-Smtp-Source: AFSGD/Xga8woUe0LMkNNov4HI35xPEH+122K6osDQvasw8KOhuOMZdSRm/FG+/hBIrf2gsh1xKMCzA==
X-Received: by 2002:adf:dfd1:: with SMTP id q17mr6053904wrn.27.1543600604979; 
 Fri, 30 Nov 2018 09:56:44 -0800 (PST)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net.
 [89.212.178.211])
 by smtp.gmail.com with ESMTPSA id s66sm5890057wmf.34.2018.11.30.09.56.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 09:56:43 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: linux-sunxi@googlegroups.com, maxime.ripard@bootlin.com
Subject: Re: [linux-sunxi] [PATCH v2 2/2] media: cedrus: Add H264 decoding
 support
Date: Fri, 30 Nov 2018 18:56:41 +0100
Message-ID: <2869850.yJDP4l804T@jernej-laptop>
In-Reply-To: <20181130073047.auafqe3rzdqfs32d@flea>
References: <20181115145650.9827-1-maxime.ripard@bootlin.com>
 <6005903.5qHflpuMbl@jernej-laptop> <20181130073047.auafqe3rzdqfs32d@flea>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_095658_189917_F5FE433D 
X-CRM114-Status: GOOD (  25.25  )
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
 jenskuske@gmail.com, linux-kernel@vger.kernel.org, tfiga@chromium.org,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, hans.verkuil@cisco.com,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 sakari.ailus@linux.intel.com, nicolas.dufresne@collabora.com,
 posciak@chromium.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RG5lIHBldGVrLCAzMC4gbm92ZW1iZXIgMjAxOCBvYiAwODozMDo0NyBDRVQgamUgTWF4aW1lIFJp
cGFyZCBuYXBpc2FsKGEpOgo+IE9uIFR1ZSwgTm92IDI3LCAyMDE4IGF0IDA1OjMwOjAwUE0gKzAx
MDAsIEplcm5laiDFoGtyYWJlYyB3cm90ZToKPiA+ID4gPiA+ICtzdGF0aWMgdm9pZCBfY2VkcnVz
X3dyaXRlX3JlZl9saXN0KHN0cnVjdCBjZWRydXNfY3R4ICpjdHgsCj4gPiA+ID4gPiArCQkJCSAg
IHN0cnVjdCBjZWRydXNfcnVuICpydW4sCj4gPiA+ID4gPiArCQkJCSAgIGNvbnN0IHU4ICpyZWZf
bGlzdCwgdTggbnVtX3JlZiwKPiA+ID4gPiA+ICsJCQkJICAgZW51bSBjZWRydXNfaDI2NF9zcmFt
X29mZiBzcmFtKQo+ID4gPiA+ID4gK3sKPiA+ID4gPiA+ICsJY29uc3Qgc3RydWN0IHY0bDJfY3Ry
bF9oMjY0X2RlY29kZV9wYXJhbSAqZGVjb2RlID0KPiA+ID4gPiA+IHJ1bi0+aDI2NC5kZWNvZGVf
cGFyYW07ICsJc3RydWN0IHZiMl9xdWV1ZSAqY2FwX3EgPQo+ID4gPiA+ID4gJmN0eC0+ZmgubTJt
X2N0eC0+Y2FwX3FfY3R4LnE7Cj4gPiA+ID4gPiArCXN0cnVjdCBjZWRydXNfZGV2ICpkZXYgPSBj
dHgtPmRldjsKPiA+ID4gPiA+ICsJdTMyIHNyYW1fYXJyYXlbQ0VEUlVTX01BWF9SRUZfSURYIC8g
c2l6ZW9mKHUzMildOwo+ID4gPiA+ID4gKwl1bnNpZ25lZCBpbnQgc2l6ZSwgaTsKPiA+ID4gPiA+
ICsKPiA+ID4gPiA+ICsJbWVtc2V0KHNyYW1fYXJyYXksIDAsIHNpemVvZihzcmFtX2FycmF5KSk7
Cj4gPiA+ID4gPiArCj4gPiA+ID4gPiArCWZvciAoaSA9IDA7IGkgPCBudW1fcmVmOyBpICs9IDQp
IHsKPiA+ID4gPiA+ICsJCXVuc2lnbmVkIGludCBqOwo+ID4gPiA+ID4gKwo+ID4gPiA+ID4gKwkJ
Zm9yIChqID0gMDsgaiA8IDQ7IGorKykgewo+ID4gPiA+IAo+ID4gPiA+IEkgZG9uJ3QgdGhpbmsg
eW91IGhhdmUgdG8gY29tcGxpY2F0ZSB3aXRoIHR3byBsb29wcyBoZXJlLgo+ID4gPiA+IGNlZHJ1
c19oMjY0X3dyaXRlX3NyYW0oKSB0YWtlcyB2b2lkKiBhbmQgaXQgYWxpZ25zIHRvIDQgYW55d2F5
LiBTbyBhcwo+ID4gPiA+IGxvbmcKPiA+ID4gPiBpbnB1dCBidWZmZXIgaXMgbXVsdGlwbGUgb2Yg
NCAodThbQ0VEUlVTX01BWF9SRUZfSURYXSBxdWFsaWZpZXMgZm9yCj4gPiA+ID4gdGhhdCksCj4g
PiA+ID4geW91IGNhbiB1c2Ugc2luZ2xlIGZvciBsb29wIHdpdGggInU4IHNyYW1fYXJyYXlbQ0VE
UlVTX01BWF9SRUZfSURYXSIuCj4gPiA+ID4gVGhpcyBzaG91bGQgbWFrZSBjb2RlIG11Y2ggbW9y
ZSByZWFkYWJsZS4KPiA+ID4gCj4gPiA+IFRoaXMgd2Fzbid0IHJlYWxseSBhYm91dCB0aGUgYWxp
Z25tZW50LCBidXQgaW4gb3JkZXIgdG8gZ2V0IHRoZQo+ID4gPiBvZmZzZXRzIGluIHRoZSB1MzIg
YW5kIHRoZSBhcnJheSBtb3JlIGVhc2lseS4KPiA+ID4gCj4gPiA+IEJyZWFraW5nIG91dCB0aGUg
bG9vcCB3aWxsIG1ha2UgdGhhdCBjb21wdXRhdGlvbiBsZXNzIGVhc3kgb24gdGhlIGV5ZSwKPiA+
ID4gc28gSSBndWVzcyBpdCdzIHZlcnkgc3ViamVjdGl2ZS4KPiA+IAo+ID4gRm9yIHNvbWUgc3Ry
YW5nZSByZWFzb24sIGNvZGUgYmVsb3cgZml4ZXMgZGVjb2RpbmcgaXNzdWUgZnJvbSBvbmUgb2Yg
bXkKPiA+IHRlc3QKPiA+IHNhbXBsZXMuIFRoaXMgaXMgd2hhdCBJIGFjdHVhbGx5IG1lYW50IHdp
dGggMSBsb29wIGFwcHJvYWNoOgo+IERvIHlvdSBoYXZlIHRoYXQgdGVzdCBzYW1wbGUgc29tZXdo
ZXJlIGFjY2Vzc2libGU/Cgp5ZXMsIGl0J3MgaGVyZToKaHR0cDovL2plcm5lai5saWJyZWVsZWMu
dHYvdmlkZW9zL2gyNjQvU3RhciUyMFdhcnMlMjBFcGlzb2RlJTIwVklJJTIwLSUyMFRoZSUyMEZv
cmNlJTIwQXdha2VucyUyMC0lMjBUZWFzZXIlMjBUcmFpbGVyJTIwMi5tcDQKCkl0IG5lZWRzIGFs
c28gcHJlZGljdGlvbiB3ZWlnaHQgdGFibGVzICh5b3VyIGVhcmx5IHBhdGNoIGZvciB0aGF0IHNo
b3VsZCB3b3JrIApvaykgYW5kIHNjYWxpbmcgbGlzdCAoY29kZSBJIHNlbnQgeW91IGluIG9uZSBv
ZiB0aGUgcHJldmlvdXMgY29tbWVudHMgc2hvdWxkIAp3b3JrKS4KCkZvciBtZSwgaWYgdGhpcyBz
YW1wbGUgd29ya2VkIHdpdGhvdXQgaXNzdWUsIGV2ZXJ5IG90aGVyIG5vbi1pbnRlcmxhY2VkIHNh
bXBsZSAKd29ya2VkIHRvby4KCj4gCj4gPiBzdGF0aWMgdm9pZCBfY2VkcnVzX3dyaXRlX3JlZl9s
aXN0KHN0cnVjdCBjZWRydXNfY3R4ICpjdHgsCj4gPiAKPiA+IAkJCQkgICBzdHJ1Y3QgY2VkcnVz
X3J1biAqcnVuLAo+ID4gCQkJCSAgIGNvbnN0IHU4ICpyZWZfbGlzdCwgdTggbnVtX3JlZiwKPiA+
IAkJCQkgICBlbnVtIGNlZHJ1c19oMjY0X3NyYW1fb2ZmIHNyYW0pCj4gPiAKPiA+IHsKPiA+IAo+
ID4gCWNvbnN0IHN0cnVjdCB2NGwyX2N0cmxfaDI2NF9kZWNvZGVfcGFyYW0gKmRlY29kZSA9Cj4g
PiAJcnVuLT5oMjY0LmRlY29kZV9wYXJhbTsKPiA+IAlzdHJ1Y3QgdmIyX3F1ZXVlICpjYXBfcSA9
ICZjdHgtPmZoLm0ybV9jdHgtPmNhcF9xX2N0eC5xOwo+ID4gCXN0cnVjdCBjZWRydXNfZGV2ICpk
ZXYgPSBjdHgtPmRldjsKPiA+IAl1OCBzcmFtX2FycmF5W0NFRFJVU19NQVhfUkVGX0lEWF07Cj4g
PiAJdW5zaWduZWQgaW50IGk7Cj4gPiAJCj4gPiAJbWVtc2V0KHNyYW1fYXJyYXksIDAsIHNpemVv
ZihzcmFtX2FycmF5KSk7Cj4gPiAJbnVtX3JlZiA9IG1pbihudW1fcmVmLCAodTgpQ0VEUlVTX01B
WF9SRUZfSURYKTsKPiA+IAkKPiA+IAlmb3IgKGkgPSAwOyBpIDwgbnVtX3JlZjsgaSsrKSB7Cj4g
PiAJCj4gPiAJCWNvbnN0IHN0cnVjdCB2NGwyX2gyNjRfZHBiX2VudHJ5ICpkcGI7Cj4gPiAJCWNv
bnN0IHN0cnVjdCBjZWRydXNfYnVmZmVyICpjZWRydXNfYnVmOwo+ID4gCQljb25zdCBzdHJ1Y3Qg
dmIyX3Y0bDJfYnVmZmVyICpyZWZfYnVmOwo+ID4gCQl1bnNpZ25lZCBpbnQgcG9zaXRpb247Cj4g
PiAJCWludCBidWZfaWR4Owo+ID4gCQl1OCBkcGJfaWR4Owo+ID4gCQkKPiA+IAkJZHBiX2lkeCA9
IHJlZl9saXN0W2ldOwo+ID4gCQlkcGIgPSAmZGVjb2RlLT5kcGJbZHBiX2lkeF07Cj4gPiAJCQo+
ID4gCQlpZiAoIShkcGItPmZsYWdzICYgVjRMMl9IMjY0X0RQQl9FTlRSWV9GTEFHX0FDVElWRSkp
Cj4gPiAJCQo+ID4gCQkJY29udGludWU7Cj4gPiAJCQo+ID4gCQlidWZfaWR4ID0gdmIyX2ZpbmRf
dGFnKGNhcF9xLCBkcGItPnRhZywgMCk7Cj4gPiAJCWlmIChidWZfaWR4IDwgMCkKPiA+IAkJCj4g
PiAJCQljb250aW51ZTsKPiA+IAkJCj4gPiAJCXJlZl9idWYgPSB0b192YjJfdjRsMl9idWZmZXIo
Y3R4LT5kc3RfYnVmc1tidWZfaWR4XSk7Cj4gPiAJCWNlZHJ1c19idWYgPSB2YjJfdjRsMl90b19j
ZWRydXNfYnVmZmVyKHJlZl9idWYpOwo+ID4gCQlwb3NpdGlvbiA9IGNlZHJ1c19idWYtPmNvZGVj
LmgyNjQucG9zaXRpb247Cj4gPiAJCQo+ID4gCQlzcmFtX2FycmF5W2ldIHw9IHBvc2l0aW9uIDw8
IDE7Cj4gPiAJCWlmIChyZWZfYnVmLT5maWVsZCA9PSBWNEwyX0ZJRUxEX0JPVFRPTSkKPiA+IAkJ
Cj4gPiAJCQlzcmFtX2FycmF5W2ldIHw9IEJJVCgwKTsKPiA+IAkKPiA+IAl9Cj4gPiAJCj4gPiAJ
Y2VkcnVzX2gyNjRfd3JpdGVfc3JhbShkZXYsIHNyYW0sICZzcmFtX2FycmF5LCBudW1fcmVmKTsK
PiA+IAo+ID4gfQo+ID4gCj4gPiBJTU8gdGhpcyBjb2RlIGlzIGVhc2llciB0byByZWFkLgo+IAo+
IElOZGVlZCwgdGhhbmtzIQo+IAo+ID4gPiA+ID4gKwkJCWNvbnN0IHN0cnVjdCB2NGwyX2gyNjRf
ZHBiX2VudHJ5ICpkcGI7Cj4gPiA+ID4gPiArCQkJY29uc3Qgc3RydWN0IGNlZHJ1c19idWZmZXIg
KmNlZHJ1c19idWY7Cj4gPiA+ID4gPiArCQkJY29uc3Qgc3RydWN0IHZiMl92NGwyX2J1ZmZlciAq
cmVmX2J1ZjsKPiA+ID4gPiA+ICsJCQl1bnNpZ25lZCBpbnQgcG9zaXRpb247Cj4gPiA+ID4gPiAr
CQkJaW50IGJ1Zl9pZHg7Cj4gPiA+ID4gPiArCQkJdTggcmVmX2lkeCA9IGkgKyBqOwo+ID4gPiA+
ID4gKwkJCXU4IGRwYl9pZHg7Cj4gPiA+ID4gPiArCj4gPiA+ID4gPiArCQkJaWYgKHJlZl9pZHgg
Pj0gbnVtX3JlZikKPiA+ID4gPiA+ICsJCQkJYnJlYWs7Cj4gPiA+ID4gPiArCj4gPiA+ID4gPiAr
CQkJZHBiX2lkeCA9IHJlZl9saXN0W3JlZl9pZHhdOwo+ID4gPiA+ID4gKwkJCWRwYiA9ICZkZWNv
ZGUtPmRwYltkcGJfaWR4XTsKPiA+ID4gPiA+ICsKPiA+ID4gPiA+ICsJCQlpZiAoIShkcGItPmZs
YWdzICYgVjRMMl9IMjY0X0RQQl9FTlRSWV9GTEFHX0FDVElWRSkpCj4gPiA+ID4gPiArCQkJCWNv
bnRpbnVlOwo+ID4gPiA+ID4gKwo+ID4gPiA+ID4gKwkJCWJ1Zl9pZHggPSB2YjJfZmluZF90YWco
Y2FwX3EsIGRwYi0+dGFnLCAwKTsKPiA+ID4gPiA+ICsJCQlpZiAoYnVmX2lkeCA8IDApCj4gPiA+
ID4gPiArCQkJCWNvbnRpbnVlOwo+ID4gPiA+ID4gKwo+ID4gPiA+ID4gKwkJCXJlZl9idWYgPSB0
b192YjJfdjRsMl9idWZmZXIoY3R4LT5kc3RfYnVmc1tidWZfaWR4XSk7Cj4gPiA+ID4gPiArCQkJ
Y2VkcnVzX2J1ZiA9IHZiMl92NGwyX3RvX2NlZHJ1c19idWZmZXIocmVmX2J1Zik7Cj4gPiA+ID4g
PiArCQkJcG9zaXRpb24gPSBjZWRydXNfYnVmLT5jb2RlYy5oMjY0LnBvc2l0aW9uOwo+ID4gPiA+
ID4gKwo+ID4gPiA+ID4gKwkJCXNyYW1fYXJyYXlbaV0gfD0gcG9zaXRpb24gPDwgKGogKiA4ICsg
MSk7Cj4gPiA+ID4gPiArCQkJaWYgKHJlZl9idWYtPmZpZWxkID09IFY0TDJfRklFTERfQk9UVE9N
KQo+ID4gPiA+IAo+ID4gPiA+IFlvdSBuZXdlciBzZXQgYWJvdmUgZmxhZyB0byBidWZmZXIgc28g
dGhpcyB3aWxsIGJlIGFsd2F5cyBmYWxzZS4KPiA+ID4gCj4gPiA+IEFzIGZhciBhcyBJIGtub3cs
IHRoZSBmaWVsZCBpcyBzdXBwb3NlZCB0byBiZSBzZXQgYnkgdGhlIHVzZXJzcGFjZS4KPiA+IAo+
ID4gSG93PyBJIHRob3VnaHQgdGhhdCBvbmx5IGZsYWdzIGF0IHF1ZXVlaW5nIGJ1ZmZlcnMgY2Fu
IGJlIHNldCBhbmQgdGhlcmUgaXMKPiA+IG5vIGJvdHRvbS90b3AgZmxhZy4KPiAKPiBodHRwczov
L2xpbnV4dHYub3JnL2Rvd25sb2Fkcy92NGwtZHZiLWFwaXMvdWFwaS92NGwvYnVmZmVyLmh0bWwj
Yy52NGwyX2J1ZmZlCj4gcgo+IAo+ICJJbmRpY2F0ZXMgdGhlIGZpZWxkIG9yZGVyIG9mIHRoZSBp
bWFnZSBpbiB0aGUgYnVmZmVyLCBzZWUKPiB2NGwyX2ZpZWxkLiBUaGlzIGZpZWxkIGlzIG5vdCB1
c2VkIHdoZW4gdGhlIGJ1ZmZlciBjb250YWlucyBWQkkKPiBkYXRhLiBEcml2ZXJzIG11c3Qgc2V0
IGl0IHdoZW4gdHlwZSByZWZlcnMgdG8gYSBjYXB0dXJlIHN0cmVhbSwKPiBhcHBsaWNhdGlvbnMg
d2hlbiBpdCByZWZlcnMgdG8gYW4gb3V0cHV0IHN0cmVhbS4iCj4gCj4gTXkgdW5kZXJzdGFuZGlu
ZyBpcyB0aGF0IHRoZSBhcHBsaWNhdGlvbiBzaG91bGQgc2V0IGl0LCBzaW5jZSB3ZSdsbAo+IHVz
ZSB0aGUgb3V0cHV0IHN0cmVhbSdzIGJ1ZmZlciBoZXJlLiBCdXQgSSBtaWdodCB2ZXJ5IHdlbGwg
YmUgd3JvbmcKPiBhYm91dCBpdCA6LwoKSSdsbCB0YWtlIGEgbG9vaywgdGhhbmtzLgoKQmVzdCBy
ZWdhcmRzLApKZXJuZWoKCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
