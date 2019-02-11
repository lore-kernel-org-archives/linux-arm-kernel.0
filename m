Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4D4C282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:22:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B393222A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FDa2WHhw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B393222A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=3/Terlc7CDsm86CwABqhVFU2JvsMWo9KLlgSh6U92l8=; b=FDa2WHhwfThPRr
	1yMFetWIGaSuFPkK+vN2XAYa6iuZRKCBOQxH6loeJvJk7wLrp0sPP1R3EJ7EtnsUaJ4IJe/Qk9uF/
	9D6Wjmwa7JgovdowkaXMiefwl29gYlBvGpVAVl55JkPd48lQ/4Aa3Bot+BOR56Qn86no7wSqtwc8t
	N0Wn84RbYNXm5JZvMSe0WWlls997/6Oy6lnVUM9+27ez4Hf3hj7XCi9alzchVnEBYul/4+KalzAjZ
	5WYNp1FmbDARn2/WgOlLjIf0YpOlFGmIsGnaV8Oswiob52aM7xDZ9PrRtEY9VC0t/Z/ELNz3vgZEc
	iLOfSSp4hDt1OJLoC3WA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtCT3-0001Rg-8w; Mon, 11 Feb 2019 14:21:53 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtCLM-0002gd-ES
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 14:14:01 +0000
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gtCL2-0004eE-Qe; Mon, 11 Feb 2019 15:13:36 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92-RC5)
 (envelope-from <ukl@pengutronix.de>)
 id 1gtCL2-00089Y-23; Mon, 11 Feb 2019 15:13:36 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 01/15] ARM: dts: imx6qdl-fdi-fs700-m60: Use explicit swpad
 values
Date: Mon, 11 Feb 2019 15:13:19 +0100
Message-Id: <20190211141333.28725-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_061357_038221_93BCF4DD 
X-CRM114-Status: GOOD (  11.91  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SW5zdGVhZCBvZiByZWx5aW5nIG9uIHJlc2V0IGRlZmF1bHRzIG9yIGEgYm9vdGxvYWRlciB0byBj
b25maWd1cmUKdXNlIGV4cGxpY2l0IHZhbHVlcyBmb3IgdGhlIHN3cGFkIGNvbmZpZ3VyYXRpb24u
IEhlcmUgdGhlIHJlc2V0CmRlZmF1bHRzIGFyZSB1c2VkIG93aW5nIHRvIGxhY2sgb2Ygb3RoZXIg
ZXZpZGVuY2UuCgpTaWduZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29l
bmlnQHBlbmd1dHJvbml4LmRlPgotLS0KIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwtZGZpLWZz
NzAwLW02MC5kdHNpIHwgMTAgKysrKystLS0tLQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9u
cygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9pbXg2
cWRsLWRmaS1mczcwMC1tNjAuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwtZGZpLWZz
NzAwLW02MC5kdHNpCmluZGV4IGViZTdhOGJkZGYwNC4uMjA4Zjk0YmUxMjk2IDEwMDY0NAotLS0g
YS9hcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLWRmaS1mczcwMC1tNjAuZHRzaQorKysgYi9hcmNo
L2FybS9ib290L2R0cy9pbXg2cWRsLWRmaS1mczcwMC1tNjAuZHRzaQpAQCAtNTgsOSArNTgsOSBA
QAogCWlteDZxZGwtZGZpLWZzNzAwLW02MCB7CiAJCXBpbmN0cmxfaG9nOiBob2dncnAgewogCQkJ
ZnNsLHBpbnMgPSA8Ci0JCQkJTVg2UURMX1BBRF9FTkVUX0NSU19EVl9fR1BJTzFfSU8yNSAweDgw
MDAwMDAwCi0JCQkJTVg2UURMX1BBRF9HUElPXzE4X19HUElPN19JTzEzIDB4ODAwMDAwMDAgLyog
UE1JQyBpcnEgKi8KLQkJCQlNWDZRRExfUEFEX0VJTV9EMjZfX0dQSU8zX0lPMjYgMHg4MDAwMDAw
MCAvKiBNQVgxMTgwMSBpcnEgKi8KKwkJCQlNWDZRRExfUEFEX0VORVRfQ1JTX0RWX19HUElPMV9J
TzI1IDB4MDAwMWIwYjAKKwkJCQlNWDZRRExfUEFEX0dQSU9fMThfX0dQSU83X0lPMTMgMHgwMDAx
YjBiMCAvKiBQTUlDIGlycSAqLworCQkJCU1YNlFETF9QQURfRUlNX0QyNl9fR1BJTzNfSU8yNiAw
eDAwMDFiMGIwIC8qIE1BWDExODAxIGlycSAqLwogCQkJCU1YNlFETF9QQURfTkFOREZfRDVfX0dQ
SU8yX0lPMDUgMHgwMDAwMzBiMCAvKiBCYWNrbGlnaHQgZW5hYmxlICovCiAJCQk+OwogCQl9OwpA
QCAtMTE0LDcgKzExNCw3IEBACiAJCQkJTVg2UURMX1BBRF9TRDJfREFUMV9fU0QyX0RBVEExCQkw
eDE3MDU5CiAJCQkJTVg2UURMX1BBRF9TRDJfREFUMl9fU0QyX0RBVEEyCQkweDE3MDU5CiAJCQkJ
TVg2UURMX1BBRF9TRDJfREFUM19fU0QyX0RBVEEzCQkweDE3MDU5Ci0JCQkJTVg2UURMX1BBRF9O
QU5ERl9EMl9fR1BJTzJfSU8wMiAweDgwMDAwMDAwIC8qIGNhcmQgZGV0ZWN0ICovCisJCQkJTVg2
UURMX1BBRF9OQU5ERl9EMl9fR1BJTzJfSU8wMiAJMHgxYjBiMCAvKiBjYXJkIGRldGVjdCAqLwog
CQkJPjsKIAkJfTsKIApAQCAtMTQ5LDcgKzE0OSw3IEBACiAJCQkJTVg2UURMX1BBRF9ESVNQMF9E
QVQyX19FQ1NQSTNfTUlTTwkweDEwMGIxCiAJCQkJTVg2UURMX1BBRF9ESVNQMF9EQVQxX19FQ1NQ
STNfTU9TSQkweDEwMGIxCiAJCQkJTVg2UURMX1BBRF9ESVNQMF9EQVQwX19FQ1NQSTNfU0NMSwkw
eDEwMGIxCi0JCQkJTVg2UURMX1BBRF9ESVNQMF9EQVQzX19HUElPNF9JTzI0IDB4ODAwMDAwMDAg
LyogU1BJIE5PUiBjaGlwc2VsZWN0ICovCisJCQkJTVg2UURMX1BBRF9ESVNQMF9EQVQzX19HUElP
NF9JTzI0CTB4MWIwYjAgLyogU1BJIE5PUiBjaGlwc2VsZWN0ICovCiAJCQk+OwogCQl9OwogCX07
Ci0tIAoyLjIwLjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1hcm0ta2VybmVsCg==
