Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31462C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:08:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3EBF21841
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CNNGjQOc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3EBF21841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=E4PIHo7ZnJwuTu8tivhBH7DVVk+b9KrbporAIiJHsTk=; b=CNNGjQOcmyBvIg
	FRrTli6GQyXupfBEq7/ZUf1437pT+6Izra/sSUt1gyv3MU3obgLdEfMWkwXAWfOD6yIBNCoZJ3xTD
	6OsxUddqrr5zmJ/Oxk9rYWmqsxcTkpKy5cT4/Qwn06Fzc7h/dHE4i8mjSWXVJ5T4EQNtv6oquJVfF
	Ti4+QpnDVurO7MPosI780WrJAjY0w2wJvoZ1enGKVcm+htjLsWIQegCAeLnAgnueTdbWuxTX2nIzj
	K9lbPtLeCgqxsozr03W7scq17E3Hw2eeox9TEpAxPqeNiR4XeBDeySXgKBpFSfGN/Zto93vmpWtiB
	jpjIFHH7KICczToq3KtQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZHv6-0001Ef-Ey; Tue, 18 Dec 2018 16:08:32 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZHut-00014j-Jg
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 16:08:21 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 316FD20A95; Tue, 18 Dec 2018 17:08:08 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
 by mail.bootlin.com (Postfix) with ESMTPSA id 05A8C207D9;
 Tue, 18 Dec 2018 17:07:58 +0100 (CET)
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Shawn Guo <shawnguo@kernel.org>
Subject: [RESEND PATCH v2 1/3] arm64: dts: fsl: use a generic node name for
 m25p80 flashes
Date: Tue, 18 Dec 2018 17:07:46 +0100
Message-Id: <20181218160750.6766-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_080819_786941_44BC5416 
X-CRM114-Status: GOOD (  11.21  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Use a generic node name for the m25p80 flashes on ls1043 and ls1046 boards.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
index dff3d648172e..8468e652a262 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
@@ -138,7 +138,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	qflash0: s25fl128s@0 {
+	qflash0: flash@0 {
 		compatible = "spansion,m25p80";
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
index e58a8ca1386c..51a518b64053 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
@@ -167,7 +167,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	qflash0: s25fl128s@0 {
+	qflash0: flash@0 {
 		compatible = "spansion,m25p80";
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
index a59b48203688..1e3d570412d2 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
@@ -103,7 +103,7 @@
 	bus-num = <0>;
 	status = "okay";
 
-	qflash0: s25fs512s@0 {
+	qflash0: flash@0 {
 		compatible = "spansion,m25p80";
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -111,7 +111,7 @@
 		reg = <0>;
 	};
 
-	qflash1: s25fs512s@1 {
+	qflash1: flash@1 {
 		compatible = "spansion,m25p80";
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
