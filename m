Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4E3C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:54:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA3972086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LaDbsWSs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA3972086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dJnyUe6IsO1VGZ7L/BtLK8pxp8+3tUy/C1E18ojuY6M=; b=LaDbsWSsWgT/4o
	nSO1Xp6dAbU0p1JZ8aD++5JPK+zAPkhkO43TDWqP+shApqFcXcbusTSLlHAcLmdg84ixr382Wnbbt
	yv5K5EzWTWeS7BISEabDXyzmvTBkeTE8KL0GABeF1frwP5wGV+ROa4mwWjuLikujaBLLUjUFaHMvC
	S/GN7o5LRv7PPPrdoP7boAno9XXXM/Q9czOdi80yuKhJ4qbtN/csa51liUa5PHKexWGK127jmkAmA
	TtYnVCbY+qqjY/hfuzbOFseQ8DIsNEGDffsHMm3C/WjgtpRIQBdCfl0ls9lyW70VAU5WQhN8tfrDE
	tIaVaaESUd+LvdiyDrtQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpb9F-0005PH-8K; Fri, 01 Feb 2019 15:54:33 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpb9C-0005Ow-6M
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 15:54:31 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gpb95-0002o3-U7; Fri, 01 Feb 2019 16:54:23 +0100
Message-ID: <1549036463.6869.58.camel@pengutronix.de>
Subject: Re: [PATCH] arm64: dts: imx8mq: Add on-chip OTP controller node
From: Lucas Stach <l.stach@pengutronix.de>
To: Carlo Caione <ccaione@baylibre.com>, robh+dt@kernel.org, 
 mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de, 
 kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
 abel.vesa@nxp.com,  devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Date: Fri, 01 Feb 2019 16:54:23 +0100
In-Reply-To: <20190128194343.13713-1-ccaione@baylibre.com>
References: <20190128194343.13713-1-ccaione@baylibre.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_075430_389160_503C4B37 
X-CRM114-Status: GOOD (  13.47  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gTW9udGFnLCBkZW4gMjguMDEuMjAxOSwgMTk6NDMgKzAwMDAgc2NocmllYiBDYXJsbyBDYWlv
bmU6Cj4gQWRkIHRoZSBub2RlIGZvciB0aGUgT1RQIGNvbnRyb2xsZXIuIFRoZSBJUCBpcyB0aGUg
c2FtZSBhcyBvbiB0aGUgaW14N2QuCj4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBDYXJsbyBDYWlvbmUg
PGNjYWlvbmVAYmF5bGlicmUuY29tPgo+IC0tLQo+IMKgYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvaW14OG1xLmR0c2kgfCA4ICsrKysrKysrCj4gwqAxIGZpbGUgY2hhbmdlZCwgOCBpbnNl
cnRpb25zKCspCj4gCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2lteDhtcS5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kK
PiBpbmRleCA4OTIwNjNhN2MyNmMuLjlhNTIwNWYwOGYzYSAxMDA2NDQKPiAtLS0gYS9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRzaQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2lteDhtcS5kdHNpCj4gQEAgLTIzNCw2ICsyMzQsMTQgQEAKPiA+IMKg
CQkJCXJlZyA9IDwweDMwMzQwMDAwIDB4MTAwMDA+Owo+ID4gwqAJCQl9Owo+IMKgCj4gPiA+ICsJ
CQlvY290cDogb2NvdHAtY3RybEAzMDM1MDAwMCB7Cj4gKwkJCQljb21wYXRpYmxlID0gImZzbCxp
bXg3ZC1vY290cCIsICJzeXNjb24iOwoKUGxlYXNlIGFkZCBhIGlteDhtcSBjb21wYXRpYmxlIGhl
cmUuCgpSZWdhcmRzLApMdWNhcwoKPiArCQkJCXJlZyA9IDwweDMwMzUwMDAwIDB4MTAwMDA+Owo+
ID4gKwkJCQljbG9ja3MgPSA8JmNsayBJTVg4TVFfQ0xLX09DT1RQX1JPT1Q+Owo+ID4gKwkJCQkj
YWRkcmVzcy1jZWxscyA9IDwxPjsKPiA+ICsJCQkJI3NpemUtY2VsbHMgPSA8MT47Cj4gPiArCQkJ
fTsKPiArCj4gPiA+IMKgCQkJYW5hdG9wOiBzeXNjb25AMzAzNjAwMDAgewo+ID4gwqAJCQkJY29t
cGF0aWJsZSA9ICJmc2wsaW14OG1xLWFuYXRvcCIsICJzeXNjb24iOwo+ID4gwqAJCQkJcmVnID0g
PDB4MzAzNjAwMDAgMHgxMDAwMD47CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
