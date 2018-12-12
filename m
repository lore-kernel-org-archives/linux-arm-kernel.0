Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326C6C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:26:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F27F120851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Is/V+KYG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQo+w0E2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F27F120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DpD+TWybqR+MJVd4LVtPNXjlyggE7kVVDzwAOMn2IzY=; b=Is/V+KYGDnPpBO
	lQxbsoFNZFIlBk1Yszxra8D5NSAobJs8E9O0nqg+3al4ATrOcT/acMTeIi+oG+5zi5+JffgFqx7Mk
	XltfkeqeDL48+SXB1HVwdmWYmtMYEW8G5tDhm+o3IyrG0TK5Q3DKJLqLLTCsZmnJPw2+wh5U3TntZ
	z2NOmDSoCKe6C0oMBjOmJbOqWFjtMyCHJEgCzfKvRcFYAgwLm0cewM1xXqwEE38o6iivhY9YhNgXx
	kEjwJy5XZNq9c6a8Y/QyZatdZP5zkQIxDkEIp1GZd5o0DITtwznoKvDCsJDxaYhu2HR61b7wnZ/mC
	v1vc1TmzQVWwsRXaUiDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX8HA-0007RT-2l; Wed, 12 Dec 2018 17:26:24 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX8H7-0007QQ-7t
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 17:26:22 +0000
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net
 [81.96.234.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D5BCC2084E;
 Wed, 12 Dec 2018 17:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544635570;
 bh=taLdMqD8uGpTPXnoETTA3FKlb2OmR9x/D/srdsOy7jE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=OQo+w0E2bfvk3XmlNAXG7GpnOJa8Vcl7oKXuJABsiIe8bnn0l8NXh6988aIqAcAhq
 98a9JrxoaB4AAdtyAmNwnNQueYIUFGUD0w2aCFFJtLrYG0aqvRd3bfxrzRy0IDMUJV
 UWs5kedJBLjWW4hVq+IqLG/E8iZmMDe86VvXqwps=
Date: Wed, 12 Dec 2018 17:26:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: iio: adc: exynos-adc: Add S5PV210 variant
Message-ID: <20181212172604.6336779e@archlinux>
In-Reply-To: <20181207191136.5464-4-pawel.mikolaj.chmiel@gmail.com>
References: <20181207191136.5464-1-pawel.mikolaj.chmiel@gmail.com>
 <20181207191136.5464-4-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_092621_292813_B25AA154 
X-CRM114-Status: GOOD (  15.03  )
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
Cc: mark.rutland@arm.com, linux-iio@vger.kernel.org, xc-racer2@live.ca,
 pmeerw@pmeerw.net, freeman.liu@spreadtrum.com, marcus.folkesson@gmail.com,
 lars@metafoo.de, krzk@kernel.org, linux-samsung-soc@vger.kernel.org,
 kgene@kernel.org, geert@linux-m68k.org, devicetree@vger.kernel.org,
 smohanad@codeaurora.org, vilhelm.gray@gmail.com, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, baolin.wang@linaro.org,
 rdunlap@infradead.org, arnaud.pouliquen@st.com, linux-kernel@vger.kernel.org,
 broonie@kernel.org, knaack.h@gmx.de, eugen.hristev@microchip.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCAgNyBEZWMgMjAxOCAyMDoxMTozNiArMDEwMApQYXdlxYIgQ2htaWVsIDxwYXdlbC5t
aWtvbGFqLmNobWllbEBnbWFpbC5jb20+IHdyb3RlOgoKPiBGcm9tOiBKb25hdGhhbiBCYWtrZXIg
PHhjLXJhY2VyMkBsaXZlLmNhPgo+IAo+IEFkZCBpbmZvcm1hdGlvbiBhYm91dCBuZXcgY29tcGF0
aWJsZSBmb3IgUzVQVjIxMAo+IAo+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIEJha2tlciA8eGMt
cmFjZXIyQGxpdmUuY2E+Cj4gU2lnbmVkLW9mZi1ieTogUGF3ZcWCIENobWllbCA8cGF3ZWwubWlr
b2xhai5jaG1pZWxAZ21haWwuY29tPgoKQXBwbGllZCB0byB0aGUgdG9ncmVnIGJyYW5jaCBvZiBp
aW8uZ2l0IGFuZCBwdXNoZWQgb3V0IGFzCnRlc3RpbmcgZm9yIHRoZSBhdXRvYnVpbGRlcnMgdG8g
cGxheSB3aXRoIGl0LgoKVGhhbmtzLAoKSm9uYXRoYW4KCj4gLS0tCj4gIC4uLi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2lpby9hZGMvc2Ftc3VuZyxleHlub3MtYWRjLnR4dCAgICAgICAgfCA0ICsrKy0K
PiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRp
ZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FkYy9zYW1z
dW5nLGV4eW5vcy1hZGMudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lp
by9hZGMvc2Ftc3VuZyxleHlub3MtYWRjLnR4dAo+IGluZGV4IDZjNDlkYjdmOGFkMi4uYTEwYzFm
ODkwMzdkIDEwMDY0NAo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9p
aW8vYWRjL3NhbXN1bmcsZXh5bm9zLWFkYy50eHQKPiArKysgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvaWlvL2FkYy9zYW1zdW5nLGV4eW5vcy1hZGMudHh0Cj4gQEAgLTExLDcg
KzExLDcgQEAgTmV3IGRyaXZlciBoYW5kbGVzIHRoZSBmb2xsb3dpbmcKPiAgCj4gIFJlcXVpcmVk
IHByb3BlcnRpZXM6Cj4gIC0gY29tcGF0aWJsZToJCU11c3QgYmUgInNhbXN1bmcsZXh5bm9zLWFk
Yy12MSIKPiAtCQkJCWZvciBleHlub3M0NDEyLzUyNTAgYW5kIHM1cHYyMTAgY29udHJvbGxlcnMu
Cj4gKwkJCQlmb3IgZXh5bm9zNDQxMi81MjUwIGNvbnRyb2xsZXJzLgo+ICAJCQlNdXN0IGJlICJz
YW1zdW5nLGV4eW5vcy1hZGMtdjIiIGZvcgo+ICAJCQkJZnV0dXJlIGNvbnRyb2xsZXJzLgo+ICAJ
CQlNdXN0IGJlICJzYW1zdW5nLGV4eW5vczMyNTAtYWRjIiBmb3IKPiBAQCAtMjgsNiArMjgsOCBA
QCBSZXF1aXJlZCBwcm9wZXJ0aWVzOgo+ICAJCQkJdGhlIEFEQyBpbiBzM2MyNDQzIGFuZCBjb21w
YXRpYmxlcwo+ICAJCQlNdXN0IGJlICJzYW1zdW5nLHMzYzY0MTAtYWRjIiBmb3IKPiAgCQkJCXRo
ZSBBREMgaW4gczNjNjQxMCBhbmQgY29tcGF0aWJsZXMKPiArCQkJTXVzdCBiZSAic2Ftc3VuZyxz
NXB2MjEwLWFkYyIgZm9yCj4gKwkJCQl0aGUgQURDIGluIHM1cHYyMTAgYW5kIGNvbXBhdGlibGVz
Cj4gIC0gcmVnOgkJCUxpc3Qgb2YgQURDIHJlZ2lzdGVyIGFkZHJlc3MgcmFuZ2UKPiAgCQkJLSBU
aGUgYmFzZSBhZGRyZXNzIGFuZCByYW5nZSBvZiBBREMgcmVnaXN0ZXIKPiAgCQkJLSBUaGUgYmFz
ZSBhZGRyZXNzIGFuZCByYW5nZSBvZiBBRENfUEhZIHJlZ2lzdGVyIChldmVyeQoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
