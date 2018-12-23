Return-Path: <SRS0=5OaU=PA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9052FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 16:32:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 617842184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 16:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZZeTpV7D";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="jbWIxcCz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617842184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=mail.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=E29DH0s3YW2MUfSnCNRApODfg7kxO+DRNfvn9yP4l/Q=; b=ZZeTpV7DX9HHQ4tvVsUmKHgW40
	TaR5Etp11AM/KcjrPIzu1qvwC8uizHh0qdX/I9vR6OaZWf6H3CL8ppbVbizKNlQ4QX1QKCKUertoi
	boovBYdngoFNOQNc44DYQPQiacavLMyIAGPdEukm6Y58maYd2AVF6nf3cKVQOLKpHtK5xpifnwH0X
	GXI6XI9YRpEumGgeIT0qlQc5WggiqjJFRmxNPlZtOhHu4DJU9j3XiF6VVhFwm9T/xx1OdKZvMm16d
	o7fq4sMYdrjUudI4HNeIB9PJGj00THZCFJ/yp/2cL6i+bUP1NO3k2byrfLBAHnFgoUmbicoXXTRUA
	AFk4ZJEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gb6gQ-0001uk-D9; Sun, 23 Dec 2018 16:32:54 +0000
Received: from smtp34.i.mail.ru ([94.100.177.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gb6fa-0001GT-W5
 for linux-arm-kernel@lists.infradead.org; Sun, 23 Dec 2018 16:32:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail2; 
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=+7DOklCtsB67p+JdfZBCnLzopBUGx8nln8kofPR0K40=; 
 b=jbWIxcCzuR73UeTc6Li4LYiSLx+IJLbD9PE8qgbWCCdY+nVLV48GORhtG6fNGPzUmsxYFLEflCqEdZ2Ij+/RZJg9Gf50IBLGNUh6lnPCw8G9599t5mBkkxVXvd98X1gFoiObL/toq7aQyczTj8N43Agtii+6DQm7yECFHw6Ln34=;
Received: by smtp34.i.mail.ru with esmtpa (envelope-from <shc_work@mail.ru>)
 id 1gb6fM-00087P-Mt; Sun, 23 Dec 2018 19:31:49 +0300
From: Alexander Shiyan <shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/4] ARM: dts: imx6q/dl-phytec-pfla02: Remove duplicate nodes
Date: Sun, 23 Dec 2018 19:31:39 +0300
Message-Id: <20181223163141.6792-2-shc_work@mail.ru>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20181223163141.6792-1-shc_work@mail.ru>
References: <20181223163141.6792-1-shc_work@mail.ru>
Authentication-Results: smtp34.i.mail.ru; auth=pass smtp.auth=shc_work@mail.ru
 smtp.mailfrom=shc_work@mail.ru
X-77F55803: 257C4F86AB09C89C5A78504BD2AC2941988784FC6C4AE31FAFF1CA450855C374373C3C7A45D85DEDEBC4798F61296032FCC72E9010248C07
X-7FA49CB5: 0D63561A33F958A5EC3E8A45EE5F0CEBAE58B855DBA0FAC14A3024F37FE0C3AC8941B15DA834481FA18204E546F3947CB861051D4BA689FCF6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8B3A703B70628EAD7BA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249DA33821E755670D83AA81AA40904B5D9CF19DD082D7633A0E7DDDDC251EA7DABD81D268191BDAD3D78DA827A17800CE72CE3825EE585899DCD04E86FAF290E2D40A5AABA2AD3711975ECD9A6C639B01B78DA827A17800CE78B28E96425A213B56DC80D5912CEBF1275ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF57285124B2A10EEC6C00306258E7E6ABB4E4A6367B16DE6309
X-Mailru-Sender: 139A7956A63CACCF2A18077BC60D2445223CBA05F7F71A494517AC039AA668A7B16B9C5DC9C832B56B3B2BD4812BFD4DC77752E0C033A69E93554C27080790AB3B25A7FBAAF806F0AE208404248635DF
X-Mras: OK
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181223_083203_410244_E62C4B07 
X-CRM114-Status: UNSURE (   7.51  )
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

"model", "compatible" and "memory" nodes is already present in
corresponed imx6q-phytec-pfla02.dtsi and imx6dl-phytec-pfla02.dtsi
files. Patch removes this duplicates.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
index ed1aafd..211640e 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
@@ -12,13 +12,6 @@
 #include <dt-bindings/gpio/gpio.h>
 
 / {
-	model = "Phytec phyFLEX-i.MX6 Quad";
-	compatible = "phytec,imx6q-pfla02", "fsl,imx6q";
-
-	memory@10000000 {
-		reg = <0x10000000 0x80000000>;
-	};
-
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.10.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
