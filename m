Return-Path: <SRS0=5OaU=PA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC2AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 06:04:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A8E82176F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 06:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hreafy86";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="ZcJ9+VsF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A8E82176F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=mail.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=COj3Gbj/KL0vSc/XMISBrGu26wipMVmab3gvy5Pzhd8=; b=Hre
	afy86w86cDSLbip1CryUOqd7CWEsqjpRwYfB/PwG0PK1MxNIPmF+Xy5pUuHBpTgBpdbSGncVuLqUo
	/6zuCHFlkA46mJZ9ZOq1IL0y4BIQsbPAKR5vISNLCPAAfOy3oKJpx8SkehtsX1FwvPbjPjLoyLCVV
	ruJOJ7bDis6AGSoHajIRDzhriF/SvsWdnrtrvLDSOdOO2CE/fmtw9+9MbEj+fzk00IzWRi2zotOQp
	qkNP7LQI7d0z3rJNQfjHkMarCnwKwG+nUoLmPxoNaGPA08LqvIsKfhgo+FnE4VsOaIcYp59aX8BIB
	qDOHveAi/p7DVa8akonD+GNnGYtUWQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gawrv-0007cI-Fo; Sun, 23 Dec 2018 06:04:07 +0000
Received: from smtp3.mail.ru ([94.100.179.58])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gawrq-0007ak-WB
 for linux-arm-kernel@lists.infradead.org; Sun, 23 Dec 2018 06:04:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail2; h=Message-Id:Date:Subject:Cc:To:From;
 bh=3ytrtnC2uwto3kgCZBUJMxaGOVK8FlmEYlfCyJTGKeM=; 
 b=ZcJ9+VsF7YjYXlcVTMzj5Vtwp4fEcHPIZ8w7/9QdClwjKb9YP7+CTPwZY+QmuvNb5si1QXqTEdbNMSNSmIO3ZQuv6QbUI0AGfTJe/nE8EdeVCpK+X0Wl3PmC/kocj6U8OyzU7LJIA2/hxGYahRJ3Eojtjm09L1wn0QX+tzR5ELs=;
Received: by smtp3.mail.ru with esmtpa (envelope-from <shc_work@mail.ru>)
 id 1gawrb-0002TA-9b; Sun, 23 Dec 2018 09:03:47 +0300
From: Alexander Shiyan <shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/4] ARM: dts: i.MX51: Add device_type to Digi ConnectCore
 memory node
Date: Sun, 23 Dec 2018 09:03:39 +0300
Message-Id: <20181223060342.32054-1-shc_work@mail.ru>
X-Mailer: git-send-email 2.10.2
Authentication-Results: smtp3.mail.ru; auth=pass smtp.auth=shc_work@mail.ru
 smtp.mailfrom=shc_work@mail.ru
X-77F55803: 689590B63E0A4B015A78504BD2AC29419868B496DAF47A9FD1F5664BC9DA345E6D3DD0356BC35ED5E52AB0084CE7CFA4
X-7FA49CB5: 0D63561A33F958A598527AAD12272E33E0772031D2666BCEBE5EF9B16175BFBA8941B15DA834481FA18204E546F3947C1D471462564A2E19F6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8B2EE5AD8F952D28FBA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249E20791DD86E535D73AA81AA40904B5D9CF19DD082D7633A0E7DDDDC251EA7DABD81D268191BDAD3D78DA827A17800CE79C0DA0AD91AF617ECD04E86FAF290E2D40A5AABA2AD3711975ECD9A6C639B01B78DA827A17800CE7C0D954458108DB8842632E527458B68875ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF57285124B2A10EEC6C00306258E7E6ABB4E4A6367B16DE6309
X-Mailru-Sender: 139A7956A63CACCF2A18077BC60D2445071D9EE416723301A78EAADB28B7DA57CC5ED27D5B39E44C6B3B2BD4812BFD4DC77752E0C033A69E93554C27080790AB3B25A7FBAAF806F0AE208404248635DF
X-Mras: OK
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181222_220403_431366_F0E6E885 
X-CRM114-Status: UNSURE (   9.51  )
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
Cc: Alexander Shiyan <shc_work@mail.ru>, Sascha Hauer <s.hauer@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The current imx51-digi-connectcore-som.dtsi lacks a 'device_type = "memory"'
for its memory node. This patch adds it.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi b/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi
index 5761a66..82d8df0 100644
--- a/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi
+++ b/arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi
@@ -17,6 +17,7 @@
 	compatible = "digi,connectcore-ccxmx51-som", "fsl,imx51";
 
 	memory@90000000 {
+		device_type = "memory";
 		reg = <0x90000000 0x08000000>;
 	};
 };
-- 
2.10.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
