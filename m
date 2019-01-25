Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8050FC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:54:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50CF520881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="InCu+2YO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wIInP2ld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50CF520881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iVmInWUM9/PXeBb0qdzVLDpysnrJWWq40L8+fNN9FHI=; b=InCu+2YOoywFWM
	CHS4ZxeiAwyqDGIPewJyshTIackW+FWA9GgdEzBuD5WY+3N9TVPYyK42Nse8AtPrK//4PH/th4M2V
	Db4CVzFpmQ2fwqiII12nCddej2BaiXkWwJhkIXzcJkLXwq1NyxP11Rc4SVl8eLpYr0qSDXg+9n+jn
	pWkYoQkrCwrnLo/KBstHRuDuz9Qw8aplDUrji5ZbrbW6/j2Qy50zMr62dXVRpNcwklOKAb9sIPeWx
	IFfciShxUiGd5z8a+lBGImxOh4JtJJNHfwng7l50XtMCcnhq36Zu7Tovqs/RYK6SJiuDyP86+7ovu
	jK/eMnpQL0SM8mpIJ0MA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmz8F-0004q3-1e; Fri, 25 Jan 2019 10:54:43 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmz8D-0004pk-Gv
 for linux-arm-kernel@bombadil.infradead.org; Fri, 25 Jan 2019 10:54:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Mime-Version:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OANXAbr+jPlAa6OwHHjhCaU/TYdPMvO5xNrvxkSoFBE=; b=wIInP2ldb2Sr63qdFxAJfLvoPp
 9FuzUY4v1Bu5VZ1UWfNophHlmftNOx5UftsTRP9iIgyMxLIURLKEd/lHxrUjYXp84HfElHjPLSuVm
 cMK9c0iEnV3OeL+3+cStoFf48TANiDNYiK8Xk1KSE0J2ZiYzKRV54nelRPEvffTmwB8ywECZYl9sj
 h+MhOz8lUyRh1WiMr/OFC+ATR+O6lCNXqxufmh1GZr0kwq7pEg8XlIt1ro5gaY4haqWQhiI8QIvrm
 Kp7+fH1o0B5HbgvPNGF6SwSG96TMpUcuYVkA0x0xT9t8D6mPTj/uFa9b0ffDpnMbmaapgRKtqoGlp
 OHYmKHZQ==;
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmz8A-00044T-Qk
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 10:54:39 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gmz88-0003cp-Dj; Fri, 25 Jan 2019 11:54:36 +0100
Message-ID: <1548413675.28802.45.camel@pengutronix.de>
Subject: Re: [PATCH 4/4] irq: imx: irqsteer: add multi output interrupts
 support
From: Lucas Stach <l.stach@pengutronix.de>
To: Aisheng Dong <aisheng.dong@nxp.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Fri, 25 Jan 2019 11:54:35 +0100
In-Reply-To: <1547797668-30342-5-git-send-email-aisheng.dong@nxp.com>
References: <1547797668-30342-1-git-send-email-aisheng.dong@nxp.com>
 <1547797668-30342-5-git-send-email-aisheng.dong@nxp.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_055439_011492_364528E4 
X-CRM114-Status: GOOD (  20.79  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gRnJlaXRhZywgZGVuIDE4LjAxLjIwMTksIDA3OjUzICswMDAwIHNjaHJpZWIgQWlzaGVuZyBE
b25nOgo+IE9uZSBpcnFzdGVlciBjaGFubmVsIGNhbiBzdXBwb3J0IHVwIHRvIDggb3V0cHV0IGlu
dGVycnVwdHMuCj4gCj4gPiBDYzogTWFyYyBaeW5naWVyIDxtYXJjLnp5bmdpZXJAYXJtLmNvbT4K
PiA+IENjOiBMdWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT4KPiA+IENjOiBTaGF3
biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBEb25nIEFpc2hl
bmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPgo+IC0tLQo+IMKgZHJpdmVycy9pcnFjaGlwL2lycS1p
bXgtaXJxc3RlZXIuYyB8IDM5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0t
Cj4gwqAxIGZpbGUgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCj4g
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaXJxY2hpcC9pcnEtaW14LWlycXN0ZWVyLmMgYi9kcml2
ZXJzL2lycWNoaXAvaXJxLWlteC1pcnFzdGVlci5jCj4gaW5kZXggMWJlYmYwYS4uNTQ4MDJmYSAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL2lycWNoaXAvaXJxLWlteC1pcnFzdGVlci5jCj4gKysrIGIv
ZHJpdmVycy9pcnFjaGlwL2lycS1pbXgtaXJxc3RlZXIuYwo+IEBAIC0xMCw2ICsxMCw3IEBACj4g
wqAjaW5jbHVkZSA8bGludXgvaXJxY2hpcC9jaGFpbmVkX2lycS5oPgo+IMKgI2luY2x1ZGUgPGxp
bnV4L2lycWRvbWFpbi5oPgo+IMKgI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPgo+ICsjaW5jbHVk
ZSA8bGludXgvb2ZfaXJxLmg+Cj4gwqAjaW5jbHVkZSA8bGludXgvb2ZfcGxhdGZvcm0uaD4KPiDC
oCNpbmNsdWRlIDxsaW51eC9zcGlubG9jay5oPgo+IMKgCj4gQEAgLTIxLDEwICsyMiwxMyBAQAo+
ID4gwqAjZGVmaW5lIENIQU5fTUlOVERJUyh0KQkJKENUUkxfU1RSSURFX09GRih0LCAzKSArIDB4
NCkKPiA+IMKgI2RlZmluZSBDSEFOX01BU1RSU1RBVCh0KQkoQ1RSTF9TVFJJREVfT0ZGKHQsIDMp
ICsgMHg4KQo+IMKgCj4gPiArI2RlZmluZSBDSEFOX01BWF9PVVRQVVRfSU5UCTB4OAo+ICsKPiDC
oHN0cnVjdCBpcnFzdGVlcl9kYXRhIHsKPiA+ID4gwqAJdm9pZCBfX2lvbWVtCQkqcmVnczsKPiA+
ID4gwqAJc3RydWN0IGNsawkJKmlwZ19jbGs7Cj4gPiA+IC0JaW50CQkJaXJxOwo+ID4gPiArCWlu
dAkJCWlycVtDSEFOX01BWF9PVVRQVVRfSU5UXTsKPiA+ID4gKwlpbnQJCQlpcnFfY291bnQ7Cj4g
PiA+IMKgCXJhd19zcGlubG9ja190CQlsb2NrOwo+ID4gPiDCoAlpbnQJCQlyZWdfbnVtOwo+ID4g
PiDCoAlpbnQJCQljaGFubmVsOwo+IEBAIC0xMTcsNyArMTIxLDcgQEAgc3RhdGljIGludCBpbXhf
aXJxc3RlZXJfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPiA+IMKgCXN0cnVj
dCBkZXZpY2Vfbm9kZSAqbnAgPSBwZGV2LT5kZXYub2Zfbm9kZTsKPiA+IMKgCXN0cnVjdCBpcnFz
dGVlcl9kYXRhICpkYXRhOwo+ID4gwqAJc3RydWN0IHJlc291cmNlICpyZXM7Cj4gPiAtCWludCBy
ZXQ7Cj4gPiArCWludCBpLCByZXQ7Cj4gwqAKPiA+IMKgCWRhdGEgPSBkZXZtX2t6YWxsb2MoJnBk
ZXYtPmRldiwgc2l6ZW9mKCpkYXRhKSwgR0ZQX0tFUk5FTCk7Cj4gPiDCoAlpZiAoIWRhdGEpCj4g
QEAgLTEzMCwxMiArMTM0LDYgQEAgc3RhdGljIGludCBpbXhfaXJxc3RlZXJfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikKPiA+IMKgCQlyZXR1cm4gUFRSX0VSUihkYXRhLT5yZWdz
KTsKPiA+IMKgCX0KPiDCoAo+ID4gLQlkYXRhLT5pcnEgPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYs
IDApOwo+ID4gLQlpZiAoZGF0YS0+aXJxIDw9IDApIHsKPiA+IC0JCWRldl9lcnIoJnBkZXYtPmRl
diwgImZhaWxlZCB0byBnZXQgaXJxXG4iKTsKPiA+IC0JCXJldHVybiAtRU5PREVWOwo+ID4gLQl9
Cj4gLQo+ID4gwqAJZGF0YS0+aXBnX2NsayA9IGRldm1fY2xrX2dldCgmcGRldi0+ZGV2LCAiaXBn
Iik7Cj4gPiDCoAlpZiAoSVNfRVJSKGRhdGEtPmlwZ19jbGspKSB7Cj4gPiDCoAkJcmV0ID0gUFRS
X0VSUihkYXRhLT5pcGdfY2xrKTsKPiBAQCAtMTc3LDggKzE3NSwyMyBAQCBzdGF0aWMgaW50IGlt
eF9pcnFzdGVlcl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+ID4gwqAJCXJl
dHVybiAtRU5PTUVNOwo+ID4gwqAJfQo+IMKgCj4gPiAtCWlycV9zZXRfY2hhaW5lZF9oYW5kbGVy
X2FuZF9kYXRhKGRhdGEtPmlycSwgaW14X2lycXN0ZWVyX2lycV9oYW5kbGVyLAo+ID4gLQkJCQkJ
wqBkYXRhKTsKPiArCWRhdGEtPmlycV9jb3VudCA9IG9mX2lycV9jb3VudChucCk7CgpXZSBub3Jt
YWxseSBkb24ndCB2YWxpZGF0ZSBzdHVmZiB0aGF0IGNvbWVzIGZyb20gdGhlIERULCBidXQgSSBn
dWVzcyBpdAptaWdodCBiZSBoZWxwZnVsIHRvIHZhbGlkYXRlIHRoYXQgdGhlIG51bWJlciBvZiBv
dXRwdXQgaXJxcyBzcGVjaWZpZWQKbWF0Y2hlcyB3aGF0IHRoZSBudW1iZXIgb2YgaW5wdXQgaXJx
cywgaS5lLiB0aGVyZSBpcyBvbmUgb3V0cHV0IGlycXMKc3BlY2lmaWVkIGZvciBlYWNoIGdyb3Vw
IG9mIDY0IGlucHV0cy4KCj4gKwlpZiAoIWRhdGEtPmlycV9jb3VudCB8fCBkYXRhLT5pcnFfY291
bnQgPiBDSEFOX01BWF9PVVRQVVRfSU5UKSB7Cj4gPiArCQljbGtfZGlzYWJsZV91bnByZXBhcmUo
ZGF0YS0+aXBnX2Nsayk7Cj4gPiArCQlyZXR1cm4gLUVJTlZBTDsKPiA+ICsJfQo+ICsKPiA+ICsJ
Zm9yIChpID0gMDsgaSA8IGRhdGEtPmlycV9jb3VudDsgaSsrKSB7Cj4gPiArCQlkYXRhLT5pcnFb
aV0gPSBpcnFfb2ZfcGFyc2VfYW5kX21hcChucCwgaSk7Cj4gPiArCQlpZiAoIWRhdGEtPmlycVtp
XSkgewo+ID4gKwkJCWNsa19kaXNhYmxlX3VucHJlcGFyZShkYXRhLT5pcGdfY2xrKTsKPiA+ICsJ
CQlyZXR1cm4gLUVJTlZBTDsKPiA+ICsJCX0KPiArCj4gPiArCQlpcnFfc2V0X2NoYWluZWRfaGFu
ZGxlcl9hbmRfZGF0YShkYXRhLT5pcnFbaV0sCj4gPiArCQkJCQkJwqBpbXhfaXJxc3RlZXJfaXJx
X2hhbmRsZXIsCj4gKwkJCQkJCcKgZGF0YSk7CgpXZSByZWFsbHkgd2FudCBzb21lIGRhdGEgYWJv
dXQgdGhlIG91dHB1dCBpcnEgYmVpbmcgcGFzc2VkIGhlcmUsIHNvIHdlCmNhbiBjdXQgZG93biB0
aGUgbnVtYmVyIG9mIHJlZ2lzdGVyIHJlYWRzIGluIHRoZSBpcnEgaGFuZGxlciB0byB0aGUKbWF4
aW11bSBvZiAyIHN0YXR1cyByZWdpc3RlcnMgcGVyIGdyb3VwLgoKUmVnYXJkcywKTHVjYXMKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1r
ZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJu
ZWwK
