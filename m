Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51B8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:06:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67FCD20656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U27s85Ed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67FCD20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q6Ms3FAW5Uz4UhTXxdcYsnbJlr+stnA8CLIfIz9jD8U=; b=U27s85Edzh39yM
	2XiVy2xWobL5Goh7eLEEcfn0+OuqAh4WL82tjv4gQJi9tr1L5/O1VvuuzN42ziHpjwX054rBOKIDz
	0U9M4DhDHuAQ6uFrkCP25bAkO5nJPYbtAbR+x9mTxfFJqu/0WL5KKFII0jIoGEO2pKWi4AEEsVRs7
	rC9xJ6GazCsJye3VPnvomZXp8+gGqBAXgkn7iYcb8Y0Rd4hBb6QC/PeSjdcRqmdewwRap+RMUFM1T
	np0qraoRu2IP2vaoDJz0HzPyhKPh3wNqA/XgMj4lDqDkplcW9w3aQB+NMul3h5E8Bl7RkxC0MkCSJ
	rAa+O6CXDeN7kP9BtaRw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj112-0007ng-CZ; Mon, 14 Jan 2019 12:06:52 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj103-0006lG-Mn; Mon, 14 Jan 2019 12:05:57 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D33D15BF;
 Mon, 14 Jan 2019 04:05:51 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com
 [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9173A3F5BD;
 Mon, 14 Jan 2019 04:05:50 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: heiko@sntech.de
Subject: [PATCH v2 4/4] arm64: dts: rockchip: 'Fix' nanopi4 uSD card detect
Date: Mon, 14 Jan 2019 12:05:34 +0000
Message-Id: <0608599d485117a9d99f5fb274fbb1b55f6ba9f7.1547466003.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.20.1.dirty
In-Reply-To: <cover.1547466003.git.robin.murphy@arm.com>
References: <cover.1547466003.git.robin.murphy@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_040552_165345_03A07C53 
X-CRM114-Status: GOOD (  17.17  )
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
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

For whatever reason, the sdmmc_dectn function isn't working properly
as-is, and microSD insertion and removal goes unnoticed. Using the pin
as a GPIO interrupt instead is rather noisy without any debouncing, but
is good enough to make it useful until someone feels inclined to figure
out how the vendor kernel/firmware gets the dedicated function to work
with no obvious difference in the pinmux/GRF configuration. Let's also
take the opportunity to tweak the node name so that all related pins
end up grouped together in the compiled DTB.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Clean up ordering

 .../boot/dts/rockchip/rk3399-nanopi4.dtsi     | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
index 9c723038d8f8..2d304d2df62e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
@@ -501,17 +501,21 @@
 		};
 	};
 
-	sd {
-		sdmmc0_pwr_h: sdmmc0-pwr-h {
-			rockchip,pins = <0 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
 	sdio-pwrseq {
 		wifi_reg_on_h: wifi-reg_on-h {
 			rockchip,pins = <0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
+
+	sdmmc {
+		sdmmc0_det_l: sdmmc0-det-l {
+			rockchip,pins = <0 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		sdmmc0_pwr_h: sdmmc0-pwr-h {
+			rockchip,pins = <0 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
 };
 
 &pmu_io_domains {
@@ -563,9 +567,10 @@
 	bus-width = <4>;
 	cap-sd-highspeed;
 	cap-mmc-highspeed;
+	cd-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
 	disable-wp;
 	pinctrl-names = "default";
-	pinctrl-0 = <&sdmmc_bus4 &sdmmc_cd &sdmmc_clk &sdmmc_cmd>;
+	pinctrl-0 = <&sdmmc_bus4 &sdmmc_clk &sdmmc_cmd &sdmmc0_det_l>;
 	sd-uhs-sdr104;
 	vmmc-supply = <&vcc3v0_sd>;
 	vqmmc-supply = <&vcc_sdio>;
-- 
2.20.1.dirty


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
