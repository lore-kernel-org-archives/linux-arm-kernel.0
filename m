Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FF6C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:15:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3C5A2184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p8AQVU9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3C5A2184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gCRSL7yBfOi6ZA00Gkc1jNoajc9n3iwiAbGUTA/0kZc=; b=p8AQVU9YSRd3Wr
	bUBnVpgSBK7aAdiY6ZdQVnLF/IbA+jy9MPxd5iLVQqxU2olg3z7mgBmrJlC5pB7xzwvluHNRQl1gm
	sLTMpLV1FxzThWiUWvISZmVA7lePE+YxAdHgMo99ZEKjUyBZM11xBVrFXKWWFjGaEw97BfikkbMdX
	sBP58urVAs7ThSFI5YCt2Du1EGtYTAYOxWLt5CttCKz4ukVQQOZxP+6C4ZQ58tUyC1C62UX3bKtl3
	vJpc7up/SlAUlikhzMzGphHn7n2wQcWs2wzC7vECyKn+6xcikIcY7HDMjyQPfE8r+b+gpkNLyHHU6
	bND9qnnUsGvS4zIrcd1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmyW1-0001SG-HQ; Fri, 25 Jan 2019 10:15:13 +0000
Received: from honk.sigxcpu.org ([24.134.29.49])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmyVi-0000XN-5F
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 10:14:56 +0000
Received: from localhost (localhost [127.0.0.1])
 by honk.sigxcpu.org (Postfix) with ESMTP id 734ADFB02;
 Fri, 25 Jan 2019 11:14:49 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
 by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 47-_qdMyG1x2; Fri, 25 Jan 2019 11:14:47 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
 id E750948FC2; Fri, 25 Jan 2019 11:14:46 +0100 (CET)
From: =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, Robert Chiras <robert.chiras@nxp.com>
Subject: [PATCH 1/2] dt-bindings: phy: Add documentation for mixel dphy
Date: Fri, 25 Jan 2019 11:14:45 +0100
Message-Id: <e2449d7bac3d9e01cd6a51eb85460dce729bf77e.1548410989.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1548410989.git.agx@sigxcpu.org>
References: <cover.1548410989.git.agx@sigxcpu.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_021454_358523_92F6AFA3 
X-CRM114-Status: GOOD (  10.53  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

U2lnbmVkLW9mZi1ieTogR3VpZG8gR8O8bnRoZXIgPGFneEBzaWd4Y3B1Lm9yZz4KLS0tCiAuLi4v
YmluZGluZ3MvcGh5L21peGVsLG1pcGktZHNpLXBoeS50eHQgICAgICAgfCAyOSArKysrKysrKysr
KysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUg
MTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvbWl4ZWwsbWlwaS1k
c2ktcGh5LnR4dAoKZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9waHkvbWl4ZWwsbWlwaS1kc2ktcGh5LnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9waHkvbWl4ZWwsbWlwaS1kc2ktcGh5LnR4dApuZXcgZmlsZSBtb2RlIDEwMDY0NApp
bmRleCAwMDAwMDAwMDAwMDAuLjEwMzIzYWU4ZWUzNwotLS0gL2Rldi9udWxsCisrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvbWl4ZWwsbWlwaS1kc2ktcGh5LnR4dApA
QCAtMCwwICsxLDI5IEBACitNaXhlbCBEU0kgUEhZIGZvciBpLk1YOAorCitUaGUgTWl4ZWwgTUlQ
SS1EU0kgUEhZIElQIGJsb2NrIGlzIGUuZy4gZm91bmQgb24gTVg4IHBsYXRmb3JtcyAoYWxvbmcK
K3RoZSBNSVBJLURTSSBJUCBmcm9tIE5vcnRod2VzdCBMb2dpYykuIEl0IHJlcHJlc2VudHMgdGhl
IHBoeXNpY2FsCitsYXllciBmb3IgdGhlIGVsZWN0cmljYWwgc2lnbmFscyBmb3IgRFNJLgorCitS
ZXF1aXJlZCBwcm9wZXJ0aWVzOgorLSBjb21wYXRpYmxlOiBNdXN0IGJlOgorICAtICJtaXhlbCxp
bXg4bXEtbWlwaS1kcGh5IgorLSBjbG9ja3M6IE11c3QgY29udGFpbiBhbiBlbnRyeSBmb3IgZWFj
aCBlbnRyeSBpbiBjbG9jay1uYW1lcy4KKy0gY2xvY2stbmFtZXM6IE11c3QgY29udGFpbiB0aGUg
Zm9sbG93aW5nIGVudHJpZXM6CisgIC0gInBoeV9yZWYiOiBwaGFuZGxlIGFuZCBzcGVjaWZpZXIg
cmVmZXJyaW5nIHRvIHRoZSBEUEhZIHJlZiBjbG9jaworLSByZWc6IHRoZSByZWdpc3RlciByYW5n
ZSBvZiB0aGUgUEhZIGNvbnRyb2xsZXIKKy0gI3BoeS1jZWxsczogbnVtYmVyIG9mIGNlbGxzIGlu
IFBIWSwgYXMgZGVmaW5lZCBpbgorICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cGh5L3BoeS1iaW5kaW5ncy50eHQKKyAgdGhpcyBtdXN0IGJlIDwwPgorCitPcHRpb25hbCBwcm9w
ZXJ0aWVzOgorLSBwb3dlci1kb21haW5zOiBwaGFuZGxlIHRvIHBvd2VyIGRvbWFpbgorCitFeGFt
cGxlOgorCW1pcGlfZHBoeTogbWlwaV9kcGh5QDMwQTAwMzAgeworCQljb21wYXRpYmxlID0gIm1p
eGVsLGlteDhtcS1taXBpLWRwaHkiOworCQljbG9ja3MgPSA8JmNsayBJTVg4TVFfQ0xLX0RTSV9Q
SFlfUkVGPjsKKwkJY2xvY2stbmFtZXMgPSAicGh5X3JlZiI7CisJCXJlZyA9IDwweDMwQTAwMzAw
IDB4MTAwPjsKKwkJcG93ZXItZG9tYWlucyA9IDwmcGRfbWlwaTA+OworCQkjcGh5LWNlbGxzID0g
PDA+OworICAgICAgICB9OwotLSAKMi4yMC4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
