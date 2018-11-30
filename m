Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E296C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:48:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 096002146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DE700L+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 096002146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GU65x9p3OMoIyJzGphu23uY08TBqyqtZwH4GF+y2ox4=; b=DE700L+OSqy2Zz
	S8w7wCapWr165Ts6Eca+bbezkD1bwPvVHt+lldgHSvfsOioOMvqsr+NIiK1IJuzDISRij8l67Dk/a
	wnuPJn3xT0NViDmgciRg6otU+f/QipamVI7PHOZ1L8m7CnXIvZK/tpLAgzayI9hG8xVD198I1qOMV
	17hxlofKPjVKcnbme7b8Y8AOSUG9ViN5lKbfXXINc/B6wumq3tEdoSWAdcLTYhHfOCst85Nxeu0yq
	77R0Bf5+McopAg9v9WYP2THxfi9PN7nJPA7mvIMu5JEM+wW21NHv6kCQEjwl9UtRPslxUMTVwIiY3
	+7Clea0NsMdG15kAio4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gScb1-0004VJ-L1; Fri, 30 Nov 2018 06:48:15 +0000
Received: from antares.kleine-koenig.org ([94.130.110.236])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gScad-00045W-Nr
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 06:47:53 +0000
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
 id 32CEA4ADA0A; Fri, 30 Nov 2018 07:47:43 +0100 (CET)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>,
	Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH v3 3/5] spi: imx: style fixes
Date: Fri, 30 Nov 2018 07:47:07 +0100
Message-Id: <20181130064709.6998-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181130064709.6998-1-u.kleine-koenig@pengutronix.de>
References: <20181130064709.6998-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_224751_949952_A40311BA 
X-CRM114-Status: GOOD (  10.97  )
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
Cc: Marek Vasut <marex@denx.de>, linux-arm-kernel@lists.infradead.org,
 NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de,
 linux-spi@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhpcyBjaGFuZ2UgZml4ZXMgc29tZSByYW5kb20gc3R5bGUgaXNzdWVzIHRoYXQgSSBub3RpY2Vk
IHdoaWxlIGRlYnVnZ2luZwp0aGUgZHJpdmVyOiBSZW1vdmUgc29tZSBkb3VibGUgc3BhY2VzLCB1
c2UgdGFicyBmb3IgaW5kZW50aW9uIGluc3RlYWQKb2Ygc3BhY2VzIGlmIHBvc3NpYmxlLCBmaXgg
Y29tbWVudCBzdHlsZS4KClNpZ25lZC1vZmYtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWlu
ZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+Ci0tLQogZHJpdmVycy9zcGkvc3BpLWlteC5jIHwgMTYg
KysrKysrKysrLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNyBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9zcGktaW14LmMgYi9kcml2ZXJzL3Nw
aS9zcGktaW14LmMKaW5kZXggZDNhMWU3MTA0NTU2Li5kOTU0YjZkOTU4YzIgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvc3BpL3NwaS1pbXguYworKysgYi9kcml2ZXJzL3NwaS9zcGktaW14LmMKQEAgLTM5
LDggKzM5LDggQEAKICNkZWZpbmUgTVhDX0lOVF9URQkoMSA8PCAxKSAvKiBUcmFuc21pdCBGSUZP
IGVtcHR5IGludGVycnVwdCAqLwogI2RlZmluZSBNWENfSU5UX1JEUglCSVQoNCkgLyogUmVjZWl2
ZSBkYXRlIHRocmVzaG9sZCBpbnRlcnJ1cHQgKi8KIAotLyogVGhlIG1heGltdW0gIGJ5dGVzIHRo
YXQgYSBzZG1hIEJEIGNhbiB0cmFuc2Zlci4qLwotI2RlZmluZSBNQVhfU0RNQV9CRF9CWVRFUyAg
KDEgPDwgMTUpCisvKiBUaGUgbWF4aW11bSBieXRlcyB0aGF0IGEgc2RtYSBCRCBjYW4gdHJhbnNm
ZXIuICovCisjZGVmaW5lIE1BWF9TRE1BX0JEX0JZVEVTICgxIDw8IDE1KQogI2RlZmluZSBNWDUx
X0VDU1BJX0NUUkxfTUFYX0JVUlNUCTUxMgogLyogVGhlIG1heGltdW0gYnl0ZXMgdGhhdCBJTVg1
M19FQ1NQSSBjYW4gdHJhbnNmZXIgaW4gc2xhdmUgbW9kZS4qLwogI2RlZmluZSBNWDUzX01BWF9U
UkFOU0ZFUl9CWVRFUwkJNTEyCkBAIC0yNTcsNyArMjU3LDcgQEAgc3RhdGljIGJvb2wgc3BpX2lt
eF9jYW5fZG1hKHN0cnVjdCBzcGlfbWFzdGVyICptYXN0ZXIsIHN0cnVjdCBzcGlfZGV2aWNlICpz
cGksCiAjZGVmaW5lIE1YNTFfRUNTUElfSU5UX1JSRU4JCSgxIDw8ICAzKQogI2RlZmluZSBNWDUx
X0VDU1BJX0lOVF9SRFJFTgkJKDEgPDwgIDQpCiAKLSNkZWZpbmUgTVg1MV9FQ1NQSV9ETUEgICAg
ICAweDE0CisjZGVmaW5lIE1YNTFfRUNTUElfRE1BCQkweDE0CiAjZGVmaW5lIE1YNTFfRUNTUElf
RE1BX1RYX1dNTCh3bWwpCSgod21sKSAmIDB4M2YpCiAjZGVmaW5lIE1YNTFfRUNTUElfRE1BX1JY
X1dNTCh3bWwpCSgoKHdtbCkgJiAweDNmKSA8PCAxNikKICNkZWZpbmUgTVg1MV9FQ1NQSV9ETUFf
UlhUX1dNTCh3bWwpCSgoKHdtbCkgJiAweDNmKSA8PCAyNCkKQEAgLTcyNiw4ICs3MjYsMTAgQEAg
c3RhdGljIGludCBteDMxX2NvbmZpZyhzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQogCXdyaXRlbChy
ZWcsIHNwaV9pbXgtPmJhc2UgKyBNWDMxX0NTUElfVEVTVFJFRyk7CiAKIAlpZiAoc3BpX2lteC0+
dXNlZG1hKSB7Ci0JCS8qIGNvbmZpZ3VyZSBETUEgcmVxdWVzdHMgd2hlbiBSWEZJRk8gaXMgaGFs
ZiBmdWxsIGFuZAotCQkgICB3aGVuIFRYRklGTyBpcyBoYWxmIGVtcHR5ICovCisJCS8qCisJCSAq
IGNvbmZpZ3VyZSBETUEgcmVxdWVzdHMgd2hlbiBSWEZJRk8gaXMgaGFsZiBmdWxsIGFuZAorCQkg
KiB3aGVuIFRYRklGTyBpcyBoYWxmIGVtcHR5CisJCSAqLwogCQl3cml0ZWwoTVgzMV9ETUFSRUdf
UkhfREVOIHwgTVgzMV9ETUFSRUdfVEhfREVOLAogCQkJc3BpX2lteC0+YmFzZSArIE1YMzFfQ1NQ
SV9ETUFSRUcpOwogCX0KQEAgLTEwOTMsNyArMTA5NSw3IEBAIHN0YXRpYyB2b2lkIHNwaV9pbXhf
cHVzaChzdHJ1Y3Qgc3BpX2lteF9kYXRhICpzcGlfaW14KQogCQlpZiAoIXNwaV9pbXgtPmNvdW50
KQogCQkJYnJlYWs7CiAJCWlmIChzcGlfaW14LT5keW5hbWljX2J1cnN0ICYmCi0JCSAgICBzcGlf
aW14LT50eGZpZm8gPj0gIERJVl9ST1VORF9VUChzcGlfaW14LT5yZW1haW5kZXIsCisJCSAgICBz
cGlfaW14LT50eGZpZm8gPj0gRElWX1JPVU5EX1VQKHNwaV9pbXgtPnJlbWFpbmRlciwKIAkJCQkJ
CSAgICAgZmlmb193b3JkcykpCiAJCQlicmVhazsKIAkJc3BpX2lteC0+dHgoc3BpX2lteCk7CkBA
IC0xMTg3LDcgKzExODksNyBAQCBzdGF0aWMgaW50IHNwaV9pbXhfc2V0dXB4ZmVyKHN0cnVjdCBz
cGlfZGV2aWNlICpzcGksCiAJCXJldHVybiAwOwogCiAJc3BpX2lteC0+Yml0c19wZXJfd29yZCA9
IHQtPmJpdHNfcGVyX3dvcmQ7Ci0Jc3BpX2lteC0+c3BlZWRfaHogID0gdC0+c3BlZWRfaHo7CisJ
c3BpX2lteC0+c3BlZWRfaHogPSB0LT5zcGVlZF9oejsKIAogCS8qCiAJICogSW5pdGlhbGl6ZSB0
aGUgZnVuY3Rpb25zIGZvciB0cmFuc2Zlci4gVG8gdHJhbnNmZXIgbm9uIGJ5dGUtYWxpZ25lZAot
LSAKMi4xOS4yCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtYXJtLWtlcm5lbAo=
