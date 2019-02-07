Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7ACC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 06:47:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A5B52175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 06:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bVuPQSMN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A5B52175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AWqv3MAX/rCEE7YYEIHg/yq4r/gBoWNpuZEUY8eYZ+k=; b=bVuPQSMNFpOXfU
	iglxK3kZ076hfqGb2/lj9QumTCJfLgDft78W9sMuWCjHuyA0dr0k4ukvKotOu4P1ZsRqFsbUrmTyT
	oWTm7ckyhxAXGgj0BoJDnurZ4BmFB61wsKsMzRAYbHyPmjr9nDidZnnaVLDv8l3gViB/TleFtCNK9
	8O1Ua9SDAj4mfrhmyRoFgUFsJcjfpWy+pfguZmPTyUbEB6NB8n2sGK+cHg/vTiWyUwJ0SXi1H5air
	y7+M+MIbYR1828E5s0p/hNVpTCVrOOa8a6GSjbuOf6UqiGU5Z7Xrj9RmwUEeqe1kjhdTca3oEqQi3
	BTBO0bN0YFmO5U/I1tOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grdTQ-0007p4-JQ; Thu, 07 Feb 2019 06:47:48 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grdRV-0005vD-SI
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 06:45:52 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id DE81B5FE33; Thu,  7 Feb 2019 14:45:39 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>
Subject: [RFT PATCH 9/9] ARM: dts: sun8i: a83t: Enable USB OTG controller on
 some boards
Date: Thu,  7 Feb 2019 14:45:35 +0800
Message-Id: <20190207064535.9226-10-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207064535.9226-1-wens@csie.org>
References: <20190207064535.9226-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_224550_267692_83EE3145 
X-CRM114-Status: UNSURE (   9.68  )
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
Cc: devicetree@vger.kernel.org, Quentin Schulz <quentin.schulz@bootlin.com>,
 linux-pm@vger.kernel.org, linux-sunxi@googlegroups.com,
 linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The Bananapi M3 and Cubietruck Plus both have USB OTG ports wired to the
SoC and PMIC in the same way, with the N_VBUSEN pin on the PMIC
controlling VBUS output, the PMIC's VBUS input for sensing VBUS, and
PH11 on the SoC for sensing the ID pin.

Enable OTG on both boards.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts     | 12 ++++++++++++
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts | 12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
index 838be7b3715f..9d34eabba121 100644
--- a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
@@ -389,7 +389,19 @@
 	};
 };
 
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usb_power_supply {
+	status = "okay";
+};
+
 &usbphy {
+	usb0_id_det-gpios = <&pio 7 11 GPIO_ACTIVE_HIGH>; /* PH11 */
+	usb0_vbus_power-supply = <&usb_power_supply>;
+	usb0_vbus-supply = <&reg_drivevbus>;
 	usb1_vbus-supply = <&reg_usb1_vbus>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts b/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
index fcbec3d7ccd7..ea299d3d84d0 100644
--- a/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
@@ -420,7 +420,19 @@
 	};
 };
 
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usb_power_supply {
+	status = "okay";
+};
+
 &usbphy {
+	usb0_id_det-gpios = <&pio 7 11 GPIO_ACTIVE_HIGH>; /* PH11 */
+	usb0_vbus_power-supply = <&usb_power_supply>;
+	usb0_vbus-supply = <&reg_drivevbus>;
 	usb1_vbus-supply = <&reg_usb1_vbus>;
 	usb2_vbus-supply = <&reg_usb2_vbus>;
 	status = "okay";
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
