Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0343EC282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:16:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C65ED222B8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VozutVHS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C65ED222B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wwVk1AmKHVU6omIIpKaRc2E3qvNpDMMaQ9fafjEm1yI=; b=VozutVHSDJK7U6
	CFFq8iK2aQC/PfogrQJgkoE8ljswfkAMxC6fniu9qJabRIzf4Kh0jLXIwOEOTILyDpxPeySVHpFjn
	vOzhkdOv08O+ykGWvZ6yIo5pnzaDiPI2/uXW+Ax2JXL1+6f33xXTgccLuCrYdRlISFMUiOLW5J1ZC
	7hRAhQrub11svxRBfd4TBqcddTLJf1W3XRyJMRVxVIwQgEHtgVkHjHVhikxckza8vr1UyRY/+HfAh
	gX+D+i8vYGxLa+YyUqGxblsG+oeIJ3cm4S4G2CxzOOmz+Qn8jqtOY52Jaq7C69MsPrH1rihQPrnFc
	aBH5Z+tJAqHL+Oud3iqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtCNO-0006Ci-6q; Mon, 11 Feb 2019 14:16:02 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtCLE-0002Wg-CX
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 14:13:56 +0000
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gtCL2-0004eQ-Qb; Mon, 11 Feb 2019 15:13:36 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92-RC5)
 (envelope-from <ukl@pengutronix.de>)
 id 1gtCL2-0008BO-8l; Mon, 11 Feb 2019 15:13:36 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 13/15] ARM: dts: imx6qdl-aristainetos: fix swpad values for
 reserved values
Date: Mon, 11 Feb 2019 15:13:31 +0100
Message-Id: <20190211141333.28725-13-u.kleine-koenig@pengutronix.de>
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
X-CRM114-CacheID: sfid-20190211_061349_256716_F16DB1CA 
X-CRM114-Status: GOOD (  11.94  )
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

VGhlIElPTVVYQ19TV19QQURfQ1RMX1BBRF9ESTBfUElOMDQgcmVnaXN0ZXIgcmVhZHMgYmFjayBh
cyAwIHdoZW4KMHgyMDAwMCB3YXMgd3JpdHRlbiB0byBpdCBiZWNhdXNlIGJpdCAxNyBpcyByZWFk
b25seS4gU28gY2hhbmdlIHRoZQpzd3BhZCB2YWx1ZSBhY2NvcmRpbmdseSB0byBub3Qgd3JpdGUg
YSAxIHRvIHRoaXMgcmVzZXJ2ZWQgYml0LgoKU2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7Zu
aWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4KLS0tCiBhcmNoL2FybS9ib290L2R0
cy9pbXg2cWRsLWFyaXN0YWluZXRvcy5kdHNpIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMv
aW14NnFkbC1hcmlzdGFpbmV0b3MuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwtYXJp
c3RhaW5ldG9zLmR0c2kKaW5kZXggZWU0ZDBmODRlZWIyLi40ZDI5Njg4NTBiNzUgMTAwNjQ0Ci0t
LSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwtYXJpc3RhaW5ldG9zLmR0c2kKKysrIGIvYXJj
aC9hcm0vYm9vdC9kdHMvaW14NnFkbC1hcmlzdGFpbmV0b3MuZHRzaQpAQCAtMzI4LDcgKzMyOCw3
IEBACiAJCQkJTVg2UURMX1BBRF9ESTBfUElOMTVfX0lQVTFfREkwX1BJTjE1CQkweDEwCiAJCQkJ
TVg2UURMX1BBRF9ESTBfUElOMl9fSVBVMV9ESTBfUElOMDIJCTB4MTAKIAkJCQlNWDZRRExfUEFE
X0RJMF9QSU4zX19JUFUxX0RJMF9QSU4wMwkJMHgxMAotCQkJCU1YNlFETF9QQURfREkwX1BJTjRf
X0dQSU80X0lPMjAJCQkweDIwMDAwCisJCQkJTVg2UURMX1BBRF9ESTBfUElONF9fR1BJTzRfSU8y
MAkJCTB4MDAKIAkJCQlNWDZRRExfUEFEX0RJU1AwX0RBVDBfX0lQVTFfRElTUDBfREFUQTAwCTB4
MTAKIAkJCQlNWDZRRExfUEFEX0RJU1AwX0RBVDFfX0lQVTFfRElTUDBfREFUQTAxCTB4MTAKIAkJ
CQlNWDZRRExfUEFEX0RJU1AwX0RBVDJfX0lQVTFfRElTUDBfREFUQTAyCTB4MTAKLS0gCjIuMjAu
MQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4
LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFy
bS1rZXJuZWwK
