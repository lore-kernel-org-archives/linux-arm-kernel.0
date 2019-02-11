Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC245C282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:13:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB0B120661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f7/KgYTl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB0B120661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=R3xuCCBuYhKtklW+pz056O9IM405SiA5GQMGiOQJyb0=; b=f7/KgYTl34nB/7
	+wL3RwLU3ro8k5mnA4FIeF6TwoCXMrFSJgwEQKFdBLLpqsBsKaDnFN7UrPJwnq3PMzxETNFUbwg9v
	g2P+By0oRiuh7FpBDu4rbNstrYK3CinpxzFNXYj9y3iKEc4E3/XxiU1gVHJecOfNREdFsYEoV20ll
	oZMSCDWDCjsxwnjHZtodTw9M+mp/Hon/BW3XTyhLQtNxmNxXXfuMvqhNyVU7DnAKd8fbnX+FjntD/
	FsLTZy85CcTfRf7M4P9BEsxszvMnpRFBndz8iF1IMu/Zo3HRq44Nyl4tbLrYcl1bd9oO6Ze+u+cxf
	fpCktGHj9ywhwiN8se5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtCLB-0002UH-5s; Mon, 11 Feb 2019 14:13:45 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtCL7-0002Sp-Ku
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 14:13:43 +0000
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gtCL2-0004eO-S9; Mon, 11 Feb 2019 15:13:36 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92-RC5)
 (envelope-from <ukl@pengutronix.de>)
 id 1gtCL2-0008B0-7g; Mon, 11 Feb 2019 15:13:36 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 11/15] ARM: dts: imx6q-dmo-edmqmx6: Use explicit swpad values
Date: Mon, 11 Feb 2019 15:13:29 +0100
Message-Id: <20190211141333.28725-11-u.kleine-koenig@pengutronix.de>
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
X-CRM114-CacheID: sfid-20190211_061341_843044_B727F8C2 
X-CRM114-Status: GOOD (  10.87  )
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
bmlnQHBlbmd1dHJvbml4LmRlPgotLS0KIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZxLWRtby1lZG1x
bXg2LmR0cyB8IDE4ICsrKysrKysrKy0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0
aW9ucygrKSwgOSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9p
bXg2cS1kbW8tZWRtcW14Ni5kdHMgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2cS1kbW8tZWRtcW14
Ni5kdHMKaW5kZXggZWU4YzM4ZWVlMDNiLi5jYTY4NmQ3Yzc0MDUgMTAwNjQ0Ci0tLSBhL2FyY2gv
YXJtL2Jvb3QvZHRzL2lteDZxLWRtby1lZG1xbXg2LmR0cworKysgYi9hcmNoL2FybS9ib290L2R0
cy9pbXg2cS1kbW8tZWRtcW14Ni5kdHMKQEAgLTMwMSw4ICszMDEsOCBAQAogCWlteDZxLWRtby1l
ZG1xbXg2IHsKIAkJcGluY3RybF9ob2c6IGhvZ2dycCB7CiAJCQlmc2wscGlucyA9IDwKLQkJCQlN
WDZRRExfUEFEX0VJTV9BMTZfX0dQSU8yX0lPMjIgMHg4MDAwMDAwMAotCQkJCU1YNlFETF9QQURf
RUlNX0ExN19fR1BJTzJfSU8yMSAweDgwMDAwMDAwCisJCQkJTVg2UURMX1BBRF9FSU1fQTE2X19H
UElPMl9JTzIyCQkweDBiMGIxCisJCQkJTVg2UURMX1BBRF9FSU1fQTE3X19HUElPMl9JTzIxCQkw
eDBiMGIxCiAJCQk+OwogCQl9OwogCkBAIC0zMTUsMTAgKzMxNSwxMCBAQAogCiAJCXBpbmN0cmxf
ZWNzcGk1OiBlY3NwaTVycC0xIHsKIAkJCWZzbCxwaW5zID0gPAotCQkJCU1YNlFETF9QQURfU0Qx
X0RBVDBfX0VDU1BJNV9NSVNPCTB4ODAwMDAwMDAKLQkJCQlNWDZRRExfUEFEX1NEMV9DTURfX0VD
U1BJNV9NT1NJCQkweDgwMDAwMDAwCi0JCQkJTVg2UURMX1BBRF9TRDFfQ0xLX19FQ1NQSTVfU0NM
SwkJMHg4MDAwMDAwMAotCQkJCU1YNlFETF9QQURfU0QyX0RBVDNfX0dQSU8xX0lPMTIJCTB4ODAw
MDAwMDAKKwkJCQlNWDZRRExfUEFEX1NEMV9EQVQwX19FQ1NQSTVfTUlTTwkweDFiMGIwCisJCQkJ
TVg2UURMX1BBRF9TRDFfQ01EX19FQ1NQSTVfTU9TSQkJMHgxYjBiMAorCQkJCU1YNlFETF9QQURf
U0QxX0NMS19fRUNTUEk1X1NDTEsJCTB4MWIwYjAKKwkJCQlNWDZRRExfUEFEX1NEMl9EQVQzX19H
UElPMV9JTzEyCQkweDFiMGIwCiAJCQk+OwogCQl9OwogCkBAIC0zNzMsMTYgKzM3MywxNiBAQAog
CiAJCXBpbmN0cmxfcGZ1emU6IHBmdXplMTAwZ3JwMSB7CiAJCQlmc2wscGlucyA9IDwKLQkJCQlN
WDZRRExfUEFEX0VJTV9EMjBfX0dQSU8zX0lPMjAJCTB4ODAwMDAwMDAKKwkJCQlNWDZRRExfUEFE
X0VJTV9EMjBfX0dQSU8zX0lPMjAJCTB4MWIwYjAKIAkJCT47CiAJCX07CiAKIAkJcGluY3RybF9z
dG1wZTE6IHN0bXBlMWdycCB7Ci0JCQlmc2wscGlucyA9IDxNWDZRRExfUEFEX0VJTV9EMzBfX0dQ
SU8zX0lPMzAgMHg4MDAwMDAwMD47CisJCQlmc2wscGlucyA9IDxNWDZRRExfUEFEX0VJTV9EMzBf
X0dQSU8zX0lPMzAgCTB4MWIwYjA+OwogCQl9OwogCiAJCXBpbmN0cmxfc3RtcGUyOiBzdG1wZTJn
cnAgewotCQkJZnNsLHBpbnMgPSA8TVg2UURMX1BBRF9FSU1fQTI1X19HUElPNV9JTzAyIDB4ODAw
MDAwMDA+OworCQkJZnNsLHBpbnMgPSA8TVg2UURMX1BBRF9FSU1fQTI1X19HUElPNV9JTzAyCTB4
MGIwYjE+OwogCQl9OwogCiAJCXBpbmN0cmxfdWFydDE6IHVhcnQxZ3JwIHsKLS0gCjIuMjAuMQoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFy
bS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1r
ZXJuZWwK
