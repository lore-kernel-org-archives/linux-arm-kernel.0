Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A74C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:58:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C761218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ckRpWg9i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C761218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h7lRUiorRAEfSErS3yblole0T3dIjnwNS/QaYSCi5Do=; b=ckRpWg9iPMfDtR
	JojhH8aMsUwOEsTGcFhITjzJ+zP/EVoLbTPmnWQcYex59M+abA65K3bpTzngiS+cFPhKqwq+FRFZP
	vPP+BoFaqNKfEMgx/fUITWf3TSFNF43yJnE8z/sK9t4MrhDDnbREuMPhxAF2sofMqMG9SI7BNtPdg
	hwaYkcoFyRYEKRjMtyHKPQx3k+MTxx/+TIaJohaTU8eAauKjDXHGJ71eZCkzFa1lMsq1Pibly65qb
	fkZqQdrZQErzWIGr5Ej5/SQ7t2KWWICjNMPjvEot1uE40HuHIDo/P0rkr0cJGzfdR1KIxn2gk3/uB
	WcYvgHWMUUmTFCo5WKbg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmyFK-00021K-5y; Fri, 25 Jan 2019 09:57:58 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmyFF-0001za-Sh
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 09:57:55 +0000
Received: from [2001:67c:670:c0a8:d4b8:1dff:fe64:e144] (helo=unicorn)
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <str@pengutronix.de>)
 id 1gmyFC-0004Iu-Nu; Fri, 25 Jan 2019 10:57:50 +0100
Received: from str by unicorn with local (Exim 4.89)
 (envelope-from <str@pengutronix.de>)
 id 1gmyFC-0008JU-FB; Fri, 25 Jan 2019 10:57:50 +0100
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
To: Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH RESEND v2 2/2] ARM: dts: socfpga: Add fpga2hps and fpga2sdram
 bridges
Date: Fri, 25 Jan 2019 10:57:40 +0100
Message-Id: <20190125095740.31889-2-s.trumtrar@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125095740.31889-1-s.trumtrar@pengutronix.de>
References: <20190125095740.31889-1-s.trumtrar@pengutronix.de>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:c0a8:d4b8:1dff:fe64:e144
X-SA-Exim-Mail-From: str@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_015754_076850_D698A917 
X-CRM114-Status: UNSURE (   9.53  )
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
Cc: kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add the remaining two bridges on the Cyclone-V SoCFPGA SoCs.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/socfpga.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index f53d9dd05d28..d0cdc331f125 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -538,6 +538,20 @@
 			status = "disabled";
 		};
 
+		fpga_bridge2: fpga-bridge@ff600000 {
+			compatible = "altr,socfpga-fpga2hps-bridge";
+			reg = <0xff600000 0x100000>;
+			resets = <&rst FPGA2HPS_RESET>;
+			clocks = <&l4_main_clk>;
+			status = "disabled";
+		};
+
+		fpga_bridge3: fpga-bridge@ffc25080 {
+			compatible = "altr,socfpga-fpga2sdram-bridge";
+			reg = <0xffc25080 0x4>;
+			status = "disabled";
+		};
+
 		fpgamgr0: fpgamgr@ff706000 {
 			compatible = "altr,socfpga-fpga-mgr";
 			reg = <0xff706000 0x1000
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
