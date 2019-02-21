Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2618C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:37:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7455214AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tBjHmpF4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7455214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Pzkq7gOe7/EgPP0onSbjZ7fsRyjVBPydKIQ4tvC+WDY=; b=tBjHmpF4BvODik
	5xVEPEpDNN1k1M+JPsINenusLtxaoQX8PBT7v74seOpzucu1oXMaYLBMYr9IEGWX353ve15W3NU7P
	RMwzrj+nCURBJ/8vlgOyOFVh8v8Ez3PbVfo4p8u0NxbA4qF5+6j9fW9x2BiOwvmfa0IN7/69M5Gf0
	fmkrgdfmX4YZ4OB+C8WrrO6YR19BAJ9JJpdGf8zW50MjHE3YbzJePEhUrjUhBX+7V26l+Ez1nKJP/
	TNameUObhAqS/v3d6tsvaH6/hQcpZQg9CwniQLzmY6SMifwai/rMYSxJyP5Wy0xa8sbrUVToHVFKv
	yCa7UfYbUaRASX2SFTdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwlji-0005kR-1k; Thu, 21 Feb 2019 10:37:50 +0000
Received: from inva020.nxp.com ([92.121.34.13])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwlje-0005ZK-Pn
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 10:37:48 +0000
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B426C1A01C6;
 Thu, 21 Feb 2019 11:37:42 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
 [134.27.226.22])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A7EAA1A015E;
 Thu, 21 Feb 2019 11:37:42 +0100 (CET)
Received: from enigma.ea.freescale.net (enigma.ea.freescale.net
 [10.171.81.110])
 by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 58621205C6;
 Thu, 21 Feb 2019 11:37:42 +0100 (CET)
From: =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
To: Li Yang <leoyang.li@nxp.com>
Subject: [PATCH] soc: fsl: guts: make fsl_guts_get_svr() static
Date: Thu, 21 Feb 2019 12:37:31 +0200
Message-Id: <20190221103731.28978-1-horia.geanta@nxp.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_023746_976235_16C394FF 
X-CRM114-Status: UNSURE (   8.35  )
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Yangbo Lu <yangbo.lu@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

VGhlIGV4cG9ydCBvZiBmc2xfZ3V0c19nZXRfc3ZyKCkgaXMgYSBsZWZ0LW92ZXIsIGl0J3MgY3Vy
cmVudGx5IHVzZWQKb25seSBpbnRlcm5hbGx5IGFuZCB1c2VycyBuZWVkaW5nIFNvQyBpbmZvcm1h
dGlvbiBzaG91bGQgdXNlIHRoZSBnZW5lcmljCnNvY19kZXZpY2UgaW5mcmFzdHJ1Y3R1cmUuCgpT
aWduZWQtb2ZmLWJ5OiBIb3JpYSBHZWFudMSDIDxob3JpYS5nZWFudGFAbnhwLmNvbT4KLS0tCiBk
cml2ZXJzL3NvYy9mc2wvZ3V0cy5jICAgfCAzICstLQogaW5jbHVkZS9saW51eC9mc2wvZ3V0cy5o
IHwgMiAtLQogMiBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNCBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9mc2wvZ3V0cy5jIGIvZHJpdmVycy9zb2MvZnNsL2d1
dHMuYwppbmRleCA0Zjk2NTUwODdiZDcuLjYzZjZkZjg2ZjllNSAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9zb2MvZnNsL2d1dHMuYworKysgYi9kcml2ZXJzL3NvYy9mc2wvZ3V0cy5jCkBAIC0xMTUsNyAr
MTE1LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBmc2xfc29jX2RpZV9hdHRyICpmc2xfc29jX2Rp
ZV9tYXRjaCgKIAlyZXR1cm4gTlVMTDsKIH0KIAotdTMyIGZzbF9ndXRzX2dldF9zdnIodm9pZCkK
K3N0YXRpYyB1MzIgZnNsX2d1dHNfZ2V0X3N2cih2b2lkKQogewogCXUzMiBzdnIgPSAwOwogCkBA
IC0xMjksNyArMTI5LDYgQEAgdTMyIGZzbF9ndXRzX2dldF9zdnIodm9pZCkKIAogCXJldHVybiBz
dnI7CiB9Ci1FWFBPUlRfU1lNQk9MKGZzbF9ndXRzX2dldF9zdnIpOwogCiBzdGF0aWMgaW50IGZz
bF9ndXRzX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiB7CmRpZmYgLS1naXQg
YS9pbmNsdWRlL2xpbnV4L2ZzbC9ndXRzLmggYi9pbmNsdWRlL2xpbnV4L2ZzbC9ndXRzLmgKaW5k
ZXggOTQxYjExODExZjg1Li4xZmMwZWRkNzFjNTIgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgv
ZnNsL2d1dHMuaAorKysgYi9pbmNsdWRlL2xpbnV4L2ZzbC9ndXRzLmgKQEAgLTEzNSw4ICsxMzUs
NiBAQCBzdHJ1Y3QgY2Nzcl9ndXRzIHsKIAl1MzIJc3JkczJjcjE7CS8qIDB4LjBmNDQgLSBTZXJE
ZXMyIENvbnRyb2wgUmVnaXN0ZXIgMCAqLwogfSBfX2F0dHJpYnV0ZV9fICgocGFja2VkKSk7CiAK
LXUzMiBmc2xfZ3V0c19nZXRfc3ZyKHZvaWQpOwotCiAvKiBBbHRlcm5hdGUgZnVuY3Rpb24gc2ln
bmFsIG11bHRpcGxleCBjb250cm9sICovCiAjZGVmaW5lIE1QQzg1eHhfUE1VWENSX1FFKHgpICgw
eDgwMDAgPj4gKHgpKQogCi0tIAoyLjE2LjIKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
