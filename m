Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD408C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:08:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACEF220844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eYBRqMQ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACEF220844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KsYof5cl5pdgcOPh6hKO6yYmH9Csvn5iak3FOKS6+Eo=; b=eYBRqMQ1SO+HRt
	QqHyqsg6HD/zN/N4WkSv7oECJtsEvCkUaDocv8dc7Kd3eNi58icOJapOqnyTd4k+cuPx3g8U2J8iL
	CEujdfMhq4FphorqHMmtbYfpAuL1fXM1eokuWLfNX2VODdA+YQI/wOdeDoBDOoL7rHNW4KdDdwTzi
	Q61Br3i+03B/yvShGIvrTaE9D9wOw/KbZfu06gd6jgEQYhbcsV0RfKZzePehSVGkVJYBj1wqM6caJ
	7/t0x8cOoFEDLvw7sy+AnkPjXmOejHkUBQsqqhBbb5KC7ljYslQMdIgFvr1Xi3fRYkm8x2U7xf5Es
	GJCZMF9qSSv15Gv+U0vw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt9RZ-0004t2-50; Mon, 11 Feb 2019 11:08:09 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt9RQ-0004jc-Mw
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 11:08:04 +0000
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gt9RE-0007xR-DZ; Mon, 11 Feb 2019 12:07:48 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92-RC5)
 (envelope-from <ukl@pengutronix.de>)
 id 1gt9RD-00016p-QO; Mon, 11 Feb 2019 12:07:47 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v3 3/3] ARM: imx_v6_v7_defconfig: Enable SIOX bus
Date: Mon, 11 Feb 2019 12:07:44 +0100
Message-Id: <20190211110744.3621-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211110744.3621-1-u.kleine-koenig@pengutronix.de>
References: <20190211110744.3621-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_030801_424107_616BCA39 
X-CRM114-Status: GOOD (  10.38  )
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
b25peC5kZT4KLS0tClRoaXMgcGF0Y2ggd2FzIHBhcnQgb2YgdjEgYW5kIGFwcGxpZWQgYnkgU2hh
d24uIEl0IHdhcyBkcm9wcGVkIGxhdGVyCmJlY2F1c2UgdGhlIGNvbW1pdCBsb2cgd2FzIHdyb25n
IGR1ZSB0byBub3QgcGlja2luZyB0aGUgY2k0eDEwIGR0cy4gU28KaXQncyBwYXJ0IG9mIHYzIGFn
YWluLgoKIGFyY2gvYXJtL2NvbmZpZ3MvaW14X3Y2X3Y3X2RlZmNvbmZpZyB8IDMgKysrCiAxIGZp
bGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vY29uZmln
cy9pbXhfdjZfdjdfZGVmY29uZmlnIGIvYXJjaC9hcm0vY29uZmlncy9pbXhfdjZfdjdfZGVmY29u
ZmlnCmluZGV4IDU1ODZhNTA3NGE5Ni4uMDU2ODBhZGMzNTVlIDEwMDY0NAotLS0gYS9hcmNoL2Fy
bS9jb25maWdzL2lteF92Nl92N19kZWZjb25maWcKKysrIGIvYXJjaC9hcm0vY29uZmlncy9pbXhf
djZfdjdfZGVmY29uZmlnCkBAIC0yMTEsNiArMjExLDcgQEAgQ09ORklHX1NQSV9HUElPPXkKIENP
TkZJR19TUElfSU1YPXkKIENPTkZJR19TUElfRlNMX0RTUEk9eQogQ09ORklHX0dQSU9fU1lTRlM9
eQorQ09ORklHX0dQSU9fU0lPWD1tCiBDT05GSUdfR1BJT19NQVg3MzJYPXkKIENPTkZJR19HUElP
X01DOVMwOERaNjA9eQogQ09ORklHX0dQSU9fUENBOTUzWD15CkBAIC00MDQsNiArNDA1LDggQEAg
Q09ORklHX05WTUVNX1ZGNjEwX09DT1RQPXkKIENPTkZJR19URUU9eQogQ09ORklHX09QVEVFPXkK
IENPTkZJR19NVVhfTU1JTz15CitDT05GSUdfU0lPWD1tCitDT05GSUdfU0lPWF9CVVNfR1BJTz1t
CiBDT05GSUdfRVhUMl9GUz15CiBDT05GSUdfRVhUMl9GU19YQVRUUj15CiBDT05GSUdfRVhUMl9G
U19QT1NJWF9BQ0w9eQotLSAKMi4yMC4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
