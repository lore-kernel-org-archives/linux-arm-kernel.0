Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3BAC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:11:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5979B20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l/V3HtRa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5979B20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eGSU65m1MarinNqjE41E8Mi4Je8K45oFOaw/zK2M2jE=; b=l/V3HtRaGQq532
	0Qq0HyOLCd1aU3NrhE5Lg3YPnzcX7M7MGLv2AbHEDqfP5/ciHnyR8xI0xzYBoMtTECBvffuuGKseF
	0ChKsqNK0iarAT6i/9V8HP1WtJNcSMZ6mskghLbyWiEsKNMrk7gSh/Hkr5FCuB+TwcESgdzigcerK
	V5/qZdWQnsKCJ6I8eHSyc6LzFUidgYa9h7hulAZrTqIUdMTdO6mMdXfmgW2pBFm5QJIO1n8xg1qf+
	8N8QaSS5MC9bcE5CAPog8x5xn7dKb0NcN2/rOaLqXML7qrEc1dvfJUEXd7lUY5n6S8Vm0d17BWUFK
	BCdXSXSxRjV7I4X40LLA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUrYl-0004NW-Ke; Thu, 06 Dec 2018 11:11:11 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUrYa-0004Cf-D2
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 11:11:04 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gUrYG-0003M3-AX; Thu, 06 Dec 2018 12:10:40 +0100
Message-ID: <1544094639.3709.58.camel@pengutronix.de>
Subject: Re: [PATCH 1/5] irqchip/irq-imx-gpcv2: Remove unused code
From: Lucas Stach <l.stach@pengutronix.de>
To: Andrey Smirnov <andrew.smirnov@gmail.com>, Marc Zyngier
 <marc.zyngier@arm.com>
Date: Thu, 06 Dec 2018 12:10:39 +0100
In-Reply-To: <20181206073125.7255-2-andrew.smirnov@gmail.com>
References: <20181206073125.7255-1-andrew.smirnov@gmail.com>
 <20181206073125.7255-2-andrew.smirnov@gmail.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_031100_593549_E9DA39D8 
X-CRM114-Status: GOOD (  11.89  )
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
 Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org,
 linux-imx@nxp.com, Thomas Gleixner <tglx@linutronix.de>,
 Leonard Crestez <leonard.crestez@nxp.com>, cphealy@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gTWl0dHdvY2gsIGRlbiAwNS4xMi4yMDE4LCAyMzozMSAtMDgwMCBzY2hyaWViIEFuZHJleSBT
bWlybm92Ogo+IFZhcmFpYmxlICdyZWcnIGluIGlteF9ncGN2Ml9pcnFfc2V0X3dha2UoKSBoYXMg
bm8gdXNlcnMuIFJlbW92ZSBpdC4KPiAKPiA+IENjOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGlu
dXRyb25peC5kZT4KPiA+IENjOiBKYXNvbiBDb29wZXIgPGphc29uQGxha2VkYWVtb24ubmV0Pgo+
ID4gQ2M6IE1hcmMgWnluZ2llciA8bWFyYy56eW5naWVyQGFybS5jb20+Cj4gQ2M6IGNwaGVhbHlA
Z21haWwuY29tCj4gQ2M6IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGUKPiA+IENjOiBMZW9uYXJkIENy
ZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPgo+ID4gQ2M6ICJBLnMuIERvbmciIDxhaXNo
ZW5nLmRvbmdAbnhwLmNvbT4KPiA+IENjOiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5j
b20+Cj4gQ2M6IGxpbnV4LWlteEBueHAuY29tCj4gQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZwo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj4gU2lnbmVk
LW9mZi1ieTogQW5kcmV5IFNtaXJub3YgPGFuZHJldy5zbWlybm92QGdtYWlsLmNvbT4KClJldmll
d2VkLWJ5OiBMdWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT4KCj4gLS0tCj4gwqBk
cml2ZXJzL2lycWNoaXAvaXJxLWlteC1ncGN2Mi5jIHwgMiAtLQo+IMKgMSBmaWxlIGNoYW5nZWQs
IDIgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaXJxY2hpcC9pcnEtaW14
LWdwY3YyLmMgYi9kcml2ZXJzL2lycWNoaXAvaXJxLWlteC1ncGN2Mi5jCj4gaW5kZXggNDc2MDMw
N2FiNDNmLi5jYmVkMDAzMTkzMTUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9pcnFjaGlwL2lycS1p
bXgtZ3BjdjIuYwo+ICsrKyBiL2RyaXZlcnMvaXJxY2hpcC9pcnEtaW14LWdwY3YyLmMKPiBAQCAt
NzMsMTEgKzczLDkgQEAgc3RhdGljIGludCBpbXhfZ3BjdjJfaXJxX3NldF93YWtlKHN0cnVjdCBp
cnFfZGF0YSAqZCwgdW5zaWduZWQgaW50IG9uKQo+ID4gwqAJc3RydWN0IGdwY3YyX2lycWNoaXBf
ZGF0YSAqY2QgPSBkLT5jaGlwX2RhdGE7Cj4gPiDCoAl1bnNpZ25lZCBpbnQgaWR4ID0gZC0+aHdp
cnEgLyAzMjsKPiA+IMKgCXVuc2lnbmVkIGxvbmcgZmxhZ3M7Cj4gPiAtCXZvaWQgX19pb21lbSAq
cmVnOwo+ID4gwqAJdTMyIG1hc2ssIHZhbDsKPiDCoAo+ID4gwqAJcmF3X3NwaW5fbG9ja19pcnFz
YXZlKCZjZC0+cmxvY2ssIGZsYWdzKTsKPiA+IC0JcmVnID0gY2QtPmdwY19iYXNlICsgY2QtPmNw
dTJ3YWtldXAgKyBpZHggKiA0Owo+ID4gwqAJbWFzayA9IDEgPDwgZC0+aHdpcnEgJSAzMjsKPiA+
IMKgCXZhbCA9IGNkLT53YWtldXBfc291cmNlc1tpZHhdOwo+IMKgCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcg
bGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
