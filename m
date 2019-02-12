Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B900C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:47:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A90820842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JwL4pWA3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qgKoLKFm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A90820842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8VcRMc9e8J15HXVPP4BGKJGrsppxVmH3X+6Er4tz7/w=; b=JwL4pWA3vmIWRr
	Ly3jLJ4/Bp2X3JTtMYZ5R2iA9UNWbm7L7epnLaHwitqgrX9zpZ30T1pkNHB7mkl1cKlocp9lbLpxP
	GPkkLR56NKjPVkUUBvlBhOgxAoN3ky73JdfJlNycpTOlOgbYpe81uqDsgz/eVBx7BQmqedLFd4Ff4
	Iv6hn3i0uf1k7OFs4iCrmV4gNlRlF6YCf+zK99zd1EXJ7+gayIxM2JMmYNAG9KfrH0aRPlyVOJvCq
	w3PbMZDTpUDBqRHx3Kh79iMkZWTmIi3ZrMu31MbWkw8e4EFDnHOcGPtz6UiIepiidL/dZAfpe3zW4
	J8nQQggsq5W9MLK+JsXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtc99-0002Pg-IM; Tue, 12 Feb 2019 17:47:03 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtc8o-00028D-OV
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 17:46:59 +0000
Received: by mail-wm1-x344.google.com with SMTP id a62so3965616wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 09:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=w4gEFxIxyax5TlhbyybnDHgnUurqHD/qF92buHHcIR8=;
 b=qgKoLKFmkAuxh1Ar6DdvgYrww1WOQersJ5ep5UCiUi0J+9yhwEkFpUCCy8yfQmKs0F
 O7B2p6q6/iq8xSEYfuJ9SJhl04BwUhPNSCVqmEr314+Ig1yj83cG1TfXkNst80XutOIO
 n7t9JWJS9XIJ/ZWr3kpfo3/Vv8XuhMUgXopwcOD4Wh9PMgI93mxVtXzZL7DrGjYZtH4+
 bM0uXg6iSpjZRPDC14l9NsVSZDYB3O/6vyny+N9pGx9VUWCGPrxevcUNZWO/Iqh5C3x2
 xb1WqgwKxQ7vVRK6zYMmr5wcMsMOhQrKdBYl4VJ6btXG/C9iO7iamMf3Og/asoc4uVUr
 d+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w4gEFxIxyax5TlhbyybnDHgnUurqHD/qF92buHHcIR8=;
 b=fXicTBsSn+4a7NXLv84lddjytRkO8iAosHQJ4392EYj8FAdpZo73MrGS1mUXVibjZX
 bWFFqwmA3D8HpzrhJLzN2eVYs66NEddtO6cTTVnQ2z2osRszYdi5gvkQONU8dXm5WKaf
 Y/sD4c2Qzg1dge/zaUt3KjhVwVQfEqY8D73mNvHFjqOCh5mcSDW9N6xDJPEXqFoRjurh
 eyF3KoNMyBy+lY9R7xgslqnNhbZWO2E2Ale49gIAFIYWM6uS0GB23igDBQg6CJpcuZdC
 tpVUQL+veAtB0Re6D9SOx7t2sc4TLbUu2SwQC7lHk3tQ1xR0hR0Qp7Y5N3yznRVcrFkg
 Cs8Q==
X-Gm-Message-State: AHQUAuYmTvJKmBbkWqBqDmhtkopxcjruregJjNTvDIAeNKaRZuGOkrwH
 s0+oKygq8yPmDIlS3OoyL0n6aaotxBk=
X-Google-Smtp-Source: AHgI3Iayj8bfyM5tDVPZR2hBc8CMXzT1/nAImWh/xGu6k4WGUoqn2o87bSsiO+4IN7cxta26eUGwTw==
X-Received: by 2002:a1c:e10a:: with SMTP id y10mr9289wmg.73.1549993601070;
 Tue, 12 Feb 2019 09:46:41 -0800 (PST)
Received: from jernej-laptop.localnet (APN-123-243-40-gprs.simobil.net.
 [46.123.243.40])
 by smtp.gmail.com with ESMTPSA id q9sm9102303wrv.26.2019.02.12.09.46.38
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 12 Feb 2019 09:46:40 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: linux-sunxi@googlegroups.com, maxime.ripard@bootlin.com
Subject: Re: [linux-sunxi] [PATCH v3 2/2] media: cedrus: Add H264 decoding
 support
Date: Tue, 12 Feb 2019 18:46:38 +0100
Message-ID: <3572175.7W1cnfb8sa@jernej-laptop>
In-Reply-To: <20190212104314.slytpbufwhf5ujv7@flea>
References: <cover.d3bb4d93da91ed5668025354ee1fca656e7d5b8b.1549895062.git-series.maxime.ripard@bootlin.com>
 <12916702.RFRCeC2GgE@jernej-laptop> <20190212104314.slytpbufwhf5ujv7@flea>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_094643_374174_8352EEF2 
X-CRM114-Status: GOOD (  15.75  )
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
 jonas@kwiboo.se, jenskuske@gmail.com, linux-kernel@vger.kernel.org,
 tfiga@chromium.org, Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, hans.verkuil@cisco.com,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 sakari.ailus@linux.intel.com, nicolas.dufresne@collabora.com,
 ezequiel@collabora.com, posciak@chromium.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RG5lIHRvcmVrLCAxMi4gZmVicnVhciAyMDE5IG9iIDExOjQzOjE0IENFVCBqZSBNYXhpbWUgUmlw
YXJkIG5hcGlzYWwoYSk6Cj4gSGksCj4gCj4gT24gTW9uLCBGZWIgMTEsIDIwMTkgYXQgMDg6MjE6
MzFQTSArMDEwMCwgSmVybmVqIMWga3JhYmVjIHdyb3RlOgo+ID4gPiArCXJlZyA9IDA7Cj4gPiA+
ICsJLyoKPiA+ID4gKwkgKiBGSVhNRTogVGhpcyBiaXQgdGVsbHMgdGhlIHZpZGVvIGVuZ2luZSB0
byB1c2UgdGhlIGRlZmF1bHQKPiA+ID4gKwkgKiBxdWFudGl6YXRpb24gbWF0cmljZXMuIFRoaXMg
d2lsbCBvYnZpb3VzbHkgbmVlZCB0byBiZQo+ID4gPiArCSAqIGNoYW5nZWQgdG8gc3VwcG9ydCB0
aGUgcHJvZmlsZXMgc3VwcG9ydGluZyBjdXN0b20KPiA+ID4gKwkgKiBxdWFudGl6YXRpb24gbWF0
cmljZXMuCj4gPiA+ICsJICovCj4gPiA+ICsJcmVnIHw9IFZFX0gyNjRfU0hTX1FQX1NDQUxJTkdf
TUFUUklYX0RFRkFVTFQ7Cj4gPiAKPiA+IFRoaXMgZmxhZyBzaG91bGQgbm90IGJlIG5lZWRlZCBh
bnltb3JlLiBGcm9tIHdoYXQgSSBzZWUsIHlvdSBjb3JyZWN0bHkgc2V0Cj4gPiBzY2FsaW5nIG1h
dHJpeCBldmVyeSB0aW1lLgo+IAo+IFRoZSBzY2FsaW5nIG1hdHJpeCBjb250cm9sIGlzIG9wdGlv
bmFsLCBzbyBJIGd1ZXNzIHdlIHNob3VsZCBwcm90ZWN0Cj4gdGhhdCBieSBhIGNoZWNrIG9uIHdo
ZXRoZXIgdGhhdCBjb250cm9sIGhhcyBiZWVuIHNldCBvciBub3QuIFdoYXQgZG8KPiB5b3UgdGhp
bms/CgpJcyBpdD8gQ29uc2lkZXIgZm9sbG93aW5nIHNuaXBwZXQgZnJvbSB5b3VyIHBhdGNoOgoK
PHNuaXA+CnsKCS5pZAk9IFY0TDJfQ0lEX01QRUdfVklERU9fSDI2NF9TQ0FMSU5HX01BVFJJWCwK
CS5lbGVtX3NpemUJPSBzaXplb2Yoc3RydWN0IHY0bDJfY3RybF9oMjY0X3NjYWxpbmdfbWF0cml4
KSwKCS5jb2RlYwk9IENFRFJVU19DT0RFQ19IMjY0LAoJLnJlcXVpcmVkCT0gdHJ1ZSwKfSwKPHNu
aXA+CgpEb2Vzbid0ICJyZXF1aXJlZCA9IHRydWUiIG1lYW4gdGhhdCBpdCdzIG1hbmRhdG9yeT8g
QnV0IHllcywgaWYgaXQncyBvcHRpb25hbCwgCnRoZW4geW91IHNob3VsZCBhZGQgYSBjaGVjay4K
CkJlc3QgcmVnYXJkcywKSmVybmVqCgoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
