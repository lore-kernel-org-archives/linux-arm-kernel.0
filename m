Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B863C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:42:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47C5020B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EU4Ppi2X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47C5020B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lPGYkJdVWbFrzh7T9o/0dJH6VYA0Rbpjd8BwQbUNGEA=; b=EU4Ppi2XSj2bZN
	e5XZC3T5Ojhaxf55bmgUfO/9tNcOUWCgXZ5USFygfCEGolBv2idw7Bgu9bk3SA24nxl0zuhgMIDaK
	v9T3mkCBtvyOh3yEXH42Xd1YBj3rbQf/iGX3LOPLOYk/ulnZSOjNrEYV1gg0K0KF3mShif9FQnOjN
	vh8CLcZD1P08bOunnxjTPC6ojW0Zvxuf/u8Ql3u0ix4voV/whaBVOLiO/o7ugF5QP8INMc90Cnrdj
	3cRj0n0DfJRZCpF5HBEuLK1NR3tDHlbhC3oOyoFwwj/rcIy3/YNLX2dDc6Vk/NPtIEPn4k8HVC/qf
	AZmLX0ZxYtbTLCGr116g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grT5e-0003vd-6k; Wed, 06 Feb 2019 19:42:34 +0000
Received: from relay2-d.mail.gandi.net ([217.70.183.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grT57-0003SV-Ay
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 19:42:04 +0000
X-Originating-IP: 90.89.68.76
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
 (Authenticated sender: maxime.ripard@bootlin.com)
 by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id B006D40006;
 Wed,  6 Feb 2019 19:41:54 +0000 (UTC)
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v2 2/7] dt-bindings: bus: Add binding for the Allwinner MBUS
 controller
Date: Wed,  6 Feb 2019 20:41:19 +0100
Message-Id: <e0b7321cd02716dc2ce1d0ec373ad81980e5be33.1549482066.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.ddd928eab0069d426b711e69940918eaf85625ce.1549482066.git-series.maxime.ripard@bootlin.com>
References: <cover.ddd928eab0069d426b711e69940918eaf85625ce.1549482066.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_114201_539140_C649F2A3 
X-CRM114-Status: GOOD (  12.21  )
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
Cc: devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org,
 Georgi Djakov <georgi.djakov@linaro.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Yong Deng <yong.deng@magewell.com>, Robin Murphy <robin.murphy@arm.com>,
 Dave Martin <dave.martin@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The MBUS controller drives the MBUS that other devices in the SoC will
use to perform DMA. It also has a register interface that allows to
monitor and control the bandwidth and priorities for masters on that
bus.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 Documentation/devicetree/bindings/arm/sunxi/sunxi-mbus.txt | 36 +++++++-
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/sunxi/sunxi-mbus.txt

diff --git a/Documentation/devicetree/bindings/arm/sunxi/sunxi-mbus.txt b/Documentation/devicetree/bindings/arm/sunxi/sunxi-mbus.txt
new file mode 100644
index 000000000000..bd4b90477610
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/sunxi/sunxi-mbus.txt
@@ -0,0 +1,36 @@
+Allwinner Memory Bus (MBUS) controller
+
+The MBUS controller drives the MBUS that other devices in the SoC will
+use to perform DMA. It also has a register interface that allows to
+monitor and control the bandwidth and priorities for masters on that
+bus.
+
+Required properties:
+ - compatible: Must be one of:
+	- allwinner,sun5i-a13-mbus
+ - reg: Offset and length of the register set for the controller
+ - clocks: phandle to the clock driving the controller
+ - dma-ranges: see booting-without-of.txt
+ - #interconnect-cells: Must be one, with the argument being the MBUS
+   port ID
+
+Each device having to perform their DMA through the MBUS must have the
+interconnects and interconnect-names properties set to the MBUS
+controller and with "dma" as the interconnect name.
+
+Example:
+
+mbus: dram-controller@1c01000 {
+	compatible = "allwinner,sun5i-a13-mbus";
+	reg = <0x01c01000 0x1000>;
+	clocks = <&ccu CLK_MBUS>;
+	dma-ranges = <0x00000000 0x40000000 0x20000000>;
+	#dma-parent-cells = <1>;
+};
+
+fe0: display-frontend@1e00000 {
+	compatible = "allwinner,sun5i-a13-display-frontend";
+	...
+	interconnects = <&mbus 19>;
+	interconnect-names = "dma";
+};
-- 
git-series 0.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
