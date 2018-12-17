Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5082DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:38:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 209A520672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="POgG8ajU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 209A520672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Rq7Ty6QVNHFj0Xn437j/In9PLC2IbgkAEWxVcZVQs9s=; b=POgG8ajUJiExY5
	Mh6z3+yvQ/X2xqOt0Ae8lsSRdq3TmR1cvHks3zCIdcMtIzlsqB4mcR+fhoDIebZvfZw63B5KgBZze
	nxCs/ZUJKv3lSbAZ/oRuao+fU3r5BzwfCVN+kU3/f5m4GAUN7ZW18ssKGF3Ph+2bZE7K3lV0viDNz
	93moKfuVXqF9Ahr6jom2ts/ZxFQ0ponmSbF7DVW2KBarNN4m5ef1gTz4oKMrjVY/OVpA/qRThifKm
	Mn4vwspI5rISRWwxWCsL0ooB30t+gw7E/CdGAXbFKn8M6N0P1DdKGdC22TzG3aJxiJ8VQh4WrOzNN
	L4scYg4cuOCrkYBW0cuA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYsAA-0003VA-JR; Mon, 17 Dec 2018 12:38:22 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYs97-0002SK-O2; Mon, 17 Dec 2018 12:37:21 +0000
Received: from wf0848.dip.tu-dresden.de ([141.76.183.80]
 helo=phil.dip.tu-dresden.de)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gYs8s-0003o4-Tn; Mon, 17 Dec 2018 13:37:02 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
	hjc@rock-chips.com
Subject: [PATCH 06/15] drm/rockchip: analogix_dp: add support for the rk3368
 variant
Date: Mon, 17 Dec 2018 13:36:41 +0100
Message-Id: <20181217123650.6773-7-heiko@sntech.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181217123650.6773-1-heiko@sntech.de>
References: <20181217123650.6773-1-heiko@sntech.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_043718_079641_4795AEEA 
X-CRM114-Status: GOOD (  16.63  )
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

Add the compatible and allow the driver to also not set any crtc input
on socs that only have one vop. While that was already possible
because the driver checked against the grf-reg being 0, make that
var an int as "0x0" is a valid grf address itself. So standardize
on -1 for "no setting needed".

The dp controller behaves similar to the one found on rk3288, so we
don't add a new chip_type to not overly pollute the bridge driver.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../display/rockchip/analogix_dp-rockchip.txt   |  1 +
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 17 +++++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/rockchip/analogix_dp-rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/analogix_dp-rockchip.txt
index 43561584c13a..d0f7a1292355 100644
--- a/Documentation/devicetree/bindings/display/rockchip/analogix_dp-rockchip.txt
+++ b/Documentation/devicetree/bindings/display/rockchip/analogix_dp-rockchip.txt
@@ -3,6 +3,7 @@ Rockchip RK3288 specific extensions to the Analogix Display Port
 
 Required properties:
 - compatible: "rockchip,rk3288-dp",
+	      "rockchip,rk3368-dp",
 	      "rockchip,rk3399-edp";
 
 - reg: physical base address of the controller and length
diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 080f05352195..acfcffc279ea 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -54,7 +54,7 @@
  * @chip_type: specific chip type
  */
 struct rockchip_dp_chip_data {
-	u32	lcdsel_grf_reg;
+	int	lcdsel_grf_reg;
 	u32	lcdsel_big;
 	u32	lcdsel_lit;
 	u32	chip_type;
@@ -207,9 +207,12 @@ static void rockchip_dp_drm_encoder_enable(struct drm_encoder *encoder)
 		return;
 	}
 
-	ret = regmap_write(dp->grf, dp->data->lcdsel_grf_reg, val);
-	if (ret != 0)
-		DRM_DEV_ERROR(dp->dev, "Could not write to GRF: %d\n", ret);
+	if (dp->data->lcdsel_grf_reg >= 0) {
+		ret = regmap_write(dp->grf, dp->data->lcdsel_grf_reg, val);
+		if (ret != 0)
+			DRM_DEV_ERROR(dp->dev, "Could not write to GRF: %d\n",
+				      ret);
+	}
 
 	clk_disable_unprepare(dp->grfclk);
 }
@@ -455,8 +458,14 @@ static const struct rockchip_dp_chip_data rk3288_dp = {
 	.chip_type = RK3288_DP,
 };
 
+static const struct rockchip_dp_chip_data rk3368_dp = {
+	.lcdsel_grf_reg = -1,
+	.chip_type = RK3288_DP,
+};
+
 static const struct of_device_id rockchip_dp_dt_ids[] = {
 	{.compatible = "rockchip,rk3288-dp", .data = &rk3288_dp },
+	{.compatible = "rockchip,rk3368-dp", .data = &rk3368_dp },
 	{.compatible = "rockchip,rk3399-edp", .data = &rk3399_edp },
 	{}
 };
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
