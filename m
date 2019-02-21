Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B51DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:22:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6993E20838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KtWFhE49";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="P2fyB9GU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6993E20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dX6iBY7n31z6y/xRnzS5i69ViZ1svQEDUDNiVdox9A0=; b=KtWFhE49EVyykv
	q7RW7pfOQQ4L2cGFjOvn27U/go6jb/GIo5gRDfo3rfQ8UDLV7/e9zBA8j+JUbkU7Rad/pPQ5nDH8G
	45qx8/Yyh7e9mEiW19dEvgCoP4OgSlGOWIoRLMVQOMh1DBM0xNczZ4oISE75w3+uVxk4qMojglixm
	YNWgBwM8rSPXv5XdjtXVNP/cTO9k1FgMvtxpVmQgJ1NcUdcR/9r70dDtmDYsNMxGM8SLmwx4L4NsB
	SrTlqaWmYa8VNEGRQddWpfeGoGLGweXc8Ixh5cO/qYSUYUw1pOtf9AnW+3m4tE+YZLofQU04GImwa
	yQpU9OsOsl5xpaPzb4HA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwigS-0005yr-OH; Thu, 21 Feb 2019 07:22:16 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwigA-0005gc-Bf
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 07:22:00 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c6e519b0001>; Wed, 20 Feb 2019 23:22:03 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Wed, 20 Feb 2019 23:21:57 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Wed, 20 Feb 2019 23:21:57 -0800
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 21 Feb
 2019 07:21:57 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Feb 2019 07:21:57 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw01.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c6e51930002>; Wed, 20 Feb 2019 23:21:57 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas
 Gleixner <tglx@linutronix.de>
Subject: [PATCH V7 1/8] dt-bindings: timer: add Tegra210 timer
Date: Thu, 21 Feb 2019 15:21:43 +0800
Message-ID: <20190221072150.4395-2-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221072150.4395-1-josephl@nvidia.com>
References: <20190221072150.4395-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1550733724; bh=3lHJQTnyy/s1T3oQkkJrYUFvEa7JrbFiTtgfe8q74Rc=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=P2fyB9GUZ+FHwJARtxWATadNBEEvjkhlOp+MyHGzoUJfT+5cZXoALqTEZr2oYhX+V
 cznagakCaCykOAM+dFyNj186O9ZGGDMIBXig9YA8aHgwLZQNc5FqPenciGZkdzzSNF
 /l5n5BM2+J+a6ThdoybZroLuGOkfLib1FUSelp305eFaYQNVBXazwi/OvCust73vvx
 ueo8h+/7musLxmEoMdQx2dpHI5UCHay/LTmWKAUpPzrIZE7/ArutUds5xbT0Q5yRG2
 bcl9h+B3ZEejaCaQ3fUVs8Z7pnDKDNPRupszIritbSNFsVpIyQvvqeORdkcRQ9cXg8
 w0mCM14XolsGw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_232158_406399_3847E18E 
X-CRM114-Status: UNSURE (   8.86  )
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
Cc: devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 linux-kernel@vger.kernel.org, Joseph Lo <josephl@nvidia.com>,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The Tegra210 timer provides fourteen 29-bit timer counters and one 32-bit
timestamp counter. The TMRs run at either a fixed 1 MHz clock rate derived
from the oscillator clock (TMR0-TMR9) or directly at the oscillator clock
(TMR10-TMR13). Each TMR can be programmed to generate one-shot periodic,
or watchdog interrupts.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Joseph Lo <josephl@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
---
v7:
 * no change
v6:
 * add ack tag from Jon.
v5:
 * no change
v4:
 * no change
v3:
 * no change
v2:
 * list all the interrupts that are supported by tegra210 timers block
 * add RB tag from Rob.
---
 .../bindings/timer/nvidia,tegra210-timer.txt  | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt b/Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
new file mode 100644
index 000000000000..032cda96fe0d
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
@@ -0,0 +1,36 @@
+NVIDIA Tegra210 timer
+
+The Tegra210 timer provides fourteen 29-bit timer counters and one 32-bit
+timestamp counter. The TMRs run at either a fixed 1 MHz clock rate derived
+from the oscillator clock (TMR0-TMR9) or directly at the oscillator clock
+(TMR10-TMR13). Each TMR can be programmed to generate one-shot, periodic,
+or watchdog interrupts.
+
+Required properties:
+- compatible : "nvidia,tegra210-timer".
+- reg : Specifies base physical address and size of the registers.
+- interrupts : A list of 14 interrupts; one per each timer channels 0 through
+  13.
+- clocks : Must contain one entry, for the module clock.
+  See ../clocks/clock-bindings.txt for details.
+
+timer@60005000 {
+	compatible = "nvidia,tegra210-timer";
+	reg = <0x0 0x60005000 0x0 0x400>;
+	interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&tegra_car TEGRA210_CLK_TIMER>;
+	clock-names = "timer";
+};
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
