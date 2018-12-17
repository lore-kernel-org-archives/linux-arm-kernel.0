Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE899C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:37:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93F6120675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AXTfrFpW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="kAHuyEoe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F6120675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nic.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Gi1X4Cr9Ceq53V6ApA6pMevsg03wfD98BfLctZ8BIt4=; b=AXTfrFpW9IRDzb
	F+5C6HjFbgDFHPjbPGI49td4FfLRaJmiOdqb0phc6StI/2pNQe9vHZ2/iOefU/9qO3x1O9+jKWefs
	TXJ1p0e2NmeqHfWcbR4nDlFAHRyOZG79tsTv/iZUVitMP5RExrMYgyigdgvEQ24iGT76bUGhSza8x
	G4J4O8VQDViXU64oQKvtZv59yjA21kmOsT39fDicO/MGcw8RJLDynazoMvMGqMAZQaWApl8T4B8An
	CXfmnVtW54RbLhc4BqAeyUqHKr6xCPYAkvPiDmQ5BSixKqdaDmbDN0EgCHHgCwbzPKMC036eGXmYE
	d8hb7W6858SxV7NUlv0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYuxf-0006jO-Qj; Mon, 17 Dec 2018 15:37:39 +0000
Received: from mail.nic.cz ([2001:1488:800:400::400])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYuxS-0006Yt-Ux
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 15:37:28 +0000
Received: from dellmb.labs.office.nic.cz (unknown
 [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
 by mail.nic.cz (Postfix) with ESMTP id 49D4662441;
 Mon, 17 Dec 2018 16:37:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
 t=1545061031; bh=hc48vW+mxpr+k+AbY5U1UYIuztcvntIdAD0DSzDFjjE=;
 h=From:To:Date;
 b=kAHuyEoeNjmVvr6dGkJfAfNPgssk/KMQTjWPim8Rvk5wJKOis8DZVTM5bgqUn/EYF
 hZJlGAAlFEdWOT1Kvl5XHp14K8gAMrvyvQXOa72JuzEEWMkvn/w/Yh0/oQUT8ESrhU
 kLXw4D6Kk8X/vI3J4PntmZ3pk8sBjkL/0pBE5DwI=
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To: Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH v1 2/3] dt-bindings: mailbox: Document
 armada-37xx-rwtm-mailbox binding
Date: Mon, 17 Dec 2018 16:37:05 +0100
Message-Id: <20181217153706.25873-2-marek.behun@nic.cz>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181217153706.25873-1-marek.behun@nic.cz>
References: <20181217153706.25873-1-marek.behun@nic.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_073727_188864_5AEA75FA 
X-CRM114-Status: GOOD (  10.20  )
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
Cc: devicetree@vger.kernel.org, Gregory CLEMENT <gregory.clement@bootlin.com>,
 linux-kernel@vger.kernel.org,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhpcyBhZGRzIGRldmljZSB0cmVlIGJpbmRpbmcgZG9jdW1lbnRhdGlvbiBmb3IgdGhlIHJXVE0g
QklVIG1haWxib3gKZHJpdmVyIG9uIHRoZSBBcm1hZGEgMzd4eCBTT0MgKEVzcHJlc3NvQmluLCBU
dXJyaXMgTW94KS4KClNpZ25lZC1vZmYtYnk6IE1hcmVrIEJlaMO6biA8bWFyZWsuYmVodW5Abmlj
LmN6PgpDYzogUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz4KQ2M6IGRldmljZXRyZWVA
dmdlci5rZXJuZWwub3JnCi0tLQogLi4uL21haWxib3gvYXJtYWRhLTM3eHgtcnd0bS1tYWlsYm94
LnR4dCAgICAgICAgIHwgMTYgKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDE2IGlu
c2VydGlvbnMoKykKIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvbWFpbGJveC9hcm1hZGEtMzd4eC1yd3RtLW1haWxib3gudHh0CgpkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21haWxib3gvYXJtYWRhLTM3eHgt
cnd0bS1tYWlsYm94LnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWls
Ym94L2FybWFkYS0zN3h4LXJ3dG0tbWFpbGJveC50eHQKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5k
ZXggMDAwMDAwMDAwMDAwLi4yZDE4MmQ2MWViM2YKLS0tIC9kZXYvbnVsbAorKysgYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWFpbGJveC9hcm1hZGEtMzd4eC1yd3RtLW1haWxi
b3gudHh0CkBAIC0wLDAgKzEsMTYgQEAKKyogcldUTSBCSVUgTWFpbGJveCBkcml2ZXIgZm9yIEFy
bWFkYSAzN3h4CisKK1JlcXVpcmVkIHByb3BlcnRpZXM6CistIGNvbXBhdGlibGUgOgltdXN0IGJl
ICJtYXJ2ZWxsLGFybWFkYS0zN3h4LXJ3dG0tbWFpbGJveCIKKy0gcmVnIDogCXBoeXNpY2FsIGJh
c2UgYWRkcmVzcyBvZiB0aGUgbWFpbGJveCBhbmQgbGVuZ3RoIG9mIG1lbW9yeSBtYXBwZWQKKwkJ
cmVnaW9uCistIGludGVycnVwdHM6CXRoZSBJUlEgbGluZSBmb3IgdGhlIG1haWxib3gKKy0gI21i
b3gtY2VsbHM6CW11c3QgYmUgMQorCitFeGFtcGxlOgorCXJ3dG06IG1haWxib3hAYjAwMDAgewor
CQljb21wYXRpYmxlID0gIm1hcnZlbGwsYXJtYWRhLTM3eHgtcnd0bS1tYWlsYm94IjsKKwkJcmVn
ID0gPDB4YjAwMDAgMHgxMDA+OworCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTggSVJRX1RZUEVf
TEVWRUxfSElHSD47CisJCSNtYm94LWNlbGxzID0gPDE+OworCX07Ci0tIAoyLjE4LjEKCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2Vy
bmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVs
Cg==
