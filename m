Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A76CC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:36:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1464120870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RLm89ojN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1464120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PAnSZXoxRd1MVB1PPXH/MGt28HJXjA0UKabPjCCNbR0=; b=RLm89ojNtvX9hU
	7CPC6Z2/3l9Fh+UDUQqIiGClyyjSnEylZcUZrexhJWiWIDN/LNnag/rKWWJ6iIM8T9D5ZDEzAWuTG
	SKdkysZ0X8kM+Fru9LlsR3VcFcytw5aewMyqtm7fRl1u7YN7BUhtm3tu4IRueooM075e/qEMwSC4F
	5E2OubbG23tl8FbTqWQg4ZXsKGZi/pFYkxAxMoIkAcSx4jXi6+GCIJnJ+TzR6EEh8k4JNMQuRVboH
	aNJpbHC9dw8MRLS3PASG2akzO4LkSj+M3bFgjgCjOXvT4z0AQUEvrPJYc9Wnu42E5sT7NVum5zAdQ
	jNiqUZbvV6U3Ako5Po1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXS5v-0008Sv-P8; Thu, 13 Dec 2018 14:36:07 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXS5a-0008Bc-Si
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 14:35:49 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gXS5I-00049s-Q5; Thu, 13 Dec 2018 15:35:28 +0100
Message-ID: <1544711727.3137.32.camel@pengutronix.de>
Subject: Re: [PATCH 1/3] arm64: Remove CONFIG_SOC_IMX8MQ and use ARCH_MXC
 instead
From: Lucas Stach <l.stach@pengutronix.de>
To: Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Stephen
 Boyd <sboyd@kernel.org>, Aisheng Dong <aisheng.dong@nxp.com>
Date: Thu, 13 Dec 2018 15:35:27 +0100
In-Reply-To: <1544707047-4417-2-git-send-email-abel.vesa@nxp.com>
References: <1544707047-4417-1-git-send-email-abel.vesa@nxp.com>
 <1544707047-4417-2-git-send-email-abel.vesa@nxp.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_063547_118731_91416FD5 
X-CRM114-Status: GOOD (  16.35  )
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
Cc: Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Olof Johansson <olof@lixom.net>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gRG9ubmVyc3RhZywgZGVuIDEzLjEyLjIwMTgsIDEzOjE3ICswMDAwIHNjaHJpZWIgQWJlbCBW
ZXNhOgo+IFRvIGtlZXAgYWxpZ25lZCB3aXRoIGFybTY0LCByZW1vdmUgdGhlIHVubmVjZXNzYXJ5
IFNPQ19JTVg4TVEgYW5kIHVzZQo+IEFSQ0hfTVhDIGluc3RlYWQuCj4gCj4gU2lnbmVkLW9mZi1i
eTogQWJlbCBWZXNhIDxhYmVsLnZlc2FAbnhwLmNvbT4KPiAtLS0KPiDCoGFyY2gvYXJtNjQvS2Nv
bmZpZy5wbGF0Zm9ybXPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfCA4IC0tLS0tLS0tCj4gwqBhcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9NYWtlZmlsZSB8IDIgKy0KPiDCoGRyaXZlcnMvY2xr
L2lteC9NYWtlZmlsZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHwgMyArKy0KPiDCoGRy
aXZlcnMvcGh5L2ZyZWVzY2FsZS9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqB8IDIgKy0KPiDC
oGRyaXZlcnMvcGluY3RybC9mcmVlc2NhbGUvS2NvbmZpZ8KgwqDCoMKgwqDCoHwgMiArLQo+IMKg
ZHJpdmVycy9zb2MvaW14L0tjb25maWfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHwg
MiArLQo+IMKgNiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygt
KQo+IAo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L0tjb25maWcucGxhdGZvcm1zCj4gYi9hcmNo
L2FybTY0L0tjb25maWcucGxhdGZvcm1zCj4gaW5kZXggN2UxNTQ1YS4uMzE4ZGJiOSAxMDA2NDQK
PiAtLS0gYS9hcmNoL2FybTY0L0tjb25maWcucGxhdGZvcm1zCj4gKysrIGIvYXJjaC9hcm02NC9L
Y29uZmlnLnBsYXRmb3Jtcwo+IEBAIC0xNDgsMTQgKzE0OCw2IEBAIGNvbmZpZyBBUkNIX01YQwo+
IMKgCcKgwqBUaGlzIGVuYWJsZXMgc3VwcG9ydCBmb3IgdGhlIEFSTXY4IGJhc2VkIFNvQ3MgaW4g
dGhlCj4gwqAJwqDCoE5YUCBpLk1YIGZhbWlseS4KPiDCoAo+IC1jb25maWcgU09DX0lNWDhNUQo+
IC0JYm9vbCAiaS5NWDhNUSBzdXBwb3J0Igo+IC0JZGVwZW5kcyBvbiBBUkNIX01YQwo+IC0Jc2Vs
ZWN0IEFSTTY0X0VSUkFUVU1fODQzNDE5Cj4gLQlzZWxlY3QgQVJNNjRfRVJSQVRVTV84NDU3MTkK
PiAtCWhlbHAKPiAtCcKgwqBUaGlzIGVuYWJsZXMgc3VwcG9ydCBmb3IgdGhlIGkuTVg4TVEgU29D
Lgo+IC0KCk5BQ0sgb24gdGhpcyBvbmUuIEhhdmluZyBhIHNpbmdsZSBwbGFjZSB3aGVyZSBzdHVm
ZiB0aGF0IGlzIGFic29sdXRlbHkKY3JpdGljYWwgZm9yIHByb3BlciBTb0Mgb3BlcmF0aW9uIGNh
biBiZSBzZWxlY3RlZCBpcyB2ZXJ5IHVzZWZ1bCBhbmQKYXZvaWRzIGhhcmQgdG8gZGVidWcgaXNz
dWVzIGR1ZSB0byBzbGlnaHRseSB3cm9uZyBjb25maWdzIGluIHRoZSBsb25nCnJ1bi4KClJlZ2Fy
ZHMsCkx1Y2FzCgo+IMKgY29uZmlnIEFSQ0hfUUNPTQo+IMKgCWJvb2wgIlF1YWxjb21tIFBsYXRm
b3JtcyIKPiDCoAlzZWxlY3QgR1BJT0xJQgo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9NYWtlZmlsZQo+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
TWFrZWZpbGUKPiBpbmRleCAwMDAxMzYxLi5mOWJlMjQyIDEwMDY0NAo+IC0tLSBhL2FyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL01ha2VmaWxlCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0
cy9mcmVlc2NhbGUvTWFrZWZpbGUKPiBAQCAtMTksNCArMTksNCBAQCBkdGItJChDT05GSUdfQVJD
SF9MQVlFUlNDQVBFKSArPSBmc2wtbHMyMDg4YS0KPiByZGIuZHRiCj4gwqBkdGItJChDT05GSUdf
QVJDSF9MQVlFUlNDQVBFKSArPSBmc2wtbHgyMTYwYS1xZHMuZHRiCj4gwqBkdGItJChDT05GSUdf
QVJDSF9MQVlFUlNDQVBFKSArPSBmc2wtbHgyMTYwYS1yZGIuZHRiCj4gwqAKPiAtZHRiLSQoQ09O
RklHX1NPQ19JTVg4TVEpICs9IGlteDhtcS1ldmsuZHRiCj4gK2R0Yi0kKENPTkZJR19BUkNIX01Y
QykgKz0gaW14OG1xLWV2ay5kdGIKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvaW14L01ha2Vm
aWxlIGIvZHJpdmVycy9jbGsvaW14L01ha2VmaWxlCj4gaW5kZXggNWMwYjExZS4uNjJhMTg4MiAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL2Nsay9pbXgvTWFrZWZpbGUKPiArKysgYi9kcml2ZXJzL2Ns
ay9pbXgvTWFrZWZpbGUKPiBAQCAtMzQsNSArMzQsNiBAQCBvYmotJChDT05GSUdfU09DX0lNWDZT
WCkgKz0gY2xrLWlteDZzeC5vCj4gwqBvYmotJChDT05GSUdfU09DX0lNWDZVTCkgKz0gY2xrLWlt
eDZ1bC5vCj4gwqBvYmotJChDT05GSUdfU09DX0lNWDdEKcKgwqArPSBjbGstaW14N2Qubwo+IMKg
b2JqLSQoQ09ORklHX1NPQ19JTVg3VUxQKSArPSBjbGstaW14N3VscC5vCj4gLW9iai0kKENPTkZJ
R19TT0NfSU1YOE1RKSArPSBjbGstaW14OG1xLm8KPiDCoG9iai0kKENPTkZJR19TT0NfVkY2MTAp
wqDCoCs9IGNsay12ZjYxMC5vCj4gKwo+ICtvYmotJChDT05GSUdfQVJDSF9NWEMpICs9IGNsay1p
bXg4bXEubwo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BoeS9mcmVlc2NhbGUvS2NvbmZpZwo+IGIv
ZHJpdmVycy9waHkvZnJlZXNjYWxlL0tjb25maWcKPiBpbmRleCBmMDUwYmQ0Li45MjNjMGVmIDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvcGh5L2ZyZWVzY2FsZS9LY29uZmlnCj4gKysrIGIvZHJpdmVy
cy9waHkvZnJlZXNjYWxlL0tjb25maWcKPiBAQCAtMiw0ICsyLDQgQEAgY29uZmlnIFBIWV9GU0xf
SU1YOE1RX1VTQgo+IMKgCXRyaXN0YXRlICJGcmVlc2NhbGUgaS5NWDhNIFVTQjMgUEhZIgo+IMKg
CWRlcGVuZHMgb24gT0YgJiYgSEFTX0lPTUVNCj4gwqAJc2VsZWN0IEdFTkVSSUNfUEhZCj4gLQlk
ZWZhdWx0IFNPQ19JTVg4TVEKPiArCWRlZmF1bHQgQVJDSF9NWEMKPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9waW5jdHJsL2ZyZWVzY2FsZS9LY29uZmlnCj4gYi9kcml2ZXJzL3BpbmN0cmwvZnJlZXNj
YWxlL0tjb25maWcKPiBpbmRleCAyZDZkYjQzLi45ODc0YTE2IDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvcGluY3RybC9mcmVlc2NhbGUvS2NvbmZpZwo+ICsrKyBiL2RyaXZlcnMvcGluY3RybC9mcmVl
c2NhbGUvS2NvbmZpZwo+IEBAIC0xMjMsNyArMTIzLDcgQEAgY29uZmlnIFBJTkNUUkxfSU1YN1VM
UAo+IMKgCj4gwqBjb25maWcgUElOQ1RSTF9JTVg4TVEKPiDCoAlib29sICJJTVg4TVEgcGluY3Ry
bCBkcml2ZXIiCj4gLQlkZXBlbmRzIG9uIFNPQ19JTVg4TVEKPiArCWRlcGVuZHMgb24gQVJDSF9N
WEMKPiDCoAlzZWxlY3QgUElOQ1RSTF9JTVgKPiDCoAloZWxwCj4gwqAJwqDCoFNheSBZIGhlcmUg
dG8gZW5hYmxlIHRoZSBpbXg4bXEgcGluY3RybCBkcml2ZXIKPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9zb2MvaW14L0tjb25maWcgYi9kcml2ZXJzL3NvYy9pbXgvS2NvbmZpZwo+IGluZGV4IDIxMTJk
MTguLjdmZmJiNmIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9zb2MvaW14L0tjb25maWcKPiArKysg
Yi9kcml2ZXJzL3NvYy9pbXgvS2NvbmZpZwo+IEBAIC0yLDcgKzIsNyBAQCBtZW51ICJpLk1YIFNv
QyBkcml2ZXJzIgo+IMKgCj4gwqBjb25maWcgSU1YX0dQQ1YyX1BNX0RPTUFJTlMKPiDCoAlib29s
ICJpLk1YIEdQQ3YyIFBNIGRvbWFpbnMiCj4gLQlkZXBlbmRzIG9uIFNPQ19JTVg3RCB8fCBTT0Nf
SU1YOE1RIHx8IChDT01QSUxFX1RFU1QgJiYgT0YpCj4gKwlkZXBlbmRzIG9uIFNPQ19JTVg3RCB8
fCBBUkNIX01YQyB8fCAoQ09NUElMRV9URVNUICYmIE9GKQo+IMKgCWRlcGVuZHMgb24gUE0KPiDC
oAlzZWxlY3QgUE1fR0VORVJJQ19ET01BSU5TCj4gwqAJZGVmYXVsdCB5IGlmIFNPQ19JTVg3RAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJt
LWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtl
cm5lbAo=
