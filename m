Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611ECC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:46:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FE66218D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Yhp8Z6L1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xX9ceKPk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE66218D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ImUn7uoDMg+hpn3UmCTEZXwUbNDSCsgRjrj5w1X422g=; b=Yhp8Z6L1oVEOGW
	TLw2eLEU9beVLdXOEVDxzRGXN7l0uQla5W9DCE0m9qHpbxiLZD9aLlx83ssoc/OB+SLa3+Mt0NZI+
	/ICuAr/bfqKI/Ol8Tj7IP8D0UsOQSZVjUyfx1XUPcNGmSc7mg7lpoRwgONJHFvXqfDOaCNOU6xdaN
	XqkAh9QlN28j1OtdcJgNexdeWOZXtT6JAz5UJ20eFpUMw+sqaSyknK0hFFzzrgSDimzixDtiuQjBc
	Lwj0Acw+GghaRDw7ei0CDgSZpDMlpr3Wo1ui8+eTW2fhi4LD+aq+L/Ikm94O98rrwD5BJ+a7nrcBf
	TvzzU5uxr0K5ymF5Kknw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmz08-000222-DK; Fri, 25 Jan 2019 10:46:20 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmz05-00021u-Vm
 for linux-arm-kernel@bombadil.infradead.org; Fri, 25 Jan 2019 10:46:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Mime-Version:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QdLbuBVMJOoaYXPaPrRWl5orWOGQfOu1PSKe8aoMLXk=; b=xX9ceKPkpMYT8RN7+EHnPa3SZT
 u7NGYaYE7WvVvK6X/NzKoVA3YNsd5FxuGEez8nPPEifrMN2HNVBOEFQ5LZGtTsuoP09Fi95WuUB8N
 mkpMtweHDLN46os5ORiK8bqzDY+qJ9MDcMZKRAP/vSN2Q3S227yyWRzvIRwzunl2PP9E4ynhcb2X2
 6ljwp29Ny4vUxfcx+GZmLJKd6eGsbu7TR0ktGlp/kMWfHjkHHoCnNRj1FY6aq21SZxITnyp+He/UA
 GihjpMQPKe3mE0OhCtxNg7K5iCALc9tixTzXcCG+wJV6gyK86DD8kkJqVTOkFtdo9TZh0vc4K4G5g
 KH5D+OgQ==;
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmz02-00041q-WE
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 10:46:16 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gmyzy-0002eL-5v; Fri, 25 Jan 2019 11:46:10 +0100
Message-ID: <1548413169.28802.43.camel@pengutronix.de>
Subject: Re: [PATCH 2/4] dt-bindings: irq: imx-irqsteer: add multi output
 interrupts support
From: Lucas Stach <l.stach@pengutronix.de>
To: Aisheng Dong <aisheng.dong@nxp.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Fri, 25 Jan 2019 11:46:09 +0100
In-Reply-To: <1547797668-30342-3-git-send-email-aisheng.dong@nxp.com>
References: <1547797668-30342-1-git-send-email-aisheng.dong@nxp.com>
 <1547797668-30342-3-git-send-email-aisheng.dong@nxp.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_054615_236011_686A91D7 
X-CRM114-Status: GOOD (  16.08  )
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
PiA+IENjOiBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPgo+ID4gQ2M6IEx1Y2FzIFN0
YWNoIDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPgo+ID4gQ2M6IFNoYXduIEd1byA8c2hhd25ndW9A
a2VybmVsLm9yZz4KPiBDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcKPiA+IFNpZ25lZC1v
ZmYtYnk6IERvbmcgQWlzaGVuZyA8YWlzaGVuZy5kb25nQG54cC5jb20+Cj4gLS0tCj4gwqAuLi4v
ZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9mc2wsaXJxc3RlZXIudHh0
wqDCoMKgwqDCoMKgwqDCoHwgNSArKystLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2ZzbCxpcnFzdGVlci50eHQgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvZnNs
LGlycXN0ZWVyLnR4dAo+IGluZGV4IGVhYWJjZGEuLmJlZWVkNGEgMTAwNjQ0Cj4gLS0tIGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2ZzbCxp
cnFzdGVlci50eHQKPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW50
ZXJydXB0LWNvbnRyb2xsZXIvZnNsLGlycXN0ZWVyLnR4dAo+IEBAIC02LDggKzYsOSBAQCBSZXF1
aXJlZCBwcm9wZXJ0aWVzOgo+ID4gwqAJLSAiZnNsLGlteDhtLWlycXN0ZWVyIgo+ID4gwqAJLSAi
ZnNsLGlteC1pcnFzdGVlciIKPiDCoC0gcmVnOiBQaHlzaWNhbCBiYXNlIGFkZHJlc3MgYW5kIHNp
emUgb2YgcmVnaXN0ZXJzLgo+IC0tIGludGVycnVwdHM6IFNob3VsZCBjb250YWluIHRoZSBwYXJl
bnQgaW50ZXJydXB0IGxpbmUgdXNlZCB0byBtdWx0aXBsZXggdGhlCj4gLcKgwqBpbnB1dCBpbnRl
cnJ1cHRzLgo+ICstIGludGVycnVwdHM6IFNob3VsZCBjb250YWluIHRoZSB1cCB0byA4IHBhcmVu
dCBpbnRlcnJ1cHQgbGluZXMgdXNlZCB0bwo+ICvCoMKgbXVsdGlwbGV4IHRoZSBpbnB1dCBpbnRl
cnJ1cHRzLiBUaGV5IHNob3VsZCBiZSBzZXBjaWZpZWQgc2VxZW5jaWFsbHkKPiArwqDCoGZyb20g
b3V0cHV0IDAgdG8gNy4gTk9URSBhdCBsZWFzdCBvbmUgb3V0cHV0IGludGVycnVwdCBoYXMgdG8g
YmUgc3BlY2lmaWVkLgoKSSBkb24ndCB0aGluayB0aGUgbm90ZSBjbGFyaWZpZXMgYW55dGhpbmcu
IEdpdmVuIHRoYXQgdGhlIHRoaW5nIGlzIGEKaXJxIG11bHRpcGxleGVyIEkgZG9uJ3QgdGhpbmsg
YW55b25lIGV4cGVjdHMgdGhhdCB5b3UgY291bGQgZ2V0IGF3YXkKd2l0aCBubyBvdXRwdXQgaXJx
LgoKSWYgYW55dGhpbmcgdGhpcyBzaG91bGQgc3BlY2lmeSB0aGF0IGl0J3MgYWx3YXlzIGdyb3Vw
cyBvZiAodXAgdG8pIDY0CmlucHV0IGlycXMgYmVpbmcgbXV4ZWQgb250byBhIHNpbmdsZSBvdXRw
dXQgaXJxLgoKUmVnYXJkcywKTHVjYXMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
