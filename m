Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC93C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:17:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A49F218A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OLIwXTw9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A49F218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hMGFRz7bwVlYIYj2/+noKog6o8feyxNFqO5NcNV8poY=; b=OLIwXTw9si9aca
	hujMBNHOOkGWP82LSb5J+G59GHOXJzlgZFTQF+T3XutteYZNumbIXexanPbAh9pocdqy0EyVqzqvy
	MO3tVgqfCx8kuo1hMHbn6UfhXAOzbHGDOOM+0MwJEYCr2bbYVjGtYCpQUpORFPxysaavQZvz2uCGt
	zqs2TyVjg+Vn8Tm85XTdoGSpPD1BWFtgpliTCn+d9GgjWhGsyuMlcLkPYvZqiOAz0bIlSc/D7ZLJo
	cX0qFFzCKCH+qcFKuiVMbcm1PYibRUyp0jmqNu5ljIDpuU/CQNx6Foy+iEtvRd4h/QXHhS6o7VTcO
	iCmuYd0DKIQcrTO4mm4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gopka-0002vU-2c; Wed, 30 Jan 2019 13:17:56 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gopkV-0002ua-HQ
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 13:17:54 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gopkR-00048q-Kr; Wed, 30 Jan 2019 14:17:47 +0100
Message-ID: <1548854267.6869.21.camel@pengutronix.de>
Subject: Re: [PATCH V2 1/4] dt-binding: irq: imx-irqsteer: use irq number
 instead of group number
From: Lucas Stach <l.stach@pengutronix.de>
To: Aisheng Dong <aisheng.dong@nxp.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Wed, 30 Jan 2019 14:17:47 +0100
In-Reply-To: <1548853196-11447-2-git-send-email-aisheng.dong@nxp.com>
References: <1548853196-11447-1-git-send-email-aisheng.dong@nxp.com>
 <1548853196-11447-2-git-send-email-aisheng.dong@nxp.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_051751_730357_C9EAF067 
X-CRM114-Status: GOOD (  16.91  )
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

QW0gTWl0dHdvY2gsIGRlbiAzMC4wMS4yMDE5LCAxMzowNSArMDAwMCBzY2hyaWViIEFpc2hlbmcg
RG9uZzoKPiBOb3QgYWxsIDY0IGludGVycnVwdHMgbWF5IGJlIHVzZWQgaW4gb25lIGdyb3VwLiBl
LmcuIG1vc3QgaXJxc3RlZXIgaW4KPiBpbXg4cXhwIGFuZCBpbXg4cW0gc3Vic3lzdGVtcyBzdXBw
b3J0cyBvbmx5IDMyIGludGVycnVwdHMuCj4gCj4gQXMgdGhlIElQIGludGVncmF0aW9uIHBhcmFt
ZXRlcnMgYXJlIENoYW5uZWwgbnVtYmVyIGFuZCBpbnRlcnJ1cHRzIG51bWJlciwKPiBsZXQncyB1
c2UgZnNsLG51bS1pcnFzIHRvIHJlcHJlc2VudHMgaG93IG1hbnkgaW50ZXJydXB0cyBzdXBwb3J0
ZWQKPiBieSB0aGlzIGlycXN0ZWVyIGNoYW5uZWwuCj4gCj4gPiBDYzogTWFyYyBaeW5naWVyIDxt
YXJjLnp5bmdpZXJAYXJtLmNvbT4KPiA+IENjOiBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwu
b3JnPgo+ID4gQ2M6IEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPgo+ID4gQ2M6
IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz4KPiBDYzogZGV2aWNldHJlZUB2Z2VyLmtl
cm5lbC5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBEb25nIEFpc2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAu
Y29tPgoKQXMgdGhlIG9yaWdpbmFsIGZzbCxpcnEtZ3JvdXBzIHdhcyBib3JuIG91dCBvZiBhIG1p
c3VuZGVyc3RhbmRpbmcgb2YKdGhlIEhXIGNvbmZpZyBvcHRpb25zIGFuZCBJJ20gbm90IGF3YXJl
IG9mIGFueSB1c2VycyBvZiB0aGUgY3VycmVudApiaW5kaW5nLCBJJ20gZmluZSB3aXRoIG1lcmdp
bmcgdGhpcy4gSSBkbyB0aGluayB0aGlzIHdhcnJhbnRzIGEKYmFja3BvcnQgdG8gc3RhYmxlIHRo
b3VnaCwgc28gd2UgZG9uJ3QgZW5kIHVwIHdpdGggZGlmZmVyZW50IGJpbmRpbmdzCmluIHN0YWJs
ZSBhbmQgY3VycmVudCBrZXJuZWxzLgoKUmV2aWV3ZWQtYnk6IEx1Y2FzIFN0YWNoIDxsLnN0YWNo
QHBlbmd1dHJvbml4LmRlPgoKCj4gLS0tCj4gQ2hhbmdlTG9nOgo+IMKgdjEtPnYyOgo+IMKgICog
Y2hhbmdlIHByb3BlcnR5IG5hbWUgZnNsLGlycXMtcGVyLWNoYW4gdG8gZnNsLG51bS1pcnFzLgo+
IC0tLQo+IMKgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvZnNs
LGlycXN0ZWVyLnR4dMKgwqDCoMKgwqDCoMKgfCA2ICsrKy0tLQo+IMKgMSBmaWxlIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2ZzbCxpcnFz
dGVlci50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW50ZXJydXB0LWNv
bnRyb2xsZXIvZnNsLGlycXN0ZWVyLnR4dAo+IGluZGV4IDQ1NzkwY2UuLjZkMGE0MWIgMTAwNjQ0
Cj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ludGVycnVwdC1jb250
cm9sbGVyL2ZzbCxpcnFzdGVlci50eHQKPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvZnNsLGlycXN0ZWVyLnR4dAo+IEBAIC0xNiw4
ICsxNiw4IEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6Cj4gwqAtICNpbnRlcnJ1cHQtY2VsbHM6IFNw
ZWNpZmllcyB0aGUgbnVtYmVyIG9mIGNlbGxzIG5lZWRlZCB0byBlbmNvZGUgYW4KPiDCoMKgwqBp
bnRlcnJ1cHQgc291cmNlLiBUaGUgdmFsdWUgbXVzdCBiZSAxLgo+IMKgLSBmc2wsY2hhbm5lbDog
VGhlIG91dHB1dCBjaGFubmVsIHRoYXQgYWxsIGlucHV0IElSUXMgc2hvdWxkIGJlIHN0ZWVyZWQg
aW50by4KPiAtLSBmc2wsaXJxLWdyb3VwczogTnVtYmVyIG9mIElSUSBncm91cHMgbWFuYWdlZCBi
eSB0aGlzIGNvbnRyb2xsZXIgaW5zdGFuY2UuCj4gLcKgwqBFYWNoIGdyb3VwIG1hbmFnZXMgNjQg
aW5wdXQgaW50ZXJydXB0cy4KPiArLSBmc2wsbnVtLWlycXM6IE51bWJlciBvZiBpbnB1dCBpbnRl
cnJ1cHRzIG9mIHRoaXMgY2hhbm5lbC4KPiArwqDCoFNob3VsZCBiZSBtdWx0aXBsZSBvZiAzMiBp
bnB1dCBpbnRlcnJ1cHRzIGFuZCB1cCB0byA1MTIgaW50ZXJydXB0cy4KPiDCoAo+IMKgRXhhbXBs
ZToKPiDCoAo+IEBAIC0yOCw3ICsyOCw3IEBAIEV4YW1wbGU6Cj4gPiDCoAkJY2xvY2tzID0gPCZj
bGsgSU1YOE1RX0NMS19ESVNQX0FQQl9ST09UPjsKPiA+IMKgCQljbG9jay1uYW1lcyA9ICJpcGci
Owo+ID4gwqAJCWZzbCxjaGFubmVsID0gPDA+Owo+ID4gLQkJZnNsLGlycS1ncm91cHMgPSA8MT47
Cj4gPiArCQlmc2wsbnVtLWlycXMgPSA8NjQ+Owo+ID4gwqAJCWludGVycnVwdC1jb250cm9sbGVy
Owo+ID4gwqAJCSNpbnRlcnJ1cHQtY2VsbHMgPSA8MT47Cj4gPiDCoAl9OwoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWls
aW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
