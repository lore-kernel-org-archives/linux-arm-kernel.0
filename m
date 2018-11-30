Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0177DC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:56:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEF6720834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oobuG8WV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEF6720834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L+m1eAe48oh2SZVcFzGWUjirVXDKeYHneioeHFuDjxY=; b=oobuG8WVBK5Cq4
	iFvkWQaYoqpm/qZ/LjYXim6S73MR+hBBijwzxc7uHIEX3uwDTs//YxHaTgKHXxM1qPoUrcasItHm4
	PkP3tME8EW01B9DnMxhzb5wbSiVYyDLxGPv+WjN8MbZ+IUoDojM6pGzfeCt3CCwaQVTlnqQCDRX9b
	aLhXOJXxKdBX1CfwsyrX/Otqzh8wNDn2t4as6DrB/FeYe3kRpFh0jUPueQPujNp5MWJRsM433bGT4
	tgZRIIqWtnb+i6aUzkWdnx9i4DZMXPbF+TmqYL4sIc3q/3A+9n31uzVyBGrsDBXwTAmHRw1DiD2da
	O3VbZa+9uvQl1xouNi2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSn1Y-0003OO-Mf; Fri, 30 Nov 2018 17:56:20 +0000
Received: from mail.bugwerft.de ([46.23.86.59])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSn1K-0003EB-AF
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 17:56:07 +0000
Received: from localhost.localdomain (pD95EF9A6.dip0.t-ipconnect.de
 [217.94.249.166])
 by mail.bugwerft.de (Postfix) with ESMTPSA id 507302C459B;
 Fri, 30 Nov 2018 17:55:40 +0000 (UTC)
From: Daniel Mack <daniel@zonque.org>
To: robert.jarzmik@free.fr,
	haojian.zhuang@gmail.com
Subject: [PATCH 4/7] ARM: dts: pxa: merge &pxa3xx_ohci with &usb0
Date: Fri, 30 Nov 2018 18:55:40 +0100
Message-Id: <20181130175543.32628-5-daniel@zonque.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181130175543.32628-1-daniel@zonque.org>
References: <20181130175543.32628-1-daniel@zonque.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_095606_493528_3290A6AF 
X-CRM114-Status: GOOD (  10.51  )
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
Cc: devicetree@vger.kernel.org, robh+dt@kernel.org,
 Daniel Mack <daniel@zonque.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Both pxa3xx.dtsi and pxa2xx.dtsi define a node for the USB controller. Merge
them, and get rid of the one in pxa3xx.dtsi.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 arch/arm/boot/dts/pxa2xx.dtsi | 1 +
 arch/arm/boot/dts/pxa3xx.dtsi | 8 --------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/pxa2xx.dtsi b/arch/arm/boot/dts/pxa2xx.dtsi
index 30e77ebbcc4d..c00b1115f2a7 100644
--- a/arch/arm/boot/dts/pxa2xx.dtsi
+++ b/arch/arm/boot/dts/pxa2xx.dtsi
@@ -138,6 +138,7 @@
 			compatible = "marvell,pxa-ohci";
 			reg = <0x4c000000 0x10000>;
 			interrupts = <3>;
+			clocks = <&clks CLK_USBH>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/pxa3xx.dtsi b/arch/arm/boot/dts/pxa3xx.dtsi
index eb3223e85f9a..eb9443208578 100644
--- a/arch/arm/boot/dts/pxa3xx.dtsi
+++ b/arch/arm/boot/dts/pxa3xx.dtsi
@@ -202,14 +202,6 @@
 			status = "disabled";
 		};
 
-		pxa3xx_ohci: usb@4c000000 {
-			compatible = "marvell,pxa-ohci";
-			reg = <0x4c000000 0x10000>;
-			interrupts = <3>;
-			clocks = <&clks CLK_USBH>;
-			status = "disabled";
-		};
-
 		pwm0: pwm@40b00000 {
 			compatible = "marvell,pxa270-pwm";
 			reg = <0x40b00000 0x10>;
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
