Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFE2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:04:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34AF7213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fDs9irei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34AF7213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3LEQyAoXSwhsstS928vMXrGv46k2J5S1UPGbuRKCIVw=; b=fDs9ireiygia2c
	o4//4ah4KhP7eyp/pugMq8B+2rZdNVfcLKPfhXD4z11OujDzVGdJMv00CmkYSYDcYeETR1u0HyTs5
	TylhOa8BxR/VkMFaFxwKtBv1Yvst2UOsjoftzKsTvpGClTuKFiv5Loj333aLsbfEV660aPE/FaOqm
	VL5bh1qWyVS3cIive90v5umW2AcOBUQSbTrHhiJlytiIqnVAgQ3A3F2YBUU9VwGZWJPOACUTWDUmO
	DMXKVUW/+kCXA6xnlp5ETRVRPzrBKOIqOUzZc29F8CFskF/xe0wQm1RPmwz3WyjbP/nmpZ3uMaCn9
	qzuMgYwVU/cgHRXj85bg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyYef-0007BJ-DX; Tue, 26 Feb 2019 09:04:01 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyYeb-00078r-DH
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 09:03:59 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gyYeS-0003Ml-Sv; Tue, 26 Feb 2019 10:03:48 +0100
Message-ID: <1551171827.2313.14.camel@pengutronix.de>
Subject: Re: [PATCH v2 0/2] Add and document the i.MX8MQ OTP controller
From: Lucas Stach <l.stach@pengutronix.de>
To: Carlo Caione <ccaione@baylibre.com>, Abel Vesa <abel.vesa@nxp.com>
Date: Tue, 26 Feb 2019 10:03:47 +0100
In-Reply-To: <e0af9818-86cf-c341-61a4-0a1406b07880@baylibre.com>
References: <20190202150638.13672-1-ccaione@baylibre.com>
 <20190225151127.elg2iuaxa4otdb46@fsr-ub1664-175>
 <e0af9818-86cf-c341-61a4-0a1406b07880@baylibre.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_010357_606765_AC0392D9 
X-CRM114-Status: GOOD (  15.93  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gRGllbnN0YWcsIGRlbiAyNi4wMi4yMDE5LCAwODo1NyArMDAwMCBzY2hyaWViIENhcmxvIENh
aW9uZToKPiBPbiAyNS8wMi8yMDE5IDE1OjExLCBBYmVsIFZlc2Egd3JvdGU6Cj4gPiBPbiAxOS0w
Mi0wMiAxNTowNjozNiwgQ2FybG8gQ2Fpb25lIHdyb3RlOgo+ID4gPiBBZGQgYSBuZXcgbm9kZSB0
byBlbmFibGUgdGhlIE9uLUNoaXAgT1RQIGNvbnRyb2xsZXIgYW5kIGFkZCB0aGUKPiA+ID4gbmV3
Cj4gPiA+IGJpbmRpbmcgaW4gdGhlIGRvY3VtZW50YXRpb24uCj4gPiA+IAo+ID4gPiBDYXJsbyBD
YWlvbmUgKDIpOgo+ID4gPiDCoMKgwqBhcm02NDogZHRzOiBpbXg4bXE6IEFkZCBvbi1jaGlwIE9U
UCBjb250cm9sbGVyIG5vZGUKPiA+ID4gwqDCoMKgZHQtYmluZGluZ3M6IGlteC1vY290cDogQWRk
IGkuTVg4TVEgY29tcGF0aWJsZQo+ID4gPiAKPiA+ID4gwqAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL252bWVtL2lteC1vY290cC50eHQgfCAxICsKPiA+ID4gwqAgYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2nCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHwgOAo+ID4gPiArKysrKysrKwo+ID4gPiDCoCAyIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9u
cygrKQo+ID4gPiAKPiA+ID4gLS3CoAo+ID4gPiAyLjE5LjEKPiA+ID4gCj4gPiAKPiA+IFdoYXQn
cyB0aGUgc3RhdHVzIG9mIHRoaXMgcGF0Y2hzZXJpZXMgPwo+ID4gCj4gPiBJdCB3b3VsZCBoZWxw
IGEgbG90IGlmIHdlIHdvdWxkIG1hbmFnZSB0byBnZXQgdGhpcyBpbi4KPiAKPiBVaCwgZm9yIHNv
bWUgcmVhc29uIEkgdGhvdWdodCBMdWNhcyB3YXMgZ29pbmcgdG8gdGFrZSBjYXJlIG9mIHRoaXMu
Cj4gSSdsbCBzdWJtaXQgYSB2MiBub3cuCgpIdWg/IEkndmUgc2VudCBvdXQgdGhlIGVudGlyZSBz
ZXJpZXMgWzFdLiBJdCdzIGp1c3Qgd2FpdGluZyBmb3IgdGhlCm52bWVtIG1haW50YWluZXJzIHRv
IHB1bGwgaXQgaW4gQUZBSUNTLiBUaGVyZSBzaG91bGQgYmUgbm8gbmVlZCB0bwpyZXNlbmQgYW55
dGhpbmcuCgpSZWdhcmRzLApMdWNhcwoKClsxXSBodHRwczovL3BhdGNod29yay5vemxhYnMub3Jn
L3BhdGNoLzEwMzk5NTkvCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1hcm0ta2VybmVsCg==
