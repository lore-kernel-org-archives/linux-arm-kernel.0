Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22608C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:14:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5ED2222B8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tyB6yCEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5ED2222B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Xcq2dc8lE+BDCuHyCYbR0f0lxgJl72YrRixYXavGfgo=; b=tyB6yCEZzfYbAb
	+1O8KQmxKLaQD1/oYXhePG0pq9nSttvNXnT115sAkrbEkcNQN258mOatOIN9mq1zT8HL3d8xwg75x
	qek2+p4Ptqo5UIoJN7F0VLWNcpur+saTL3O+ZM/vBo66BouZ9E8qreMdEfid59W74XfB3Oes8sciw
	/1WgeYIvNX4UpXfxeyEmU4/+p4Ub/IwcbsYqV3hjyt5ml1c/9EHJK2CBUgTZtwx/i0PkWtbiJ5l9S
	ElrkNs6qxxAC9SYk+f/1I91U4g9d7dSXJPpCqJ9MhDBfCjYJsC8dI0zmqxPKOqVkGCod7BHrwHrjl
	YUwV39Lr7Nw1Q6Xa0I2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtCLs-0003D8-0Z; Mon, 11 Feb 2019 14:14:28 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtCL7-0002Sq-Kx
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 14:13:45 +0000
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gtCL2-0004eH-Qe; Mon, 11 Feb 2019 15:13:36 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92-RC5)
 (envelope-from <ukl@pengutronix.de>)
 id 1gtCL2-00089x-3s; Mon, 11 Feb 2019 15:13:36 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 04/15] ARM: dts: imx6qdl-phytec-pbab01/pfla02: Use explicit
 swpad values
Date: Mon, 11 Feb 2019 15:13:22 +0100
Message-Id: <20190211141333.28725-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141333.28725-1-u.kleine-koenig@pengutronix.de>
References: <20190211141333.28725-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_061342_142241_2449A73A 
X-CRM114-Status: GOOD (  12.17  )
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
IEhlcmUgdGhlIHJlc2V0CmRlZmF1bHRzIG9mIHRoZSBpLk1YNmRsIGFyZSB1c2VkIG93aW5nIHRv
IGxhY2sgb2Ygb3RoZXIgZXZpZGVuY2UuIChUaGV5CmRpZmZlciBmcm9tIHRoZSBpLk1YNnEgZGVm
YXVsdHMgZm9yIEdQSU9fMCBhbmQgS0VZX1JPVzQuKQoKU2lnbmVkLW9mZi1ieTogVXdlIEtsZWlu
ZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4KLS0tCiBhcmNoL2FybS9i
b290L2R0cy9pbXg2cWRsLXBoeXRlYy1wZmxhMDIuZHRzaSB8IDIwICsrKysrKysrKystLS0tLS0t
LS0tCiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC1waHl0ZWMtcGZsYTAyLmR0c2kg
Yi9hcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLXBoeXRlYy1wZmxhMDIuZHRzaQppbmRleCAxYjUw
YjAxZTliYWMuLjhlMDRhYjdkZjJkNyAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14
NnFkbC1waHl0ZWMtcGZsYTAyLmR0c2kKKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC1w
aHl0ZWMtcGZsYTAyLmR0c2kKQEAgLTIxMSwxMSArMjExLDExIEBACiAJaW14NnEtcGh5dGVjLXBm
bGEwMiB7CiAJCXBpbmN0cmxfaG9nOiBob2dncnAgewogCQkJZnNsLHBpbnMgPSA8Ci0JCQkJTVg2
UURMX1BBRF9FSU1fRDIzX19HUElPM19JTzIzIDB4ODAwMDAwMDAKLQkJCQlNWDZRRExfUEFEX0RJ
U1AwX0RBVDNfX0dQSU80X0lPMjQgMHg4MDAwMDAwMCAvKiBTUEkgTk9SIGNoaXBzZWxlY3QgKi8K
LQkJCQlNWDZRRExfUEFEX1NENF9EQVQxX19HUElPMl9JTzA5ICAweDgwMDAwMDAwIC8qIFBNSUMg
aW50ZXJydXB0ICovCi0JCQkJTVg2UURMX1BBRF9FTkVUX1RYRDBfX0dQSU8xX0lPMzAgMHg4MDAw
MDAwMCAvKiBHcmVlbiBMRUQgKi8KLQkJCQlNWDZRRExfUEFEX0VJTV9FQjNfX0dQSU8yX0lPMzEg
MHg4MDAwMDAwMCAvKiBSZWQgTEVEICovCisJCQkJTVg2UURMX1BBRF9FSU1fRDIzX19HUElPM19J
TzIzCQkweDFiMGIwCisJCQkJTVg2UURMX1BBRF9ESVNQMF9EQVQzX19HUElPNF9JTzI0CTB4MWIw
YjAgLyogU1BJIE5PUiBjaGlwc2VsZWN0ICovCisJCQkJTVg2UURMX1BBRF9TRDRfREFUMV9fR1BJ
TzJfSU8wOQkJMHgxYjBiMCAvKiBQTUlDIGludGVycnVwdCAqLworCQkJCU1YNlFETF9QQURfRU5F
VF9UWEQwX19HUElPMV9JTzMwCTB4MWIwYjAgLyogR3JlZW4gTEVEICovCisJCQkJTVg2UURMX1BB
RF9FSU1fRUIzX19HUElPMl9JTzMxCQkweDFiMGIxIC8qIFJlZCBMRUQgKi8KIAkJCT47CiAJCX07
CiAKQEAgLTI5OSw3ICsyOTksNyBAQAogCQl9OwogCiAJCXBpbmN0cmxfcGNpZTogcGNpZWdycCB7
Ci0JCQlmc2wscGlucyA9IDxNWDZRRExfUEFEX0RJMF9QSU4xNV9fR1BJTzRfSU8xNyAgMHg4MDAw
MDAwMD47CisJCQlmc2wscGlucyA9IDxNWDZRRExfUEFEX0RJMF9QSU4xNV9fR1BJTzRfSU8xNwkw
eDFiMGIwPjsKIAkJfTsKIAogCQlwaW5jdHJsX3VhcnQzOiB1YXJ0M2dycCB7CkBAIC0zMjAsNyAr
MzIwLDcgQEAKIAogCQlwaW5jdHJsX3VzYmgxOiB1c2JoMWdycCB7CiAJCQlmc2wscGlucyA9IDwK
LQkJCQlNWDZRRExfUEFEX0dQSU9fMF9fVVNCX0gxX1BXUgkJMHg4MDAwMDAwMAorCQkJCU1YNlFE
TF9QQURfR1BJT18wX19VU0JfSDFfUFdSCQkweDEzMGIwCiAJCQk+OwogCQl9OwogCkBAIC0zMjgs
NyArMzI4LDcgQEAKIAkJCWZzbCxwaW5zID0gPAogCQkJCU1YNlFETF9QQURfR1BJT18xX19VU0Jf
T1RHX0lECQkweDE3MDU5CiAJCQkJTVg2UURMX1BBRF9LRVlfQ09MNF9fVVNCX09UR19PQwkJMHgx
YjBiMAotCQkJCU1YNlFETF9QQURfS0VZX1JPVzRfX0dQSU80X0lPMTUJCTB4ODAwMDAwMDAKKwkJ
CQlNWDZRRExfUEFEX0tFWV9ST1c0X19HUElPNF9JTzE1CQkweDEzMGIwCiAJCQk+OwogCQl9Owog
CkBAIC0zNTYsOCArMzU2LDggQEAKIAogCQlwaW5jdHJsX3VzZGhjM19jZHdwOiB1c2RoYzNjZHdw
IHsKIAkJCWZzbCxwaW5zID0gPAotCQkJCU1YNlFETF9QQURfRU5FVF9SWEQwX19HUElPMV9JTzI3
IDB4ODAwMDAwMDAKLQkJCQlNWDZRRExfUEFEX0VORVRfVFhEMV9fR1BJTzFfSU8yOSAweDgwMDAw
MDAwCisJCQkJTVg2UURMX1BBRF9FTkVUX1JYRDBfX0dQSU8xX0lPMjcJMHgxYjBiMAorCQkJCU1Y
NlFETF9QQURfRU5FVF9UWEQxX19HUElPMV9JTzI5CTB4MWIwYjAKIAkJCT47CiAJCX07CiAKLS0g
CjIuMjAuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LWFybS1rZXJuZWwK
