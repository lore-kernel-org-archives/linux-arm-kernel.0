Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377D9C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:47:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0679A20878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZoxyF4Rh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0679A20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=96B1iQIXTWDesiHtjSIhm/KPYzrTXGHQGq8R6eFMzkg=; b=Zox
	yF4RhAHptFUaBJ95O5/VIA+eVzM/Cuntg5tARLEP6/T3Vkf2FnVLW5MjUX/CSz0ECVnKlI2YQsI2o
	nesPesOHxri69mkRw4LWNvoTMM0GhU/seXVOTbi+T1eEoEqq2m9AK/lIL4VwnkiFj98UasRO7+meP
	Sii1hgA/oNNMZKxVmvQKw1UNNiusb3zSWIgzazvSPWFIlLklRREuBOmw1cukQRT9+tqWyPPR99WSL
	5GQNiV8+kCPp9RpU9VxRS9AUqNrwLHBqYI9sPQYn2/tSHf6iie/DIZtKLoBxlyY8Lzp9JWMETGX03
	miE5adDJzWLjRnXGdLMuBFTnCBQTk3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUA6t-0005Ej-0x; Tue, 04 Dec 2018 12:47:31 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUA6c-0004qi-Rs; Tue, 04 Dec 2018 12:47:16 +0000
Received: from we0660.dip.tu-dresden.de ([141.76.178.148]
 helo=phil.dip.tu-dresden.de)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gUA6O-0000ku-Uf; Tue, 04 Dec 2018 13:47:00 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org
Subject: [PATCH 1/2] arm64: dts: rockchip: use correct pinctrl for syr82x on
 rk3399 firefly
Date: Tue,  4 Dec 2018 13:46:52 +0100
Message-Id: <20181204124653.3872-1-heiko@sntech.de>
X-Mailer: git-send-email 2.18.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_044715_074831_37987014 
X-CRM114-Status: GOOD (  12.09  )
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
Cc: Heiko Stuebner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On the firefly the vsel pins of the syr82x regulators are connected to
soc gpios, making them software controllable.
Right now the pins do not get configured at all, so cpu_b_sleep_h is
configured as input with a pull up while the gpu_sleep_h has a pull-down.

In contrast the pin names indicate both should be high in their sleep
state and low in normal operation and the fcs,suspend-voltage-selector
does mirror this setting, so enable the already existing pinctrl
entries for them and also fix their naming to match the schematics.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
index aaa485dbe081..ea63477ca9fe 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
@@ -456,6 +456,8 @@
 		compatible = "silergy,syr827";
 		reg = <0x40>;
 		fcs,suspend-voltage-selector = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&cpu_b_sleep_h>;
 		regulator-name = "vdd_cpu_b";
 		regulator-min-microvolt = <712500>;
 		regulator-max-microvolt = <1500000>;
@@ -473,6 +475,8 @@
 		compatible = "silergy,syr828";
 		reg = <0x41>;
 		fcs,suspend-voltage-selector = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpu_sleep_h>;
 		regulator-name = "vdd_gpu";
 		regulator-min-microvolt = <712500>;
 		regulator-max-microvolt = <1500000>;
@@ -589,11 +593,11 @@
 	};
 
 	pmic {
-		vsel1_gpio: vsel1-gpio {
+		cpu_b_sleep_h: cpu-b-sleep-h {
 			rockchip,pins = <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_down>;
 		};
 
-		vsel2_gpio: vsel2-gpio {
+		gpu_sleep_h: gpu-sleep-h {
 			rockchip,pins = <1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_down>;
 		};
 	};
-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
