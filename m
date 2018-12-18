Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CA2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:26:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A5AA21871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dDRumo30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A5AA21871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tweak.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=84+vZEGGe4rF0Ilp7/lCrzqDoO0JReo52UVVH1GjC3I=; b=dDR
	umo309Ak3XRwYU8OF7mqO7g6AyEHkotDDE1D6CnIIcHK3i/NBZdZzkx/ZwzUZL1sbEBVwOTivE+Dl
	dVMkTjqbCccsObDnEseOr4O0EPcIjAZu1SagUzPkc2kvKObom2M6S/3Rzx8iyqpUto+O5wWG57+Mb
	KDx5PyUIl1DeIwH6Cbv6PuJRBNq9EHBaXmCZBThAcC+RCIod5cGjCYzlDCxjAk56IQGRPHgj+I9og
	hO05JUaOQmflZ1E+jWOpaTSTXYytNkHSxrdxhHHWkdkaW/q3qc+PfIaitw4YkchAi9OPMgHIXoL3h
	bsfm1Rau+5OwbSoO3gCCc6UE1Ly4ReA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZMsz-0008NO-Uv; Tue, 18 Dec 2018 21:26:41 +0000
Received: from palmtree.beeroclock.net ([2a01:7e00::f03c:91ff:fe93:f66c])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZMsw-0008LR-2Q
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 21:26:39 +0000
Received: from beros.lan (89-160-129-47.du.xdsl.is [89.160.129.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: karlp)
 by palmtree.beeroclock.net (Postfix) with ESMTPSA id 41B4910279;
 Tue, 18 Dec 2018 21:25:36 +0000 (UTC)
From: Karl Palsson <karlp@tweak.net.au>
To: robh+dt@kernel.org, mark.rutland@arm.com, maxime.ripard@bootlin.com,
 wens@csie.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] ARM: dts: sunxi: h3/h5: add missing uart2 rts/cts pins
Date: Tue, 18 Dec 2018 21:24:55 +0000
Message-Id: <20181218212457.30382-1-karlp@tweak.net.au>
X-Mailer: git-send-email 2.14.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_132638_240729_2BB9CCF2 
X-CRM114-Status: UNSURE (   8.64  )
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
Cc: Karl Palsson <karlp@tweak.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

uart1 and uart3 had existing pin definitions for the rts/cts pairs.
Add definitions for uart2 as well.

Signed-off-by: Karl Palsson <karlp@tweak.net.au>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index a4c757c0b741..38d3deefa0e3 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -472,6 +472,11 @@
 				function = "uart2";
 			};
 
+			uart2_rts_cts_pins: uart2_rts_cts {
+				pins = "PA2", "PA3";
+				function = "uart2";
+			};
+
 			uart3_pins: uart3 {
 				pins = "PA13", "PA14";
 				function = "uart3";
-- 
2.14.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
