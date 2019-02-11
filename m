Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A72C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:15:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18E5E222B8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f+3xH5MR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E5E222B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zlpSE2R6hJyzcvo/KvmHRouYDtF2dRMu3zTMTWHelzw=; b=f+3xH5MRMkO4hi
	KcHAkxambaHUwLOu3LPoYwsAq3XOlwkifS579uC18JPT8lHOXzY2bAyxBrn/ZJs+3ljNeLtORSqgQ
	S+PPh57VWdNw5Z6xPis+FVjOlvb1HJc0/1DMoDfmdv92L9XwT+360YRJLOFJgCsZqYmuwed2LmsYd
	NHTuOBffnHTxwU+J/QMtbaasK1aa16ONUOqeZl8blxab7myHj6CYMbYb5RK5qxKNMAQcvaITs17DN
	AZsXoiI+Cxj52gHRI5lKwoItRoWAcOobkghNVs0hlQKDiPlBuPWaiJqi/yC0DWPXRNGuT4l+IHqom
	I+YMTQyxW2S7cL4cLmgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtCMd-0004RG-Lh; Mon, 11 Feb 2019 14:15:15 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtCLE-0002WU-60
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 14:13:51 +0000
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gtCL2-0004eR-Qi; Mon, 11 Feb 2019 15:13:36 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92-RC5)
 (envelope-from <ukl@pengutronix.de>)
 id 1gtCL2-0008BY-9H; Mon, 11 Feb 2019 15:13:36 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 14/15] ARM: dts: imx6qdl-colibri: fix swpad values for
 reserved values
Date: Mon, 11 Feb 2019 15:13:32 +0100
Message-Id: <20190211141333.28725-14-u.kleine-koenig@pengutronix.de>
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
X-CRM114-CacheID: sfid-20190211_061348_840349_A78990F6 
X-CRM114-Status: GOOD (  11.07  )
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

Qml0cyA2IGFuZCA3IG9mIHRoZSBSR01JSV8qIHN3cGFkIHJlZ2lzdGVycyBhcmUgbm90IHdyaXRl
YWJsZSBhbmQgcmVhZAphcyB6ZXJvLiBTbyBjaGFuZ2UgdGhlIGNvcnJlc3BvbmRpbmcgY29uZmln
dXJhdGlvbiB2YWx1ZXMgdG8gd3JpdGUgYQp6ZXJvIHRvIHRoZXNlIGJpdHMuCgpTaWduZWQtb2Zm
LWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPgot
LS0KIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwtY29saWJyaS5kdHNpIHwgMTIgKysrKysrLS0t
LS0tCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwtY29saWJyaS5kdHNpIGIvYXJjaC9h
cm0vYm9vdC9kdHMvaW14NnFkbC1jb2xpYnJpLmR0c2kKaW5kZXggODdlMTVlN2NiMzJiLi41Y2Jm
MzUyOTNlNDEgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwtY29saWJyaS5k
dHNpCisrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwtY29saWJyaS5kdHNpCkBAIC01NTUs
NyArNTU1LDcgQEAKIAlwaW5jdHJsX21pY19nbmQ6IGdwaW9taWNnbmQgewogCQlmc2wscGlucyA9
IDwKIAkJCS8qIENvbnRyb2xzIE1pYyBHTkQsIFBVIG9yICcxJyBwdWxsIE1pYyBHTkQgdG8gR05E
ICovCi0JCQlNWDZRRExfUEFEX1JHTUlJX1REMV9fR1BJTzZfSU8yMSAweDFiMGIwCisJCQlNWDZR
RExfUEFEX1JHTUlJX1REMV9fR1BJTzZfSU8yMSAweDFiMDMwCiAJCT47CiAJfTsKIApAQCAtNjA3
LDcgKzYwNyw3IEBACiAJcGluY3RybF90b3VjaF9pbnQ6IGdwaW90b3VjaGludGdycCB7CiAJCWZz
bCxwaW5zID0gPAogCQkJLyogU1RNUEU4MTEgaW50ZXJydXB0ICovCi0JCQlNWDZRRExfUEFEX1JH
TUlJX1REMF9fR1BJTzZfSU8yMCAweDFiMGIwCisJCQlNWDZRRExfUEFEX1JHTUlJX1REMF9fR1BJ
TzZfSU8yMCAweDFiMDMwCiAJCT47CiAJfTsKIApAQCAtNjU4LDkgKzY1OCw5IEBACiAJCQkvKiBV
U0JDX0RFVCAqLwogCQkJTVg2UURMX1BBRF9HUElPXzE3X19HUElPN19JTzEyCQkweDFiMGIwCiAJ
CQkvKiBVU0JDX0RFVF9FTiAqLwotCQkJTVg2UURMX1BBRF9SR01JSV9UWF9DVExfX0dQSU82X0lP
MjYJMHgwZjA1OAorCQkJTVg2UURMX1BBRF9SR01JSV9UWF9DVExfX0dQSU82X0lPMjYJMHgwZjAx
OAogCQkJLyogVVNCQ19ERVRfT1ZFUldSSVRFICovCi0JCQlNWDZRRExfUEFEX1JHTUlJX1JYQ19f
R1BJTzZfSU8zMAkweDBmMDU4CisJCQlNWDZRRExfUEFEX1JHTUlJX1JYQ19fR1BJTzZfSU8zMAkw
eDBmMDE4CiAJCT47CiAJfTsKIApAQCAtNzU3LDE0ICs3NTcsMTQgQEAKIAlwaW5jdHJsX3dlaW1f
cmRud3I6IHdlaW1yZG53ciB7CiAJCWZzbCxwaW5zID0gPAogCQkJTVg2UURMX1BBRF9TRDJfQ0xL
X19HUElPMV9JTzEwCQkweDAwNDAKLQkJCU1YNlFETF9QQURfUkdNSUlfVEQzX19HUElPNl9JTzIz
CTB4MTMwYjAKKwkJCU1YNlFETF9QQURfUkdNSUlfVEQzX19HUElPNl9JTzIzCTB4MTMwMzAKIAkJ
PjsKIAl9OwogCiAJcGluY3RybF93ZWltX25wd2U6IHdlaW1ucHdlIHsKIAkJZnNsLHBpbnMgPSA8
CiAJCQlNWDZRRExfUEFEX1NEMl9EQVQzX19HUElPMV9JTzEyCQkweDAwNDAKLQkJCU1YNlFETF9Q
QURfUkdNSUlfVEQyX19HUElPNl9JTzIyCTB4MTMwYjAKKwkJCU1YNlFETF9QQURfUkdNSUlfVEQy
X19HUElPNl9JTzIyCTB4MTMwMzAKIAkJPjsKIAl9OwogCi0tIAoyLjIwLjEKCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1h
aWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
