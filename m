Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3CAC282DB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:36:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D36520663
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p9VwVOxz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D36520663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=b5ZYKMQrmiQLy5b23jnd9H5dsQCHewn/Kg9nxkT5RGs=; b=p9V
	wVOxzGK29+15AX6F1bQizrFldxopHDCXpTeF8aSjDXth8kjvzs4OC7dReoVsHg+zD1WbSX/vy0YpF
	+8OZAIZ+8jIeTPqwK+5l7JG18xNqiSvNuCTxeQoCMQ8+IBZqlEm2QeXSxPR3vkJImj/EdWq343ZFF
	7/ve/nhASuosvPGp8ZZ9ICd9h1PnJ5FCTKAC4BztOGWLoZH2zEZ6/7LeLIIKI1Ft4zAeP5KCtwoFh
	t0QOdYxed3DPQblMWAVUdgRi/UskjBwBFrPgwxe20YN/1WX6fGgG3oQyihPgAu7/oXEqceygZxE/0
	ngMYRIf3105M4MhNxnMUlNMBAZWVeMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glWvz-0003fd-Mx; Mon, 21 Jan 2019 10:36:03 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glWvp-0003Vt-6T
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 10:35:57 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8448AEBD;
 Mon, 21 Jan 2019 02:35:52 -0800 (PST)
Received: from login2.euhpc.arm.com (login2.euhpc.arm.com [10.6.27.34])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D5A153F5C1;
 Mon, 21 Jan 2019 02:35:51 -0800 (PST)
From: Vladimir Murzin <vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: dts: mps2: use list instead of tuple for uart interrupts
Date: Mon, 21 Jan 2019 10:35:39 +0000
Message-Id: <1548066939-20880-1-git-send-email-vladimir.murzin@arm.com>
X-Mailer: git-send-email 2.0.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_023553_838236_714F5071 
X-CRM114-Status: GOOD (  11.38  )
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
Cc: sudeep.holla@arm.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

MPS2 UART requires dedicated interrupts for RX, TX and overflow, which
obviously should be expressed as a list. Current form uses tuple and
it has worked so far because NVIC has interrupt-cells equal to 1.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/boot/dts/mps2.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/mps2.dtsi b/arch/arm/boot/dts/mps2.dtsi
index 2346739..6f20e42 100644
--- a/arch/arm/boot/dts/mps2.dtsi
+++ b/arch/arm/boot/dts/mps2.dtsi
@@ -171,7 +171,7 @@
 			uart0: serial@4000 {
 				compatible = "arm,mps2-uart";
 				reg = <0x4000 0x1000>;
-				interrupts = <0 1 12>;
+				interrupts = <0>,<1>,<12>;
 				clocks = <&sysclk>;
 				status = "disabled";
 			};
@@ -179,7 +179,7 @@
 			uart1: serial@5000 {
 				compatible = "arm,mps2-uart";
 				reg = <0x5000 0x1000>;
-				interrupts = <2 3 12>;
+				interrupts = <2>,<3>,<12>;
 				clocks = <&sysclk>;
 				status = "disabled";
 			};
@@ -187,7 +187,7 @@
 			uart2: serial@6000 {
 				compatible = "arm,mps2-uart";
 				reg = <0x6000 0x1000>;
-				interrupts = <4 5 12>;
+				interrupts = <4>,<5>,<12>;
 				clocks = <&sysclk>;
 				status = "disabled";
 			};
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
