Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1910DC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:18:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD6A020857
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="id0SnOYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD6A020857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hZ1wEE7zoWIVeQs5qCq6sNGHpAR5hvnV9NF9kqdAlqE=; b=id0SnOYI4YfPoB
	CM0QRVsx7h5ob2U5+G8eYXcH807OhpWspTuFSh3HNGar/0nEeQDE6GE5xHLJ1c9aW8ggDyPAQUMOg
	3Jnnmy5g2ixvvsA26H6K2r8xkOOtW+a90263p8KQzHxV81oYinq3o84t4guM0GarpS9dhheyasUE7
	osoRXyXKvEzH7FW4Q3gDcDy2bLPYwYwE9nBKNMxGeivbLN7kLCeMNucpHZRZU0UHt6QO5qVxn5d8A
	6NSSsLcrlbIoAMZpTsARnPvGMiY/wdlqes4EuntVabhko4oeub9Djr/DWPCjIIlO0OfJYl1zdrSty
	BEVJOIibRAnmb/nWSWZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goplZ-0003lG-3u; Wed, 30 Jan 2019 13:18:57 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goplV-0003kG-DF
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 13:18:54 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1goplS-0004Fy-QO; Wed, 30 Jan 2019 14:18:50 +0100
Message-ID: <1548854330.6869.22.camel@pengutronix.de>
Subject: Re: [PATCH V2 2/4] dt-bindings: irq: imx-irqsteer: add multi output
 interrupts support
From: Lucas Stach <l.stach@pengutronix.de>
To: Aisheng Dong <aisheng.dong@nxp.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Wed, 30 Jan 2019 14:18:50 +0100
In-Reply-To: <1548853196-11447-3-git-send-email-aisheng.dong@nxp.com>
References: <1548853196-11447-1-git-send-email-aisheng.dong@nxp.com>
 <1548853196-11447-3-git-send-email-aisheng.dong@nxp.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_051853_599761_274832E0 
X-CRM114-Status: GOOD (  13.36  )
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
RG9uZzoKPiBPbmUgaXJxc3RlZXIgY2hhbm5lbCBjYW4gc3VwcG9ydCB1cCB0byA4IG91dHB1dCBp
bnRlcnJ1cHRzLgo+IAo+ID4gQ2M6IE1hcmMgWnluZ2llciA8bWFyYy56eW5naWVyQGFybS5jb20+
Cj4gPiBDYzogUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz4KPiA+IENjOiBMdWNhcyBT
dGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT4KPiA+IENjOiBTaGF3biBHdW8gPHNoYXduZ3Vv
QGtlcm5lbC5vcmc+Cj4gQ2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnCj4gPiBTaWduZWQt
b2ZmLWJ5OiBEb25nIEFpc2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPgo+IC0tLQo+IENoYW5n
ZUxvZzoKPiB2MS0+djI6Cj4gwqAqIHJlbW92ZSBvbmUgdW5uZWNlc3Nhcnkgbm90ZS4KPiAtLS0K
PiDCoC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2ZzbCxpcnFz
dGVlci50eHTCoMKgwqDCoMKgwqDCoMKgfCA1ICsrKy0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvZnNsLGlycXN0ZWVy
LnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJv
bGxlci9mc2wsaXJxc3RlZXIudHh0Cj4gaW5kZXggNmQwYTQxYi4uOTg0YWI5MiAxMDA2NDQKPiAt
LS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xs
ZXIvZnNsLGlycXN0ZWVyLnR4dAo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9mc2wsaXJxc3RlZXIudHh0Cj4gQEAgLTYsOCArNiw5
IEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6Cj4gPiDCoAktICJmc2wsaW14OG0taXJxc3RlZXIiCj4g
PiDCoAktICJmc2wsaW14LWlycXN0ZWVyIgo+IMKgLSByZWc6IFBoeXNpY2FsIGJhc2UgYWRkcmVz
cyBhbmQgc2l6ZSBvZiByZWdpc3RlcnMuCj4gLS0gaW50ZXJydXB0czogU2hvdWxkIGNvbnRhaW4g
dGhlIHBhcmVudCBpbnRlcnJ1cHQgbGluZSB1c2VkIHRvIG11bHRpcGxleCB0aGUKPiAtwqDCoGlu
cHV0IGludGVycnVwdHMuCj4gKy0gaW50ZXJydXB0czogU2hvdWxkIGNvbnRhaW4gdGhlIHVwIHRv
IDggcGFyZW50IGludGVycnVwdCBsaW5lcyB1c2VkIHRvCj4gK8KgwqBtdWx0aXBsZXggdGhlIGlu
cHV0IGludGVycnVwdHMuIFRoZXkgc2hvdWxkIGJlIHNlcGNpZmllZCBzZXFlbmNpYWxseQoKVHlw
b3MgaGVyZSwgc2hvdWxkIGJlOiAic3BlY2lmaWVkIHNlcXVlbnRpYWxseSIKCj4gK8KgwqBmcm9t
IG91dHB1dCAwIHRvIDcuCj4gwqAtIGNsb2NrczogU2hvdWxkIGNvbnRhaW4gb25lIGNsb2NrIGZv
ciBlbnRyeSBpbiBjbG9jay1uYW1lcwo+IMKgwqDCoHNlZSBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvY2xvY2svY2xvY2stYmluZGluZ3MudHh0Cj4gwqAtIGNsb2NrLW5hbWVzOgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJt
LWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtl
cm5lbAo=
