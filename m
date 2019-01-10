Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77F8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:20:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87D50208E3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h8urdI8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D50208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UYTKcPAqiH2b7K7G8+ApQ9Fjpo2RFNBq2HAHMmEDs5A=; b=h8urdI8A+LKhte
	nMuLH6Lh6dbH/34mz4o3Knt7gxPC31PJwDWure8Ui/WyKbzaXrUps8KOVEraR/9QNXXI3t4evgSDH
	TXG7dqo+idDR3g7OrqAryE74UWr6RwLKxeFUrqb57Mlq+VmgY/c6da1AUwxCGfRFNRXbBkA98qvn8
	M0N0VfXwl+DGTlo3V34EkvrIJcRaQLTSwwGGr2FNAXt72A0hJ8LvnLiBLyXQSSEdtWLlUP5sTRh11
	HW/TxznyADMAy2eACSekrKh2MBMPzX1ANn0nxCiyc3UxEZovGjFCJodD9MU9OyNKosgbXT8OBGsWj
	VYnIjkMAiukdz99ODhVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghgoQ-00072w-3J; Thu, 10 Jan 2019 20:20:22 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghgnq-0005aS-3f
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 20:19:48 +0000
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1ghgnl-00040u-FH; Thu, 10 Jan 2019 21:19:41 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1ghgnl-0007zh-5S; Thu, 10 Jan 2019 21:19:41 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>, Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 1/2] ARM: imx_v6_v7_defconfig: continue compiling the pwm
 driver
Date: Thu, 10 Jan 2019 21:19:33 +0100
Message-Id: <20190110201934.4105-2-u.kleine-koenig@pengutronix.de>
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
X-CRM114-CacheID: sfid-20190110_121946_317858_0B102579 
X-CRM114-Status: GOOD (  12.52  )
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

QWZ0ZXIgdGhlIHB3bS1pbXggZHJpdmVyIHdhcyBzcGxpdCBpbnRvIHR3byBkcml2ZXJzIGFuZCB0
aGUgS2NvbmZpZyBzeW1ib2wKY2hhbmdlZCBhY2NvcmRpbmdseSwgdXNlIHRoZSBuZXcgbmFtZSB0
byBjb250aW51ZSBiZWluZyBhYmxlIHRvIHVzZSB0aGUKUFdNIGhhcmR3YXJlLgoKU2lnbmVkLW9m
Zi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4K
LS0tCiBhcmNoL2FybS9jb25maWdzL2lteF92Nl92N19kZWZjb25maWcgfCAyICstCiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9hcmNo
L2FybS9jb25maWdzL2lteF92Nl92N19kZWZjb25maWcgYi9hcmNoL2FybS9jb25maWdzL2lteF92
Nl92N19kZWZjb25maWcKaW5kZXggNTU4NmE1MDc0YTk2Li41MGZiMDFkNzBiMTAgMTAwNjQ0Ci0t
LSBhL2FyY2gvYXJtL2NvbmZpZ3MvaW14X3Y2X3Y3X2RlZmNvbmZpZworKysgYi9hcmNoL2FybS9j
b25maWdzL2lteF92Nl92N19kZWZjb25maWcKQEAgLTM5OCw3ICszOTgsNyBAQCBDT05GSUdfTUFH
MzExMD15CiBDT05GSUdfTVBMMzExNT15CiBDT05GSUdfUFdNPXkKIENPTkZJR19QV01fRlNMX0ZU
TT15Ci1DT05GSUdfUFdNX0lNWD15CitDT05GSUdfUFdNX0lNWDI3PXkKIENPTkZJR19OVk1FTV9J
TVhfT0NPVFA9eQogQ09ORklHX05WTUVNX1ZGNjEwX09DT1RQPXkKIENPTkZJR19URUU9eQotLSAK
Mi4yMC4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbAo=
