Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6C2C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:22:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FDBF20863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AMQLx+Su";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="de84Maij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FDBF20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=npQKUarV7i4VC/PCJdBJ4tWn/dUzzDRzjOmkfPIbnCs=; b=AMQLx+SuSH2lLQJJ4LCjHvCCa/
	VRDqntTOuH+z4xpdjsY6W32qWSOh01gxifTV13GZwNPs+5K+Y72Vw2K9mIZTnRQjgPsFTcsX9SmzK
	o/aJIQr01i9Zb295QfDpAs1lpEDfTtFjnUvMeCEU8ehqZ72yWrSfz/KauYKdWdlDZMJwcyPN9cxmq
	tXcANDSHHVRwzLBYXIafe1nWMmjZVrrCCrZv7lYFcIHm/1+G82oBfQ/PopqGlFheFlHb/6he+WZdi
	NEMQGXxItx7lL6ixyIMXTc3Wo0k0XcDpT/vLf0NscBYlSN87QpKVgd2xJ/HeQ9RowaqlSKHtdSRQ9
	vQw3snLA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs4EL-0000tr-91; Fri, 08 Feb 2019 11:22:01 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs4E1-0005IB-Uk
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 11:21:56 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 465F725BEF9;
 Fri,  8 Feb 2019 22:14:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1549624457; bh=8BA8EOdDVypovmE5tSCxI/WFVLCpOk/6ZVenc4SVb5I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=de84Maiji0PMCRwXlbvJFrBai6W1YUNJgg1RCrK3V9KBVeeL71A4gkVFxqWZ+RjQ1
 m+Gnjw7ixOmVQMa1m6kjz/+474BP7hlUzoL+tgh6AXymLd2UVTHi8+NIc2/Fc5q4Kz
 hnJmdojQYSSIaJ8FU6NOeqJu8NuE8ov1ApBWdG7o=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 938879406FE; Fri,  8 Feb 2019 12:14:15 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 05/12] ARM: dts: r8a7743: Remove aliases from SoC dtsi
Date: Fri,  8 Feb 2019 12:14:06 +0100
Message-Id: <aeefe7394ca9a77b264963beaba01b4e85a9142c.1549623128.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1549623128.git.horms+renesas@verge.net.au>
References: <cover.1549623128.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_032142_305315_764A5582 
X-CRM114-Status: UNSURE (   8.45  )
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
Cc: Simon Horman <horms+renesas@verge.net.au>,
 Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org,
 Biju Das <biju.das@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

This patch removes aliases from SoC dtsi tree. Device aliases are
board-specific, if needed define it in board dts rather than SoC
dtsi.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7743.dtsi | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 169fddc33229..19e96e2e2e55 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -15,25 +15,6 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	aliases {
-		i2c0 = &i2c0;
-		i2c1 = &i2c1;
-		i2c2 = &i2c2;
-		i2c3 = &i2c3;
-		i2c4 = &i2c4;
-		i2c5 = &i2c5;
-		i2c6 = &iic0;
-		i2c7 = &iic1;
-		i2c8 = &iic3;
-		spi0 = &qspi;
-		spi1 = &msiof0;
-		spi2 = &msiof1;
-		spi3 = &msiof2;
-		vin0 = &vin0;
-		vin1 = &vin1;
-		vin2 = &vin2;
-	};
-
 	/*
 	 * The external audio clocks are configured as 0 Hz fixed frequency
 	 * clocks by default.
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
