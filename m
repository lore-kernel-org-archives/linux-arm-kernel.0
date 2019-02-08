Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6FAC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:41:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1ACB206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gHW7HZmd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1ACB206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WO0DvKQy+ty8l0jpFq7LP3QEoeL0Mi4p8KWJ3RbT4CE=; b=gHW7HZmd6C03gX
	jcX856QRf0CKE1XFY0ZUMzqNZtL6c6+knCYFrbIuEKhf9O1Vjo9qGNNDaYm3Q+GtCMau9ZA6q9Aub
	249Vg/EKiXjm+f/1RhnFk4uZM2bQwIKz6vtsBlJ4Gs/vLdSY93ogb2DFNh7btguOlEbrLc1BdI7hN
	hteHLWXoe6U3f28PQpSnufcmrSE5KCnl8zkllnYFkxi2rN7qaLUjBEaScHZnSfk7hKAznpjW82Wy+
	r7t/k7xcDHdtYsoiFuuU0dkq+U67rYZmTxN6vx/csJdr5ymrcUMHzpQTzyxG+z9Ga4KNWNorczePX
	d5r15df57Zhcfzjtv+BQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs2f6-0005a8-45; Fri, 08 Feb 2019 09:41:32 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs2f2-0005Zm-ED
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 09:41:30 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gs2eu-00008e-Ow; Fri, 08 Feb 2019 10:41:20 +0100
Message-ID: <1549618880.2544.83.camel@pengutronix.de>
Subject: Re: [RFC v2 2/5] arm64: dts: imx8mq: Add a node for SRC IP block
From: Lucas Stach <l.stach@pengutronix.de>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Fri, 08 Feb 2019 10:41:20 +0100
In-Reply-To: <20190208002941.30343-3-andrew.smirnov@gmail.com>
References: <20190208002941.30343-1-andrew.smirnov@gmail.com>
 <20190208002941.30343-3-andrew.smirnov@gmail.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_014129_026790_C121FC19 
X-CRM114-Status: GOOD (  11.92  )
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
 linux-kernel@vger.kernel.org, linux-imx@nxp.com,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Chris Healy <cphealy@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

QW0gRG9ubmVyc3RhZywgZGVuIDA3LjAyLjIwMTksIDE2OjI5IC0wODAwIHNjaHJpZWIgQW5kcmV5
IFNtaXJub3Y6Cj4gQWRkIGEgbm9kZSBmb3IgcmVzZXQgY29udHJvbGxlciBJUCBibG9jayBmb3Vu
ZCBvbiBpLk1YOE1RLgo+IAo+ID4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IFNtaXJub3YgPGFuZHJl
dy5zbWlybm92QGdtYWlsLmNvbT4KPiBDYzogU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3Jn
Pgo+IENjOiBGYWJpbyBFc3RldmFtIDxmYWJpby5lc3RldmFtQG54cC5jb20+Cj4gQ2M6IENocmlz
IEhlYWx5IDxjcGhlYWx5QGdtYWlsLmNvbT4KPiBDYzogTHVjYXMgU3RhY2ggPGwuc3RhY2hAcGVu
Z3V0cm9uaXguZGU+Cj4gQ2M6IExlb25hcmQgQ3Jlc3RleiA8bGVvbmFyZC5jcmVzdGV6QG54cC5j
b20+Cj4gQ2M6ICJBLnMuIERvbmciIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4KPiBDYzogUmljaGFy
ZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPgo+IENjOiBsaW51eC1pbXhAbnhwLmNvbQo+IENj
OiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKPiBDYzogbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZwoKUmV2aWV3ZWQtYnk6IEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBlbmd1
dHJvbml4LmRlPgoKPiAtLS0KPiDCoGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDht
cS5kdHNpIHwgNiArKysrKysKPiDCoDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKPiAK
PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kg
Yi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRzaQo+IGluZGV4IGY2YzM3
YmY5Y2JjZS4uNTA0MzZiZDM5M2VkIDEwMDY0NAo+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2lteDhtcS5kdHNpCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvaW14OG1xLmR0c2kKPiBAQCAtMjU0LDYgKzI1NCwxMiBAQAo+IMKgCQkJCcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAiY2xrX2V4dDMiLCAiY2xrX2V4dDQiOwo+IMKgCQkJfTsKPiDCoAo+
ICsJCQlzcmM6IHNyY0AzMDM5MDAwMCB7Cj4gKwkJCQljb21wYXRpYmxlID0gImZzbCxpbXg4bXEt
c3JjIiwgInN5c2NvbiI7Cj4gKwkJCQlyZWcgPSA8MHgzMDM5MDAwMCAweDEwMDAwPjsKPiArCQkJ
CSNyZXNldC1jZWxscyA9IDwxPjsKPiArCQkJfTsKPiArCj4gwqAJCQlncGM6IGdwY0AzMDNhMDAw
MCB7Cj4gwqAJCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OG1xLWdwYyI7Cj4gwqAJCQkJcmVnID0g
PDB4MzAzYTAwMDAgMHgxMDAwMD47CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
