Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C34C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:49:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D82620657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rkezqJWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D82620657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oWSIucGp/eWyDufq8+/Ip/T99Rtqq90PSok5gkNJGl4=; b=rkezqJWziv7jOx
	MkMDzOUSgLcG038cGH2kKskV3bDn0GmQnU21wWjheTTA4go4cDnx+f/iomI2oFtKuZuu/GRrKzE7A
	4yhkf52d15r5pyLoIaOpHg3DSeloJvoPdSyAo3P+c0yXn7CkOaq4LpGmSeIjoxQ5f92PBv7uurGxv
	0W+S8ObIvjjU7xclw3ruQM3on+ee8SnoO25kCMgOB5Q8jv4EnggfAEH4rrVwwK3lGjNBlIn4Wamgf
	fOldDQXnh3Ji2dsBn58uI9tnD5qmQoMTB/pWu9O9uNHFeWY4szGz2pLoKrNWVfNtEjFGhLv18G0KZ
	tOmQigNNdkSApBXCWXgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi00D-0002vc-Fl; Fri, 11 Jan 2019 16:49:49 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi009-0002uo-6j
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 16:49:46 +0000
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gi005-00077i-7G; Fri, 11 Jan 2019 17:49:41 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92-RC4)
 (envelope-from <ukl@pengutronix.de>)
 id 1gi004-0001sA-UJ; Fri, 11 Jan 2019 17:49:40 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 2/2] ARM: imx_v6_v7_defconfig: Enable SIOX bus
Date: Fri, 11 Jan 2019 17:49:36 +0100
Message-Id: <20190111164936.7152-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111164936.7152-1-u.kleine-koenig@pengutronix.de>
References: <20190111164936.7152-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_084945_399852_4A5F2A43 
X-CRM114-Status: UNSURE (   9.91  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Gavin Schenk <g.schenk@eckelmann.de>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Tm93IHRoYXQgdGhlcmUgaXMgYSBib2FyZCBtYWtpbmcgdXNlIG9mIHRoaXMgYnVzIGlzIGF2YWls
YWJsZQplbmFibGUgdGhlIHNpb3ggY29kZSB0byBpbmNyZWFzZSBjb21waWxlIGNvdmVyYWdlLgoK
U2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRy
b25peC5kZT4KLS0tCiBhcmNoL2FybS9jb25maWdzL2lteF92Nl92N19kZWZjb25maWcgfCAzICsr
KwogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJt
L2NvbmZpZ3MvaW14X3Y2X3Y3X2RlZmNvbmZpZyBiL2FyY2gvYXJtL2NvbmZpZ3MvaW14X3Y2X3Y3
X2RlZmNvbmZpZwppbmRleCA1NTg2YTUwNzRhOTYuLjA1NjgwYWRjMzU1ZSAxMDA2NDQKLS0tIGEv
YXJjaC9hcm0vY29uZmlncy9pbXhfdjZfdjdfZGVmY29uZmlnCisrKyBiL2FyY2gvYXJtL2NvbmZp
Z3MvaW14X3Y2X3Y3X2RlZmNvbmZpZwpAQCAtMjExLDYgKzIxMSw3IEBAIENPTkZJR19TUElfR1BJ
Tz15CiBDT05GSUdfU1BJX0lNWD15CiBDT05GSUdfU1BJX0ZTTF9EU1BJPXkKIENPTkZJR19HUElP
X1NZU0ZTPXkKK0NPTkZJR19HUElPX1NJT1g9bQogQ09ORklHX0dQSU9fTUFYNzMyWD15CiBDT05G
SUdfR1BJT19NQzlTMDhEWjYwPXkKIENPTkZJR19HUElPX1BDQTk1M1g9eQpAQCAtNDA0LDYgKzQw
NSw4IEBAIENPTkZJR19OVk1FTV9WRjYxMF9PQ09UUD15CiBDT05GSUdfVEVFPXkKIENPTkZJR19P
UFRFRT15CiBDT05GSUdfTVVYX01NSU89eQorQ09ORklHX1NJT1g9bQorQ09ORklHX1NJT1hfQlVT
X0dQSU89bQogQ09ORklHX0VYVDJfRlM9eQogQ09ORklHX0VYVDJfRlNfWEFUVFI9eQogQ09ORklH
X0VYVDJfRlNfUE9TSVhfQUNMPXkKLS0gCjIuMjAuMQoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0Cmxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
