Return-Path: <SRS0=5OaU=PA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEBFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 16:32:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 973B8222A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 16:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nUS2A2uC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="q8Cyy2/K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 973B8222A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=mail.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=4YMVKDjmDkD6apfmqOLRNGztKxub/GUiT+AJGcgp+Kw=; b=nUS
	2A2uC/CXUsitsUqm2MeeK1izzALn+zg7kayjkjeO/QwouKhJYRJBjuJ1uCNyLe6r3tNzPVIi83LB3
	uANo8PKRG4uWDIbtnaCfF7EGNSicJHWu+Kyuify9ADEmJAH0fh9FoAQdhaGbvPmA3mTOTesA75wog
	VWtSudrCFM3CaEFv0xdFMIO/JYaUQbQvbmbtf33FjESSic/7rEZdmy/6taAaCDLwPt2H8335j3evM
	+rJqcKVcu1dd9IeYkqaxMtgHiMdBShCzXW7oG8WNi4EQDRGynW4zbBN1swdaO1hfPwrjJWCY4frAT
	4GIwUwNlxukPsawT3bOtxlH0F12Kriw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gb6ff-0001Hm-7S; Sun, 23 Dec 2018 16:32:07 +0000
Received: from smtp34.i.mail.ru ([94.100.177.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gb6fb-0001GS-1R
 for linux-arm-kernel@lists.infradead.org; Sun, 23 Dec 2018 16:32:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail2; h=Message-Id:Date:Subject:Cc:To:From;
 bh=iqosbWh8y6mkmneKkYRyUcSCXVZ2eomzcWCw0ihxtW0=; 
 b=q8Cyy2/KZ9B+MmobGQyWwsmeSBX/LBYTie1I2CMQR9fA1T18rk25ETDOsAn6SCoPhEsU/9qGQFL26F4Xa6yZLURRAySX7hzbU6n9qU7Phafix/Nbv6pEELZL/hvRDVwePZ4zXKeyT5TZjkCqM5LVuAm43fesomXuhNm5oHrwU+I=;
Received: by smtp34.i.mail.ru with esmtpa (envelope-from <shc_work@mail.ru>)
 id 1gb6fM-00087P-8j; Sun, 23 Dec 2018 19:31:48 +0300
From: Alexander Shiyan <shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/4] ARM: dts: imx6q-phytec-pbab01: Remove duplicate "chosen"
 node
Date: Sun, 23 Dec 2018 19:31:38 +0300
Message-Id: <20181223163141.6792-1-shc_work@mail.ru>
X-Mailer: git-send-email 2.10.2
Authentication-Results: smtp34.i.mail.ru; auth=pass smtp.auth=shc_work@mail.ru
 smtp.mailfrom=shc_work@mail.ru
X-77F55803: 0014004E1F3277295A78504BD2AC29417183463EAF47BFE329D536166247B373C258DDD26D9545C9F001E625AC15EA5D
X-7FA49CB5: 0D63561A33F958A5EC3E8A45EE5F0CEBAE58B855DBA0FAC1931DDCC77D75C8D28941B15DA834481FA18204E546F3947C0CABCCA60F52D7EBF6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8B55B19328CBC4F849A471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249E20791DD86E535D73AA81AA40904B5D9CF19DD082D7633A0E7DDDDC251EA7DABD81D268191BDAD3D78DA827A17800CE79C0DA0AD91AF617ECD04E86FAF290E2D40A5AABA2AD3711975ECD9A6C639B01B78DA827A17800CE72C83F5BD062A294A3A9669203D61ED9075ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF57285124B2A10EEC6C00306258E7E6ABB4E4A6367B16DE6309
X-Mailru-Sender: 139A7956A63CACCF2A18077BC60D2445223CBA05F7F71A494517AC039AA668A754C8EF9622D1B5C56B3B2BD4812BFD4DC77752E0C033A69E93554C27080790AB3B25A7FBAAF806F0AE208404248635DF
X-Mras: OK
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181223_083203_403205_75ADE7D2 
X-CRM114-Status: UNSURE (   7.34  )
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
Cc: Alexander Shiyan <shc_work@mail.ru>, Shawn Guo <shawnguo@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

"chosen" is already present in imx6qdl-phytec-pbab01.dtsi.
Patch removes this duplicate.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx6q-phytec-pbab01.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-phytec-pbab01.dts b/arch/arm/boot/dts/imx6q-phytec-pbab01.dts
index 1f47713..6c811e8 100644
--- a/arch/arm/boot/dts/imx6q-phytec-pbab01.dts
+++ b/arch/arm/boot/dts/imx6q-phytec-pbab01.dts
@@ -16,10 +16,6 @@
 / {
 	model = "Phytec phyFLEX-i.MX6 Quad Carrier-Board";
 	compatible = "phytec,imx6q-pbab01", "phytec,imx6q-pfla02", "fsl,imx6q";
-
-	chosen {
-		stdout-path = &uart4;
-	};
 };
 
 &sata {
-- 
2.10.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
