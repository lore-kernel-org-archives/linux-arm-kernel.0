Return-Path: <SRS0=d92h=OZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E38C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 09:42:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2442217FA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 09:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PcmT9mbL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2442217FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EuaNoWCZ0ZDIWxk3SS+bgwlbXmNkjY9vc9PIsmuEaWo=; b=PcmT9mbLC+zGui
	z/+scRAArceORM8hrjlzVGZD88QRPZCrF4WZm1xgklrJ3i2ftC6CgYhVa58o/G0+aA8T8LV824Jek
	4UqVGklt/A9aDXuhvpRu1MyLQw2YMAWWymi+wy4uzvvhyzqkRwAAj+2HYuVVXhGmsRzN+7dhE2gVk
	G8TwxC6vsTiK0ijrCJCYm1VjmEdt9Ac4ljSkE1tSK4qtQfMq4utezl1NRo5mQtwSrtJpLFpTJHsCT
	aM7ey6Ocoj9P1MI/t3N2Urs7ogRuUJFABjzWvLnjvTMH1xmoIZwXlxwVEs+Y5m/x+bWzulhrsznkb
	JLnfy/Wo9fyCuSgtxg2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYSwD-00062P-7y; Sun, 16 Dec 2018 09:42:17 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYSw9-0005zX-3H
 for linux-arm-kernel@lists.infradead.org; Sun, 16 Dec 2018 09:42:14 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id A530B20C94; Sun, 16 Dec 2018 10:42:01 +0100 (CET)
Received: from localhost (vfc69-4-88-175-133-2.fbx.proxad.net [88.175.133.2])
 by mail.bootlin.com (Postfix) with ESMTPSA id 647C3206FF;
 Sun, 16 Dec 2018 10:41:51 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Stephen Boyd <sboyd@codeaurora.org>,
 Mike Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/6] dt-bindings: ap806: add the cluster clock node in the
 syscon file
Date: Sun, 16 Dec 2018 10:41:42 +0100
Message-Id: <20181216094147.6468-2-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181216094147.6468-1-gregory.clement@bootlin.com>
References: <20181216094147.6468-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_014213_289092_AD9BD23A 
X-CRM114-Status: UNSURE (   9.64  )
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
Cc: devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
 Andrew Lunn <andrew@lunn.ch>, Antoine Tenart <antoine.tenart@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Document the device tree binding for the cluster clock controllers found
in the Armada 7K/8K SoCs.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 .../arm/marvell/ap806-system-controller.txt   | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
index 3fd21bb7cb37..8f281816a6b8 100644
--- a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
@@ -136,3 +136,25 @@ ap_syscon1: system-controller@6f8000 {
 		#thermal-sensor-cells = <1>;
 	};
 };
+
+Cluster clocks:
+---------------
+
+Device Tree Clock bindings for cluster clock of AP806 Marvell. Each
+cluster contain up to 2 CPUs running at the same frequency.
+
+Required properties:
+- compatible: must be  "marvell,ap806-cpu-clock";
+- #clock-cells : should be set to 1.
+- clocks : shall be the input parents clock phandle for the clock.
+
+ap_syscon1: system-controller@6f8000 {
+	compatible = "syscon", "simple-mfd";
+	reg = <0x6f8000 0x1000>;
+
+	cpu_clk: clock-cpu {
+		compatible = "marvell,ap806-cpu-clock";
+		clocks = <&ap_clk 0>, <&ap_clk 1>;
+		#clock-cells = <1>;
+	};
+};
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
