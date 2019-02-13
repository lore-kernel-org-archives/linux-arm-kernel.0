Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD25C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:09:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE5F32075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QrQ4c2M4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5F32075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZL7kfpnZkisvzvjdrj+AfZ2K45Qx8j6/eLRxikBz4ZY=; b=QrQ4c2M4Teelfz
	3iaH9j1KjNurRG7vNGRsgaW7aWzXTYWQEqQIjIORGwQfy0/PiyTkD5akjK4x4xHZwZG5ektMNfDx0
	1SBjpO4qXq36QdFtIlhma/4hS+zjMGvy+zkb7hkMld1vg1CgRQ9ozTih6nA6yrjWeR8vN0H42yzDL
	FYhK1KvIxw2QBeevDml6S8trRjFX+f1flGvRavKh97xiQ76PyIQS8ALr7nbYRA+NCYyQmzwhIr7Vg
	+G26YzbiE05IKq6YEcz/JjgE2ZNgIslmMZVNMOKCtuLIBvThMU5O6y4KbIC0BvHAS+I/w3mz+KPxJ
	k7cxTJ1GG2M140GkDtEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gty2W-000083-SQ; Wed, 13 Feb 2019 17:09:40 +0000
Received: from relay1.mentorg.com ([192.94.38.131])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gty2G-0008JM-7o; Wed, 13 Feb 2019 17:09:39 +0000
Received: from nat-ies.mentorg.com ([192.94.31.2]
 helo=SVR-IES-MBX-04.mgc.mentorg.com)
 by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
 id 1gty2F-00048H-1j from Akash_Gajjar@mentor.com ;
 Wed, 13 Feb 2019 09:09:23 -0800
Received: from eyas.local (137.202.0.90) by SVR-IES-MBX-04.mgc.mentorg.com
 (139.181.222.4) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Wed, 13 Feb
 2019 17:09:16 +0000
From: Akash Gajjar <Akash_Gajjar@mentor.com>
To: <heiko@sntech.de>
Subject: [PATCH 3/4] arm64: dts: rockchip: rockpro64 dts rename LED labels and
 default trigger
Date: Wed, 13 Feb 2019 22:36:39 +0530
Message-ID: <20190213170651.3210-4-Akash_Gajjar@mentor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213170651.3210-1-Akash_Gajjar@mentor.com>
References: <20190213170651.3210-1-Akash_Gajjar@mentor.com>
MIME-Version: 1.0
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_090925_582832_BBCA9D4A 
X-CRM114-Status: GOOD (  15.19  )
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
 Shohei Maruyama <cheat.sc.linux@outlook.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Rob Herring <robh+dt@kernel.org>, Oskari Lemmela <oskari@lemmela.net>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Levin Du <djw@t-chip.com.cn>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

rename white and red LEDs with status and heartbeat respectively.
replace red LED default state off with default-trigger heartbeat.

Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>
---
 .../arm64/boot/dts/rockchip/rk3399-rockpro64.dts | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
index c9a2b26d7cad..dab53d2eb676 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
@@ -43,17 +43,17 @@
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
-		pinctrl-0 = <&work_led_gpio>, <&diy_led_gpio>;
+		pinctrl-0 = <&status_led_gpio>, <&heartbeat_led_gpio>;
 
-		work-led {
-			label = "work";
+		status-led {
+			label = "rockpro64:white:status";
 			default-state = "on";
 			gpios = <&gpio0 RK_PB3 GPIO_ACTIVE_HIGH>;
 		};
 
-		diy-led {
-			label = "diy";
-			default-state = "off";
+		heartbeat-led {
+			label = "rockpor64:red:heartbeat";
+			linux,default-trigger = "heartbeat";
 			gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
 		};
 	};
@@ -502,11 +502,11 @@
 	};
 
 	leds {
-		work_led_gpio: work_led-gpio {
+		status_led_gpio: status-led-gpio {
 			rockchip,pins = <0 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 
-		diy_led_gpio: diy_led-gpio {
+		heartbeat_led_gpio: heartbeat-led-gpio {
 			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
