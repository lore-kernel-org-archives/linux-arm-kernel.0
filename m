Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD16C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:57:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E10A5222D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aMrxDvRJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E10A5222D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gT7vHtL+G//H0R40o3V43T2aLF7/0p8pQsRY1uFTl0U=; b=aMrxDvRJunBcjx
	WhpBgt5Y7xjJ8Z28s2oAtT96Ab/P9Ypi1I7QirM8ItsNa8D0JCS0PR6YXSaio9ri5TMzc9GLBAIe+
	xDcxAqvA7VINpD3k9UsZgL1dkdjE7WKM7Xm716QfhIq48iwZ1EPJvNt1zTfeZC44o40hW08gSSLqv
	xYlLNdfxpLk8BDdIPJV4dcg1LLrlNjr3WEeN6YvckHkFSQJntC0jumOstNzxTSmXRPmdRXG0kpvmO
	e4JPLx+E+DeruX71srqNaP+CKXd0yZL+Q8b9m0h0VakL4TKJd1mN79ZXTRk5afB1RgLpt2P7IRPN3
	mt2+/5+pAyS90eWhPOyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guJNi-0000nN-8z; Thu, 14 Feb 2019 15:56:58 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guJM3-0006lL-D5
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 15:55:33 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1guJLw-0004qF-9D; Thu, 14 Feb 2019 16:55:08 +0100
Message-ID: <1550159708.2546.45.camel@pengutronix.de>
Subject: Re: [RFC 0/5] Add cpufreq-dt support i.MX8MQ
From: Lucas Stach <l.stach@pengutronix.de>
To: Abel Vesa <abel.vesa@nxp.com>, Rob Herring <robh@kernel.org>, Stephen
 Boyd <sboyd@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mike
 Turquette <mturquette@baylibre.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <kernel@pengutronix.de>, Angus Ainslie
 <angus.ainslie@puri.sm>, Anson Huang <anson.huang@nxp.com>
Date: Thu, 14 Feb 2019 16:55:08 +0100
In-Reply-To: <1550084693-9797-1-git-send-email-abel.vesa@nxp.com>
References: <1550084693-9797-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_075516_036248_EE07D357 
X-CRM114-Status: GOOD (  17.12  )
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
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gTWl0dHdvY2gsIGRlbiAxMy4wMi4yMDE5LCAxOTowNSArMDAwMCBzY2hyaWViIEFiZWwgVmVz
YToKPiBJJ20gc2VuZGluZyB0aGlzIGFzIGEgcGF0Y2hzZXJpZXMgKFJGQykganVzdCB0byBzaG93
IGFsbCB0aGUgY2hhbmdlcwo+IG5lZWRlZCBmb3IgdGhpcyB0byB3b3JrLiBJJ2xsIHJlc2VuZCBz
ZXBhcmF0ZWx5IG9uY2UgSSBnZXQgc29tZQo+IGZlZWRiYWNrCj4gb24gdGhlIGVudGlyZSB0aGlu
Zy4KPiAKPiBPbmUgdGhpbmcgdGhhdCBpcyBtaXNzaW5nIGNvbXBhcmVkIHRvIHRoZSBlYXJsaWVy
IHdvcmsKPiAoaGVyZTogaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMDgwNzgy
MS8gKQo+IGlzIHRoZSBzcGVlZCBncmFkaW5nLiBUaGF0IGNhbiBiZSBkb25lIGFzIGEgc2VwYXJh
dGUgY2hhbmdlwqAKPiBvbmNlIEkgZmlndXJlIG91dCBob3cgdG8gZG8gaXQgd2l0aCBjcHVmcmVx
LWR0Lgo+IAo+IFVuZm9ydHVtYXRlbHksIHRoZXJlIGlzIGEgbmVlZCB0byB1cGRhdGUgdGhlIGR0
LWJpbmRpbmdzCj4gb25jZSBhZ2FpbiBpbiBvcmRlciB0byBhZGQgbWlzc2luZyBBUk0gY2xvY2sg
ZnJvbSBwYXRjaGVzIDEgYW5kIDIuCgpXaGljaCBpc24ndCBtdWNoIG9mIGEgcHJvYmxlbSBhcyBp
dCdzIGEgYmFja3dhcmQgY29tcGF0aWJsZSBjaGFuZ2UuIEEKbmV3IGtlcm5lbCB3aXRoIGNwdWZy
ZXEgc3VwcG9ydCB3aWxsIG5vdCBmaW5kIHRoZSBjbG9jayB3aGVuIHN0YXJ0ZWQKd2l0aCBhbiBv
bGQgRFQgYW5kIHRodXMgbm90IGV4cG9zZSBjcHVmcmVxIHN1cHBvcnQuIEkuZS4gaXQncyB3b3Jr
aW5nCndpdGggZXhhY3RseSB0aGUgc2FtZSBmdW5jdGlvbmFsaXR5IGxldmVsIGFzIGEga2VybmVs
IG1hdGNoaW5nIHRoZSBvbGQKRFQuCgpSZWdhcmRzLApMdWNhcwoKPiBBYmVsIFZlc2EgKDUpOgo+
IMKgIGNsazogaW14OiBpbXg4bXE6IEZpeCB0aGUgcmF0ZSBwcm9wYWdhdGlvbiBmb3IgYXJtIHBs
bAo+IMKgIGR0LWJpbmRpbmdzOiBpbXg4bXEtY2xvY2s6IEFkZCB0aGUgbWlzc2luZyBBUk0gY2xv
Y2sKPiDCoCBjbGs6IGlteDhtcTogQWRkIHRoZSBtaXNzaW5nIEFSTSBjbG9jawo+IMKgIGFybTY0
OiBkdHM6IGlteDhtcTogQWRkIHRoZSBjbG9ja3MgYW5kIHRoZSBsYXRlbmNpZXMgZm9yIHRoZSBB
NTMKPiBjb3Jlcwo+IMKgIGFybTY0OiBkdHM6IGlteDhtcTogQWRkIHRoZSBvcHAgdGFibGUgYW5k
IHRoZSBjcHUtc3VwcGx5IG5vZGVzCj4gCj4gwqBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2Fs
ZS9pbXg4bXEtZXZrLmR0cyB8IDE3ICsrKysrKysrKysrKysrKwo+IMKgYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2nCoMKgwqDCoHwgMzEKPiArKysrKysrKysrKysrKysr
KysrKysrKysrKysrCj4gwqBkcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtcS5jwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHzCoMKgOCArKysrKystCj4gwqBpbmNsdWRlL2R0LWJpbmRp
bmdzL2Nsb2NrL2lteDhtcS1jbG9jay5owqDCoMKgwqDCoHzCoMKgNCArKystCj4gwqA0IGZpbGVz
IGNoYW5nZWQsIDU4IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1h
aWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
