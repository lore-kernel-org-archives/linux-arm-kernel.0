Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B144C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:05:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC04820833
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dO1IX3O9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC04820833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SaXWAk9XvOLJkGUVhly7Of8uuLBHNF+Q82xCAbwPUYQ=; b=dO1IX3O9QFniaN
	unTs7Usdykv+3UdO+gfMXc+xhk+kBrIND8frpYa2IDonzQZ24Kb4VPoOzZ/RITQs/1rxVI7svbJck
	WOnahoP4PdDmCrOjMwr4o3PtcB1fXPWz/Xsmew+Ih2u+ybvj1exk5utB83ER02LzK3XhxrIcMCNEZ
	UivynGVY3OZRqnIsKzF0q09kxoZOGYn/sHr8WGQEOyc3oVtsg3iiPwQbLgP+4FhjzORxDozOpglvQ
	sPjcuHDUYI7QOWMHS/VuX7/tJx+nTsDnf5+FH42eWFjf5jo43GLqQGjx4X4oGfpPYDZ5+vpAC3nWM
	a4qQRr+eYZmCZDzWb8mA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp8I6-0004LW-Lc; Thu, 31 Jan 2019 09:05:46 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp8I3-0004Ic-MQ
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 09:05:45 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gp8I0-0007Qz-GK; Thu, 31 Jan 2019 10:05:40 +0100
Message-ID: <1548925539.6869.36.camel@pengutronix.de>
Subject: Re: [PATCH V3 2/4] dt-bindings: irq: imx-irqsteer: add multi output
 interrupts support
From: Lucas Stach <l.stach@pengutronix.de>
To: Aisheng Dong <aisheng.dong@nxp.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Thu, 31 Jan 2019 10:05:39 +0100
In-Reply-To: <1548921464-28917-3-git-send-email-aisheng.dong@nxp.com>
References: <1548921464-28917-1-git-send-email-aisheng.dong@nxp.com>
 <1548921464-28917-3-git-send-email-aisheng.dong@nxp.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_010543_891942_F179BCD8 
X-CRM114-Status: GOOD (  13.27  )
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

QW0gRG9ubmVyc3RhZywgZGVuIDMxLjAxLjIwMTksIDA4OjAzICswMDAwIHNjaHJpZWIgQWlzaGVu
ZyBEb25nOgo+IE9uZSBpcnFzdGVlciBjaGFubmVsIGNhbiBzdXBwb3J0IHVwIHRvIDggb3V0cHV0
IGludGVycnVwdHMuCj4gCj4gPiBDYzogTWFyYyBaeW5naWVyIDxtYXJjLnp5bmdpZXJAYXJtLmNv
bT4KPiA+IENjOiBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPgo+ID4gQ2M6IEx1Y2Fz
IFN0YWNoIDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPgo+ID4gQ2M6IFNoYXduIEd1byA8c2hhd25n
dW9Aa2VybmVsLm9yZz4KPiBDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcKPiBTaWduZWQt
b2ZmLWJ5OiBEb25nIEFpc2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPgoKUmV2aWV3ZWQtYnk6
IEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPgoKPiAtLS0KPiBDaGFuZ2VMb2c6
Cj4gdjItPnYzOgo+IMKgKiBmaXggYSB0eXBvCj4gdjEtPnYyOgo+IMKgKiByZW1vdmUgb25lIHVu
bmVjZXNzYXJ5IG5vdGUuCj4gLS0tCj4gwqAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1
cHQtY29udHJvbGxlci9mc2wsaXJxc3RlZXIudHh0wqDCoMKgwqDCoMKgwqDCoHwgNSArKystLQo+
IMKgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiAKPiBk
aWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ludGVycnVwdC1j
b250cm9sbGVyL2ZzbCxpcnFzdGVlci50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvZnNsLGlycXN0ZWVyLnR4dAo+IGluZGV4IDZkMGE0
MWIuLjU4Mjk5MWMgMTAwNjQ0Cj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2ludGVycnVwdC1jb250cm9sbGVyL2ZzbCxpcnFzdGVlci50eHQKPiArKysgYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvZnNsLGlycXN0
ZWVyLnR4dAo+IEBAIC02LDggKzYsOSBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOgo+ID4gwqAJLSAi
ZnNsLGlteDhtLWlycXN0ZWVyIgo+ID4gwqAJLSAiZnNsLGlteC1pcnFzdGVlciIKPiDCoC0gcmVn
OiBQaHlzaWNhbCBiYXNlIGFkZHJlc3MgYW5kIHNpemUgb2YgcmVnaXN0ZXJzLgo+IC0tIGludGVy
cnVwdHM6IFNob3VsZCBjb250YWluIHRoZSBwYXJlbnQgaW50ZXJydXB0IGxpbmUgdXNlZCB0byBt
dWx0aXBsZXggdGhlCj4gLcKgwqBpbnB1dCBpbnRlcnJ1cHRzLgo+ICstIGludGVycnVwdHM6IFNo
b3VsZCBjb250YWluIHRoZSB1cCB0byA4IHBhcmVudCBpbnRlcnJ1cHQgbGluZXMgdXNlZCB0bwo+
ICvCoMKgbXVsdGlwbGV4IHRoZSBpbnB1dCBpbnRlcnJ1cHRzLiBUaGV5IHNob3VsZCBiZSBzcGVj
aWZpZWQgc2VxdWVudGlhbGx5Cj4gK8KgwqBmcm9tIG91dHB1dCAwIHRvIDcuCj4gwqAtIGNsb2Nr
czogU2hvdWxkIGNvbnRhaW4gb25lIGNsb2NrIGZvciBlbnRyeSBpbiBjbG9jay1uYW1lcwo+IMKg
wqDCoHNlZSBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svY2xvY2stYmlu
ZGluZ3MudHh0Cj4gwqAtIGNsb2NrLW5hbWVzOgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
