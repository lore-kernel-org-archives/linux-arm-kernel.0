Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB72C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:21:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F221021850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CqNjjGoE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="mpAwMMAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F221021850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rere.qmqm.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:MIME-Version:Subject:From:Message-Id
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=cuTfTE7JkOI0r+h0jh9Q46UUNbDIVj0jSTyuH2Pz3MM=; b=CqNjjGoECVeUcO
	uPTV7qyZkaF+f4bskPw3ShIWcja5LuMl7wdqEy6ROsFHNtsJVcxhfF5UzW0WiMKNvRTlLTuefIKeS
	2mWTd2VJQVgXeSZ/nAI70RDiZ2fdxQ1jGKyY5ikSeVsUIOh3owg5q7Ps7K7nYbGQ9kwC8rT7RPPkz
	IrWMdSMvH8qVwZq3xDNZDMZNqhhGlln+I2LLo7jIizkJ3FNrQ02bdqp4vlNV6IfK2vH3TdXbp+TNM
	neBGCgJWHXNsqGtedjthGRREukIGhfGbsy680gc66VpjUmDH8/SwGhfeCXR3DzRa5WDsySviygiJe
	ZipXuf/50buZWPSt/tHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZDQt-0005OP-Lo; Tue, 18 Dec 2018 11:21:03 +0000
Received: from rere.qmqm.pl ([91.227.64.183])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZDQq-0005ND-BJ
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 11:21:01 +0000
Received: from remote.user (localhost [127.0.0.1])
 by rere.qmqm.pl (Postfix) with ESMTPSA id 43JwX96CXdzHb;
 Tue, 18 Dec 2018 12:19:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
 t=1545131961; bh=jycAhEYzEBtnnZoIZGaZbJ1DFaTdDSu9LD2wajM16/g=;
 h=Date:From:Subject:To:Cc:From;
 b=mpAwMMApmN8uoG4xh979VO7RlITGhfUDRY4C/AYkXJ4K5BZJ+OXay+LL5POTqAbt3
 0UjdSzIyA+0uzA/4evpexUK/07teX32fw4L+Ll43r6z5VojB6RnFDx0veErQ9FZSBN
 F4B4p6Zlk/NTjDTozhBvqVkQV/f5vMK43eVZKfAD6Q+XAs8n9nlTYmHeAlYh/HDNPq
 naA4jx9CCdiEDQialJIy4tJxjKMbqG00nbLPNiLlNi0BGFnwUP7EVTG8mZr7zBAOqr
 OqGBX50kCJVHjIgsjtwfslt7Y9KwbkjD/iVENEEpvTP/qG40zbH6JrwVLnlgXDHt/f
 lqioPEpTnFUmw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.2 at mail
Date: Tue, 18 Dec 2018 12:20:48 +0100
Message-Id: <70db24a03b552ca553e6435306d895644fb08545.1545131728.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3] clk: at91: optimize clk_round_rate() for AUDIO_PLL
MIME-Version: 1.0
To: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_032100_562679_8583D42F 
X-CRM114-Status: UNSURE (   8.72  )
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

U3RvcCB0aGUgc2VhcmNoIGZvciBwYXJlbnQgcmF0ZSB3aGVuIGV4YWN0IG1hdGNoIGlzIGZvdW5k
LgoKVGhpcyBtYWtlcyBmb3IgMyBjbGtfcm91bmRfcmF0ZSgpIGNhbGxzIGluc3RlYWQgb2YgNjQg
b2YgdGhlbSBvbgpTQU1BNUQyLWJhc2VkIGJvYXJkIHdoZW4gc2VhcmNoaW5nIGZvciAxMi4yODhN
SHogY2xvY2suCgpTaWduZWQtb2ZmLWJ5OiBNaWNoYcWCIE1pcm9zxYJhdyA8bWlycS1saW51eEBy
ZXJlLnFtcW0ucGw+Ci0tLQogdjI6IHJlYmFzZWQgb24gdjQuMjAtcmM3CiB2MzogZm9ybWF0dGlu
ZyBhbmQgY29tbWl0IGRlc2NyaXB0aW9uIGNoYW5nZXMKLS0tCiBkcml2ZXJzL2Nsay9hdDkxL2Ns
ay1hdWRpby1wbGwuYyB8IDkgKysrKysrKystCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvYXQ5MS9jbGstYXVk
aW8tcGxsLmMgYi9kcml2ZXJzL2Nsay9hdDkxL2Nsay1hdWRpby1wbGwuYwppbmRleCAzNmQ3NzE0
NmEzYmQuLjNjYzRhODJmNGU5ZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9jbGsvYXQ5MS9jbGstYXVk
aW8tcGxsLmMKKysrIGIvZHJpdmVycy9jbGsvYXQ5MS9jbGstYXVkaW8tcGxsLmMKQEAgLTM0MCw3
ICszNDAsMTIgQEAgc3RhdGljIGxvbmcgY2xrX2F1ZGlvX3BsbF9wbWNfcm91bmRfcmF0ZShzdHJ1
Y3QgY2xrX2h3ICpodywgdW5zaWduZWQgbG9uZyByYXRlLAogCXByX2RlYnVnKCJBIFBMTC9QTUM6
ICVzLCByYXRlID0gJWx1IChwYXJlbnRfcmF0ZSA9ICVsdSlcbiIsIF9fZnVuY19fLAogCQkgcmF0
ZSwgKnBhcmVudF9yYXRlKTsKIAotCWZvciAoZGl2ID0gMTsgZGl2IDw9IEFVRElPX1BMTF9RRFBN
Q19NQVg7IGRpdisrKSB7CisJaWYgKCFyYXRlKQorCQlyZXR1cm4gMDsKKworCWJlc3RfcGFyZW50
X3JhdGUgPSBjbGtfcm91bmRfcmF0ZShwY2xrLT5jbGssIDEpOworCWRpdiA9IG1heChiZXN0X3Bh
cmVudF9yYXRlIC8gcmF0ZSwgMVVMKTsKKwlmb3IgKDsgZGl2IDw9IEFVRElPX1BMTF9RRFBNQ19N
QVg7IGRpdisrKSB7CiAJCWJlc3RfcGFyZW50X3JhdGUgPSBjbGtfcm91bmRfcmF0ZShwY2xrLT5j
bGssIHJhdGUgKiBkaXYpOwogCQl0bXBfcmF0ZSA9IGJlc3RfcGFyZW50X3JhdGUgLyBkaXY7CiAJ
CXRtcF9kaWZmID0gYWJzKHJhdGUgLSB0bXBfcmF0ZSk7CkBAIC0zNTAsNiArMzU1LDggQEAgc3Rh
dGljIGxvbmcgY2xrX2F1ZGlvX3BsbF9wbWNfcm91bmRfcmF0ZShzdHJ1Y3QgY2xrX2h3ICpodywg
dW5zaWduZWQgbG9uZyByYXRlLAogCQkJYmVzdF9yYXRlID0gdG1wX3JhdGU7CiAJCQliZXN0X2Rp
ZmYgPSB0bXBfZGlmZjsKIAkJCXRtcF9xZCA9IGRpdjsKKwkJCWlmICghYmVzdF9kaWZmKQorCQkJ
CWJyZWFrOwkvKiBnb3QgZXhhY3QgbWF0Y2ggKi8KIAkJfQogCX0KIAotLSAKMi4xOS4yCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtl
cm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5l
bAo=
