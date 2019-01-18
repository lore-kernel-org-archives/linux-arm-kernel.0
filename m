Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73FFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:46:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2E4B2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OWQEYGub"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2E4B2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sXeHJPdpcO0hfNEIo2ozuV7Cwhf6vy8QLT4RO3Xr9nQ=; b=OWQEYGub2hNRYX
	KVbwNOoD9llARb+2aU/3niw+a5/QeoM+pCCOlxQsS42A5l9TFLD54Lz27UV9HbVq39BEOmetpPCK2
	NOYgOi3wao8fG0wpW3Gbj8v22ztY2BZ79fHEL1Ifxq632bB54053AF6dbM50Pi+vTNNlyY8mfAB98
	lHFpIhTIGBw8xaKm+own7//6kCC07aBDyLe88DwcBeBqc0PclDK51NqMOgaRW1Yr05HpSn9dfJDfv
	Mnh708s0x4lRLTu27TJX4t8cj4w+mL7+zchSDoDjanb+yzBD/p0ArsoAQEZ8DzdlF/WwryehfVi5C
	gP++AkCjHFKl4qZv5lAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkJEn-0005PX-PF; Fri, 18 Jan 2019 01:46:25 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkJEj-0005Of-SB; Fri, 18 Jan 2019 01:46:23 +0000
X-UUID: 4512f0f7f947418696b4974e624d0647-20190117
X-UUID: 4512f0f7f947418696b4974e624d0647-20190117
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
 (envelope-from <ck.hu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 250754739; Thu, 17 Jan 2019 17:46:19 -0800
Received: from mtkmbs03n1.mediatek.inc (172.21.101.181) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 17 Jan 2019 17:46:17 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 18 Jan 2019 09:46:15 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 18 Jan 2019 09:46:16 +0800
Message-ID: <1547775975.4221.11.camel@mtksdaap41>
Subject: Re: Aw: [PATCH 2/2] drm/mediatek: Add Mediatek framebuffer device
From: CK Hu <ck.hu@mediatek.com>
To: Frank Wunderlich <frank-w@public-files.de>
Date: Fri, 18 Jan 2019 09:46:15 +0800
In-Reply-To: <trinity-1adab8be-573a-4816-9e9f-feddf07bdcd3-1547734452313@3c-app-gmx-bs28>
References: <20190116013924.11345-1-ck.hu@mediatek.com>
 <20190116013924.11345-2-ck.hu@mediatek.com>
 <trinity-1adab8be-573a-4816-9e9f-feddf07bdcd3-1547734452313@3c-app-gmx-bs28>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_174621_913831_9484C6C9 
X-CRM114-Status: GOOD (  20.81  )
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
Cc: Daniel Vetter <daniel@ffwll.ch>, srv_heupstream@mediatek.com,
 David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 "\"Noralf =?UTF-8?Q?Tr=EF=BF=BDnnes=22?=" <noralf@tronnes.org>,
 linux-mediatek@lists.infradead.org, Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGksIEZyYW5rOgoKT24gVGh1LCAyMDE5LTAxLTE3IGF0IDE1OjE0ICswMTAwLCBGcmFuayBXdW5k
ZXJsaWNoIHdyb3RlOgo+IEhpLAo+IAo+IHRoaXMgUGF0Y2hzZXQgZG9lcyBub3QgaGFuZyBvbiBC
YW5hbmFwaSBSMiwgYnV0IGRvZXMgbm90IHNob3cgYW55dGhpbmcgb24gRkItQ29uc29sZS4uLnNl
ZW1zIGFueXRoaW5nIGlzIG1pc3NpbmcKPiAKPiBodHRwczovL2dpdGh1Yi5jb20vZnJhbmstdy9C
UEktUjItNC4xNC90cmVlLzQuMjAtZmJkZXYKPiAKPiBkbWVzZyB8IGdyZXAgJ2ZiXHxmcmFtZWJ1
ZmZlcicKPiBbICAgIDAuMDAwMDAwXSBMaW51eCB2ZXJzaW9uIDQuMjAuMC1yYzctYnBpLXIyLWZi
ZGV2IChmcmFua0BmcmFuay1ONTZWWikgKGdjYyB2ZXJzaW9uIDcuMy4wIChVYnVudHUvTGluYXJv
IDcuMy4wLTI3dWJ1bnR1MX4xOC4wNCkpIDkKPiBbICAgIDAuMDAwMDAwXSBjbWE6IFJlc2VydmVk
IDY0IE1pQiBhdCAweGZiODAwMDAwCj4gWyAgICAwLjAwMDAwMF0gS2VybmVsIGNvbW1hbmQgbGlu
ZTogYm9hcmQ9YnBpLXIyIGNvbnNvbGU9ZWFybHlwcmludGsgY29uc29sZT10dHkxIGZiY29uPW1h
cDowIGNvbnNvbGU9dHR5UzAsMTE1MjAwIHJvb3Q9L2Rldi9tbWNibGs3Cj4gWyAgICA1LjczMzE4
NV0gW2RybTpkcm1fZmJfaGVscGVyX2dlbmVyaWNfcHJvYmVdIHN1cmZhY2Ugd2lkdGgoMTI4MCks
IGhlaWdodCgxMDI0KSBhbmQgYnBwKDMyKQo+IFsgICAgNS43NTQ0NTJdIFtkcm06ZHJtX21vZGVf
YWRkZmIyXSBbRkI6NDRdCj4gWyAgICA1Ljc5Mjg3OF0gbWVkaWF0ZWstZHJtIDE0MDAwMDAwLmRp
c3BzeXM6IGZiMDogRFJNIGVtdWxhdGVkIGZyYW1lIGJ1ZmZlciBkZXZpY2UKPiBbICAgIDUuODE0
MDY3XSBbZHJtOmRybV9mYl9oZWxwZXJfaG90cGx1Z19ldmVudC5wYXJ0LjExXSAKPiBbICAgIDYu
MjAzMDgzXSBtZWRpYXRlay1kcm0gMTQwMDAwMDAuZGlzcHN5czogW2RybTpkcm1fY2xpZW50X2Rl
dl9ob3RwbHVnXSBmYmRldjogcmV0PTAKPiBbICAgMjQuOTMwMzQ3XSBtZWRpYXRlay1kcm0gMTQw
MDAwMDAuZGlzcHN5czogW2RybTpkcm1fY2xpZW50X2Rldl9yZXN0b3JlXSBmYmRldjogcmV0PTAK
PiBbICAgMjUuMTk2ODcyXSBtZWRpYXRlay1kcm0gMTQwMDAwMDAuZGlzcHN5czogW2RybTpkcm1f
Y2xpZW50X2Rldl9yZXN0b3JlXSBmYmRldjogcmV0PTAKPiBbICAgMjUuMjgxMTg0XSBbZHJtOmRy
bV9tb2RlX2FkZGZiMl0gW0ZCOjQ5XQo+IFsgICAyNy45NDc5NjJdIFtkcm06ZHJtX21vZGVfYWRk
ZmIyXSBbRkI6NDldCgpUaGUgbG9nIGRvZXMgbm90IHNob3cgYW55IGluZm9ybWF0aW9uIG9mIGVy
cm9yLCBidXQgaXQgY2xvc2UgZmJkZXYgYXQKdGhlIHRpbWUgMjQuOTMwMzQ3LgoKSSBqdXN0IHRl
c3Qgdm1hcCgpIGJ5IHdyaXRpbmcgd2hpdGUgY29sb3IgaW50byBmcmFtZWJ1ZmZlciBhZnRlciB2
bWFwKCkKYW5kIHVzZSB1c2VyIHNwYWNlIHByb2dyYW0gdG8gY29udHJvbCBmYmRldiB0byBzaG93
IHRoaXMgZnJhbWVidWZmZXIgYW5kCnRoZSBwYW5lbCBzaG93cyB3aGl0ZSBzY3JlZW4uIFNvIEkg
YmVsaWV2ZSB0aGF0IHZtYXAoKSBhbmQgZmJkZXYgd29ya3MKZmluZSwgYnV0IEknbSBub3Qgc3Vy
ZSB3aGF0IGhhcHBlbiB0byBmYmNvbi4gSSB3b3VsZCB0cnkgdG8gc2V0dXAgZmJjb24KdG8gZmlu
ZCBvdXQgdGhlIGJ1Zy4gSWYgeW91IGNvdWxkIHRyeSB0byBkZWJ1ZyBwYXJhbGxlbGx5LCBpdCB3
b3VsZCBiZQptdWNoIGhlbHAuCgpSZWdhcmRzLApDSwoKPiAKPiByZWdhcmRzIEZyYW5rCj4gCj4g
Cj4gPiBHZXNlbmRldDogTWl0dHdvY2gsIDE2LiBKYW51YXIgMjAxOSB1bSAwMjozOSBVaHIKPiA+
IFZvbjogIkNLIEh1IiA8Y2suaHVAbWVkaWF0ZWsuY29tPgo+ID4gQW46ICJQaGlsaXBwIFphYmVs
IiA8cC56YWJlbEBwZW5ndXRyb25peC5kZT4sICJEYXZpZCBBaXJsaWUiIDxhaXJsaWVkQGxpbnV4
LmllPiwgIkRhbmllbCBWZXR0ZXIiIDxkYW5pZWxAZmZ3bGwuY2g+LCAiTWF0dGhpYXMgQnJ1Z2dl
ciIgPG1hdHRoaWFzLmJnZ0BnbWFpbC5jb20+LCAiTm9yYWxmIFRy77+9bm5lcyIgPG5vcmFsZkB0
cm9ubmVzLm9yZz4sICJGcmFuayBXdW5kZXJsaWNoIiA8ZnJhbmstd0BwdWJsaWMtZmlsZXMuZGU+
Cj4gPiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZywgbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnLCBsaW51eC1tZWRpYXRla0BsaXN0cy5pbmZyYWRlYWQub3Jn
LCBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnLCBzcnZfaGV1cHN0cmVhbUBtZWRpYXRlay5j
b20sICJDSyBIdSIgPGNrLmh1QG1lZGlhdGVrLmNvbT4KPiA+IEJldHJlZmY6IFtQQVRDSCAyLzJd
IGRybS9tZWRpYXRlazogQWRkIE1lZGlhdGVrIGZyYW1lYnVmZmVyIGRldmljZQo+ID4KPiA+IEZv
ciBNZWRpYXRlayBkcm0gZHJpdmVyLCB1c2UgZmJkZXYgZW11bGF0aW9uIHRvIGNyZWF0ZSBhIGZy
YW1lYnVmZmVyCj4gPiBkZXZpY2UuCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IENLIEh1IDxjay5o
dUBtZWRpYXRlay5jb20+Cj4gPiAtLS0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RybV9kcnYuYyB8IDUgKysrKysKPiA+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCsp
Cj4gPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9k
cnYuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jCj4gPiBpbmRleCA2
ZWM0Y2EwNzAzODIuLjVmY2MwZTI5NDY5NiAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RybV9kcnYuYwo+ID4gQEAgLTE2LDYgKzE2LDcgQEAKPiA+ICAjaW5jbHVkZSA8ZHJt
L2RybV9hdG9taWMuaD4KPiA+ICAjaW5jbHVkZSA8ZHJtL2RybV9hdG9taWNfaGVscGVyLmg+Cj4g
PiAgI2luY2x1ZGUgPGRybS9kcm1fY3J0Y19oZWxwZXIuaD4KPiA+ICsjaW5jbHVkZSA8ZHJtL2Ry
bV9mYl9oZWxwZXIuaD4KPiA+ICAjaW5jbHVkZSA8ZHJtL2RybV9nZW0uaD4KPiA+ICAjaW5jbHVk
ZSA8ZHJtL2RybV9nZW1fY21hX2hlbHBlci5oPgo+ID4gICNpbmNsdWRlIDxkcm0vZHJtX29mLmg+
Cj4gPiBAQCAtMzc4LDYgKzM3OSwxMCBAQCBzdGF0aWMgaW50IG10a19kcm1fYmluZChzdHJ1Y3Qg
ZGV2aWNlICpkZXYpCj4gPiAgCWlmIChyZXQgPCAwKQo+ID4gIAkJZ290byBlcnJfZGVpbml0Owo+
ID4gIAo+ID4gKwlyZXQgPSBkcm1fZmJkZXZfZ2VuZXJpY19zZXR1cChkcm0sIDMyKTsKPiA+ICsJ
aWYgKHJldCkKPiA+ICsJCURSTV9FUlJPUigiRmFpbGVkIHRvIGluaXRpYWxpemUgZmJkZXY6ICVk
XG4iLCByZXQpOwo+ID4gKwo+ID4gIAlyZXR1cm4gMDsKPiA+ICAKPiA+ICBlcnJfZGVpbml0Ogo+
ID4gLS0gCj4gPiAyLjE4LjEKPiA+IAo+ID4KPiAKPiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwo+IExpbnV4LW1lZGlhdGVrIG1haWxpbmcgbGlzdAo+IExp
bnV4LW1lZGlhdGVrQGxpc3RzLmluZnJhZGVhZC5vcmcKPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW1lZGlhdGVrCgoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBs
aXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
