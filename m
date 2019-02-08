Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92F8C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:37:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82A1D21916
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cwr3e2Ub";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6Ub6F4y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A1D21916
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r/WiVKqWrvXKCIarATK3ZT7iIioVdlxnbvJCoLBR3kQ=; b=Cwr3e2UbGvasky
	SkspeAb7t0M2b12rbaWSUq0O4k3Xgo1UsoKZ6koQBcRyph/zrq0/5CXScK5Cg2kEzhDgH55/lTSTj
	OSSPssGyUaYSUpKNYnPcpN5tikuYd/5i0MaqhcYKNxlELJIHnDtgdID2wJ6S5IbpXfjAh44QLvzJ0
	X5DKL5B9vVENP0PQeRUbkW9FDm+W0ozcabpknas9n4NB8pZLsDoNgV0IP+1CxkH51cHfEPjm5Npp2
	1VzK9fnGIRvkSB9wURJGlXS92t4rM4iJj/GdQiQj/oUGRharMaf7el8hT1IZf2WViKECCOpLhHwTF
	PHFtvr1rLQ+5wvhRVmIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gruAW-00046g-5V; Fri, 08 Feb 2019 00:37:24 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gru3M-0007mG-Rk
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 00:30:02 +0000
Received: by mail-pf1-x444.google.com with SMTP id j3so798151pfi.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 16:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=c324b380hphqzikJSwYwP+iMI2K9W7f9e6HIiTYzB7k=;
 b=Y6Ub6F4ydFHhhs7fQk8IjFmLX17QPsmXIhljs3ttclwAAhAFQsFDD/d6UMXpXsJPCy
 dAh37W5bDhiIFaYTAz/2vjI3qRxono16pVaIsLmCuxZg0DKMmA6K7kPM717tq/pBgQo8
 V9hnUhl/7xR7tptVuJ1GkCnNJQVH1fAWzu1pwj6y3/DLV/uOu52wa9IqquGEMU/rmT+O
 DJBTEG7pGkvtbOxWsq7kCOHP7ZeXJ9c4d5GBela9ftO4TEyMsPeNSf2tcHhwVZVLTqch
 RLIbzu8VtWTGBBcPxOab6V/sQsfU5bfnAN47f4ANk7PIGTGHMXKBFiBnusj4FvuPlReJ
 goJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c324b380hphqzikJSwYwP+iMI2K9W7f9e6HIiTYzB7k=;
 b=jQs5D1nE2NMsJRf6HlYpduSblrqKWCmZ9jb2ohQIEGeWh2+1ttiQ/SX4PO079bWTfy
 bs/ECrY/iL8vbkGUdlPHLeOGQDzY/Nx+ymchIdMo00PlCyZ4owBS+YPjcv9+cHN5xCnV
 JG8p8EGtasnI0H6jhK+7Kfrju/2rrKm15pMsGYwzyATGRVhBJ7b7TA97imcwgv2hZcIG
 3q1NT3cR88HMD1s8SDKUIOEGKrmrTQB1xpxiYKiKzpacpt1aMI8cO6Pr6t3f48aJiqFB
 aZOiqkVeOaceW1MPk+iBdD5CtEoXnsR3VW3bYL4n84JB4gaJlPfGRxffzRj0ESCA04tN
 tHOg==
X-Gm-Message-State: AHQUAubg6r8r3mTvpYaho3za/cwRhF+y+c9OCFPEvxT4HwVVKbOFUYW6
 1P2+I8dsyugqjTT+V2lToEo=
X-Google-Smtp-Source: AHgI3Iatvplw1t39WpZ1FuDx8dLwVFh25jfkRAbg/cnaQUJj6AX/lmjxWW3/02r+d9pW3T/WZUgJyw==
X-Received: by 2002:a62:2f06:: with SMTP id v6mr19345960pfv.216.1549585800149; 
 Thu, 07 Feb 2019 16:30:00 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
 [24.22.235.96])
 by smtp.gmail.com with ESMTPSA id p81sm380835pfa.107.2019.02.07.16.29.58
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Feb 2019 16:29:59 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>
Subject: [RFC v2 3/5] arm64: dts: imx8mq: Combine PCIE power domains
Date: Thu,  7 Feb 2019 16:29:39 -0800
Message-Id: <20190208002941.30343-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208002941.30343-1-andrew.smirnov@gmail.com>
References: <20190208002941.30343-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_163000_894120_9467953F 
X-CRM114-Status: GOOD (  13.27  )
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
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-imx@nxp.com, Fabio Estevam <fabio.estevam@nxp.com>,
 Leonard Crestez <leonard.crestez@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Chris Healy <cphealy@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

According to NXP's FAE feedback and a comment in ATF firmware, PCIE1
and PCIE2 power domains can't really be used independently. Due to
shared reset line both power domains have to be turned on at the same
time. Account for that quirk by combining PCIE power domains into a
single 'pgc_pcie' power domain.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 50436bd393ed..89babc531380 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -273,9 +273,28 @@
 						reg = <IMX8M_POWER_DOMAIN_MIPI>;
 					};
 
-					pgc_pcie1: power-domain@1 {
+					/*
+					 * As per comment in ATF source code:
+					 *
+					 * PCIE1 and PCIE2 share the
+					 * same reset signal, if we
+					 * power down PCIE2, PCIE1
+					 * will be held in reset too.
+					 *
+					 * So instead of creating two
+					 * separate power domains for
+					 * PCIE1 and PCIE2. We create
+					 * a link between 1 and 10 and
+					 * use what was supposed to be
+					 * domain 1 as a shared PCIE
+					 * power domain powering both
+					 * PCIE1 and PCIE2 at the same
+					 * time
+					 */
+					pgc_pcie: power-domain@1 {
 						#power-domain-cells = <0>;
 						reg = <IMX8M_POWER_DOMAIN_PCIE1>;
+						power-domains = <&pgc_pcie2>;
 					};
 
 					pgc_otg1: power-domain@2 {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
