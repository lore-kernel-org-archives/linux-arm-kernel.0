Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D093CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:48:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A091E2147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s0bKPqp1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A091E2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8NRfvW+xDHTL5sAgbVCGIrg98sUNL9IbvJFJdEthRew=; b=s0bKPqp1iowacM
	U4CZSvw+bybRsjBmBLxU7nOvNvcUqz4yXKf9rqmb/D1AjG7D+saH4pgIdRsqSavMeaqyWU/HnCbaf
	pdTGVM/yLv4TTOoRlF6De4unac7ee6+yNMAZWEEhD/g+eZuHlxrDV0o7X8jgGyS1cDCx34ZPTzZ07
	fPQRDf0yYPila27E35rtd1OvJe8yC2CjtwCUPHqiIZlWKQssXjB14eGMISrat8Q1XnZkOo38Qdsp7
	CKk0pesGbtv+AKJym90tHhlNZAtmaMvYLHrSqTR6wbUZ4RePryhJM2mGzDTGoyXk5ICSbqAOWc/wR
	bYV4TVUMuJ3FiFIWil6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwmpg-0004OJ-Qf; Thu, 21 Feb 2019 11:48:04 +0000
Received: from relay9-d.mail.gandi.net ([217.70.183.199])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwmpd-0004Ns-FP; Thu, 21 Feb 2019 11:48:03 +0000
X-Originating-IP: 90.88.23.190
Received: from xps13 (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr
 [90.88.23.190]) (Authenticated sender: miquel.raynal@bootlin.com)
 by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id F0786FF810;
 Thu, 21 Feb 2019 11:47:43 +0000 (UTC)
Date: Thu, 21 Feb 2019 12:47:42 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [RFC PATCH 05/27] mtd: nand: Move standard OOB layouts to the
 NAND core
Message-ID: <20190221124742.322e38ed@xps13>
In-Reply-To: <20190221121900.19d28477@kernel.org>
References: <20190221100216.25255-1-miquel.raynal@bootlin.com>
 <20190221100216.25255-6-miquel.raynal@bootlin.com>
 <20190221121900.19d28477@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_034801_662472_B97C48EA 
X-CRM114-Status: GOOD (  13.87  )
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
Cc: Mason Yang <masonccyang@mxic.com.tw>, Vignesh R <vigneshr@ti.com>,
 Tudor Ambarus <Tudor.Ambarus@microchip.com>, Julien Su <juliensu@mxic.com.tw>,
 Richard Weinberger <richard@nod.at>,
 Schrempf Frieder <frieder.schrempf@kontron.de>,
 Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgQm9yaXMsCgpCb3JpcyBCcmV6aWxsb24gPGJicmV6aWxsb25Aa2VybmVsLm9yZz4gd3JvdGUg
b24gVGh1LCAyMSBGZWIgMjAxOQoxMjoxOTowMCArMDEwMDoKCj4gT24gVGh1LCAyMSBGZWIgMjAx
OSAxMTowMTo1NCArMDEwMAo+IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5j
b20+IHdyb3RlOgo+IAo+ID4gVGhlc2UgT09CIGxheW91dHMgYXJlIGdlbmVyaWMgdG8gYWxsIE5B
TkQgY2hpcHMsIHRoZSBzaG91bGQgbm90IGJlCj4gPiByZXN0cmljdGVkIHRvIGJlIHVzZWQgb25s
eSBieSByYXcgTkFORCBjb250cm9sbGVyIGRyaXZlcnMuIFRoZXkgbWlnaHQKPiA+IGxhdGVyIGJl
IHVzZWQgYnkgZ2VuZXJpYyBFQ0MgZW5naW5lcyBhbmQgU1BJLU5BTkQgZGV2aWNlcyBhcyB3ZWxs
Lgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBNaXF1ZWwgUmF5bmFsIDxtaXF1ZWwucmF5bmFsQGJv
b3RsaW4uY29tPgo+ID4gLS0tCj4gPiAgZHJpdmVycy9tdGQvbmFuZC9jb3JlLmMgICAgICAgICAg
ICAgfCAxNjEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKyAgCj4gCj4gQ2FuIHdlIHBsYWNl
IHRob3NlIGRlZmluaXRpb25zIGluIGVjYy5jIGluc3RlYWQgb2YgY29yZS5jCgpSaWdodCBhZnRl
ciAoYnV0IEkgY2FuIG1vdmUgdGhpcyBwYXRjaCBpbiB0aGUgc2VyaWVzIGVhc2lseSkgSSBjcmVh
dGUgYQpkcml2ZXJzL210ZC9uYW5kL2VjYy8gZGlyZWN0b3J5IHdpdGggYSBlbmdpbmUuYyBmaWxl
LiBJZiBJIHVuZGVyc3RhbmQKeW91ciBzdWdnZXN0aW9uIGNvcnJlY3RseSwgeW91IHdvdWxkIHBy
ZWZlciB0byBoYXZlIHRoZSBPT0IgbGF5b3V0cyBpbgp0aGlzIGZpbGUuCgo+IAo+ID4gIGRyaXZl
cnMvbXRkL25hbmQvcmF3L25hbmRfYmFzZS5jICAgIHwgMTYxICstLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0KPiA+ICBkcml2ZXJzL210ZC9uYW5kL3Jhdy9uYW5kX3Rvc2hpYmEuYyB8ICAgMiAr
Cj4gPiAgaW5jbHVkZS9saW51eC9tdGQvbmFuZC5oICAgICAgICAgICAgfCAgIDQgKwo+ID4gIGlu
Y2x1ZGUvbGludXgvbXRkL3Jhd25hbmQuaCAgICAgICAgIHwgICAzIC0KPiA+ICA1IGZpbGVzIGNo
YW5nZWQsIDE2OCBpbnNlcnRpb25zKCspLCAxNjMgZGVsZXRpb25zKC0pICAKClRoYW5rcywKTWlx
dcOobAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
YXJtLWtlcm5lbAo=
