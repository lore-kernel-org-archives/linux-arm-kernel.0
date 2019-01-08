Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D88C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:59:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF2DC218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A2pNaEmU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2DC218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=3Alnm5uXB5cJ3l9Tp00hDhvfA041hsQKDhwszPqg42g=; b=A2pNaEmUFLqzKBFi6n264KgExC
	LOsh1cVk+Y7dlN5DNp9a0xWxpwpCZauzzwwj/WdKz0Eh0xHy+xmvgUw5XbpqN12OG7Lxs8nuUf8PD
	G4zp42sRJrTkxc5uT+jPWlRMudLKdrDXs6FGfqGlaHLDv4KJSNZDCmW4CCd1hRu78zlNk/8ixiJU+
	tlO8RhbeEsAhXT2RaTLWq+3OHpokAj7MYfR9r+m53Q8wOpYK8cq9cJzVQvQmd/dbheuoFEGodaT9/
	+T061oLbBCbnP9wZs5zorv5FCrivpK+SJmhXdCZqUKuNEut0z273fZyVs6+JBNLsr3G43UIohzAfO
	jDs7BnSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggzOw-0005Nw-4E; Tue, 08 Jan 2019 21:59:10 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggzNg-0003yE-7i; Tue, 08 Jan 2019 21:58:04 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E78801596;
 Tue,  8 Jan 2019 13:57:51 -0800 (PST)
Received: from DESKTOP-VLO843J.lan (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9DA1C3F5AF;
 Tue,  8 Jan 2019 13:57:50 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: heiko@sntech.de
Subject: [PATCH 5/5] arm64: dts: rockchip: Fix nanopi4 uSD card detect
Date: Tue,  8 Jan 2019 21:57:27 +0000
Message-Id: <83098c7ecc471a77dd89564f5f98fcf30c1ed431.1546981251.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1546981251.git.robin.murphy@arm.com>
References: <cover.1546981251.git.robin.murphy@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_135752_648851_9A9076BE 
X-CRM114-Status: GOOD (  14.78  )
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
Cc: linux-rockchip@lists.infradead.org, tomeu.vizoso@collabora.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

For whatever reason, the sdmmc_dectn function isn't working properly
as-is, and microSD insertion and removal goes unnoticed. Flipping the
pin into GPIO mode, however, does do the job, so let's just handle it
that way for now until someone feels inclined to figure out what GRF
voodoo or otherwise is needed for correct 'native' operation.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
index 9c723038d8f8..2a183a6af150 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
@@ -505,6 +505,10 @@
 		sdmmc0_pwr_h: sdmmc0-pwr-h {
 			rockchip,pins = <0 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
+
+		sdmmc0_det_l: sdmmc0-det-l {
+			rockchip,pins = <0 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
 	};
 
 	sdio-pwrseq {
@@ -563,9 +567,10 @@
 	bus-width = <4>;
 	cap-sd-highspeed;
 	cap-mmc-highspeed;
+	cd-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
 	disable-wp;
 	pinctrl-names = "default";
-	pinctrl-0 = <&sdmmc_bus4 &sdmmc_cd &sdmmc_clk &sdmmc_cmd>;
+	pinctrl-0 = <&sdmmc_bus4 &sdmmc0_det_l &sdmmc_clk &sdmmc_cmd>;
 	sd-uhs-sdr104;
 	vmmc-supply = <&vcc3v0_sd>;
 	vqmmc-supply = <&vcc_sdio>;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
