Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E72C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:42:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4646F20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f0xV88xS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4646F20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fmxwPQucifThSeoOTIFh3ugU1cAclYzSEWQfdH/iCVs=; b=f0xV88xSSZMKxN
	CG+3g1TyksmdEZkt6xwbN+46v54hiOxOpiUSznj2UjirT8gw2gSjJpi2iOL9gjlgY9VGc3TK5ba64
	cjtDdf0DlNupGCTjbFT9eqMRDgrNpB0wbJwiuFcIaIMxWAoqOl3S/sOMMi5VAMj83TXWOpQC5Pytf
	mq3EMdBvAzInHP/jL5wH3MFB8sAk5NJ5dpd23ldEZHDm6qunV9Q9e2xV5nrX1PsTeEOcGEjE8LUXC
	yujBDB55QhWz7Kmaih2hUafZSs9v0c5sO0PPuwCkUdY0c0jpGj6ekst33NGi2fizO/9xd03NKesfW
	sVi5A//UOEDcUMR6QSRw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUqAR-0006lQ-Bf; Thu, 06 Dec 2018 09:41:59 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUqAL-0006cI-2H
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 09:41:57 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gUqA2-00018n-QO; Thu, 06 Dec 2018 10:41:34 +0100
Message-ID: <1544089293.3709.53.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/3] PCI: imx: No-op imx6_setup_phy_mpll() on i.MX7D
From: Lucas Stach <l.stach@pengutronix.de>
To: Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pci@vger.kernel.org
Date: Thu, 06 Dec 2018 10:41:33 +0100
In-Reply-To: <20181206073545.10967-2-andrew.smirnov@gmail.com>
References: <20181206073545.10967-1-andrew.smirnov@gmail.com>
 <20181206073545.10967-2-andrew.smirnov@gmail.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_014153_259425_FF1618C9 
X-CRM114-Status: GOOD (  13.69  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>,
 linux-imx@nxp.com, bhelgaas@google.com,
 Leonard Crestez <leonard.crestez@nxp.com>, cphealy@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gTWl0dHdvY2gsIGRlbiAwNS4xMi4yMDE4LCAyMzozNSAtMDgwMCBzY2hyaWViIEFuZHJleSBT
bWlybm92Ogo+IFBDSUUgUEhZIElQIGJsb2NrIG9uIGkuTVg3RCBkaWZmZXJzIGZyb20gdGhlIG9u
ZSB1c2VkIG9uIGkuTVg2Cj4gZmFtaWx5LAo+IHNvIG5vbmUgb2YgdGhlIGNvZGUgaW4gY3VycmVu
dCBpbXBsZW1lbnRhdGlvbiBvZgo+IGlteDZfc2V0dXBfcGh5X21wbGwoKQo+IGlzIGFwcGxpY2Fi
bGUuCj4gCj4gQ2M6IGJoZWxnYWFzQGdvb2dsZS5jb20KPiBDYzogRmFiaW8gRXN0ZXZhbSA8ZmFi
aW8uZXN0ZXZhbUBueHAuY29tPgo+IENjOiBjcGhlYWx5QGdtYWlsLmNvbQo+IENjOiBsLnN0YWNo
QHBlbmd1dHJvbml4LmRlCj4gQ2M6IExlb25hcmQgQ3Jlc3RleiA8bGVvbmFyZC5jcmVzdGV6QG54
cC5jb20+Cj4gQ2M6ICJBLnMuIERvbmciIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4KPiBDYzogUmlj
aGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPgo+IENjOiBsaW51eC1pbXhAbnhwLmNvbQo+
IENjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKPiBDYzogbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZwo+IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnCj4gVGVz
dGVkLWJ5OiBUcmVudCBQaWVwaG8gPHRwaWVwaG9AaW1waW5qLmNvbT4KPiBTaWduZWQtb2ZmLWJ5
OiBBbmRyZXkgU21pcm5vdiA8YW5kcmV3LnNtaXJub3ZAZ21haWwuY29tPgoKUmV2aWV3ZWQtYnk6
IEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPgoKPiAtLS0KPiDCoGRyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMgfCAzICsrKwo+IMKgMSBmaWxlIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2ktaW14Ni5jCj4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5j
Cj4gaW5kZXggMmNiZWYyZDdjMjA3Li5jMTQwZjc5ODc1OTggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYwo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvZHdjL3BjaS1pbXg2LmMKPiBAQCAtNTI1LDYgKzUyNSw5IEBAIHN0YXRpYyBpbnQgaW14
Nl9zZXR1cF9waHlfbXBsbChzdHJ1Y3QgaW14Nl9wY2llCj4gKmlteDZfcGNpZSkKPiDCoAlpbnQg
bXVsdCwgZGl2Owo+IMKgCXUzMiB2YWw7Cj4gwqAKPiArCWlmIChpbXg2X3BjaWUtPnZhcmlhbnQg
PT0gSU1YN0QpCj4gKwkJcmV0dXJuIDA7Cj4gKwo+IMKgCXN3aXRjaCAocGh5X3JhdGUpIHsKPiDC
oAljYXNlIDEyNTAwMDAwMDoKPiDCoAkJLyoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
