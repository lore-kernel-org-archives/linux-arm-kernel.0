Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A31C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:14:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E20D5222B8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VYhRikeb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E20D5222B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G80YTqRL39gYWQQZFPPsXVe4CapOMGxCY6lcL+xjWdc=; b=VYhRikeb+pNiWI
	ETLZ8riT0ALJZ0rBHaqw0ueTJgvES97EYhABzHptT/PjieeJC6uqw98pn8x/3stJNTTsmTf6BEcsa
	jBEiTtb1qLvkR9tKQMWUvi/gKKKKTEydRX0pijSgPHFouzjxtRBjRBwBXxQDlQBtUNtW/T5yOVl+7
	JQ4H+qTUTRaUAg51J2tpRiLVjIOOuWi67Rh6qcsZiw/9E6UXnXpBI9BrOnwj3DLpJ7lq2iNlqWvtC
	o1IG7JbjQojwh+B5XpSkQRFQVSmy9Yyevx2He9xlsoPnNzFQJVzOFh7SjuM1gOzq/WMQ14DcIdjYY
	gvcBMs8vhuZqqPboZOsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtCLS-0002mQ-35; Mon, 11 Feb 2019 14:14:02 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtCL7-0002Ss-Ks
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 14:13:43 +0000
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gtCL2-0004eL-Qc; Mon, 11 Feb 2019 15:13:36 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92-RC5)
 (envelope-from <ukl@pengutronix.de>)
 id 1gtCL2-0008AP-68; Mon, 11 Feb 2019 15:13:36 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 08/15] ARM: dts: imx6qdl-wandboard-*: Use explicit swpad values
Date: Mon, 11 Feb 2019 15:13:26 +0100
Message-Id: <20190211141333.28725-8-u.kleine-koenig@pengutronix.de>
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
X-CRM114-CacheID: sfid-20190211_061341_842789_F019F1BC 
X-CRM114-Status: GOOD (  11.50  )
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
bmlnQHBlbmd1dHJvbml4LmRlPgotLS0KIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwtd2FuZGJv
YXJkLXJldmIxLmR0c2kgfCAxNiArKysrKysrKy0tLS0tLS0tCiBhcmNoL2FybS9ib290L2R0cy9p
bXg2cWRsLXdhbmRib2FyZC1yZXZjMS5kdHNpIHwgMTYgKysrKysrKystLS0tLS0tLQogYXJjaC9h
cm0vYm9vdC9kdHMvaW14NnFkbC13YW5kYm9hcmQtcmV2ZDEuZHRzaSB8ICA2ICsrKy0tLQogMyBm
aWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9hcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLXdhbmRib2FyZC1yZXZiMS5kdHNpIGIvYXJj
aC9hcm0vYm9vdC9kdHMvaW14NnFkbC13YW5kYm9hcmQtcmV2YjEuZHRzaQppbmRleCBlNzgxYTQ1
Nzg1ZWQuLjk1NjYxYzM5YTUxOSAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFk
bC13YW5kYm9hcmQtcmV2YjEuZHRzaQorKysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLXdh
bmRib2FyZC1yZXZiMS5kdHNpCkBAIC0xMiwxNyArMTIsMTcgQEAKIAlpbXg2cWRsLXdhbmRib2Fy
ZCB7CiAJCXBpbmN0cmxfaG9nOiBob2dncnAgewogCQkJZnNsLHBpbnMgPSA8Ci0JCQkJTVg2UURM
X1BBRF9HUElPXzJfX0dQSU8xX0lPMDIJCTB4ODAwMDAwMDAJLyogdVNESEMxIENEICovCi0JCQkJ
TVg2UURMX1BBRF9FSU1fREE5X19HUElPM19JTzA5CQkweDgwMDAwMDAwCS8qIHVTREhDMyBDRCAq
LworCQkJCU1YNlFETF9QQURfR1BJT18yX19HUElPMV9JTzAyCQkweDFiMGIwCQkvKiB1U0RIQzEg
Q0QgKi8KKwkJCQlNWDZRRExfUEFEX0VJTV9EQTlfX0dQSU8zX0lPMDkJCTB4MGIwYjEJCS8qIHVT
REhDMyBDRCAqLwogCQkJCU1YNlFETF9QQURfRUlNX0VCMV9fR1BJTzJfSU8yOQkJMHgwZjBiMAkJ
LyogV0xfUkVGX09OICovCiAJCQkJTVg2UURMX1BBRF9FSU1fQTI1X19HUElPNV9JTzAyCQkweDBm
MGIwCQkvKiBXTF9SU1RfTiAqLwogCQkJCU1YNlFETF9QQURfRU5FVF9SWEQxX19HUElPMV9JTzI2
CTB4MDAwYjAJCS8qIFdMX1JFR19PTiAqLwotCQkJCU1YNlFETF9QQURfRU5FVF9UWEQxX19HUElP
MV9JTzI5CTB4ODAwMDAwMDAJLyogV0xfSE9TVF9XQUtFICovCi0JCQkJTVg2UURMX1BBRF9FTkVU
X1RYRDBfX0dQSU8xX0lPMzAJMHg4MDAwMDAwMAkvKiBXTF9XQUtFICovCi0JCQkJTVg2UURMX1BB
RF9FSU1fRDI5X19HUElPM19JTzI5CQkweDgwMDAwMDAwCS8qIFJHTUlJX25SU1QgKi8KLQkJCQlN
WDZRRExfUEFEX0VJTV9EQTEzX19HUElPM19JTzEzCQkweDgwMDAwMDAwCS8qIEJUX09OICovCi0J
CQkJTVg2UURMX1BBRF9FSU1fREExNF9fR1BJTzNfSU8xNAkJMHg4MDAwMDAwMAkvKiBCVF9XQUtF
ICovCi0JCQkJTVg2UURMX1BBRF9FSU1fREExNV9fR1BJTzNfSU8xNQkJMHg4MDAwMDAwMAkvKiBC
VF9IT1NUX1dBS0UgKi8KKwkJCQlNWDZRRExfUEFEX0VORVRfVFhEMV9fR1BJTzFfSU8yOQkweDFi
MGIwCQkvKiBXTF9IT1NUX1dBS0UgKi8KKwkJCQlNWDZRRExfUEFEX0VORVRfVFhEMF9fR1BJTzFf
SU8zMAkweDFiMGIwCQkvKiBXTF9XQUtFICovCisJCQkJTVg2UURMX1BBRF9FSU1fRDI5X19HUElP
M19JTzI5CQkweDFiMGIwCQkvKiBSR01JSV9uUlNUICovCisJCQkJTVg2UURMX1BBRF9FSU1fREEx
M19fR1BJTzNfSU8xMwkJMHgwYjBiMQkJLyogQlRfT04gKi8KKwkJCQlNWDZRRExfUEFEX0VJTV9E
QTE0X19HUElPM19JTzE0CQkweDBiMGIxCQkvKiBCVF9XQUtFICovCisJCQkJTVg2UURMX1BBRF9F
SU1fREExNV9fR1BJTzNfSU8xNQkJMHgwYjBiMQkJLyogQlRfSE9TVF9XQUtFICovCiAJCQk+Owog
CQl9OwogCX07CmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLXdhbmRib2Fy
ZC1yZXZjMS5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC13YW5kYm9hcmQtcmV2YzEu
ZHRzaQppbmRleCAzODc0ZTc0NzAzZjAuLjhhYmRhNDdiYzg2NiAxMDA2NDQKLS0tIGEvYXJjaC9h
cm0vYm9vdC9kdHMvaW14NnFkbC13YW5kYm9hcmQtcmV2YzEuZHRzaQorKysgYi9hcmNoL2FybS9i
b290L2R0cy9pbXg2cWRsLXdhbmRib2FyZC1yZXZjMS5kdHNpCkBAIC0xMiwxNyArMTIsMTcgQEAK
IAlpbXg2cWRsLXdhbmRib2FyZCB7CiAJCXBpbmN0cmxfaG9nOiBob2dncnAgewogCQkJZnNsLHBp
bnMgPSA8Ci0JCQkJTVg2UURMX1BBRF9HUElPXzJfX0dQSU8xX0lPMDIJCTB4ODAwMDAwMDAJLyog
dVNESEMxIENEICovCi0JCQkJTVg2UURMX1BBRF9FSU1fREE5X19HUElPM19JTzA5CQkweDgwMDAw
MDAwCS8qIHVTREhDMyBDRCAqLworCQkJCU1YNlFETF9QQURfR1BJT18yX19HUElPMV9JTzAyCQkw
eDFiMGIwCQkvKiB1U0RIQzEgQ0QgKi8KKwkJCQlNWDZRRExfUEFEX0VJTV9EQTlfX0dQSU8zX0lP
MDkJCTB4MGIwYjEJCS8qIHVTREhDMyBDRCAqLwogCQkJCU1YNlFETF9QQURfQ1NJMF9EQVQxNF9f
R1BJTzZfSU8wMAkweDBmMGIwCQkvKiBXSUZJX09OIChyZXNldCwgYWN0aXZlIGxvdykgKi8KIAkJ
CQlNWDZRRExfUEFEX0VORVRfUlhEMV9fR1BJTzFfSU8yNgkweDAwMGIwCQkvKiBXTF9SRUdfT04g
KHVudXNlZCkgKi8KLQkJCQlNWDZRRExfUEFEX0VORVRfVFhEMV9fR1BJTzFfSU8yOQkweDgwMDAw
MDAwCS8qIFdMX0hPU1RfV0FLRSwgaW5wdXQgKi8KKwkJCQlNWDZRRExfUEFEX0VORVRfVFhEMV9f
R1BJTzFfSU8yOQkweDFiMGIwCQkvKiBXTF9IT1NUX1dBS0UsIGlucHV0ICovCiAJCQkJTVg2UURM
X1BBRF9DU0kwX0RBVDEzX19HUElPNV9JTzMxCTB4MGYwYjAJCS8qIEdQSU81X0lPMzEgKFdpZmkg
UG93ZXIgRW5hYmxlKSAqLwotCQkJCU1YNlFETF9QQURfRU5FVF9UWEQwX19HUElPMV9JTzMwCTB4
ODAwMDAwMDAJLyogV0xfV0FLRSAodW51c2VkKSAqLwotCQkJCU1YNlFETF9QQURfQ1NJMF9WU1lO
Q19fR1BJTzVfSU8yMQkweDgwMDAwMDAwCS8qIEJUX09OICovCi0JCQkJTVg2UURMX1BBRF9DU0kw
X0RBVDEyX19HUElPNV9JTzMwCTB4ODAwMDAwMDAJLyogQlRfV0FLRSAqLwotCQkJCU1YNlFETF9Q
QURfQ1NJMF9EQVRBX0VOX19HUElPNV9JTzIwCTB4ODAwMDAwMDAJLyogQlRfSE9TVF9XQUtFICov
Ci0JCQkJTVg2UURMX1BBRF9FSU1fRDI5X19HUElPM19JTzI5CQkweDgwMDAwMDAwCS8qIFJHTUlJ
X25SU1QgKi8KKwkJCQlNWDZRRExfUEFEX0VORVRfVFhEMF9fR1BJTzFfSU8zMAkweDFiMGIwCQkv
KiBXTF9XQUtFICh1bnVzZWQpICovCisJCQkJTVg2UURMX1BBRF9DU0kwX1ZTWU5DX19HUElPNV9J
TzIxCTB4MWIwYjAJCS8qIEJUX09OICovCisJCQkJTVg2UURMX1BBRF9DU0kwX0RBVDEyX19HUElP
NV9JTzMwCTB4MWIwYjAJCS8qIEJUX1dBS0UgKi8KKwkJCQlNWDZRRExfUEFEX0NTSTBfREFUQV9F
Tl9fR1BJTzVfSU8yMAkweDFiMGIwCQkvKiBCVF9IT1NUX1dBS0UgKi8KKwkJCQlNWDZRRExfUEFE
X0VJTV9EMjlfX0dQSU8zX0lPMjkJCTB4MWIwYjAJCS8qIFJHTUlJX25SU1QgKi8KIAkJCT47CiAJ
CX07CiAJfTsKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwtd2FuZGJvYXJk
LXJldmQxLmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLXdhbmRib2FyZC1yZXZkMS5k
dHNpCmluZGV4IDkzOTA5Nzk2ODg1YS4uYzk0ZDI0N2EyNDk2IDEwMDY0NAotLS0gYS9hcmNoL2Fy
bS9ib290L2R0cy9pbXg2cWRsLXdhbmRib2FyZC1yZXZkMS5kdHNpCisrKyBiL2FyY2gvYXJtL2Jv
b3QvZHRzL2lteDZxZGwtd2FuZGJvYXJkLXJldmQxLmR0c2kKQEAgLTE0Miw5ICsxNDIsOSBAQAog
CWlteDZxZGwtd2FuZGJvYXJkIHsKIAkJcGluY3RybF9ob2c6IGhvZ2dycCB7CiAJCQlmc2wscGlu
cyA9IDwKLQkJCQlNWDZRRExfUEFEX0VJTV9EMjJfX1VTQl9PVEdfUFdSCQkweDgwMDAwMDAwCS8q
IFVTQiBQb3dlciBFbmFibGUgKi8KLQkJCQlNWDZRRExfUEFEX0dQSU9fMl9fR1BJTzFfSU8wMgkJ
MHg4MDAwMDAwMAkvKiBVU0RIQzEgQ0QgKi8KLQkJCQlNWDZRRExfUEFEX0VJTV9EQTlfX0dQSU8z
X0lPMDkJCTB4ODAwMDAwMDAJLyogdVNESEMzIENEICovCisJCQkJTVg2UURMX1BBRF9FSU1fRDIy
X19VU0JfT1RHX1BXUgkJMHgxYjBiMAkJLyogVVNCIFBvd2VyIEVuYWJsZSAqLworCQkJCU1YNlFE
TF9QQURfR1BJT18yX19HUElPMV9JTzAyCQkweDFiMGIwCQkvKiBVU0RIQzEgQ0QgKi8KKwkJCQlN
WDZRRExfUEFEX0VJTV9EQTlfX0dQSU8zX0lPMDkJCTB4MGIwYjEJCS8qIHVTREhDMyBDRCAqLwog
CQkJCU1YNlFETF9QQURfRUlNX0QyOV9fR1BJTzNfSU8yOSAgIAkweDFmMGIxCQkvKiBSR01JSSBQ
SFkgcmVzZXQgKi8KIAkJCT47CiAJCX07Ci0tIAoyLjIwLjEKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
