Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD484C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:49:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACA0C20863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m0LLCR2a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA0C20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T6JdX3UGfntWIKWJj0JyJRPxalFRCcnBi29E6hu+Oz0=; b=m0LLCR2axIkfWa
	M3viwWUXOIzcXxltwezIPnNqUaOOUa2xn1bnCxVaqim5dO7UNFc1gA8ScHny2g61z0GlFEDDYtNX5
	NVsvaDtM+iSX/a2Sbs/DmZDG7eZ/8FafkYnY/7HapVhSS5Yg0qPwI/lcYURsVFI3W6d8rFAdvZbWT
	6Gwu40YXJujcEpkIQS4cJ//CTWWHF1j8vxYJim5Bi5G+KAg7dCTuby8x5/k8ed0bHAfMKDyIVOYCg
	xJl7uCk/rURNcRTUzFtXv7jE005no6+KL3OzDdYV8UaRbPJRcT9I9OAI2CX5cWRT57Ix7CaI6a8n5
	Qhmh5c2Lj1qZODXuLRTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSccC-0005Gk-IL; Fri, 30 Nov 2018 06:49:28 +0000
Received: from antares.kleine-koenig.org ([94.130.110.236])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gScar-0004Gz-1U
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 06:48:08 +0000
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
 id E09894ADA0E; Fri, 30 Nov 2018 07:47:45 +0100 (CET)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>,
	Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH v3 5/5] spi: imx: drop useless member speed_hz from driver
 data struct
Date: Fri, 30 Nov 2018 07:47:09 +0100
Message-Id: <20181130064709.6998-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181130064709.6998-1-u.kleine-koenig@pengutronix.de>
References: <20181130064709.6998-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_224805_865865_AB7A3390 
X-CRM114-Status: GOOD (  10.86  )
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

VGhlIGRyaXZlciBkYXRhJ3MgbWVtYmVyIHZhcmlhYmxlIGp1c3QgY2FjaGVzIHRoZSB0cmFuc2Zl
cidzIHNwZWVkX2h6Cm1lbWJlci4gQWxsIHVzZXJzIG9mIHRoZSBmb3JtZXIgbm93IGhhdmUgYWNj
ZXNzIGRpcmVjdGx5IHRvIHRoZSBsYXR0ZXIuClNvIGZpeCB0aGVtIHRvIHVzZSB0aGUgdW5jYWNo
ZWQgdmFsdWUgYW5kIHJlbW92ZSB0aGUgY2FjaGUuCgpTaWduZWQtb2ZmLWJ5OiBVd2UgS2xlaW5l
LUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPgotLS0KIGRyaXZlcnMvc3Bp
L3NwaS1pbXguYyB8IDEyICsrKysrLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9u
cygrKSwgNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9zcGktaW14LmMg
Yi9kcml2ZXJzL3NwaS9zcGktaW14LmMKaW5kZXggNzJjODc5MjI2YWJkLi42ZWM2NDdiYmJhNzcg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvc3BpL3NwaS1pbXguYworKysgYi9kcml2ZXJzL3NwaS9zcGkt
aW14LmMKQEAgLTg3LDcgKzg3LDYgQEAgc3RydWN0IHNwaV9pbXhfZGF0YSB7CiAJdW5zaWduZWQg
bG9uZyBzcGlfY2xrOwogCXVuc2lnbmVkIGludCBzcGlfYnVzX2NsazsKIAotCXVuc2lnbmVkIGlu
dCBzcGVlZF9oejsKIAl1bnNpZ25lZCBpbnQgYml0c19wZXJfd29yZDsKIAl1bnNpZ25lZCBpbnQg
c3BpX2RyY3RsOwogCkBAIC01NjIsNyArNTYxLDcgQEAgc3RhdGljIGludCBteDUxX2Vjc3BpX3By
ZXBhcmVfdHJhbnNmZXIoc3RydWN0IHNwaV9pbXhfZGF0YSAqc3BpX2lteCwKIAkJCQkgICAgICAg
c3RydWN0IHNwaV90cmFuc2ZlciAqdCkKIHsKIAl1MzIgY3RybCA9IHJlYWRsKHNwaV9pbXgtPmJh
c2UgKyBNWDUxX0VDU1BJX0NUUkwpOwotCXUzMiBjbGsgPSBzcGlfaW14LT5zcGVlZF9oeiwgZGVs
YXk7CisJdTMyIGNsayA9IHQtPnNwZWVkX2h6LCBkZWxheTsKIAogCS8qIENsZWFyIEJMIGZpZWxk
IGFuZCBzZXQgdGhlIHJpZ2h0IHZhbHVlICovCiAJY3RybCAmPSB+TVg1MV9FQ1NQSV9DVFJMX0JM
X01BU0s7CkBAIC01NzYsNyArNTc1LDcgQEAgc3RhdGljIGludCBteDUxX2Vjc3BpX3ByZXBhcmVf
dHJhbnNmZXIoc3RydWN0IHNwaV9pbXhfZGF0YSAqc3BpX2lteCwKIAkvKiBzZXQgY2xvY2sgc3Bl
ZWQgKi8KIAljdHJsICY9IH4oMHhmIDw8IE1YNTFfRUNTUElfQ1RSTF9QT1NURElWX09GRlNFVCB8
CiAJCSAgMHhmIDw8IE1YNTFfRUNTUElfQ1RSTF9QUkVESVZfT0ZGU0VUKTsKLQljdHJsIHw9IG14
NTFfZWNzcGlfY2xrZGl2KHNwaV9pbXgsIHNwaV9pbXgtPnNwZWVkX2h6LCAmY2xrKTsKKwljdHJs
IHw9IG14NTFfZWNzcGlfY2xrZGl2KHNwaV9pbXgsIHQtPnNwZWVkX2h6LCAmY2xrKTsKIAlzcGlf
aW14LT5zcGlfYnVzX2NsayA9IGNsazsKIAogCWlmIChzcGlfaW14LT51c2VkbWEpCkBAIC02OTQs
NyArNjkzLDcgQEAgc3RhdGljIGludCBteDMxX3ByZXBhcmVfdHJhbnNmZXIoc3RydWN0IHNwaV9p
bXhfZGF0YSAqc3BpX2lteCwKIAl1bnNpZ25lZCBpbnQgcmVnID0gTVgzMV9DU1BJQ1RSTF9FTkFC
TEUgfCBNWDMxX0NTUElDVFJMX01BU1RFUjsKIAl1bnNpZ25lZCBpbnQgY2xrOwogCi0JcmVnIHw9
IHNwaV9pbXhfY2xrZGl2XzIoc3BpX2lteC0+c3BpX2Nsaywgc3BpX2lteC0+c3BlZWRfaHosICZj
bGspIDw8CisJcmVnIHw9IHNwaV9pbXhfY2xrZGl2XzIoc3BpX2lteC0+c3BpX2NsaywgdC0+c3Bl
ZWRfaHosICZjbGspIDw8CiAJCU1YMzFfQ1NQSUNUUkxfRFJfU0hJRlQ7CiAJc3BpX2lteC0+c3Bp
X2J1c19jbGsgPSBjbGs7CiAKQEAgLTgwMCw3ICs3OTksNyBAQCBzdGF0aWMgaW50IG14MjFfcHJl
cGFyZV90cmFuc2ZlcihzdHJ1Y3Qgc3BpX2lteF9kYXRhICpzcGlfaW14LAogCXVuc2lnbmVkIGlu
dCBtYXggPSBpc19pbXgyN19jc3BpKHNwaV9pbXgpID8gMTYgOiAxODsKIAl1bnNpZ25lZCBpbnQg
Y2xrOwogCi0JcmVnIHw9IHNwaV9pbXhfY2xrZGl2XzEoc3BpX2lteC0+c3BpX2Nsaywgc3BpX2lt
eC0+c3BlZWRfaHosIG1heCwgJmNsaykKKwlyZWcgfD0gc3BpX2lteF9jbGtkaXZfMShzcGlfaW14
LT5zcGlfY2xrLCB0LT5zcGVlZF9oeiwgbWF4LCAmY2xrKQogCQk8PCBNWDIxX0NTUElDVFJMX0RS
X1NISUZUOwogCXNwaV9pbXgtPnNwaV9idXNfY2xrID0gY2xrOwogCkBAIC04NzUsNyArODc0LDcg
QEAgc3RhdGljIGludCBteDFfcHJlcGFyZV90cmFuc2ZlcihzdHJ1Y3Qgc3BpX2lteF9kYXRhICpz
cGlfaW14LAogCXVuc2lnbmVkIGludCByZWcgPSBNWDFfQ1NQSUNUUkxfRU5BQkxFIHwgTVgxX0NT
UElDVFJMX01BU1RFUjsKIAl1bnNpZ25lZCBpbnQgY2xrOwogCi0JcmVnIHw9IHNwaV9pbXhfY2xr
ZGl2XzIoc3BpX2lteC0+c3BpX2Nsaywgc3BpX2lteC0+c3BlZWRfaHosICZjbGspIDw8CisJcmVn
IHw9IHNwaV9pbXhfY2xrZGl2XzIoc3BpX2lteC0+c3BpX2NsaywgdC0+c3BlZWRfaHosICZjbGsp
IDw8CiAJCU1YMV9DU1BJQ1RSTF9EUl9TSElGVDsKIAlzcGlfaW14LT5zcGlfYnVzX2NsayA9IGNs
azsKIApAQCAtMTE5NCw3ICsxMTkzLDYgQEAgc3RhdGljIGludCBzcGlfaW14X3NldHVweGZlcihz
dHJ1Y3Qgc3BpX2RldmljZSAqc3BpLAogCQlyZXR1cm4gMDsKIAogCXNwaV9pbXgtPmJpdHNfcGVy
X3dvcmQgPSB0LT5iaXRzX3Blcl93b3JkOwotCXNwaV9pbXgtPnNwZWVkX2h6ID0gdC0+c3BlZWRf
aHo7CiAKIAkvKgogCSAqIEluaXRpYWxpemUgdGhlIGZ1bmN0aW9ucyBmb3IgdHJhbnNmZXIuIFRv
IHRyYW5zZmVyIG5vbiBieXRlLWFsaWduZWQKLS0gCjIuMTkuMgoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBs
aXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
