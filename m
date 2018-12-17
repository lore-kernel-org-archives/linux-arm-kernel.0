Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CF7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:37:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDC54206A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mUluHmlf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="dWKECi2D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC54206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rere.qmqm.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:MIME-Version:Subject:From:Message-Id
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=8vM/kaWL7BTUkC5cd3sC2l2vJ1PRrzWVRBmJN/tHLMI=; b=mUluHmlffilUm3
	1beQTPu3tztzKn14JaShSKQ/GR2Pakfabn/807GyscHgvs0S6d3vDbYX5ArqBAeynSOI9R+mjHX8o
	LImQUuTneO2xbBtsAsJSl1s0ogd1v9QWbXRaq2N1ewacpe2dVxYk4DjtjsXEW0MxoQ1ls0DmTov2P
	tVszTTewHT5k/bCvW+z2RuRoqY4o4wp9L8iQsH3CfrGwFUuj8ctb9dm/KkEUUtNERqj+XuYeKqK9I
	Clg/rMeWH4dRzhpPswjUnlSoLHZj79eVZVpJmYHW5xgeaYHQF/iXXKy7cuok+c7cesA/ItEH1fa4P
	mPWxMcIWn1EhVvpat53w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYyhv-0006B8-15; Mon, 17 Dec 2018 19:37:39 +0000
Received: from rere.qmqm.pl ([91.227.64.183])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYyhi-000629-Rd
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 19:37:28 +0000
Received: from remote.user (localhost [127.0.0.1])
 by rere.qmqm.pl (Postfix) with ESMTPSA id 43JWbH4RLgz9F;
 Mon, 17 Dec 2018 20:35:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
 t=1545075339; bh=/56MsxFwaSjwK7/mt/Tkx+PibwmttCvRGbZJTSeRTC8=;
 h=Date:From:Subject:To:Cc:From;
 b=dWKECi2DpPxPmwe+wJ7l63SbcBQYpFyVnoM+YgPT2DyXaKDn+BQJ6XvRcv4/hn1Y+
 eO9zTdGOiWfVVMb45afiKDgkaZ45GXaX1PZ9BHh6UmZthlr1nRGoQ6QLkbRDqvYZqx
 hJ7WrfPbrPhoVi8aY/B6DwV2I8ZkfhhBkefm1uS+tiIZp9OhlBx5gB7kjGXccdFYew
 wO/4OzAYVyH+OlL9zByDpTjIELlnbhn9GveJGqIreFEpz3rZ+jG69EbuC4DdVB5RBe
 QzOEQQTxIP+MeVWbcNYkO186MDJHh57ZOrBpT64sM9JIkqTj59iCpFGXCOweuG3c9k
 VayOJwZR/nISQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.2 at mail
Date: Mon, 17 Dec 2018 20:37:05 +0100
Message-Id: <772b3869cc992d894d8c1b4296f21100bcbed30d.1545075103.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] clk: at91: optimize clk_round_rate() for AUDIO_PLL
MIME-Version: 1.0
To: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_113727_064519_45516A9C 
X-CRM114-Status: UNSURE (   8.81  )
X-CRM114-Notice: Please train this message.
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
Cc: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhpcyBtYWtlcyBmb3IgMyBjbGtfcm91bmRfcmF0ZSgpIGNhbGxzIGluc3RlYWQgb2YgNjQgb2Yg
dGhlbSBvbgpTQU1BNUQyLWJhc2VkIGJvYXJkIHdoZW4gc2VhcmNoaW5nIGZvciAxMi4yODhNSHog
Y2xvY2suCgpTaWduZWQtb2ZmLWJ5OiBNaWNoYcWCIE1pcm9zxYJhdyA8bWlycS1saW51eEByZXJl
LnFtcW0ucGw+Ci0tLQogZHJpdmVycy9jbGsvYXQ5MS9jbGstYXVkaW8tcGxsLmMgfCA4ICsrKysr
KystCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9jbGsvYXQ5MS9jbGstYXVkaW8tcGxsLmMgYi9kcml2ZXJzL2Nsay9h
dDkxL2Nsay1hdWRpby1wbGwuYwppbmRleCAzNmQ3NzE0NmEzYmQuLjNhMzU4MjgyNzg0ZSAxMDA2
NDQKLS0tIGEvZHJpdmVycy9jbGsvYXQ5MS9jbGstYXVkaW8tcGxsLmMKKysrIGIvZHJpdmVycy9j
bGsvYXQ5MS9jbGstYXVkaW8tcGxsLmMKQEAgLTM0MCw3ICszNDAsMTEgQEAgc3RhdGljIGxvbmcg
Y2xrX2F1ZGlvX3BsbF9wbWNfcm91bmRfcmF0ZShzdHJ1Y3QgY2xrX2h3ICpodywgdW5zaWduZWQg
bG9uZyByYXRlLAogCXByX2RlYnVnKCJBIFBMTC9QTUM6ICVzLCByYXRlID0gJWx1IChwYXJlbnRf
cmF0ZSA9ICVsdSlcbiIsIF9fZnVuY19fLAogCQkgcmF0ZSwgKnBhcmVudF9yYXRlKTsKIAotCWZv
ciAoZGl2ID0gMTsgZGl2IDw9IEFVRElPX1BMTF9RRFBNQ19NQVg7IGRpdisrKSB7CisJaWYgKCFy
YXRlKQorCQlyZXR1cm4gMDsKKworCWJlc3RfcGFyZW50X3JhdGUgPSBjbGtfcm91bmRfcmF0ZShw
Y2xrLT5jbGssIDEpOworCWZvciAoZGl2ID0gbWF4KGJlc3RfcGFyZW50X3JhdGUgLyByYXRlLCAx
dWwpOyBkaXYgPD0gQVVESU9fUExMX1FEUE1DX01BWDsgZGl2KyspIHsKIAkJYmVzdF9wYXJlbnRf
cmF0ZSA9IGNsa19yb3VuZF9yYXRlKHBjbGstPmNsaywgcmF0ZSAqIGRpdik7CiAJCXRtcF9yYXRl
ID0gYmVzdF9wYXJlbnRfcmF0ZSAvIGRpdjsKIAkJdG1wX2RpZmYgPSBhYnMocmF0ZSAtIHRtcF9y
YXRlKTsKQEAgLTM1MCw2ICszNTQsOCBAQCBzdGF0aWMgbG9uZyBjbGtfYXVkaW9fcGxsX3BtY19y
b3VuZF9yYXRlKHN0cnVjdCBjbGtfaHcgKmh3LCB1bnNpZ25lZCBsb25nIHJhdGUsCiAJCQliZXN0
X3JhdGUgPSB0bXBfcmF0ZTsKIAkJCWJlc3RfZGlmZiA9IHRtcF9kaWZmOwogCQkJdG1wX3FkID0g
ZGl2OworCQkJaWYgKCFiZXN0X2RpZmYpCisJCQkJYnJlYWs7CS8qIGdvdCBleGFjdCBtYXRjaCAq
LwogCQl9CiAJfQogCi0tIAoyLjE5LjIKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
