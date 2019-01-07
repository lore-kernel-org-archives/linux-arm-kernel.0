Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95928C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:24:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 665CC21736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OAq51Rt/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="oiDyAptw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 665CC21736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PNABE0FF9cVyKF7/dHgzHBxOq5c+QwC9TLJHgOKiu1g=; b=OAq51Rt/Bi4bKW
	FdIFTQqQVpDkFIFOHqGQ/rvrRdI9dLYiNHfWqAFhR94W567gPqvL0eJf+aEecndri67OrFRHsv7rq
	chyABNmhJLZxL+a2D8VbzEBv4LkXJWmn4mfClBAq/1qBEFFAvkjgg7xRlQaQjAv9M66Ess4+SCs4D
	E+FkFkfStPFogpfOecQ6QmvckjH5ROOPiT2q1dZcdKrTHaiNvylmAGKn7Gsd/6WkNuMpgOjC35j+e
	qZoJwow5fWVeLC0OXrFd5sUZHh0XgJglTqmwzft1KSVYRykJnPhonGQIJw6HgI98tjl9qTxjyr8NU
	8oDkFRxyC3V76E04SzTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggUtA-00073Z-U2; Mon, 07 Jan 2019 13:24:20 +0000
Received: from mail.kmu-office.ch ([2a02:418:6a02::a2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggUsx-0006sO-1L
 for linux-arm-kernel@lists.infradead.org; Mon, 07 Jan 2019 13:24:08 +0000
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
 by mail.kmu-office.ch (Postfix) with ESMTPSA id 6596A5C11D1;
 Mon,  7 Jan 2019 14:24:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
 t=1546867443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T9kSgtB+6bwBO2+ezniVgU9XTsFZAzPwnM/wMIv4bq4=;
 b=oiDyAptwamZ1YjIWD/fLsgaE+c4v+xHxd5ELkI5OO4KHcd7Zs4ia4b8mOZyiMPX0BFPH5O
 ha1W5XZYSq4wsW9kN3AfNkmz1mxM6dnr6rKCLZ/uF7NGs3V6U+YAiGvrO7To1e1g3Rcg4v
 r5QojwcXkGrWpvebHUX2P9dIrzBmuGI=
From: Stefan Agner <stefan@agner.ch>
To: shawnguo@kernel.org,
	s.hauer@pengutronix.de
Subject: [PATCH 2/2] ARM: dts: imx7: add DMA properties for ECSPI
Date: Mon,  7 Jan 2019 14:22:26 +0100
Message-Id: <20190107132226.16216-2-stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107132226.16216-1-stefan@agner.ch>
References: <20190107132226.16216-1-stefan@agner.ch>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190107_052407_373111_D90BB207 
X-CRM114-Status: GOOD (  12.40  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
 robh+dt@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
 fabio.estevam@nxp.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Allow to use DMA for SPI by adding the appropriate DMA properites
to the ecspi nodes.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx7s.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index a052198f6e96..b9330176c3af 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -653,6 +653,8 @@
 				clocks = <&clks IMX7D_ECSPI4_ROOT_CLK>,
 					<&clks IMX7D_ECSPI4_ROOT_CLK>;
 				clock-names = "ipg", "per";
+				dmas = <&sdma 6 7 1>, <&sdma 7 7 2>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -734,6 +736,8 @@
 					clocks = <&clks IMX7D_ECSPI1_ROOT_CLK>,
 						<&clks IMX7D_ECSPI1_ROOT_CLK>;
 					clock-names = "ipg", "per";
+					dmas = <&sdma 0 7 1>, <&sdma 1 7 2>;
+					dma-names = "rx", "tx";
 					status = "disabled";
 				};
 
@@ -746,6 +750,8 @@
 					clocks = <&clks IMX7D_ECSPI2_ROOT_CLK>,
 						<&clks IMX7D_ECSPI2_ROOT_CLK>;
 					clock-names = "ipg", "per";
+					dmas = <&sdma 2 7 1>, <&sdma 3 7 2>;
+					dma-names = "rx", "tx";
 					status = "disabled";
 				};
 
@@ -758,6 +764,8 @@
 					clocks = <&clks IMX7D_ECSPI3_ROOT_CLK>,
 						<&clks IMX7D_ECSPI3_ROOT_CLK>;
 					clock-names = "ipg", "per";
+					dmas = <&sdma 4 7 1>, <&sdma 5 7 2>;
+					dma-names = "rx", "tx";
 					status = "disabled";
 				};
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
