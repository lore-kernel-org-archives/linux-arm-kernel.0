Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25D5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:13:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E56D2133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cxp3NS9j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E56D2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YdtcTzeDhNs9nu6agGo3fPuzB1Rmc64JvyuQCVsbscY=; b=Cxp3NS9jUXTLFk
	tvB4an2BtCgfUhqNV2Nb37OslXmp/Yi2ia4rN7AbtQopSPU1bwmgm/npybk1mBsYB4LGGgm9pWcCK
	MI3fRBmuX9k3BLXiBt5F8Q87fJR5n9WK39EDYHC/Ve0FJ+4Fy0JJy107GlffE/hexL5ZTpzjDo/Rg
	sCVpgutxV0bGir5pe/c3WF87bt2OqZLXUkEKn2W4G2a1QPpIjy3Kvqov+nW1GJuFWbEej7PXJBzcc
	CNl8VsZmSK5A9OV9NZu4N0xLSYGvhrx3pCrUkQaKaAOW71aX1bAEe0kHFuTG425XvBBkgADYl/wXT
	f8HzJ9BqgyYG5NrVtc/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYshu-0004aT-Eo; Mon, 17 Dec 2018 13:13:14 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYshZ-0004Aq-BR; Mon, 17 Dec 2018 13:12:55 +0000
Received: from wf0848.dip.tu-dresden.de ([141.76.183.80]
 helo=phil.dip.tu-dresden.de)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gYs8u-0003o4-JL; Mon, 17 Dec 2018 13:37:04 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
	hjc@rock-chips.com
Subject: [PATCH 11/15] arm64: dts: rockchip: add analogix-dp controller on
 rk3368
Date: Mon, 17 Dec 2018 13:36:46 +0100
Message-Id: <20181217123650.6773-12-heiko@sntech.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181217123650.6773-1-heiko@sntech.de>
References: <20181217123650.6773-1-heiko@sntech.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_051253_556211_A53AEC06 
X-CRM114-Status: GOOD (  11.22  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, architt@codeaurora.org,
 Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, a.hajda@samsung.com, robh+dt@kernel.org,
 Laurent.pinchart@ideasonboard.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add the core node for the Analogix displayport controller
found on rk3368 socs.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 4ddf380a2c2d..e30cbf30c026 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -868,6 +868,21 @@
 		status = "disabled";
 	};
 
+	edp: dp@ff970000 {
+		compatible = "rockchip,rk3368-dp";
+		reg = <0x0 0xff970000 0x0 0x4000>;
+		interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_EDP>, <&cru PCLK_EDP_CTRL>;
+		clock-names = "dp", "pclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&edp_hpd>;
+		power-domains = <&power RK3368_PD_VIO>;
+		resets = <&cru SRST_EDP>;
+		reset-names = "dp";
+		rockchip,grf = <&grf>;
+		status = "disabled";
+	};
+
 	hdmi: hdmi@ff980000 {
 		compatible = "rockchip,rk3368-dw-hdmi";
 		reg = <0x0 0xff980000 0x0 0x20000>;
@@ -1080,6 +1095,13 @@
 			drive-strength = <12>;
 		};
 
+		edp {
+			edp_hpd: edp-hpd {
+				rockchip,pins =
+					<2 RK_PC7 RK_FUNC_2 &pcfg_pull_none>;
+			};
+		};
+
 		emmc {
 			emmc_clk: emmc-clk {
 				rockchip,pins = <2 4 RK_FUNC_2 &pcfg_pull_none>;
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
