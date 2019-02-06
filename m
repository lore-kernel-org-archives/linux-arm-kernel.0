Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148C5C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:33:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D59B02184E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pD5/yf4b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D59B02184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LGYmNjoPgm/hOJJyLD8v+Wfzyngo2KV+HRanpyaMgiw=; b=pD5/yf4bnwe1us
	dlkl1NrhkvYWdWhcnar28nlwnXAz8oWQ4ffcz93bh6g7eycWnJZsJlxlvTHiW1a7VoKmrCCQGjPlu
	NySnGxD3Vr4Adkojjw9Vqt+fCmAcZCSPJX4Kh04TY5ZgGZhbG4BqPu1L7BGhiGHzM/5Y5kuWosVBJ
	RMWN1F9PwStKQky5kXhd+/sq4GcVY95dFxI6r0vrsydxNovPlo7aHFjC4h9kKRpoELokHDDy+8CUl
	fJPAGNSN+P6Rqy2wcoTOaaczjlfvb4WtAbWPEEgfnd122+xRnZC3bkt9OvY9kZGpbQg+QUh6UcDA8
	ZQ1ZQASlPsmMrTJ7Pykg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grDxg-0003HJ-ST; Wed, 06 Feb 2019 03:33:20 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grDxA-0002nt-53
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 03:32:51 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 9EF415FD4D; Wed,  6 Feb 2019 11:32:43 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/9] ARM: dts: sun9i: a80-optimus: Add node for AXP809's
 unused dc1sw regulator
Date: Wed,  6 Feb 2019 11:32:32 +0800
Message-Id: <20190206033239.3619-3-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206033239.3619-1-wens@csie.org>
References: <20190206033239.3619-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_193248_438181_9AA9C4FA 
X-CRM114-Status: UNSURE (   8.37  )
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
Cc: devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The DC1SW output from the AXP809 is unused. Unused regulators should
still be listed so as to be considered to be fully constrained.

Fixes: aa4a27bc819e ("ARM: dts: sun9i: a80-optimus: Add AXP809 PMIC
		      device node and regulators")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80-optimus.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index 58a199b0e494..1ee2792b3a27 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -213,6 +213,10 @@
 				regulator-name = "vdd-cpus-09-usbh";
 			};
 
+			dc1sw {
+				/* unused */
+			};
+
 			reg_dcdc1: dcdc1 {
 				regulator-always-on;
 				regulator-min-microvolt = <3000000>;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
