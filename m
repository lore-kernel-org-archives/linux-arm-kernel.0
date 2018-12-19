Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC634C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:19:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C36F21850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OBAC83ii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C36F21850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pFCodH32y1Otd8PzJPwmhH7JmOFtaQIEpRX9rb01+HE=; b=OBAC83iihJYmFj
	Vs1gZDeIzAoNMmVobhxEbH3Qu0QOlL5nyUo3gPO1+2tbPct1lTe00tjxeEUXPeum1AUdtsUnTa4AN
	OMespwCVnWRyWLHDj5nysbdQd3lFdrzB4l5o2LwSOoJ+O0b7jZKrIBuMaijkdFeXMwws6yJnSAVym
	1g7StdlT7xPJo7CuqdrSp0CoRy/T0rhH9vFnn9lSRBE78ObYrAuLUoPmwHXRY32w+LFyIiOvsmR22
	AhuwbkT3J/Gmgynstv+XHoh7YdnD+sYcpKV3BtwLBSlUPZtOf9E/4N5lGxDF0ZkyZeQ15YbEknEno
	RuSxOqp0/irLbb8huAQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZYwZ-0005jq-KS; Wed, 19 Dec 2018 10:19:11 +0000
Received: from inva020.nxp.com ([92.121.34.13])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZYwW-0005iK-5m
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 10:19:09 +0000
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C47511A01CD;
 Wed, 19 Dec 2018 11:18:54 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
 [134.27.226.22])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B7AFC1A00F4;
 Wed, 19 Dec 2018 11:18:54 +0100 (CET)
Received: from enigma.ea.freescale.net (enigma.ea.freescale.net
 [10.171.81.110])
 by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 5AFFD20466;
 Wed, 19 Dec 2018 11:18:54 +0100 (CET)
From: =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
To: Olof Johansson <olof@lixom.net>,
	Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: [PATCH] Revert "arm64: defconfig: Enable FSL_MC_BUS and FSL_MC_DPIO"
Date: Wed, 19 Dec 2018 12:18:44 +0200
Message-Id: <20181219101844.6362-1-horia.geanta@nxp.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <2071995319.127120.1545163830046@email.ionos.de>
References: <2071995319.127120.1545163830046@email.ionos.de>
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_021908_354344_0FBD254E 
X-CRM114-Status: UNSURE (   7.99  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, sfr@canb.auug.org.au,
 linux-kernel@vger.kernel.org, arm@kernel.org, linux-next@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhpcyByZXZlcnRzIGNvbW1pdCBkOTY3OGFkYmU3MzNhNzcwNDI4YTk4NjUxYmVhYTI4MTdkNTAz
ZWQzLgoKUmVjZWl2ZWQgYmVsb3cgcmVwb3J0IGZyb20gU3RlZmFuLgpSZXZlcnQgdGhlIGNvbW1p
dCB1bnRpbCBDQUFNIGRyaXZlciBkZXBlbmRlbmN5IGN5Y2xlcyBhcmUgZml4ZWQuCgp0aGlzIHBh
dGNoIGluIG5leHQtMjAxODEyMTQgYnJlYWtzICJtYWtlIG1vZHVsZXNfaW5zdGFsbCIgZm9yCmFy
bTY0L2RlZmNvbmZpZyBvbiBteSBVYnVudHUgbWFjaGluZToKCkRFUE1PRCAgNC4yMC4wLXJjNi1u
ZXh0LTIwMTgxMjE0CmRlcG1vZDogRVJST1I6IEZvdW5kIDYgbW9kdWxlcyBpbiBkZXBlbmRlbmN5
IGN5Y2xlcyEKZGVwbW9kOiBFUlJPUjogQ3ljbGUgZGV0ZWN0ZWQ6IGNhYW1hbGdfZGVzYyAtPiBk
cGFhMl9jYWFtIC0+IGF1dGhlbmMKZGVwbW9kOiBFUlJPUjogQ3ljbGUgZGV0ZWN0ZWQ6IGNhYW1h
bGdfZGVzYyAtPiBkcGFhMl9jYWFtIC0+IGZzbF9tY19kcGlvCmRlcG1vZDogRVJST1I6IEN5Y2xl
IGRldGVjdGVkOiBkcGFhMl9jYWFtIC0+IGNhYW1oYXNoX2Rlc2MgLT4gZHBhYTJfY2FhbQpkZXBt
b2Q6IEVSUk9SOiBDeWNsZSBkZXRlY3RlZDogY2FhbWFsZ19kZXNjIC0+IGRwYWEyX2NhYW0gLT4g
Y2FhbWhhc2hfZGVzYyAtPiBlcnJvcgpkZXBtb2Q6IEVSUk9SOiBDeWNsZSBkZXRlY3RlZDogY2Fh
bWFsZ19kZXNjIC0+IGRwYWEyX2NhYW0gLT4gY2FhbWhhc2hfZGVzYyAtPiBjYWFtYWxnX2Rlc2MK
ClJlcG9ydGVkLWJ5OiBTdGVmYW4gV2FocmVuIDxzdGVmYW4ud2FocmVuQGkyc2UuY29tPgpTaWdu
ZWQtb2ZmLWJ5OiBIb3JpYSBHZWFudMSDIDxob3JpYS5nZWFudGFAbnhwLmNvbT4KLS0tCiBhcmNo
L2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnIHwgMyAtLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcgYi9hcmNo
L2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnCmluZGV4IDk4OWY1MWJiMWJkNC4uZDA3MjRkNGUwNTQ2
IDEwMDY0NAotLS0gYS9hcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnCisrKyBiL2FyY2gvYXJt
NjQvY29uZmlncy9kZWZjb25maWcKQEAgLTIwMCw3ICsyMDAsNiBAQCBDT05GSUdfRE1BX0NNQT15
CiBDT05GSUdfQ01BX1NJWkVfTUJZVEVTPTMyCiBDT05GSUdfSElTSUxJQ09OX0xQQz15CiBDT05G
SUdfU0lNUExFX1BNX0JVUz15Ci1DT05GSUdfRlNMX01DX0JVUz15CiBDT05GSUdfTVREPXkKIENP
TkZJR19NVERfQkxPQ0s9eQogQ09ORklHX01URF9NMjVQODA9eQpAQCAtNjQ0LDcgKzY0Myw2IEBA
IENPTkZJR19SUE1TR19RQ09NX0dMSU5LX1JQTT15CiBDT05GSUdfUlBNU0dfUUNPTV9HTElOS19T
TUVNPW0KIENPTkZJR19SUE1TR19RQ09NX1NNRD15CiBDT05GSUdfUkFTUEJFUlJZUElfUE9XRVI9
eQotQ09ORklHX0ZTTF9NQ19EUElPPW0KIENPTkZJR19RQ09NX0NPTU1BTkRfREI9eQogQ09ORklH
X1FDT01fR0VOSV9TRT15CiBDT05GSUdfUUNPTV9HTElOS19TU1I9bQpAQCAtNzM3LDcgKzczNSw2
IEBAIENPTkZJR19OTFNfSVNPODg1OV8xPXkKIENPTkZJR19TRUNVUklUWT15CiBDT05GSUdfQ1JZ
UFRPX0VDSEFJTklWPXkKIENPTkZJR19DUllQVE9fQU5TSV9DUFJORz15Ci1DT05GSUdfQ1JZUFRP
X0RFVl9GU0xfRFBBQTJfQ0FBTT1tCiBDT05GSUdfUFJJTlRLX1RJTUU9eQogQ09ORklHX0RFQlVH
X0lORk89eQogQ09ORklHX0RFQlVHX0ZTPXkKLS0gCjIuMTYuMgoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBs
aXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
