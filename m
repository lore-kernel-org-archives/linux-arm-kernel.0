Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C23C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:15:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 415AD222B8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OfV1aPxb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 415AD222B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bou3S+NV7odEJJ8uHxYJE5bCoSLiAOtnU92djn2mKrw=; b=OfV1aPxb3NqPic
	HhuLaUMf6ryGj1Bt0GsCUlBMUYxqtYTybyxck0tH44gLILZw/iwuXfqBFMVhyEzBszr/u06t+s8FG
	U0alwL+Pwiie1hCFsXcPcU2AuXZL7h9XdWdlI9FQJ56AVR720tPq4rxgiM6nQDyrTSFIlm2B0/2aK
	NoZAWPwjMSVZYgN3vHAvvQfEWjVIT/GEgUun3SJg6dMQJfm82gxWLIQmRsCCE0ARIAjfQ7WaOUThJ
	QguvkBzo5P6KHtgIJi6Lh72JmG0Ud+UDaVm6GxiTs03k0IkfdJj5EluIeHRjxphxPz8Rw64u62KSz
	0RhbvOoWCUkwotenKBPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtCML-0003kU-7K; Mon, 11 Feb 2019 14:14:57 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtCLB-0002UF-53
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 14:13:48 +0000
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gtCL7-0004eP-QV; Mon, 11 Feb 2019 15:13:41 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92-RC5)
 (envelope-from <ukl@pengutronix.de>)
 id 1gtCL2-0008BA-8G; Mon, 11 Feb 2019 15:13:36 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 12/15] ARM: dts: imx6qdl-aristainetos2: fix swpad values for
 reserved values
Date: Mon, 11 Feb 2019 15:13:30 +0100
Message-Id: <20190211141333.28725-12-u.kleine-koenig@pengutronix.de>
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
X-CRM114-CacheID: sfid-20190211_061345_693445_510039DF 
X-CRM114-Status: UNSURE (   9.98  )
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
LWFyaXN0YWluZXRvczIuZHRzaSB8IDI0ICsrKysrKysrKystLS0tLS0tLS0tCiAxIGZpbGUgY2hh
bmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJj
aC9hcm0vYm9vdC9kdHMvaW14NnFkbC1hcmlzdGFpbmV0b3MyLmR0c2kgYi9hcmNoL2FybS9ib290
L2R0cy9pbXg2cWRsLWFyaXN0YWluZXRvczIuZHRzaQppbmRleCAzNzY3NTA4ODJlZDMuLmRhMDEy
NWVmNGZmMSAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC1hcmlzdGFpbmV0
b3MyLmR0c2kKKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC1hcmlzdGFpbmV0b3MyLmR0
c2kKQEAgLTQ0OCwxOSArNDQ4LDE5IEBACiAJCWZzbCxwaW5zID0gPAogCQkJTVg2UURMX1BBRF9F
TkVUX01ESU9fX0VORVRfTURJTyAgICAgICAweDFiMGIwCiAJCQlNWDZRRExfUEFEX0VORVRfTURD
X19FTkVUX01EQyAgICAgICAgIDB4MWIwYjAKLQkJCU1YNlFETF9QQURfUkdNSUlfVFhDX19SR01J
SV9UWEMgICAgICAgMHgxYjBiMAotCQkJTVg2UURMX1BBRF9SR01JSV9URDBfX1JHTUlJX1REMCAg
ICAgICAweDFiMGIwCi0JCQlNWDZRRExfUEFEX1JHTUlJX1REMV9fUkdNSUlfVEQxICAgICAgIDB4
MWIwYjAKLQkJCU1YNlFETF9QQURfUkdNSUlfVEQyX19SR01JSV9URDIgICAgICAgMHgxYjBiMAot
CQkJTVg2UURMX1BBRF9SR01JSV9URDNfX1JHTUlJX1REMyAgICAgICAweDFiMGIwCi0JCQlNWDZR
RExfUEFEX1JHTUlJX1RYX0NUTF9fUkdNSUlfVFhfQ1RMIDB4MWIwYjAKKwkJCU1YNlFETF9QQURf
UkdNSUlfVFhDX19SR01JSV9UWEMgICAgICAgMHgxYjAzMAorCQkJTVg2UURMX1BBRF9SR01JSV9U
RDBfX1JHTUlJX1REMCAgICAgICAweDFiMDMwCisJCQlNWDZRRExfUEFEX1JHTUlJX1REMV9fUkdN
SUlfVEQxICAgICAgIDB4MWIwMzAKKwkJCU1YNlFETF9QQURfUkdNSUlfVEQyX19SR01JSV9URDIg
ICAgICAgMHgxYjAzMAorCQkJTVg2UURMX1BBRF9SR01JSV9URDNfX1JHTUlJX1REMyAgICAgICAw
eDFiMDMwCisJCQlNWDZRRExfUEFEX1JHTUlJX1RYX0NUTF9fUkdNSUlfVFhfQ1RMIDB4MWIwMzAK
IAkJCU1YNlFETF9QQURfRU5FVF9SRUZfQ0xLX19FTkVUX1RYX0NMSyAgMHgxYjBiMAotCQkJTVg2
UURMX1BBRF9SR01JSV9SWENfX1JHTUlJX1JYQyAgICAgICAweDFiMGIwCi0JCQlNWDZRRExfUEFE
X1JHTUlJX1JEMF9fUkdNSUlfUkQwICAgICAgIDB4MWIwYjAKLQkJCU1YNlFETF9QQURfUkdNSUlf
UkQxX19SR01JSV9SRDEgICAgICAgMHgxYjBiMAotCQkJTVg2UURMX1BBRF9SR01JSV9SRDJfX1JH
TUlJX1JEMiAgICAgICAweDFiMGIwCi0JCQlNWDZRRExfUEFEX1JHTUlJX1JEM19fUkdNSUlfUkQz
ICAgICAgIDB4MWIwYjAKLQkJCU1YNlFETF9QQURfUkdNSUlfUlhfQ1RMX19SR01JSV9SWF9DVEwg
MHgxYjBiMAorCQkJTVg2UURMX1BBRF9SR01JSV9SWENfX1JHTUlJX1JYQyAgICAgICAweDFiMDMw
CisJCQlNWDZRRExfUEFEX1JHTUlJX1JEMF9fUkdNSUlfUkQwICAgICAgIDB4MWIwMzAKKwkJCU1Y
NlFETF9QQURfUkdNSUlfUkQxX19SR01JSV9SRDEgICAgICAgMHgxYjAzMAorCQkJTVg2UURMX1BB
RF9SR01JSV9SRDJfX1JHTUlJX1JEMiAgICAgICAweDFiMDMwCisJCQlNWDZRRExfUEFEX1JHTUlJ
X1JEM19fUkdNSUlfUkQzICAgICAgIDB4MWIwMzAKKwkJCU1YNlFETF9QQURfUkdNSUlfUlhfQ1RM
X19SR01JSV9SWF9DVEwgMHgxYjAzMAogCQk+OwogCX07CiAKLS0gCjIuMjAuMQoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
