Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF86C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:15:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77F9D205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jiCJvGsA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F9D205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=public-files.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:Date:Subject:To:
	From:Message-ID:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X/lG1cjn2V1tk+nDDx0Z35B1KMTzhe5b5jxex3Jv8Rs=; b=jiCJvGsAwsL0rm
	EczgLmc1wA642hlSYvVEyvS5O+SgHgCHgy40K28LjBse3GJyaz0NBkf/79M7Omhc796S2NPZhNQS8
	3RRjgrsHCrfwNrWsCae7sxFLUsibNCyWTlv8saD2foi1D1D32EV4QbsGy86jYWrI8tyoyte9S0GN+
	Dm4ZbH/qsuXUrZ0/YkxWaxJdv8nsT3nMyEK9SPRJDdA3UMctDFLu6W52kpPTR/4k1H5PpCIp2Exbi
	kOFwwmEd2g6ZC3vXFy4W2W8VYBWFLqBaiykKyZI0FcUOkFiz9fGTRQIkmjyNs0LVQNr5nH7T3YHo9
	gWQVwXvCoyMP+d/6KXVg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk8S1-0005Ym-Te; Thu, 17 Jan 2019 14:15:21 +0000
Received: from mout.gmx.net ([212.227.15.18])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk8Rx-0005Xm-2j; Thu, 17 Jan 2019 14:15:19 +0000
Received: from [91.14.66.187] ([91.14.66.187]) by web-mail.gmx.net
 (3c-app-gmx-bs28.server.lan [172.19.170.80]) (via HTTP); Thu, 17 Jan 2019
 15:14:12 +0100
MIME-Version: 1.0
Message-ID: <trinity-1adab8be-573a-4816-9e9f-feddf07bdcd3-1547734452313@3c-app-gmx-bs28>
From: "Frank Wunderlich" <frank-w@public-files.de>
To: "CK Hu" <ck.hu@mediatek.com>
Subject: Aw: [PATCH 2/2] drm/mediatek: Add Mediatek framebuffer device
Date: Thu, 17 Jan 2019 15:14:12 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <20190116013924.11345-2-ck.hu@mediatek.com>
References: <20190116013924.11345-1-ck.hu@mediatek.com>
 <20190116013924.11345-2-ck.hu@mediatek.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:ZCXujUahy4rjWoxPg/1yVwlO0qAajHDw4P89dYpDctPb15HiyLPXx2moE+1sexaDO5ywL
 VOJ4OKznWVdagZJJWCvIV3JtzRKkK73Mt0VNMnm6BQOrWJHnvOHdtJASD9zHYw8xPbWEwB/8bBko
 dIXHWzv0RQRVKTkfS/xiaOwgIUK2kNPtIVEAFnUJdp5Zpoelh9YteSYewQmSJH55rRl3KGn1FEMi
 Ss1APqWlLJvUt32lUSft+uMJSYJGgNfrINavRMnvAsHSqRxENtLelpry3np+yADRN7sNbMfKJ04r
 e0=
X-UI-Out-Filterresults: notjunk:1;V03:K0:GpvUPjUexyI=:tCCUqaY+pQHNs9CSsYO9fi
 Z7abOvN+j51mJptyhbB8/uwj1h8nnTUtPsvCPsxsDMJKOY0eww0q1iUkHlHeIUmBS/53VeUC3
 YOGpyBz28goZzYrKZdbOdEYPrn0wTGRMcEPOmKpJcCxrxOZibZO0rXuaHVsD/0pN8FFSsDCVB
 t808m5aGh784fRQNg7cO9XlPw9eMCLCsFWNPv1lYnnvWPk1g1MqlvWSwvi2CjS8XoU54oYcgk
 Rn+kPJKk9yIqIHEL3yvxY2AOepTlhWuAePDWpqIp1ajiISekIHAxTkTFvazaynkci+Gz8qRF8
 vls2pQORQ1i0AixoWinAC+7PsMPCsTVCv9097Us/oNVlX+d450+z1QFQRHxJgWHLr4JWo+mZn
 sU40dtSIKOS8i1NZB/bdFvi0g08Tq6wY0Z5dUWAkvvHbw5+iGRgCRvNBqYwSf9B5vcg/RZnlV
 1+2bP10ndvBRCBVw6GSmfrwf26u6MjPNirSlgvPkaJUmmh7fXewjpWCZ2BxBRCOZRHUOgZiAB
 6f3qc62oANP8oMR4FaYLwNqXa1B9qqlQbFFzTD+e9Rvi5WAMeHoZDQhieYaTaRQkKOUfAgBJC
 qnTp2JAUwn2E4=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_061517_423986_58AB424A 
X-CRM114-Status: GOOD (  11.93  )
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
Cc: Philipp Zabel <p.zabel@pengutronix.de>, srv_heupstream@mediatek.com,
 David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, CK Hu <ck.hu@mediatek.com>,
 =?UTF-8?Q?=22Noralf_Tr=EF=BF=BDnnes=22?= <noralf@tronnes.org>,
 linux-mediatek@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGksCgp0aGlzIFBhdGNoc2V0IGRvZXMgbm90IGhhbmcgb24gQmFuYW5hcGkgUjIsIGJ1dCBkb2Vz
IG5vdCBzaG93IGFueXRoaW5nIG9uIEZCLUNvbnNvbGUuLi5zZWVtcyBhbnl0aGluZyBpcyBtaXNz
aW5nCgpodHRwczovL2dpdGh1Yi5jb20vZnJhbmstdy9CUEktUjItNC4xNC90cmVlLzQuMjAtZmJk
ZXYKCmRtZXNnIHwgZ3JlcCAnZmJcfGZyYW1lYnVmZmVyJwpbICAgIDAuMDAwMDAwXSBMaW51eCB2
ZXJzaW9uIDQuMjAuMC1yYzctYnBpLXIyLWZiZGV2IChmcmFua0BmcmFuay1ONTZWWikgKGdjYyB2
ZXJzaW9uIDcuMy4wIChVYnVudHUvTGluYXJvIDcuMy4wLTI3dWJ1bnR1MX4xOC4wNCkpIDkKWyAg
ICAwLjAwMDAwMF0gY21hOiBSZXNlcnZlZCA2NCBNaUIgYXQgMHhmYjgwMDAwMApbICAgIDAuMDAw
MDAwXSBLZXJuZWwgY29tbWFuZCBsaW5lOiBib2FyZD1icGktcjIgY29uc29sZT1lYXJseXByaW50
ayBjb25zb2xlPXR0eTEgZmJjb249bWFwOjAgY29uc29sZT10dHlTMCwxMTUyMDAgcm9vdD0vZGV2
L21tY2JsazcKWyAgICA1LjczMzE4NV0gW2RybTpkcm1fZmJfaGVscGVyX2dlbmVyaWNfcHJvYmVd
IHN1cmZhY2Ugd2lkdGgoMTI4MCksIGhlaWdodCgxMDI0KSBhbmQgYnBwKDMyKQpbICAgIDUuNzU0
NDUyXSBbZHJtOmRybV9tb2RlX2FkZGZiMl0gW0ZCOjQ0XQpbICAgIDUuNzkyODc4XSBtZWRpYXRl
ay1kcm0gMTQwMDAwMDAuZGlzcHN5czogZmIwOiBEUk0gZW11bGF0ZWQgZnJhbWUgYnVmZmVyIGRl
dmljZQpbICAgIDUuODE0MDY3XSBbZHJtOmRybV9mYl9oZWxwZXJfaG90cGx1Z19ldmVudC5wYXJ0
LjExXSAKWyAgICA2LjIwMzA4M10gbWVkaWF0ZWstZHJtIDE0MDAwMDAwLmRpc3BzeXM6IFtkcm06
ZHJtX2NsaWVudF9kZXZfaG90cGx1Z10gZmJkZXY6IHJldD0wClsgICAyNC45MzAzNDddIG1lZGlh
dGVrLWRybSAxNDAwMDAwMC5kaXNwc3lzOiBbZHJtOmRybV9jbGllbnRfZGV2X3Jlc3RvcmVdIGZi
ZGV2OiByZXQ9MApbICAgMjUuMTk2ODcyXSBtZWRpYXRlay1kcm0gMTQwMDAwMDAuZGlzcHN5czog
W2RybTpkcm1fY2xpZW50X2Rldl9yZXN0b3JlXSBmYmRldjogcmV0PTAKWyAgIDI1LjI4MTE4NF0g
W2RybTpkcm1fbW9kZV9hZGRmYjJdIFtGQjo0OV0KWyAgIDI3Ljk0Nzk2Ml0gW2RybTpkcm1fbW9k
ZV9hZGRmYjJdIFtGQjo0OV0KCnJlZ2FyZHMgRnJhbmsKCgo+IEdlc2VuZGV0OiBNaXR0d29jaCwg
MTYuIEphbnVhciAyMDE5IHVtIDAyOjM5IFVocgo+IFZvbjogIkNLIEh1IiA8Y2suaHVAbWVkaWF0
ZWsuY29tPgo+IEFuOiAiUGhpbGlwcCBaYWJlbCIgPHAuemFiZWxAcGVuZ3V0cm9uaXguZGU+LCAi
RGF2aWQgQWlybGllIiA8YWlybGllZEBsaW51eC5pZT4sICJEYW5pZWwgVmV0dGVyIiA8ZGFuaWVs
QGZmd2xsLmNoPiwgIk1hdHRoaWFzIEJydWdnZXIiIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPiwg
Ik5vcmFsZiBUcu+/vW5uZXMiIDxub3JhbGZAdHJvbm5lcy5vcmc+LCAiRnJhbmsgV3VuZGVybGlj
aCIgPGZyYW5rLXdAcHVibGljLWZpbGVzLmRlPgo+IENjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnLCBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcsIGxpbnV4LW1l
ZGlhdGVrQGxpc3RzLmluZnJhZGVhZC5vcmcsIGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcs
IHNydl9oZXVwc3RyZWFtQG1lZGlhdGVrLmNvbSwgIkNLIEh1IiA8Y2suaHVAbWVkaWF0ZWsuY29t
Pgo+IEJldHJlZmY6IFtQQVRDSCAyLzJdIGRybS9tZWRpYXRlazogQWRkIE1lZGlhdGVrIGZyYW1l
YnVmZmVyIGRldmljZQo+Cj4gRm9yIE1lZGlhdGVrIGRybSBkcml2ZXIsIHVzZSBmYmRldiBlbXVs
YXRpb24gdG8gY3JlYXRlIGEgZnJhbWVidWZmZXIKPiBkZXZpY2UuCj4gCj4gU2lnbmVkLW9mZi1i
eTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fZHJ2LmMgfCA1ICsrKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2Vy
dGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fZHJ2LmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYwo+IGluZGV4
IDZlYzRjYTA3MDM4Mi4uNWZjYzBlMjk0Njk2IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcm1fZHJ2LmMKPiBAQCAtMTYsNiArMTYsNyBAQAo+ICAjaW5jbHVkZSA8ZHJtL2RybV9h
dG9taWMuaD4KPiAgI2luY2x1ZGUgPGRybS9kcm1fYXRvbWljX2hlbHBlci5oPgo+ICAjaW5jbHVk
ZSA8ZHJtL2RybV9jcnRjX2hlbHBlci5oPgo+ICsjaW5jbHVkZSA8ZHJtL2RybV9mYl9oZWxwZXIu
aD4KPiAgI2luY2x1ZGUgPGRybS9kcm1fZ2VtLmg+Cj4gICNpbmNsdWRlIDxkcm0vZHJtX2dlbV9j
bWFfaGVscGVyLmg+Cj4gICNpbmNsdWRlIDxkcm0vZHJtX29mLmg+Cj4gQEAgLTM3OCw2ICszNzks
MTAgQEAgc3RhdGljIGludCBtdGtfZHJtX2JpbmQoc3RydWN0IGRldmljZSAqZGV2KQo+ICAJaWYg
KHJldCA8IDApCj4gIAkJZ290byBlcnJfZGVpbml0Owo+ICAKPiArCXJldCA9IGRybV9mYmRldl9n
ZW5lcmljX3NldHVwKGRybSwgMzIpOwo+ICsJaWYgKHJldCkKPiArCQlEUk1fRVJST1IoIkZhaWxl
ZCB0byBpbml0aWFsaXplIGZiZGV2OiAlZFxuIiwgcmV0KTsKPiArCj4gIAlyZXR1cm4gMDsKPiAg
Cj4gIGVycl9kZWluaXQ6Cj4gLS0gCj4gMi4xOC4xCj4gCj4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0
CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
