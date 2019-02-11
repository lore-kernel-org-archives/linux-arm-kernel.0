Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FA6C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:48:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C35B121B68
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="es62vE9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C35B121B68
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RYYtPaPgMp/XYyr/5r83zVLO9Y5KkBT1xDzF5UL8iHE=; b=es62vE9GcqjT1Y
	97oluawjXVv55h0erXriTrOxaN6LjsUFM4Lvb27x7AXL6i0jMUaqMibvIIwUNYcR1MAiAlVAbtpRs
	RyrnW9q/iLBi9x938tKrmItOhVIZmVgii4g680+8GXSz4206xxhDmjK83kP9mBzUA2HalYraAY2oN
	gZvG4kXZ7pOQ13od/EUwGFEjAz2gz8x4Wfst2c/Di/7VT4oDmPixKS+/H6eyMAmCHZ8M1vldySdPA
	3T39eU93tMeQVpYuxCk0smG9aITIpozSJeWKLB25cmLXBksR+kfDkvNqN4CioQfqZ7PVOc8Xyyrrj
	zEQXQ7I/OTyjkxyuTlIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtHZA-00050c-Qp; Mon, 11 Feb 2019 19:48:32 +0000
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtHZ6-00050A-Hk
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 19:48:30 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: ezequiel) with ESMTPSA id B983A27EC6B
Message-ID: <5a31f5596c04390d76bf34fdb8b71b6a96306943.camel@collabora.com>
Subject: Re: [PATCH v3 2/2] media: cedrus: Add H264 decoding support
From: Ezequiel Garcia <ezequiel@collabora.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, hans.verkuil@cisco.com, 
 acourbot@chromium.org, sakari.ailus@linux.intel.com, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>
Date: Mon, 11 Feb 2019 16:48:17 -0300
In-Reply-To: <4c00e1ab1e70adb1d94db59c37393250ca3791c5.1549895062.git-series.maxime.ripard@bootlin.com>
References: <cover.d3bb4d93da91ed5668025354ee1fca656e7d5b8b.1549895062.git-series.maxime.ripard@bootlin.com>
 <4c00e1ab1e70adb1d94db59c37393250ca3791c5.1549895062.git-series.maxime.ripard@bootlin.com>
Organization: Collabora
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_114828_718304_B40C3EF8 
X-CRM114-Status: UNSURE (   9.63  )
X-CRM114-Notice: Please train this message.
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
Cc: jonas@kwiboo.se, jenskuske@gmail.com, linux-sunxi@googlegroups.com,
 linux-kernel@vger.kernel.org, jernej.skrabec@gmail.com, tfiga@chromium.org,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, posciak@chromium.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 nicolas.dufresne@collabora.com, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCAyMDE5LTAyLTExIGF0IDE1OjM5ICswMTAwLCBNYXhpbWUgUmlwYXJkIHdyb3RlOgo+
IEludHJvZHVjZSBzb21lIGJhc2ljIEgyNjQgZGVjb2Rpbmcgc3VwcG9ydCBpbiBjZWRydXMuIFNv
IGZhciwgb25seSB0aGUKPiBiYXNlbGluZSBwcm9maWxlIHZpZGVvcyBoYXZlIGJlZW4gdGVzdGVk
LCBhbmQgc29tZSBtb3JlIGFkdmFuY2VkIGZlYXR1cmVzCj4gdXNlZCBpbiBoaWdoZXIgcHJvZmls
ZXMgYXJlIG5vdCBldmVuIGltcGxlbWVudGVkLgo+IAo+IFNpZ25lZC1vZmYtYnk6IE1heGltZSBS
aXBhcmQgPG1heGltZS5yaXBhcmRAYm9vdGxpbi5jb20+ClsuLl0KCgo+ICtzdGF0aWMgdm9pZCBf
Y2VkcnVzX3dyaXRlX3JlZl9saXN0KHN0cnVjdCBjZWRydXNfY3R4ICpjdHgsCj4gKwkJCQkgICBz
dHJ1Y3QgY2VkcnVzX3J1biAqcnVuLAo+ICsJCQkJICAgY29uc3QgdTggKnJlZl9saXN0LCB1OCBu
dW1fcmVmLAo+ICsJCQkJICAgZW51bSBjZWRydXNfaDI2NF9zcmFtX29mZiBzcmFtKQo+ICt7Cj4g
Kwljb25zdCBzdHJ1Y3QgdjRsMl9jdHJsX2gyNjRfZGVjb2RlX3BhcmFtICpkZWNvZGUgPSBydW4t
PmgyNjQuZGVjb2RlX3BhcmFtOwo+ICsJc3RydWN0IHZiMl9xdWV1ZSAqY2FwX3EgPSAmY3R4LT5m
aC5tMm1fY3R4LT5jYXBfcV9jdHgucTsKPiArCWNvbnN0IHN0cnVjdCB2YjJfYnVmZmVyICpkc3Rf
YnVmID0gJnJ1bi0+ZHN0LT52YjJfYnVmOwo+ICsJc3RydWN0IGNlZHJ1c19kZXYgKmRldiA9IGN0
eC0+ZGV2Owo+ICsJdTggc3JhbV9hcnJheVtDRURSVVNfTUFYX1JFRl9JRFhdOwo+ICsJdW5zaWdu
ZWQgaW50IHNpemUsIGk7Cj4gKwo+ICsJbWVtc2V0KHNyYW1fYXJyYXksIDAsIHNpemVvZihzcmFt
X2FycmF5KSk7Cj4gKwo+ICsJZm9yIChpID0gMDsgaSA8IG51bV9yZWY7IGkrKykgewo+ICsJCWNv
bnN0IHN0cnVjdCB2NGwyX2gyNjRfZHBiX2VudHJ5ICpkcGI7Cj4gKwkJY29uc3Qgc3RydWN0IGNl
ZHJ1c19idWZmZXIgKmNlZHJ1c19idWY7Cj4gKwkJY29uc3Qgc3RydWN0IHZiMl92NGwyX2J1ZmZl
ciAqcmVmX2J1ZjsKPiArCQl1bnNpZ25lZCBpbnQgcG9zaXRpb247Cj4gKwkJaW50IGJ1Zl9pZHg7
Cj4gKwkJdTggZHBiX2lkeDsKPiArCj4gKwkJZHBiX2lkeCA9IHJlZl9saXN0W2ldOwo+ICsJCWRw
YiA9ICZkZWNvZGUtPmRwYltkcGJfaWR4XTsKPiArCj4gKwkJaWYgKCEoZHBiLT5mbGFncyAmIFY0
TDJfSDI2NF9EUEJfRU5UUllfRkxBR19BQ1RJVkUpKQo+ICsJCQljb250aW51ZTsKPiArCj4gKwkJ
aWYgKGRzdF9idWYtPnRpbWVzdGFtcCA9PSBkcGItPnRpbWVzdGFtcCkKPiArCQkJYnVmX2lkeCA9
IGRzdF9idWYtPmluZGV4Owo+ICsJCWVsc2UKPiArCQkJYnVmX2lkeCA9IHZiMl9maW5kX3RpbWVz
dGFtcChjYXBfcSwgZHBiLT50aW1lc3RhbXAsIDApOwo+ICsKPiArCQlpZiAoYnVmX2lkeCA8IDAp
Cj4gKwkJCWNvbnRpbnVlOwo+ICsKPiArCQlyZWZfYnVmID0gdG9fdmIyX3Y0bDJfYnVmZmVyKGN0
eC0+ZHN0X2J1ZnNbYnVmX2lkeF0pOwo+ICsJCWNlZHJ1c19idWYgPSB2YjJfdjRsMl90b19jZWRy
dXNfYnVmZmVyKHJlZl9idWYpOwo+ICsJCXBvc2l0aW9uID0gY2VkcnVzX2J1Zi0+Y29kZWMuaDI2
NC5wb3NpdGlvbjsKPiArCj4gKwkJc3JhbV9hcnJheVtpXSB8PSBwb3NpdGlvbiA8PCAxOwo+ICsJ
CWlmIChyZWZfYnVmLT5maWVsZCA9PSBWNEwyX0ZJRUxEX0JPVFRPTSkKPiArCQkJc3JhbV9hcnJh
eVtpXSB8PSBCSVQoMCk7Cj4gKwl9Cj4gKwo+ICsJc2l6ZSA9IG1pbigodW5zaWduZWQgaW50KUFM
SUdOKG51bV9yZWYsIDQpLCBzaXplb2Yoc3JhbV9hcnJheSkpOwoKUGVyaGFwcyBzL3Vuc2lnbmVk
IGludC9zaXplX3QsIHNvIHRoZSBhcmd1bWVudHMgdG8gbWluKCkgaGF2ZSB0aGUgc2FtZSB0eXBl
PwoKT3RoZXJ3aXNlLCBJIGdvdCB0aGlzIHdhcm5pbmc6CgovaG9tZS96ZXRhL3JlcG9zL2xpbnV4
L21lZGlhX3RyZWUvZHJpdmVycy9zdGFnaW5nL21lZGlhL3N1bnhpL2NlZHJ1cy9jZWRydXNfaDI2
NC5jOiBJbiBmdW5jdGlvbiDigJhfY2VkcnVzX3dyaXRlX3JlZl9saXN04oCZOgovaG9tZS96ZXRh
L3JlcG9zL2xpbnV4L21lZGlhX3RyZWUvaW5jbHVkZS9saW51eC9rZXJuZWwuaDo4NDY6Mjk6IHdh
cm5pbmc6IGNvbXBhcmlzb24gb2YgZGlzdGluY3QgcG9pbnRlciB0eXBlcyBsYWNrcyBhIGNhc3QK
ICAgKCEhKHNpemVvZigodHlwZW9mKHgpICopMSA9PSAodHlwZW9mKHkpICopMSkpKQoKUmVnYXJk
cywKRXoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
aW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1hcm0ta2VybmVsCg==
