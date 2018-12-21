Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCC8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:34:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CA6221917
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hSe7HVLX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA6221917
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DGf/Oo9YTUdcsVKWq95FPRx1NKmw8/Xd6C2+J2M2EiU=; b=hSe7HVLXa76Yol
	SmitbIujVMmghPx4i1kD/6x4ygDrBaBwFsyBEURZfYfRPpu8XAFawZ0moGE1QUnMiKIEpBGVTftMs
	yIP65q2a7V1soSE0WijfCMjjVts8+5zsR2/FdG1405qtsGzwjdU2qN/urpPdMSTaF5FbFjoeRdclD
	eWIWZpzzh+aClez8Wobn0hQxodnohqMoyWaRtYNg9u12Jv16jqdFQZyR0tt8b6L+zUs3PViBLBgZ+
	Ko7fYnV4AnKFcUVD9ki1y8KQ4p165i0DmH1qhDRE7J7bquN64dllb6TQSEl6H6o6zEyT+JjfopSu3
	Km+xW2/GtZd7Y68Jm3jw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaOgk-0008H3-LI; Fri, 21 Dec 2018 17:34:18 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaOfx-0007In-Hf
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 17:33:32 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id E5BE520717; Fri, 21 Dec 2018 18:33:15 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
 by mail.bootlin.com (Postfix) with ESMTPSA id AD89020734;
 Fri, 21 Dec 2018 18:33:05 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] pinctrl: armada-37xx: Correct mpp definitions
Date: Fri, 21 Dec 2018 18:32:57 +0100
Message-Id: <20181221173259.8372-2-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181221173259.8372-1-gregory.clement@bootlin.com>
References: <20181221173259.8372-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_093329_987892_D714C078 
X-CRM114-Status: GOOD (  11.49  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
 Marcin Wojtas <mw@semihalf.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

RnJvbTogTWFyZWsgQmVow7puIDxtYXJlay5iZWh1bkBuaWMuY3o+CgpUaGlzIGlzIGEgY2xlYW51
cCBhbmQgZml4IG9mIHRoZSBwYXRjaCBieSBLZW4gTWEgPG1ha2VAbWFydmVsbC5jb20+LgoKRml4
IHRoZSBtcHAgZGVmaW5pdGlvbnMgYWNjb3JkaW5nIHRvIG5ld2VzdCByZXZpc2lvbiBvZiB0aGUK
c3BlY2lmaWNhdGlvbjoKICAtIG5vcnRoYnJpZGdlOgogICAgZml4IHBtaWMxIGdwaW8gbnVtYmVy
IHRvIDcKICAgIGZpeCBwbWljMCBncGlvIG51bWJlciB0byA2CiAgLSBzb3V0aGJyaWRnZQogICAg
c3BsaXQgcGNpZTEgZ3JvdXAgYml0IG1hc2sgdG8gQklUKDUpIGFuZCAgQklUKDkpCiAgICBmaXgg
cHRwIGdyb3VwIGJpdCBtYXNrIHRvIEJJVCgxMSkgfCBCSVQoMTIpIHwgQklUKDEzKQogICAgYWRk
IHNtaSBncm91cCB3aXRoIGJpdCBtYXNrIEJJVCg0KQoKW2dyZWdvcnk6IHNwbGl0IHRoZSBwY2ll
IGdyb3VwIGluIDIsIGFzIGF0IGhhcmR3YXJlIGxldmVsIHRoZXkgY2FuIGJlCmNvbmZpZ3VyZWQg
c2VwYXJhdGVseV0KU2lnbmVkLW9mZi1ieTogTWFyZWsgQmVow7puIDxtYXJlay5iZWh1bkBuaWMu
Y3o+ClNpZ25lZC1vZmYtYnk6IEdyZWdvcnkgQ0xFTUVOVCA8Z3JlZ29yeS5jbGVtZW50QGJvb3Rs
aW4uY29tPgotLS0KIC4uLi9waW5jdHJsL21hcnZlbGwsYXJtYWRhLTM3eHgtcGluY3RybC50eHQg
ICAgfCAxOCArKysrKysrKysrKysrLS0tLS0KIGRyaXZlcnMvcGluY3RybC9tdmVidS9waW5jdHJs
LWFybWFkYS0zN3h4LmMgICAgfCAxMCArKysrKystLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDE5IGlu
c2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3BpbmN0cmwvbWFydmVsbCxhcm1hZGEtMzd4eC1waW5jdHJsLnR4
dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waW5jdHJsL21hcnZlbGwsYXJt
YWRhLTM3eHgtcGluY3RybC50eHQKaW5kZXggYzdjMDg4ZDJkZDUwLi5mNjlmODI3NDFjYWUgMTAw
NjQ0Ci0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waW5jdHJsL21hcnZl
bGwsYXJtYWRhLTM3eHgtcGluY3RybC50eHQKKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3BpbmN0cmwvbWFydmVsbCxhcm1hZGEtMzd4eC1waW5jdHJsLnR4dApAQCAtNTgs
MTEgKzU4LDExIEBAIGdyb3VwIHB3bTMKICAtIGZ1bmN0aW9ucyBwd20sIGdwaW8KIAogZ3JvdXAg
cG1pYzEKLSAtIHBpbiAxNworIC0gcGluIDcKICAtIGZ1bmN0aW9ucyBwbWljLCBncGlvCiAKIGdy
b3VwIHBtaWMwCi0gLSBwaW4gMTYKKyAtIHBpbiA2CiAgLSBmdW5jdGlvbnMgcG1pYywgZ3Bpbwog
CiBncm91cCBpMmMyCkBAIC0xMTIsMTcgKzExMiwyNSBAQCBncm91cCB1c2IyX2RydnZidXMxCiAg
LSBmdW5jdGlvbnMgZHJ2YnVzLCBncGlvCiAKIGdyb3VwIHNkaW9fc2IKLSAtIHBpbnMgNjAtNjQK
KyAtIHBpbnMgNjAtNjUKICAtIGZ1bmN0aW9ucyBzZGlvLCBncGlvCiAKIGdyb3VwIHJnbWlpCi0g
LSBwaW5zIDQyLTU1CisgLSBwaW5zIDQyLTUzCiAgLSBmdW5jdGlvbnMgbWlpLCBncGlvCiAKIGdy
b3VwIHBjaWUxCi0gLSBwaW5zIDM5LTQwCisgLSBwaW5zIDM5CisgLSBmdW5jdGlvbnMgcGNpZSwg
Z3BpbworCitncm91cCBwY2llMV9jbGtyZXEKKyAtIHBpbnMgNDAKICAtIGZ1bmN0aW9ucyBwY2ll
LCBncGlvCiAKK2dyb3VwIHNtaQorIC0gcGlucyA1NC01NQorIC0gZnVuY3Rpb25zIHNtaSwgZ3Bp
bworCiBncm91cCBwdHAKICAtIHBpbnMgNTYtNTgKICAtIGZ1bmN0aW9ucyBwdHAsIGdwaW8KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvcGluY3RybC9tdmVidS9waW5jdHJsLWFybWFkYS0zN3h4LmMgYi9k
cml2ZXJzL3BpbmN0cmwvbXZlYnUvcGluY3RybC1hcm1hZGEtMzd4eC5jCmluZGV4IGFhNDhiM2Yy
M2M3Zi4uMjY3ZGZjNTMwOTg1IDEwMDY0NAotLS0gYS9kcml2ZXJzL3BpbmN0cmwvbXZlYnUvcGlu
Y3RybC1hcm1hZGEtMzd4eC5jCisrKyBiL2RyaXZlcnMvcGluY3RybC9tdmVidS9waW5jdHJsLWFy
bWFkYS0zN3h4LmMKQEAgLTE3MCw4ICsxNzAsOCBAQCBzdGF0aWMgc3RydWN0IGFybWFkYV8zN3h4
X3Bpbl9ncm91cCBhcm1hZGFfMzd4eF9uYl9ncm91cHNbXSA9IHsKIAlQSU5fR1JQX0dQSU8oInB3
bTEiLCAxMiwgMSwgQklUKDQpLCAicHdtIiksCiAJUElOX0dSUF9HUElPKCJwd20yIiwgMTMsIDEs
IEJJVCg1KSwgInB3bSIpLAogCVBJTl9HUlBfR1BJTygicHdtMyIsIDE0LCAxLCBCSVQoNiksICJw
d20iKSwKLQlQSU5fR1JQX0dQSU8oInBtaWMxIiwgMTcsIDEsIEJJVCg3KSwgInBtaWMiKSwKLQlQ
SU5fR1JQX0dQSU8oInBtaWMwIiwgMTYsIDEsIEJJVCg4KSwgInBtaWMiKSwKKwlQSU5fR1JQX0dQ
SU8oInBtaWMxIiwgNywgMSwgQklUKDcpLCAicG1pYyIpLAorCVBJTl9HUlBfR1BJTygicG1pYzAi
LCA2LCAxLCBCSVQoOCksICJwbWljIiksCiAJUElOX0dSUF9HUElPKCJpMmMyIiwgMiwgMiwgQklU
KDkpLCAiaTJjIiksCiAJUElOX0dSUF9HUElPKCJpMmMxIiwgMCwgMiwgQklUKDEwKSwgImkyYyIp
LAogCVBJTl9HUlBfR1BJTygic3BpX2NzMSIsIDE3LCAxLCBCSVQoMTIpLCAic3BpIiksCkBAIC0x
OTUsOCArMTk1LDEwIEBAIHN0YXRpYyBzdHJ1Y3QgYXJtYWRhXzM3eHhfcGluX2dyb3VwIGFybWFk
YV8zN3h4X3NiX2dyb3Vwc1tdID0gewogCVBJTl9HUlBfR1BJTygidXNiMl9kcnZ2YnVzMSIsIDEs
IDEsIEJJVCgxKSwgImRydmJ1cyIpLAogCVBJTl9HUlBfR1BJTygic2Rpb19zYiIsIDI0LCA2LCBC
SVQoMiksICJzZGlvIiksCiAJUElOX0dSUF9HUElPKCJyZ21paSIsIDYsIDEyLCBCSVQoMyksICJt
aWkiKSwKLQlQSU5fR1JQX0dQSU8oInBjaWUxIiwgMywgMiwgQklUKDQpLCAicGNpZSIpLAotCVBJ
Tl9HUlBfR1BJTygicHRwIiwgMjAsIDMsIEJJVCg1KSwgInB0cCIpLAorCVBJTl9HUlBfR1BJTygi
c21pIiwgMTgsIDIsIEJJVCg0KSwgInNtaSIpLAorCVBJTl9HUlBfR1BJTygicGNpZTEiLCAzLCAx
LCBCSVQoNSksICJwY2llIiksCisJUElOX0dSUF9HUElPKCJwY2llMV9jbGtyZXEiLCA0LCAxLCBC
SVQoOSksICJwY2llIiksCisJUElOX0dSUF9HUElPKCJwdHAiLCAyMCwgMywgQklUKDExKSB8IEJJ
VCgxMikgfCBCSVQoMTMpLCAicHRwIiksCiAJUElOX0dSUCgicHRwX2NsayIsIDIxLCAxLCBCSVQo
NiksICJwdHAiLCAibWlpIiksCiAJUElOX0dSUCgicHRwX3RyaWciLCAyMiwgMSwgQklUKDcpLCAi
cHRwIiwgIm1paSIpLAogCVBJTl9HUlBfR1BJT18zKCJtaWlfY29sIiwgMjMsIDEsIEJJVCg4KSB8
IEJJVCgxNCksIDAsIEJJVCg4KSwgQklUKDE0KSwKLS0gCjIuMTkuMgoKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGlu
ZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
