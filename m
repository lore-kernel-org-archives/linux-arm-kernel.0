Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A042BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:58:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62A29217D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cO3stK8M";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="SxZbVJfF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A29217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=mail.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=z/oQuOYIMPSFQypRZTssNpIhz08xcZVhBvLqgq7/gzE=; b=cO3
	stK8MKDbJPGCTQ3X1XKkqDYfFl7VjveztOYgE+6oNHrEaVEhrOIJF/7lgjdKvHPsWVw6Y6LtBDliu
	Jzkj+I+C28XvAYZi0YVzkdaa1w2uHBwYYgvDiV0OOhrgWx7pAPh5DmBaKKz3jnnJkVsIzidfJoPnw
	oZjHj5wDZHWPTX2Pa9JzJvIn905pikXuV2z8o3ViOa7akwc/8yWut/9LOtNBkyWlKzopahCotkYq2
	+B4KpmCLj+rjuNjW61lSPG/q1ZM959ewkuq6vAM3O4qXwxhSan42ZoVrhKcS8Imw+rQ+icnw4q+CM
	rmf6ZSahZuYFjU3zgeXJ12p0RNChO4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZeF0-0006qo-Mk; Wed, 19 Dec 2018 15:58:34 +0000
Received: from smtp16.mail.ru ([94.100.176.153])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZeDP-0005RS-Bn
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 15:56:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail2; h=Message-Id:Date:Subject:Cc:To:From;
 bh=5UD85iKKJVkB5OSOV1AOuNyAdG4Xw6Py43ue9VYyFfI=; 
 b=SxZbVJfFIpQbSh/wfQ0mz0TKhQB2gQ0GNS+gKSFUqj603Ij/tFWJ3QEDhyRz51/tzpRWkBPK9kGM89MtAaJF32XcdigM9kz4UeaNxz2q64H799zsCrv6JOhkQQld1qoxejni9ELgenloNbIRANFyMj9v9eydIilDy2GUCPqAAkc=;
Received: by smtp16.mail.ru with esmtpa (envelope-from <shc_work@mail.ru>)
 id 1gZeDC-0004o3-11; Wed, 19 Dec 2018 18:56:42 +0300
From: Alexander Shiyan <shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: dts: imx: Change i.MX27 interrupt controller unit name
Date: Wed, 19 Dec 2018 18:56:39 +0300
Message-Id: <20181219155639.17096-1-shc_work@mail.ru>
X-Mailer: git-send-email 2.10.2
Authentication-Results: smtp16.mail.ru; auth=pass smtp.auth=shc_work@mail.ru
 smtp.mailfrom=shc_work@mail.ru
X-77F55803: 689590B63E0A4B015A78504BD2AC2941AC9F5C0DA9FA9AD2E0EB87422B15FCA24F8481E4DFCB938DF0EA0A14B3930363
X-7FA49CB5: 0D63561A33F958A5C230ED0F72CE375D3D6D6F7A9853045BB27420F9988F54058941B15DA834481FA18204E546F3947C989FD0BDF65E50FBF6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8B60CDF180582EB8FBA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C224999B836357A5F2ED63AA81AA40904B5D9CF19DD082D7633A0E7DDDDC251EA7DABD81D268191BDAD3D78DA827A17800CE769E77FCA7B33833FCD04E86FAF290E2D40A5AABA2AD3711975ECD9A6C639B01B78DA827A17800CE757E66468AB8B84C80E574589093979EC75ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF57285124B2A10EEC6C00306258E7E6ABB4E4A6367B16DE6309
X-Mailru-Sender: 139A7956A63CACCF2A18077BC60D2445446E41041DC1FAFBF60C6C1E1C45F47A30513CE0030DFCD06B3B2BD4812BFD4DC77752E0C033A69E93554C27080790AB3B25A7FBAAF806F0AE208404248635DF
X-Mras: OK
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_075656_120366_CC628F8C 
X-CRM114-Status: GOOD (  12.16  )
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
Cc: Shawn Guo <shawnguo@kernel.org>, Alexander Shiyan <shc_work@mail.ru>,
 kernel@pengutronix.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The interrupt controller is located at the physical address 0x10040000.
This patch changes the unit name of the controller to reflect the actual
address.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 151b0eb..e34c7f3 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -42,7 +42,7 @@
 		spi2 = &cspi3;
 	};
 
-	aitc: aitc-interrupt-controller@e0000000 {
+	aitc: aitc-interrupt-controller@10040000 {
 		compatible = "fsl,imx27-aitc", "fsl,avic";
 		interrupt-controller;
 		#interrupt-cells = <1>;
-- 
2.10.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
