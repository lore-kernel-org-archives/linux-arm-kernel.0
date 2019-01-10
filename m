Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6E8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:20:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BE1E208E3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gm6uAmBc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BE1E208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FzYK45PpWh2rZVEZ/nyVqHkEsGevAft7RMOoAHnSos0=; b=Gm6uAmBcllr7mD
	f2Cx5xItWdouXmLp6lBvrX2Fj1BQcOugoj0MBx3UR48aP8OSKnHgBMOqC+kIZJ2L8tsqCTxhqt6Df
	EJW/xRa/Frxe37U/9rtnYg/UebpdfvXipan9Jfxw/SecNHkkGUf7Z5nkVNdY0a2vPRerjHcMm0wXd
	hgHDM3ASBJhRELKoEE9k4a1JKCd0DjytWTTl2ngiKlcvsxTdCRvrSF90NCY5U+DW+kLs9KfTVhCor
	6ZS2vyM5FlCdOsj8gkX3FbGzD0cPjzuiCuaeMhVKcTr9jRUmS4vLR/Czte5hQKtX9bz7zrvT3MbkJ
	EnPYM+LcLI/Rde4gpOyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghgo2-0005kq-UX; Thu, 10 Jan 2019 20:19:58 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghgnp-0005aV-VR
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 20:19:47 +0000
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1ghgnm-00042h-Su; Thu, 10 Jan 2019 21:19:42 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1ghgnm-000806-Jk; Thu, 10 Jan 2019 21:19:42 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>, Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 2/2] ARM: imx_v4_v5_defconfig: enable PWM driver
Date: Thu, 10 Jan 2019 21:19:34 +0100
Message-Id: <20190110201934.4105-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190110201934.4105-1-u.kleine-koenig@pengutronix.de>
References: <20190107195352.3149-5-u.kleine-koenig@pengutronix.de>
 <20190110201934.4105-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_121946_166273_917DE2A5 
X-CRM114-Status: GOOD (  10.19  )
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
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@pengutronix.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

V2hpbGUgdGhlcmUgaXMgbm8gbWFpbmxpbmUgYm9hcmQgdGhhdCBtYWtlcyB1c2Ugb2YgdGhlIFBX
TSBzdGlsbCBlbmFibGUgdGhlCmRyaXZlciBmb3IgaXQgdG8gaW5jcmVhc2UgY29tcGlsZSB0ZXN0
IGNvdmVyYWdlLgoKU2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtv
ZW5pZ0BwZW5ndXRyb25peC5kZT4KLS0tCiBhcmNoL2FybS9jb25maWdzL2lteF92NF92NV9kZWZj
b25maWcgfCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL2FyY2gvYXJtL2NvbmZpZ3MvaW14X3Y0X3Y1X2RlZmNvbmZpZyBiL2FyY2gvYXJtL2NvbmZp
Z3MvaW14X3Y0X3Y1X2RlZmNvbmZpZwppbmRleCA4NjYxZGQ5YjA2NGEuLmIzN2Y4ZTY3NWU0MCAx
MDA2NDQKLS0tIGEvYXJjaC9hcm0vY29uZmlncy9pbXhfdjRfdjVfZGVmY29uZmlnCisrKyBiL2Fy
Y2gvYXJtL2NvbmZpZ3MvaW14X3Y0X3Y1X2RlZmNvbmZpZwpAQCAtMTcwLDYgKzE3MCw5IEBAIENP
TkZJR19JTVhfU0RNQT15CiAjIENPTkZJR19JT01NVV9TVVBQT1JUIGlzIG5vdCBzZXQKIENPTkZJ
R19JSU89eQogQ09ORklHX0ZTTF9NWDI1X0FEQz15CitDT05GSUdfUFdNPXkKK0NPTkZJR19QV01f
SU1YMT15CitDT05GSUdfUFdNX0lNWDI3PXkKIENPTkZJR19FWFQ0X0ZTPXkKICMgQ09ORklHX0RO
T1RJRlkgaXMgbm90IHNldAogQ09ORklHX1ZGQVRfRlM9eQotLSAKMi4yMC4xCgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBt
YWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
