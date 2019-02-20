Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD48C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:26:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E059720880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VDZM5YbG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E059720880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mansr.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Ovm+QC2BKgAqXo6gWZi8HB8/jenC/rW3amKQYtB/BUU=; b=VDZM5YbG1ay84g
	MoBw84XX8OWbYC+flXZCDRsplDSMLGUsLkaIuKA78TJWp66WWjM1HjXbBC65JRXcsjBPnsxtA3anE
	LpymUZWS3NV60lskOmp1TXCwXAOmf3G1FgC0GWPW8VEZD76ijKdBC1lv9nR7wl8H51zDwjN0PBn3D
	D4i5TH2vINlrOp9v22zb/LP2kQmUxNSm5CDJ6zk1/eeuR1fnrdYEAEOZVmEpbgSDdB6evUnEC1FIY
	whNYCBPC5Etl5LGANmvfEoNHZdiqrPrNGtx9B5I6ZvqgO3uaGMGfPC7IJvevVgahHXMQzriOYtgXQ
	6h1lik0fxJ3GGeC4gtrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwSpH-0006FY-0R; Wed, 20 Feb 2019 14:26:19 +0000
Received: from unicorn.mansr.com ([2001:8b0:ca0d:8d8e::2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwSp6-00066H-Ff
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 14:26:09 +0000
Received: by unicorn.mansr.com (Postfix, from userid 51770)
 id 2235515632; Wed, 20 Feb 2019 14:26:02 +0000 (GMT)
From: Mans Rullgard <mans@mansr.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
	Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 1/3] ARM: dts: sun7i: add pinctrl for CAN in PA bank
Date: Wed, 20 Feb 2019 14:25:34 +0000
Message-Id: <20190220142536.21051-1-mans@mansr.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_062608_674557_B03BC28F 
X-CRM114-Status: UNSURE (   8.11  )
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
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds pinctrl settings for the CAN controller using pins
PA16 and PA17.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 76d0c961f01e..4528c91ef837 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -757,6 +757,12 @@
 			#interrupt-cells = <3>;
 			#gpio-cells = <3>;
 
+			/omit-if-no-ref/
+			can_pa_pins: can-pa-pins {
+				pins = "PA16", "PA17";
+				function = "can";
+			};
+
 			can_ph_pins: can-ph-pins {
 				pins = "PH20", "PH21";
 				function = "can";
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
