Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5ADC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:50:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38F5020811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jliroler"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F5020811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AOU9dC8w99Reai+aEicEHD5X5zhZfOgMSoSuXzAQqlE=; b=jlirolerf17x/d
	Rv9kIAssr0HAD93xVlIo1vVe9ltEFK55xQzDTva2lBgAD+WLrLyr6hSsfdDAV8mX/8hNfk97C4wTn
	giil7XblNquNIObw5mEhL3fOzYGAhrriHQr/8GtPgsiyntcgXvT0Rjiig5OH36YSIDjj47lhLwnXt
	qGf0T8ytzKZnfFiCGnFQGeht6Dv6KshRx6KTNfWc8Mqtp2Gm/CAVqdrsc4ryFA00fnpD+1oQ4evZk
	IAIIWnxX1z8/kmyAfqP+8RGYjYse3M8dlAbUoieCSbeq8IAX86qVgkE63UK/fk+FSRWgljydobgVZ
	R0Tu3MfQrTYJHoMt/T3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpUWm-0003Jp-GZ; Fri, 01 Feb 2019 08:50:24 +0000
Received: from honk.sigxcpu.org ([24.134.29.49])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpUWQ-0001qw-O0
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 08:50:06 +0000
Received: from localhost (localhost [127.0.0.1])
 by honk.sigxcpu.org (Postfix) with ESMTP id E46EDFB03;
 Fri,  1 Feb 2019 09:49:57 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
 by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c9bpIqNCVqFh; Fri,  1 Feb 2019 09:49:56 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
 id 885E1461BD; Fri,  1 Feb 2019 09:49:55 +0100 (CET)
From: =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org,
 Robert Chiras <robert.chiras@nxp.com>, Sam Ravnborg <sam@ravnborg.org>,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 2/3] dt-bindings: phy: Add documentation for mixel dphy
Date: Fri,  1 Feb 2019 09:49:54 +0100
Message-Id: <107cd5e7f44f5361db64115530e228ba5993e692.1549010639.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1549010639.git.agx@sigxcpu.org>
References: <cover.1549010639.git.agx@sigxcpu.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_005003_046256_DBEBBB71 
X-CRM114-Status: GOOD (  11.30  )
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

QWRkIHN1cHBvcnQgZm9yIHRoZSBNSVhFTCBEUEhZIElQIGFzIGZvdW5kIGluIHRoZSBOWFAncyBp
Lk1YOE1RLgoKU2lnbmVkLW9mZi1ieTogR3VpZG8gR8O8bnRoZXIgPGFneEBzaWd4Y3B1Lm9yZz4K
LS0tCiAuLi4vYmluZGluZ3MvcGh5L21peGVsLG1pcGktZHNpLXBoeS50eHQgICAgICAgfCAyOSAr
KysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKQogY3Jl
YXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvbWl4
ZWwsbWlwaS1kc2ktcGh5LnR4dAoKZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9waHkvbWl4ZWwsbWlwaS1kc2ktcGh5LnR4dCBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9waHkvbWl4ZWwsbWlwaS1kc2ktcGh5LnR4dApuZXcgZmlsZSBtb2Rl
IDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMDAuLjEwMzIzYWU4ZWUzNwotLS0gL2Rldi9udWxsCisr
KyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvbWl4ZWwsbWlwaS1kc2kt
cGh5LnR4dApAQCAtMCwwICsxLDI5IEBACitNaXhlbCBEU0kgUEhZIGZvciBpLk1YOAorCitUaGUg
TWl4ZWwgTUlQSS1EU0kgUEhZIElQIGJsb2NrIGlzIGUuZy4gZm91bmQgb24gTVg4IHBsYXRmb3Jt
cyAoYWxvbmcKK3RoZSBNSVBJLURTSSBJUCBmcm9tIE5vcnRod2VzdCBMb2dpYykuIEl0IHJlcHJl
c2VudHMgdGhlIHBoeXNpY2FsCitsYXllciBmb3IgdGhlIGVsZWN0cmljYWwgc2lnbmFscyBmb3Ig
RFNJLgorCitSZXF1aXJlZCBwcm9wZXJ0aWVzOgorLSBjb21wYXRpYmxlOiBNdXN0IGJlOgorICAt
ICJtaXhlbCxpbXg4bXEtbWlwaS1kcGh5IgorLSBjbG9ja3M6IE11c3QgY29udGFpbiBhbiBlbnRy
eSBmb3IgZWFjaCBlbnRyeSBpbiBjbG9jay1uYW1lcy4KKy0gY2xvY2stbmFtZXM6IE11c3QgY29u
dGFpbiB0aGUgZm9sbG93aW5nIGVudHJpZXM6CisgIC0gInBoeV9yZWYiOiBwaGFuZGxlIGFuZCBz
cGVjaWZpZXIgcmVmZXJyaW5nIHRvIHRoZSBEUEhZIHJlZiBjbG9jaworLSByZWc6IHRoZSByZWdp
c3RlciByYW5nZSBvZiB0aGUgUEhZIGNvbnRyb2xsZXIKKy0gI3BoeS1jZWxsczogbnVtYmVyIG9m
IGNlbGxzIGluIFBIWSwgYXMgZGVmaW5lZCBpbgorICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvcGh5L3BoeS1iaW5kaW5ncy50eHQKKyAgdGhpcyBtdXN0IGJlIDwwPgorCitPcHRp
b25hbCBwcm9wZXJ0aWVzOgorLSBwb3dlci1kb21haW5zOiBwaGFuZGxlIHRvIHBvd2VyIGRvbWFp
bgorCitFeGFtcGxlOgorCW1pcGlfZHBoeTogbWlwaV9kcGh5QDMwQTAwMzAgeworCQljb21wYXRp
YmxlID0gIm1peGVsLGlteDhtcS1taXBpLWRwaHkiOworCQljbG9ja3MgPSA8JmNsayBJTVg4TVFf
Q0xLX0RTSV9QSFlfUkVGPjsKKwkJY2xvY2stbmFtZXMgPSAicGh5X3JlZiI7CisJCXJlZyA9IDww
eDMwQTAwMzAwIDB4MTAwPjsKKwkJcG93ZXItZG9tYWlucyA9IDwmcGRfbWlwaTA+OworCQkjcGh5
LWNlbGxzID0gPDA+OworICAgICAgICB9OwotLSAKMi4yMC4xCgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxp
c3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
