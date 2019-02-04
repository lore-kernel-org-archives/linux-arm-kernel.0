Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11662C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:26:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE95C2075D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dxwo6EbA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE95C2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FCeBLlDCB10lCXPyIfatCy0ktgYO/BQfQx0BK+vGbfM=; b=dxwo6EbAyNO5fm
	IibuUrobcMCJUgtNJmV0hr9ovYzmR3SOQSUNQo/TwjGpbIvNXs8qMzEmDdd12vYtFft0bmt7Q4H3J
	W40bkXKsllu2oUP7R7t85xAHXDHMcJRcsBB1qRECBPMhTpt5ukdBlaayKFS6Wi2xDyWXVnmZGXPAM
	bI0fSigwpaKP7lc+quOhR7/Kxoy38BOkVdhQ732Bgu5I3jQ6rxamedfGbfBc9+Gjgx266FKRRAcIO
	tTOl4axKbnKTBF4RJbxrC2pzJ9P3vZXmSUvVohfd1ZpZQPM7gGH4Uqb3TuhMhupPI03AhH4kolaGe
	+J6thMlnyQ6xK9w56mDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqbSe-0000wP-2B; Mon, 04 Feb 2019 10:26:44 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqbSa-0000vY-PL
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 10:26:42 +0000
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
 by metis.ext.pengutronix.de with esmtp (Exim 4.89)
 (envelope-from <l.stach@pengutronix.de>)
 id 1gqbSS-000064-Bs; Mon, 04 Feb 2019 11:26:32 +0100
Message-ID: <1549275990.2544.3.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/2] arm64: dts: imx8mq: Add on-chip OTP controller node
From: Lucas Stach <l.stach@pengutronix.de>
To: Carlo Caione <ccaione@baylibre.com>, robh+dt@kernel.org, 
 mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de, 
 kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Mon, 04 Feb 2019 11:26:30 +0100
In-Reply-To: <20190202150638.13672-2-ccaione@baylibre.com>
References: <20190202150638.13672-1-ccaione@baylibre.com>
 <20190202150638.13672-2-ccaione@baylibre.com>
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_022640_979600_B2E8B982 
X-CRM114-Status: GOOD (  12.55  )
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

QW0gU2Ftc3RhZywgZGVuIDAyLjAyLjIwMTksIDE1OjA2ICswMDAwIHNjaHJpZWIgQ2FybG8gQ2Fp
b25lOgo+IEFkZCB0aGUgbm9kZSBmb3IgdGhlIE9UUCBjb250cm9sbGVyLiBUaGUgSVAgaXMgdGhl
IHNhbWUgYXMgb24gdGhlIGlteDdkLgo+IAo+IFNpZ25lZC1vZmYtYnk6IENhcmxvIENhaW9uZSA8
Y2NhaW9uZUBiYXlsaWJyZS5jb20+CgpSZXZpZXdlZC1ieTogTHVjYXMgU3RhY2ggPGwuc3RhY2hA
cGVuZ3V0cm9uaXguZGU+Cgo+IC0tLQo+IMKgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
aW14OG1xLmR0c2kgfCA4ICsrKysrKysrCj4gwqAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25z
KCspCj4gCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDht
cS5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kKPiBpbmRl
eCBjMzRjYWJlOWIzNTYuLmYzN2YxN2I3MTE1MSAxMDA2NDQKPiAtLS0gYS9hcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRzaQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2lteDhtcS5kdHNpCj4gQEAgLTI0MSw2ICsyNDEsMTQgQEAKPiDCoAkJCQlyZWcg
PSA8MHgzMDM0MDAwMCAweDEwMDAwPjsKPiDCoAkJCX07Cj4gwqAKPiArCQkJb2NvdHA6IG9jb3Rw
LWN0cmxAMzAzNTAwMDAgewo+ICsJCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OG1xLW9jb3RwIiwg
ImZzbCxpbXg3ZC1vY290cCIsICJzeXNjb24iOwo+ICsJCQkJcmVnID0gPDB4MzAzNTAwMDAgMHgx
MDAwMD47Cj4gKwkJCQljbG9ja3MgPSA8JmNsayBJTVg4TVFfQ0xLX09DT1RQX1JPT1Q+Owo+ICsJ
CQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47Cj4gKwkJCQkjc2l6ZS1jZWxscyA9IDwxPjsKPiArCQkJ
fTsKPiArCj4gwqAJCQlhbmF0b3A6IHN5c2NvbkAzMDM2MDAwMCB7Cj4gwqAJCQkJY29tcGF0aWJs
ZSA9ICJmc2wsaW14OG1xLWFuYXRvcCIsICJzeXNjb24iOwo+IMKgCQkJCXJlZyA9IDwweDMwMzYw
MDAwIDB4MTAwMDA+OwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtYXJtLWtlcm5lbAo=
