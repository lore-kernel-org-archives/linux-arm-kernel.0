Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB004C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:44:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BEC82080D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sLl6Q4Ql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BEC82080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+r+oun4wsKuVPg/FFmaQm3b84idxHERCf/OkhxAtrcI=; b=sLl6Q4QlBYFlzX
	qZl/O9Vsc/6qV2OFmv7KSk421euvMjZ0rVmla+bGhoUXgE4zkpizDzlljJ757nmwcqWwNj2u33yjG
	SFISYDaJR0vQR8MmoqHo5SYAwtT4gg3dbsBYEYHHizI1nW89+kgshpucJbxSpRcGSXQIaZAoK/5yS
	lEh81+vgeUOHBYA57UQbYgHmn2Y8j9Xbzl9u58CeSlFBzlcdjoKW9LmlOQ5TZbQ5YiSF/dN7Yjc9y
	g5uJx8aaTm32DyWE5KfrA+AWSho/g2VTrvP9OTbd4Z3oRmzjEhqs/0c4CLUGH/y0GgKvprsRfbp6P
	/UdqZAYBu4U4EmM3dwCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqxGu-00062j-Jc; Tue, 05 Feb 2019 09:44:04 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqxGr-00062H-KI
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 09:44:03 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gqxGn-00029G-EA; Tue, 05 Feb 2019 10:43:57 +0100
Message-ID: <1549359836.2544.33.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/3] dt-bindings: imx6q-pcie: Add description of
 imx7d pcie phy
From: Lucas Stach <l.stach@pengutronix.de>
To: Trent Piepho <tpiepho@impinj.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>
Date: Tue, 05 Feb 2019 10:43:56 +0100
In-Reply-To: <20190205001721.18639-2-tpiepho@impinj.com>
References: <20190205001721.18639-1-tpiepho@impinj.com>
 <20190205001721.18639-2-tpiepho@impinj.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_014401_822335_0DF033F9 
X-CRM114-Status: GOOD (  14.55  )
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
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 devicetree@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gRGllbnN0YWcsIGRlbiAwNS4wMi4yMDE5LCAwMDoxNyArMDAwMCBzY2hyaWViIFRyZW50IFBp
ZXBobzoKPiBUaGVyZSBpcyBhIHNlcGFyYXRlIFBIWSBkZXZpY2Ugd2l0aCBpdHMgb3duIHJlZ2lz
dGVycyBvbiBpbXg3ZC7CoMKgSXQncwo+IGN1cnJlbnRseSB1bnVzZWQsIGJ1dCBhIFBDSWUgZXJy
YXR1bSBvbiBpbXg3ZCB3aWxsIHJlcXVpcmUgaXQgZm9yIHRoZQo+IHdvcmthcm91bmQuCj4gCj4g
U2lnbmVkLW9mZi1ieTogVHJlbnQgUGllcGhvIDx0cGllcGhvQGltcGluai5jb20+CgpJJ20gZ2Vu
ZXJhbGx5IGZpbmUgd2l0aCB0aGlzLCBidXQgcmVhbGx5IHdhbnQgdG8gc2VlIGFuIEFjayBmcm9t
IHRoZSBEVApmb2xrcyAoQ0MnZWQpIG9uIHRoaXMuCgpBY2tlZC1ieTogTHVjYXMgU3RhY2ggPGwu
c3RhY2hAcGVuZ3V0cm9uaXguZGU+CgpSZWdhcmRzLApMdWNhcwoKPiAtLS0KPiDCoERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvZnNsLGlteDZxLXBjaWUudHh0IHwgMTEgKysr
KysrKysrKysKPiDCoDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAt
LWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvZnNsLGlteDZxLXBj
aWUudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9mc2wsaW14NnEt
cGNpZS50eHQKPiBpbmRleCBkNTE0YzFmMjM2NWYuLmY0OTMzYzg5NTFiYyAxMDA2NDQKPiAtLS0g
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2ZzbCxpbXg2cS1wY2llLnR4
dAo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvZnNsLGlteDZx
LXBjaWUudHh0Cj4gQEAgLTUzLDYgKzUzLDcgQEAgQWRkaXRpb25hbCByZXF1aXJlZCBwcm9wZXJ0
aWVzIGZvciBpbXg3ZC1wY2llOgo+ID4gwqAJwqDCoMKgwqDCoMKgwqAtICJwY2llcGh5Igo+ID4g
wqAJwqDCoMKgwqDCoMKgwqAtICJhcHBzIgo+ID4gwqAJwqDCoMKgwqDCoMKgwqAtICJ0dXJub2Zm
Igo+ICstIGZzbCxpbXg3ZC1wY2llLXBoeTogQSBwaGFuZGxlIHRvIGFuIGZzbCxpbXg3ZC1wY2ll
LXBoeSBub2RlLgo+IMKgCj4gwqBFeGFtcGxlOgo+IMKgCj4gQEAgLTc5LDMgKzgwLDEzIEBAIEV4
YW1wbGU6Cj4gPiDCoAkJY2xvY2tzID0gPCZjbGtzIDE0ND4sIDwmY2xrcyAyMDY+LCA8JmNsa3Mg
MTg5PjsKPiA+IMKgCQljbG9jay1uYW1lcyA9ICJwY2llIiwgInBjaWVfYnVzIiwgInBjaWVfcGh5
IjsKPiA+IMKgCX07Cj4gKwo+ICsqIEZyZWVzY2FsZSBpLk1YN2QgUENJZSBQSFkKPiArCj4gK1Ro
aXMgaXMgdGhlIFBIWSBhc3NvY2lhdGVkIHdpdGggdGhlIElNWDdkIFBDSWUgY29udHJvbGxlci7C
oMKgSXQncyB1c2VkIGJ5IHRoZQo+ICtQQ0ktZSBjb250cm9sbGVyIHZpYSB0aGUgZnNsLGlteDdk
LXBjaWUtcGh5IHBoYW5kbGUuCj4gKwo+ICtSZXF1aXJlZCBwcm9wZXJ0aWVzOgo+ICstIGNvbXBh
dGlibGU6Cj4gPiArCS0gImZzbCxpbXg3ZC1wY2llLXBoeSIKPiArLSByZWc6IGJhc2UgYWRkcmVz
cyBhbmQgbGVuZ3RoIG9mIHRoZSBQQ0llIFBIWSBjb250cm9sbGVyCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcg
bGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
