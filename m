Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7549BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:53:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BC5E218D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fPmfXuYE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC5E218D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7gi/3WZetEvRQWCmJEBxz3XsGn19rX0Tw3cF43V+z5A=; b=fPmfXuYEAW4P+m
	qud4hzeGB0JzVRk15VnachBRlBfm2o9nmssfcZfYbd+eI1gJJUsPrGI5NoLI7LW/tRDcO1vjsxZGg
	jxHTvAExCIKGHLjORbyAHABoEMmSLfQCz1TrhhXqOtSMznDGQJrpkemAC39nlyxcWCSm2D+6rUiE3
	5TtNabjrk8kM6NFBN+iPLxZmFaGqKqpvA7kRJgaTOI6kDinQ3TSBNJ0Ti34nNefZs5Ds8OSGwIVNS
	eVuBBUD4OGS+ZHY2me/FZi6YQB1VRpLI+nRI8r9YHG+1sY20nF1AreXHYLO11YcPe+J/NNFUaMkRj
	YpePA6vr8zWcFRJ2+lUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs2qo-0003La-74; Fri, 08 Feb 2019 09:53:38 +0000
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs2ql-0003L0-0d
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 09:53:36 +0000
X-Originating-IP: 90.88.22.177
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr
 [90.88.22.177]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id CF4ED60006;
 Fri,  8 Feb 2019 09:53:26 +0000 (UTC)
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Sean Paul <seanpaul@chromium.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v2 1/9] fixup! ARM: dts: sun8i-a33: bridgemate: Enable display
 support
Date: Fri,  8 Feb 2019 10:53:14 +0100
Message-Id: <7e571a7f2fc622f81f8be4a4d8725551490378b2.1549619502.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.23dbbc9b943ff8f36253ac7c617e2eda142b1b69.1549619502.git-series.maxime.ripard@bootlin.com>
References: <cover.23dbbc9b943ff8f36253ac7c617e2eda142b1b69.1549619502.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_015335_204557_4028D2E0 
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
Cc: bbrezillon@kernel.org, dri-devel@lists.freedesktop.org,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Jagan Teki <jagan@openedev.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

---
 arch/arm/boot/dts/sun8i-a33-bridgemate-bm3.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-a33-bridgemate-bm3.dts b/arch/arm/boot/dts/sun8i-a33-bridgemate-bm3.dts
index ea12d12bf221..c26316465dc0 100644
--- a/arch/arm/boot/dts/sun8i-a33-bridgemate-bm3.dts
+++ b/arch/arm/boot/dts/sun8i-a33-bridgemate-bm3.dts
@@ -106,7 +106,7 @@
 	status = "okay";
 
 	panel@0 {
-		compatible = "rondo,rb070d30";
+		compatible = "ronbo,rb070d30";
 		reg = <0>;
 		power-gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>;
 		updn-gpios = <&r_pio 0 7 GPIO_ACTIVE_HIGH>;
-- 
git-series 0.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
