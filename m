Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033EFC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:53:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6387222DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pIZ3FROq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6387222DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ysD8guNy+qWEYGASSPVqCKBPq3Qosdlt6XdLaQFFikc=; b=pIZ3FROq8dt3+M
	a1W106ZO6nkZqbdsWkSth0kjxCiiSPnh53DdZwPAqetEIjifzFa9e8oOEnm01ReYj2RQuLMU6ScyS
	5b7Pp93vx7wGQklF9dNjuIt/Bko+hdVDR3a1amQ1aXvDqr6XiH5E48RmXyMxpWdD0swYrI2SHg9m8
	b/HFM4dAodGZVT0pncsu67+Cgz2GK4K/i5m1ZmQeE4jP9AxQCb46GCzAzc/aczVANhtZVapfj04tR
	FCS0QwzOZQvQDvQOhMtEsbwuXAcRteKrC3Zc+JigrJwAdP+Uif75BNTK/5SfY9SBbelogBKthgLZw
	s0MUMMiDiIcojX11JCAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guJJs-0005IV-8k; Thu, 14 Feb 2019 15:53:00 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guJJp-0005I9-EU
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 15:52:58 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1guJJi-0004Yu-7n; Thu, 14 Feb 2019 16:52:50 +0100
Message-ID: <1550159569.2546.43.camel@pengutronix.de>
Subject: Re: [RFC 3/5] clk: imx8mq: Add the missing ARM clock
From: Lucas Stach <l.stach@pengutronix.de>
To: Abel Vesa <abel.vesa@nxp.com>, Rob Herring <robh@kernel.org>, Stephen
 Boyd <sboyd@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mike
 Turquette <mturquette@baylibre.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <kernel@pengutronix.de>, Angus Ainslie
 <angus.ainslie@puri.sm>, Anson Huang <anson.huang@nxp.com>
Date: Thu, 14 Feb 2019 16:52:49 +0100
In-Reply-To: <1550084693-9797-4-git-send-email-abel.vesa@nxp.com>
References: <1550084693-9797-1-git-send-email-abel.vesa@nxp.com>
 <1550084693-9797-4-git-send-email-abel.vesa@nxp.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_075257_635590_E2B06C4D 
X-CRM114-Status: GOOD (  12.97  )
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
YToKPiBBZGQgdGhlIEFSTSBjbG9jayBhcyBpbXhfY2xrX2NwdSB0eXBlLgo+IFdpbGwgYmUgdXNl
ZCBieSBjcHVmcmVxLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEFiZWwgVmVzYSA8YWJlbC52ZXNhQG54
cC5jb20+CgpSZXZpZXdlZC1ieTogTHVjYXMgU3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+
Cgo+IC0tLQo+IMKgZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4bXEuYyB8IDYgKysrKysrCj4gwqAx
IGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Y2xrL2lteC9jbGstaW14OG1xLmMgYi9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtcS5jCj4gaW5k
ZXggNTc0OTllZC4uOGEyODNjYiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2Nsay9pbXgvY2xrLWlt
eDhtcS5jCj4gKysrIGIvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4bXEuYwo+IEBAIC01NTgsNiAr
NTU4LDEyIEBAIHN0YXRpYyBpbnQgaW14OG1xX2Nsb2Nrc19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQo+IMKgCWNsa3NbSU1YOE1RX0dQVF8zTV9DTEtdID0gaW14X2Nsa19maXhl
ZF9mYWN0b3IoImdwdF8zbSIsICJvc2NfMjVtIiwgMSwgOCk7Cj4gwqAJY2xrc1tJTVg4TVFfQ0xL
X0RSQU1fQUxUX1JPT1RdID0gaW14X2Nsa19maXhlZF9mYWN0b3IoImRyYW1fYWx0X3Jvb3QiLCAi
ZHJhbV9hbHQiLCAxLCA0KTsKPiDCoAo+ICsJY2xrc1tJTVg4TVFfQ0xLX0FSTV0gPSBpbXhfY2xr
X2NwdSgiYXJtIiwgImFybV9hNTNfZGl2IiwKPiArCQkJCQnCoMKgwqBjbGtzW0lNWDhNUV9DTEtf
QTUzX0RJVl0sCj4gKwkJCQkJwqDCoMKgY2xrc1tJTVg4TVFfQ0xLX0E1M19TUkNdLAo+ICsJCQkJ
CcKgwqDCoGNsa3NbSU1YOE1RX0FSTV9QTExfT1VUXSwKPiArCQkJCQnCoMKgwqBjbGtzW0lNWDhN
UV9TWVMxX1BMTF84MDBNXSk7Cj4gKwo+IMKgCWZvciAoaSA9IDA7IGkgPCBJTVg4TVFfQ0xLX0VO
RDsgaSsrKQo+IMKgCQlpZiAoSVNfRVJSKGNsa3NbaV0pKQo+IMKgCQkJcHJfZXJyKCJpLk1YOG1x
IGNsayAldSByZWdpc3RlciBmYWlsZWQgd2l0aCAlbGRcbiIsCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
