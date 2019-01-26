Return-Path: <SRS0=wPy5=QC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C601C282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 14:30:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D117218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 14:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i1stfOYD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D117218B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qq5F5x6m43Sfyum3iIDfSnqLOcjV8y7lCqW+MFQ4Gtg=; b=i1stfOYDsWbYJB
	FUDq1oaVo+0ZcoySSmyDv4+7ROQZMhJmOSf8HmR9LkPhb8wr4Ec1FSQUWfswT0wY8pIoe5wsGe4ud
	jcVwHuWeP3vruQqzFD0FyZLJmOa9z+oUC+jP8z93vC61t9s6KzlfyhzK6o88ArnkPJUxEkCjFslvW
	Usfnd6hVkZHueBZ+G7000k0UZcKL6bp0vRT8RtGuLSwhYEav6/stx6jvMQwGSSAdFjLy+UltNb2rA
	aHB80Pnu2NaKfRhh3IlaBHV2UqRgC33xO2h9h07M+cYc94t+SxPkqcjgj78CfrcmcwZ4ycjsqFgzE
	2rmlkqkU16Z7rcD5OceQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnOyg-0003QL-4S; Sat, 26 Jan 2019 14:30:34 +0000
Received: from mleia.com ([178.79.152.223] helo=mail.mleia.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnOxc-0001Nh-WD
 for linux-arm-kernel@lists.infradead.org; Sat, 26 Jan 2019 14:29:31 +0000
Received: from mail.mleia.com (localhost [127.0.0.1])
 by mail.mleia.com (Postfix) with ESMTP id D561243DD9F;
 Sat, 26 Jan 2019 14:29:27 +0000 (GMT)
From: Vladimir Zapolskiy <vz@mleia.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 3/3] ARM: dts: lpc32xx: reparent keypad controller to SIC1
Date: Sat, 26 Jan 2019 16:29:21 +0200
Message-Id: <20190126142921.16041-4-vz@mleia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190126142921.16041-1-vz@mleia.com>
References: <20190126142921.16041-1-vz@mleia.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20190126_142927_892340_CFC0F91F 
X-CRM114-Status: GOOD (  12.24  )
/bin/ln: failed to access
 'reaver_cache/texts/20190126_142927_892340_CFC0F91F': No such file or
 directory
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190126_142927_892340_CFC0F91F 
X-CRM114-Status: GOOD (  10.19  )
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
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Sylvain Lemieux <slemieux.tyco@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

After switching to a new interrupt controller scheme by separating SIC1
and SIC2 from MIC interrupt controller just one SoC keypad controller
was not taken into account, fix it now:

  WARNING: CPU: 0 PID: 1 at kernel/irq/irqdomain.c:524 irq_domain_associate+0x50/0x1b0
  error: hwirq 0x36 is too large for interrupt-controller@40008000
  ...
  lpc32xx_keys 40050000.key: failed to get platform irq
  lpc32xx_keys: probe of 40050000.key failed with error -22

Fixes: 9b8ad3fb81ae ("ARM: dts: lpc32xx: reparent SIC1 and SIC2 interrupts from MIC")
Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/boot/dts/lpc32xx.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index d4368eeff1b9..4f8f671c3343 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -463,7 +463,8 @@
 				compatible = "nxp,lpc3220-key";
 				reg = <0x40050000 0x1000>;
 				clocks = <&clk LPC32XX_CLK_KEY>;
-				interrupts = <54 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-parent = <&sic1>;
+				interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
