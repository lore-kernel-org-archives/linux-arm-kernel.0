Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7916C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:24:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 859F22184E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FXgOBQ16";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="pigx0JnH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 859F22184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rere.qmqm.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:MIME-Version:Subject:From:Message-Id
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ajQJft2tm5e9xFZk7JcGVeXu8ClI0f2UH7uO3Cwj3fA=; b=FXgOBQ16iMGu9F
	koFDjQB1Xfb2F7NSFcHMYxJCOEzWSaclfFA39c2VxfNTOhnJ6hnZOpWQYJ3vPkQUQyePvcQRg+6Jl
	QZ9/uoAUn8B82DwZK/yOWZoOfwJ0I+bKFRv8BXXwisrWcNvKi/yHUwj1ashBYzEcY86+sN2b4+pjb
	Ia9smK847BcX6ij3I7bqjNaRmeToSM5YAg1j+5mHh/8DaGoHnScf1mMM9EC0g2AWDv/7wG/Q55+p5
	X+oiZlAShHxSGpEpIYutSuPpgVDSVRtC30ybhmj6+mxnM7Psz8qusULysfl9t6vEQ1Je1UlT4WnNS
	9lNT7A12YpqDyIHPlCTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZDUB-000656-G9; Tue, 18 Dec 2018 11:24:27 +0000
Received: from rere.qmqm.pl ([91.227.64.183])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZDTz-0005pn-Kt
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 11:24:19 +0000
Received: from remote.user (localhost [127.0.0.1])
 by rere.qmqm.pl (Postfix) with ESMTPSA id 43Jwbx1D9Dz1f;
 Tue, 18 Dec 2018 12:22:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
 t=1545132157; bh=LoiL0Ir2qotlSd4J6F6YKsc3OqiC7BOqc1ue5iQ2gtE=;
 h=Date:From:Subject:To:Cc:From;
 b=pigx0JnHuPz++WuMHysiiZ1dS2MvSSSmGKgcey1ScdcVrvpBh4iA/HeNXwNMKWuf/
 qPUdwpnvqaBE0tJoibJjrF4g5X45awcaL+J8Wftbknp8FaW7cnn8DkRrBqFUYdDS+x
 hJ9N+gUwAmSNTGqmAbEs1MWFxhQxY0ttY/1Uf+ODhOKYnul7gaTGSHepC5NReqHkii
 WxaeLtLwIabHn+XtqasNf9I59FXHiyp37gJGGpDqBj8N58Qfv59vTVoXtXJ4PhEmqC
 gUQoPnuSlUrJdUMFPheAYn6e9fX++WV36GSB6qkru5c4HjGXnQKreYWgg2TlV/Z3GO
 I1NY4/MdDm9Tg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.2 at mail
Date: Tue, 18 Dec 2018 12:24:03 +0100
Message-Id: <1-28c5791f73370d0aa8cbb57af796b61de2b21238.1545131728.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [RESEND PATCH v3] clk: at91: enable AUDIOPLL as source for PCKx on
 SAMA5D2
MIME-Version: 1.0
To: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_032416_310717_A0D93DDC 
X-CRM114-Status: UNSURE (   9.96  )
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

RGF0YXNoZWV0IGZvciBTQU1BNUQyeCBtZW50aW9ucyA2IHNvdXJjZXMgZm9yIFBDS3gsIHRoZSBs
YXN0IGJlaW5nIEFVRElPUExMLgoKU2lnbmVkLW9mZi1ieTogTWljaGHFgiBNaXJvc8WCYXcgPG1p
cnEtbGludXhAcmVyZS5xbXFtLnBsPgoKLS0tCiB2MjogcmViYXNlZCBmb3IgNC4yMC1yYzcKIHYz
OiByZXdyaXR0ZW4gZm9yIDQuMjEKLS0tCiBkcml2ZXJzL2Nsay9hdDkxL3NhbWE1ZDIuYyB8IDMg
KystCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9jbGsvYXQ5MS9zYW1hNWQyLmMgYi9kcml2ZXJzL2Nsay9hdDkxL3Nh
bWE1ZDIuYwppbmRleCBkNjlhZDk2ZmU5ODguLmFkZTA2MzYyMjUzMSAxMDA2NDQKLS0tIGEvZHJp
dmVycy9jbGsvYXQ5MS9zYW1hNWQyLmMKKysrIGIvZHJpdmVycy9jbGsvYXQ5MS9zYW1hNWQyLmMK
QEAgLTI0MSwxMyArMjQxLDE0IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBzYW1hNWQyX3BtY19zZXR1
cChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wKQogCXBhcmVudF9uYW1lc1syXSA9ICJwbGxhZGl2Y2si
OwogCXBhcmVudF9uYW1lc1szXSA9ICJ1dG1pY2siOwogCXBhcmVudF9uYW1lc1s0XSA9ICJtY2si
OworCXBhcmVudF9uYW1lc1s1XSA9ICJhdWRpb3BsbF9wbWNjayI7CiAJZm9yIChpID0gMDsgaSA8
IDM7IGkrKykgewogCQljaGFyIG5hbWVbNl07CiAKIAkJc25wcmludGYobmFtZSwgc2l6ZW9mKG5h
bWUpLCAicHJvZyVkIiwgaSk7CiAKIAkJaHcgPSBhdDkxX2Nsa19yZWdpc3Rlcl9wcm9ncmFtbWFi
bGUocmVnbWFwLCBuYW1lLAotCQkJCQkJICAgIHBhcmVudF9uYW1lcywgNSwgaSwKKwkJCQkJCSAg
ICBwYXJlbnRfbmFtZXMsIDYsIGksCiAJCQkJCQkgICAgJmF0OTFzYW05eDVfcHJvZ3JhbW1hYmxl
X2xheW91dCk7CiAJCWlmIChJU19FUlIoaHcpKQogCQkJZ290byBlcnJfZnJlZTsKLS0gCjIuMTku
MgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4
LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFy
bS1rZXJuZWwK
