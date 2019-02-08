Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143DDC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:55:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2FA120857
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oW0YCOaG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2FA120857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CZ8fWuXLN8ECgxeObUw10McsqBVEcDnXKT4PQuBnCxU=; b=oW0YCOaG2ITN+Y
	YtCpx+YBQ0QPS4LaxONtyfo0zT3W3WkiznkQQHhndVzu/zOC8nXZqXVAMdIJy3p8jQXPml69qqsll
	+U3LtrKWPGYwJBzYVuM0jVpQ/g7hWInz4ErQohLXoXDlCMTZgnchAB732KjDpsCZ8wwq+Q1mAW3am
	mye65rXebWEqEAl8AsJywr6wzp6GZTZTzYo2z8CE4s53onJpmBDy1WIZfUAnpBAI3gtmz9n8keyf1
	3J3+JKV3elX4yxe6CLQwByCwf++biQRdEWgS57SZi6DqgvC9KIDcOS8OMTn3KdHpp5u6PYdRGTBMz
	1Z5WTj7uuVABiL22Cw5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs4kH-0000r2-0f; Fri, 08 Feb 2019 11:55:01 +0000
Received: from honk.sigxcpu.org ([24.134.29.49])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs4jp-0000MC-Dz
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 11:54:35 +0000
Received: from localhost (localhost [127.0.0.1])
 by honk.sigxcpu.org (Postfix) with ESMTP id 0807DFB02;
 Fri,  8 Feb 2019 12:54:32 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
 by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qzDXjwsEQd7M; Fri,  8 Feb 2019 12:54:29 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
 id 8BC6F43F23; Fri,  8 Feb 2019 12:54:27 +0100 (CET)
From: =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org,
 Robert Chiras <robert.chiras@nxp.com>, Sam Ravnborg <sam@ravnborg.org>,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v3 2/3] dt-bindings: phy: Add documentation for mixel dphy
Date: Fri,  8 Feb 2019 12:54:26 +0100
Message-Id: <6cdb57f5c216f0d4031cd7ae91f1429e2f45bb15.1549626136.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1549626136.git.agx@sigxcpu.org>
References: <cover.1549626136.git.agx@sigxcpu.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_035433_625795_411F0A01 
X-CRM114-Status: GOOD (  10.98  )
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
UmV2aWV3ZWQtYnk6IFNhbSBSYXZuYm9yZyA8c2FtQHJhdm5ib3JnLm9yZz4KLS0tCiAuLi4vYmlu
ZGluZ3MvcGh5L21peGVsLG1pcGktZHNpLXBoeS50eHQgICAgICAgfCAyOSArKysrKysrKysrKysr
KysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAw
NjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvbWl4ZWwsbWlwaS1kc2kt
cGh5LnR4dAoKZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
aHkvbWl4ZWwsbWlwaS1kc2ktcGh5LnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9waHkvbWl4ZWwsbWlwaS1kc2ktcGh5LnR4dApuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRl
eCAwMDAwMDAwMDAwMDAuLmQzNjQ2NTgwNDEyYQotLS0gL2Rldi9udWxsCisrKyBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvbWl4ZWwsbWlwaS1kc2ktcGh5LnR4dApAQCAt
MCwwICsxLDI5IEBACitNaXhlbCBEU0kgUEhZIGZvciBpLk1YOAorCitUaGUgTWl4ZWwgTUlQSS1E
U0kgUEhZIElQIGJsb2NrIGlzIGUuZy4gZm91bmQgb24gaS5NWDggcGxhdGZvcm1zIChhbG9uZyB0
aGUKK01JUEktRFNJIElQIGZyb20gTm9ydGh3ZXN0IExvZ2ljKS4gSXQgcmVwcmVzZW50cyB0aGUg
cGh5c2ljYWwgbGF5ZXIgZm9yIHRoZQorZWxlY3RyaWNhbCBzaWduYWxzIGZvciBEU0kuCisKK1Jl
cXVpcmVkIHByb3BlcnRpZXM6CistIGNvbXBhdGlibGU6IE11c3QgYmU6CisgIC0gIm1peGVsLGlt
eDhtcS1taXBpLWRwaHkiCistIGNsb2NrczogTXVzdCBjb250YWluIGFuIGVudHJ5IGZvciBlYWNo
IGVudHJ5IGluIGNsb2NrLW5hbWVzLgorLSBjbG9jay1uYW1lczogTXVzdCBjb250YWluIHRoZSBm
b2xsb3dpbmcgZW50cmllczoKKyAgLSAicGh5X3JlZiI6IHBoYW5kbGUgYW5kIHNwZWNpZmllciBy
ZWZlcnJpbmcgdG8gdGhlIERQSFkgcmVmIGNsb2NrCistIHJlZzogdGhlIHJlZ2lzdGVyIHJhbmdl
IG9mIHRoZSBQSFkgY29udHJvbGxlcgorLSAjcGh5LWNlbGxzOiBudW1iZXIgb2YgY2VsbHMgaW4g
UEhZLCBhcyBkZWZpbmVkIGluCisgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
aHkvcGh5LWJpbmRpbmdzLnR4dAorICB0aGlzIG11c3QgYmUgPDA+CisKK09wdGlvbmFsIHByb3Bl
cnRpZXM6CistIHBvd2VyLWRvbWFpbnM6IHBoYW5kbGUgdG8gcG93ZXIgZG9tYWluCisKK0V4YW1w
bGU6CisJbWlwaV9kcGh5OiBtaXBpX2RwaHlAMzBBMDAzMCB7CisJCWNvbXBhdGlibGUgPSAibWl4
ZWwsaW14OG1xLW1pcGktZHBoeSI7CisJCWNsb2NrcyA9IDwmY2xrIElNWDhNUV9DTEtfRFNJX1BI
WV9SRUY+OworCQljbG9jay1uYW1lcyA9ICJwaHlfcmVmIjsKKwkJcmVnID0gPDB4MzBBMDAzMDAg
MHgxMDA+OworCQlwb3dlci1kb21haW5zID0gPCZwZF9taXBpMD47CisJCSNwaHktY2VsbHMgPSA8
MD47CisgICAgICAgIH07Ci0tIAoyLjIwLjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
