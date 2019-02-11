Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1898C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:16:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 743A2222B8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t4am06Gv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 743A2222B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AjBgSw1uQrjYE3nOjK4MepZPLuxhzUbCirCwXDkMuxI=; b=t4am06Gve1anI2
	Jov51s8yRUzzska8eZBV/IbQidSLCXq0MAh9A4NiATAH/uhhI0g7pxc45Y8xUWxNAGRZTGksGvkHK
	2JDiZcC64Vyei3ieUapqlyK0z6eEOx33xlYHnvsE+E6yF49m0+bzoAtBKEkjdYxuZalSPHHATcHYF
	mNSTtrMkEhOP8EMSRVyAfew+RKAO54MLL/3uty4SRj0MmFuV535bCHtwSpIO5RCSt1zKISQQC7THn
	JufsMGGlx+SQOSPlLqughiUUTlPYPPnSiYP6gooX3xsweLO7iJZM14mv/Iv3soe7E+XRgqiMpMgcU
	kJPqrdR0Vy57A+w6pz0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtCO1-0006qR-8C; Mon, 11 Feb 2019 14:16:41 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtCLM-0002ge-EW
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 14:14:00 +0000
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gtCL2-0004eJ-Qg; Mon, 11 Feb 2019 15:13:36 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92-RC5)
 (envelope-from <ukl@pengutronix.de>)
 id 1gtCL2-0008AB-4q; Mon, 11 Feb 2019 15:13:36 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 06/15] ARM: dts: imx6qdl-sabreauto: Use explicit swpad values
Date: Mon, 11 Feb 2019 15:13:24 +0100
Message-Id: <20190211141333.28725-6-u.kleine-koenig@pengutronix.de>
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
X-CRM114-CacheID: sfid-20190211_061357_009446_D9D6BD53 
X-CRM114-Status: GOOD (  12.08  )
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
bmlnQHBlbmd1dHJvbml4LmRlPgotLS0KIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwtc2FicmVh
dXRvLmR0c2kgfCAxMCArKysrKy0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCsp
LCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwt
c2FicmVhdXRvLmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLXNhYnJlYXV0by5kdHNp
CmluZGV4IDEyODBkZTUwYTk4NC4uZTNkYWI5N2RkMTY4IDEwMDY0NAotLS0gYS9hcmNoL2FybS9i
b290L2R0cy9pbXg2cWRsLXNhYnJlYXV0by5kdHNpCisrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lt
eDZxZGwtc2FicmVhdXRvLmR0c2kKQEAgLTQ2Niw5ICs0NjYsOSBAQAogCWlteDZxZGwtc2FicmVh
dXRvIHsKIAkJcGluY3RybF9ob2c6IGhvZ2dycCB7CiAJCQlmc2wscGlucyA9IDwKLQkJCQlNWDZR
RExfUEFEX05BTkRGX0NTMl9fR1BJTzZfSU8xNSAweDgwMDAwMDAwCi0JCQkJTVg2UURMX1BBRF9T
RDJfREFUMl9fR1BJTzFfSU8xMyAgMHg4MDAwMDAwMAotCQkJCU1YNlFETF9QQURfR1BJT18xOF9f
U0QzX1ZTRUxFQ1QgMHgxNzA1OQorCQkJCU1YNlFETF9QQURfTkFOREZfQ1MyX19HUElPNl9JTzE1
CTB4MWIwYjAKKwkJCQlNWDZRRExfUEFEX1NEMl9EQVQyX19HUElPMV9JTzEzCQkweDFiMGIwCisJ
CQkJTVg2UURMX1BBRF9HUElPXzE4X19TRDNfVlNFTEVDVAkJMHgxNzA1OQogCQkJPjsKIAkJfTsK
IApAQCAtNDgyLDcgKzQ4Miw3IEBACiAKIAkJcGluY3RybF9lY3NwaTFfY3M6IGVjc3BpMWNzIHsK
IAkJCWZzbCxwaW5zID0gPAotCQkJCU1YNlFETF9QQURfRUlNX0QxOV9fR1BJTzNfSU8xOSAweDgw
MDAwMDAwCisJCQkJTVg2UURMX1BBRF9FSU1fRDE5X19HUElPM19JTzE5CQkweDFiMGIwCiAJCQk+
OwogCQl9OwogCkBAIC01NTQsNyArNTU0LDcgQEAKIAogCQlwaW5jdHJsX2dwaW9fbGVkczogZ3Bp
b2xlZHNncnAgewogCQkJZnNsLHBpbnMgPSA8Ci0JCQkJTVg2UURMX1BBRF9ESVNQMF9EQVQyMV9f
R1BJTzVfSU8xNQkweDgwMDAwMDAwCisJCQkJTVg2UURMX1BBRF9ESVNQMF9EQVQyMV9fR1BJTzVf
SU8xNQkweDFiMGIwCiAJCQk+OwogCQl9OwogCi0tIAoyLjIwLjEKCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcg
bGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
