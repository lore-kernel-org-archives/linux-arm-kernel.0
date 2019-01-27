Return-Path: <SRS0=mu0f=QD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4CCC282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 14:49:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A7B32147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 14:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TkMW3rGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A7B32147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hzXx5OdGjt6D9DVq6vHChmv1vwxzMwAvQs2jKM53ZVk=; b=TkMW3rGimdRBp7
	bDcsC43ZgqaRbXHGmgdTuVyiwI++BTd3q/CSkjnOAjEXSQ7XcP8vwPR7xNvh5FzLtxMdXedfRRWOI
	Mqs6Xzgt4NNPBqS0UmRl1vMYIS50vf8aUZ7zyizibt9/b9Us0JwPpj0RX/0rgfcGqcGZljsK9lNDU
	RHLLqk6s1tAfYJhm+1uAizXuR7K6p+aZVsCWJrTOaIF8UMj4sXOp/VeUltlYM2iqkVt880jdEdN3W
	CEVSlORlI2K3ETh5Qt5qYyA5SDeetjcFAehqVNMBoj0TLr5HaWZyWJ6w7ZEHjDkoZ7+ZoCStCpRzD
	EZhHBi2zwly2JqZL7VqA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnlkf-00017e-9C; Sun, 27 Jan 2019 14:49:37 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnljo-0000MY-8k
 for linux-arm-kernel@lists.infradead.org; Sun, 27 Jan 2019 14:48:46 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 69A8F5FD23; Sun, 27 Jan 2019 22:48:39 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 2/5] ARM: dts: sun5i: q8-tablet: Move panel properties to
 correct node level
Date: Sun, 27 Jan 2019 22:48:35 +0800
Message-Id: <20190127144838.3578-3-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190127144838.3578-1-wens@csie.org>
References: <20190127144838.3578-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190127_064844_435281_5C0AABAC 
X-CRM114-Status: GOOD (  11.32  )
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
Cc: devicetree@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The panel backlight and enable GPIO comments were incorrectly placed
in the input port, while it should have been in the panel node itself.

Move them to the correct position.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun5i-a13-q8-tablet.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a13-q8-tablet.dts b/arch/arm/boot/dts/sun5i-a13-q8-tablet.dts
index a89f29fa3e40..3a844dae26f7 100644
--- a/arch/arm/boot/dts/sun5i-a13-q8-tablet.dts
+++ b/arch/arm/boot/dts/sun5i-a13-q8-tablet.dts
@@ -50,13 +50,13 @@
 
 	panel: panel {
 		compatible = "urt,umsh-8596md-t", "simple-panel";
+		/* TODO: lcd panel uses axp gpio0 as enable pin */
+		backlight = <&backlight>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
 		port@0 {
 			reg = <0>;
-			/* TODO: lcd panel uses axp gpio0 as enable pin */
-			backlight = <&backlight>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
