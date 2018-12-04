Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670EFC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:17:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18FA62082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OOJVNPYw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18FA62082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jWAa+deu2W/dk2rCG3id1I9KgaOwU0qFx1aknPA5+mk=; b=OOJVNPYw+3VLP4
	hzrjFHtE7dMoPDkICW510ZszbL5nhiPj9HxfuQmYfHCgmbzddvTeqVOuTUJkvyHD/5YZ0AceQqrvg
	ftt2HZTt+8BKHVCdjnZHLIlaM15qcBhO24K9F/fz5gWO9r8jvdkdV7mEdo9UEXK4ney2o3HzHcD8C
	Tgh2hIWC0Vi87Kv5rhf/nSyumzaZbF0B3wRVkE2kFyMJ4UwaJXX55Owup5XTIzB5/wmMiP/ehGLB5
	MXUmaajv42qsRGLMsankMEBgjsfmwm5ZT8RFE3D3k5i3JqzzqjRjf7nxAPvf2e9A2/xYii1pIvtn9
	vp8a/DzEUFu6yFpIHbLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUBWA-0002QF-AI; Tue, 04 Dec 2018 14:17:42 +0000
Received: from skedge04.snt-world.com ([91.208.41.69])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUBU4-0000Li-Us; Tue, 04 Dec 2018 14:15:38 +0000
Received: from sntmail14r.snt-is.com (unknown [10.203.32.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by skedge04.snt-world.com (Postfix) with ESMTPS id EF1866798D3;
 Tue,  4 Dec 2018 15:15:25 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail14r.snt-is.com
 (10.203.32.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Tue, 4 Dec 2018
 15:15:25 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Tue, 4 Dec 2018 15:15:25 +0100
From: Schrempf Frieder <frieder.schrempf@kontron.de>
To: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v7 8/9] ARM64: dts: ls1046a: Remove fsl,qspi-has-second-chip
 as it is not used
Thread-Topic: [PATCH v7 8/9] ARM64: dts: ls1046a: Remove
 fsl,qspi-has-second-chip as it is not used
Thread-Index: AQHUi9vNhsWzRl0kbkGeXUxBfJrp3w==
Date: Tue, 4 Dec 2018 14:15:25 +0000
Message-ID: <1543932685-15011-9-git-send-email-frieder.schrempf@kontron.de>
References: <1543932685-15011-1-git-send-email-frieder.schrempf@kontron.de>
In-Reply-To: <1543932685-15011-1-git-send-email-frieder.schrempf@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: EF1866798D3.AF939
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: boris.brezillon@bootlin.com, broonie@kernel.org,
 computersforpeace@gmail.com, david.wolfe@nxp.com,
 devicetree@vger.kernel.org, dwmw2@infradead.org,
 fabio.estevam@nxp.com, han.xu@nxp.com, leoyang.li@nxp.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
 marek.vasut@gmail.com, mark.rutland@arm.com,
 miquel.raynal@bootlin.com, prabhakar.kushwaha@nxp.com,
 richard@nod.at, robh+dt@kernel.org, shawnguo@kernel.org,
 yogeshnarayan.gaur@nxp.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_061534_149669_D38692A0 
X-CRM114-Status: UNSURE (   9.54  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "yogeshnarayan.gaur@nxp.com" <yogeshnarayan.gaur@nxp.com>,
 Rob Herring <robh+dt@kernel.org>, "richard@nod.at" <richard@nod.at>,
 "prabhakar.kushwaha@nxp.com" <prabhakar.kushwaha@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Schrempf
 Frieder <frieder.schrempf@kontron.de>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
 "han.xu@nxp.com" <han.xu@nxp.com>, "broonie@kernel.org" <broonie@kernel.org>,
 "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
 "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
 "david.wolfe@nxp.com" <david.wolfe@nxp.com>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

After switching to the new FSL QSPI driver the property
'fsl,qspi-has-second-chip' is not needed anymore.

The driver now uses the 'reg' property to determine the bus and
the chipselect.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 51cbd50..9e083f6 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -213,7 +213,6 @@
 			clock-names = "qspi_en", "qspi";
 			clocks = <&clockgen 4 1>, <&clockgen 4 1>;
 			big-endian;
-			fsl,qspi-has-second-chip;
 			status = "disabled";
 		};
 
-- 
2.7.4

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
