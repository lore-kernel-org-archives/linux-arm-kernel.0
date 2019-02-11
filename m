Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB88C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:15:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D240A222B8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hL4znWZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D240A222B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M0U3H9KC8OSurG3xv0F4hUOd3PpIx0CUSV0FfkpyBZY=; b=hL4znWZ3AC+qKJ
	LcvDzZv2oykzLGke1u4VS4Hc4+z8RppxCn+BMyvNniOFFf8gL67ManhcQA/ds5W/KtTk3fDQpZqz8
	yHJJaip0RhGpAV+HySFsNRFKXGgPUB1jI6Wy/vbzJnT5Ciwi0S7lRI1K6U5HkO0p6SbmshpeoIVa9
	4RTG14t+Lo9e6B4EGjILoR+P0QGCC+QR6qSAvmVDypI6Wgp1lkKd1o5qJtaPtSlG6eMORdldVU01o
	2Xqw/8dLcQ5ju8/siyRWi1jj96EizhMT5xGh0/AVKA0E1rFdLOtsEwt+KUlOCyW+z9U/einZkvG4o
	vyaHityvWYvST5elu9eg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtCN7-0005qV-Da; Mon, 11 Feb 2019 14:15:45 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtCLE-0002Wh-HI
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 14:13:56 +0000
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gtCL2-0004eS-Sf; Mon, 11 Feb 2019 15:13:36 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92-RC5)
 (envelope-from <ukl@pengutronix.de>)
 id 1gtCL2-0008Br-9m; Mon, 11 Feb 2019 15:13:36 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 15/15] ARM: dts: imx6qdl-ts7970: fix swpad values for reserved
 values
Date: Mon, 11 Feb 2019 15:13:33 +0100
Message-Id: <20190211141333.28725-15-u.kleine-koenig@pengutronix.de>
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
X-CRM114-CacheID: sfid-20190211_061349_422854_42B23BD3 
X-CRM114-Status: GOOD (  10.17  )
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

TW9zdCBvZiB0aGUgUkdNSUlfKiBwYWRzIGRvbid0IGhhdmUgYSB3cml0YWJsZSBTUEVFRCBmaWVs
ZC4gVGhlCnJlc3BlY3RpdmUgcmVhZC1vbmx5IGJpdHMgcmVhZCBhcyB6ZXJvLCBzbyBhbHNvIHdy
aXRlIGJhY2sgYSB6ZXJvLgoKU2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xl
aW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4KLS0tCiBhcmNoL2FybS9ib290L2R0cy9pbXg2cWRs
LXRzNzk3MC5kdHNpIHwgMjQgKysrKysrKysrKysrLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgMTIgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9h
cm0vYm9vdC9kdHMvaW14NnFkbC10czc5NzAuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZx
ZGwtdHM3OTcwLmR0c2kKaW5kZXggZjBiZTUxNmRjMjhlLi4wNDRkODc1ZTBiODYgMTAwNjQ0Ci0t
LSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwtdHM3OTcwLmR0c2kKKysrIGIvYXJjaC9hcm0v
Ym9vdC9kdHMvaW14NnFkbC10czc5NzAuZHRzaQpAQCAtMjgyLDE4ICsyODIsMTggQEAKIAkJZnNs
LHBpbnMgPSA8CiAJCQlNWDZRRExfUEFEX0VORVRfTURJT19fRU5FVF9NRElPCQkweDFiMGIwCiAJ
CQlNWDZRRExfUEFEX0VORVRfTURDX19FTkVUX01EQwkJMHgxYjBiMAotCQkJTVg2UURMX1BBRF9S
R01JSV9UWENfX1JHTUlJX1RYQwkJMHgxYjBiMAotCQkJTVg2UURMX1BBRF9SR01JSV9URDBfX1JH
TUlJX1REMAkJMHgxYjBiMAotCQkJTVg2UURMX1BBRF9SR01JSV9URDFfX1JHTUlJX1REMQkJMHgx
YjBiMAotCQkJTVg2UURMX1BBRF9SR01JSV9URDJfX1JHTUlJX1REMgkJMHgxYjBiMAotCQkJTVg2
UURMX1BBRF9SR01JSV9URDNfX1JHTUlJX1REMwkJMHgxYjBiMAotCQkJTVg2UURMX1BBRF9SR01J
SV9UWF9DVExfX1JHTUlJX1RYX0NUTAkweDFiMGIwCi0JCQlNWDZRRExfUEFEX1JHTUlJX1JYQ19f
UkdNSUlfUlhDCQkweDFiMGIwCi0JCQlNWDZRRExfUEFEX1JHTUlJX1JEMF9fUkdNSUlfUkQwCQkw
eDFiMGIwCi0JCQlNWDZRRExfUEFEX1JHTUlJX1JEMV9fUkdNSUlfUkQxCQkweDFiMGIwCi0JCQlN
WDZRRExfUEFEX1JHTUlJX1JEMl9fUkdNSUlfUkQyCQkweDFiMGIwCi0JCQlNWDZRRExfUEFEX1JH
TUlJX1JEM19fUkdNSUlfUkQzCQkweDFiMGIwCi0JCQlNWDZRRExfUEFEX1JHTUlJX1JYX0NUTF9f
UkdNSUlfUlhfQ1RMCTB4MWIwYjAKKwkJCU1YNlFETF9QQURfUkdNSUlfVFhDX19SR01JSV9UWEMJ
CTB4MWIwMzAKKwkJCU1YNlFETF9QQURfUkdNSUlfVEQwX19SR01JSV9URDAJCTB4MWIwMzAKKwkJ
CU1YNlFETF9QQURfUkdNSUlfVEQxX19SR01JSV9URDEJCTB4MWIwMzAKKwkJCU1YNlFETF9QQURf
UkdNSUlfVEQyX19SR01JSV9URDIJCTB4MWIwMzAKKwkJCU1YNlFETF9QQURfUkdNSUlfVEQzX19S
R01JSV9URDMJCTB4MWIwMzAKKwkJCU1YNlFETF9QQURfUkdNSUlfVFhfQ1RMX19SR01JSV9UWF9D
VEwJMHgxYjAzMAorCQkJTVg2UURMX1BBRF9SR01JSV9SWENfX1JHTUlJX1JYQwkJMHgxYjAzMAor
CQkJTVg2UURMX1BBRF9SR01JSV9SRDBfX1JHTUlJX1JEMAkJMHgxYjAzMAorCQkJTVg2UURMX1BB
RF9SR01JSV9SRDFfX1JHTUlJX1JEMQkJMHgxYjAzMAorCQkJTVg2UURMX1BBRF9SR01JSV9SRDJf
X1JHTUlJX1JEMgkJMHgxYjAzMAorCQkJTVg2UURMX1BBRF9SR01JSV9SRDNfX1JHTUlJX1JEMwkJ
MHgxYjAzMAorCQkJTVg2UURMX1BBRF9SR01JSV9SWF9DVExfX1JHTUlJX1JYX0NUTAkweDFiMDMw
CiAJCQlNWDZRRExfUEFEX0VORVRfUkVGX0NMS19fRU5FVF9UWF9DTEsJMHgxYjBiMAogCQkJTVg2
UURMX1BBRF9FTkVUX1RYX0VOX19HUElPMV9JTzI4CTB4MWIwODgKIAkJCU1YNlFETF9QQURfREkw
X1BJTjRfX0dQSU80X0lPMjAJCTB4MWIwODggLyogRVRIX1BIWV9SRVNFVCAqLwotLSAKMi4yMC4x
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
YXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJt
LWtlcm5lbAo=
