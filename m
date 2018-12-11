Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29571C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:02:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EADE42081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cpvtk12H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EADE42081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ih5pl+5/o4dVqpuWjxM8eg2oEk3AiGWQVPfnSJIYrVo=; b=Cpvtk12H5XjylL
	S+Klp7/ysbSwhTKPXo0e/1uLeeKBV7k59MWb4U3JYjdbu9Ao3ZE/wCtW2NdYVYDQpokSefcG9GY8b
	a1rAol58OnyaIFPpCf7OBiaRogY2DwqM4MpIzRVRZXNlGZf4cv+720aMQKvo2/xJhpPzuG+H2xSnL
	rhJ8pnQQDqzNtLAyK1X6q+lEmdbv4dG7vnRDSXgCqdMHbcwfSrwrZPP5nap0NdVyOVTwPMlYBpRLi
	TGCOLZRv2S95VcWbCIcSgozkUdSck90lCzHOW98+t9ImMMlWo+oU7P1t4WWtOuAm9zewaX+HvzpaP
	XyME2RwYvX+T1YTKqyfA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWczc-0000xj-7A; Tue, 11 Dec 2018 08:02:12 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWczW-0000vB-Br; Tue, 11 Dec 2018 08:02:09 +0000
X-UUID: 05589f5ad45341589857077929822880-20181211
X-UUID: 05589f5ad45341589857077929822880-20181211
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
 (envelope-from <zhiyong.tao@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1072666083; Tue, 11 Dec 2018 16:01:28 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 11 Dec 2018 16:01:28 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 11 Dec 2018 16:01:27 +0800
From: Zhiyong Tao <zhiyong.tao@mediatek.com>
To: <robh+dt@kernel.org>, <linus.walleij@linaro.org>, <mark.rutland@arm.com>, 
 <matthias.bgg@gmail.com>
Subject: [PATCH] pinctrl: add drive for I2C related pins on MT8183
Date: Tue, 11 Dec 2018 16:01:23 +0800
Message-ID: <20181211080123.1397-2-zhiyong.tao@mediatek.com>
X-Mailer: git-send-email 2.12.5
In-Reply-To: <20181211080123.1397-1-zhiyong.tao@mediatek.com>
References: <20181211080123.1397-1-zhiyong.tao@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_000206_661319_E8D75D77 
X-CRM114-Status: GOOD (  12.01  )
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
Cc: devicetree@vger.kernel.org, hongkun.cao@mediatek.com,
 srv_heupstream@mediatek.com, chuanjia.liu@mediatek.com,
 biao.huang@mediatek.com, Zhiyong Tao <zhiyong.tao@mediatek.com>,
 erin.lo@mediatek.com, liguo.zhang@mediatek.com, linux-kernel@vger.kernel.org,
 hongzhou.yang@mediatek.com, linux-mediatek@lists.infradead.org,
 linux-gpio@vger.kernel.org, eddie.huang@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch provides the advanced drive for I2C used pins on MT8183.

Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt8183.c        | 50 ++++++++++++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 45 +++++++++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h | 13 ++++++
 drivers/pinctrl/mediatek/pinctrl-paris.c         | 20 ++++++++++
 4 files changed, 128 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8183.c b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
index 6262fd3678ea..5244e1b27b1d 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8183.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
@@ -472,6 +472,51 @@ static const struct mtk_pin_field_calc mt8183_pin_r1_range[] = {
 	PIN_FIELD_BASE(133, 133, 8, 0x0D0, 0x10, 13, 1),
 };
 
+static const struct mtk_pin_field_calc mt8183_pin_drv_en_dis_range[] = {
+	PIN_FIELD_BASE(48, 48, 3, 0x0F0, 0x10, 20, 1),
+	PIN_FIELD_BASE(49, 49, 3, 0x0F0, 0x10, 15, 1),
+	PIN_FIELD_BASE(50, 50, 4, 0x0F0, 0x10, 12, 1),
+	PIN_FIELD_BASE(51, 51, 4, 0x0F0, 0x10, 7, 1),
+	PIN_FIELD_BASE(81, 81, 5, 0x0F0, 0x10, 12, 1),
+	PIN_FIELD_BASE(82, 82, 5, 0x0F0, 0x10, 9, 1),
+	PIN_FIELD_BASE(83, 83, 5, 0x0F0, 0x10, 19, 1),
+	PIN_FIELD_BASE(84, 84, 5, 0x0F0, 0x10, 22, 1),
+	PIN_FIELD_BASE(103, 103, 6, 0x0F0, 0x10, 24, 1),
+	PIN_FIELD_BASE(104, 104, 6, 0x0F0, 0x10, 14, 1),
+	PIN_FIELD_BASE(105, 105, 6, 0x0F0, 0x10, 27, 1),
+	PIN_FIELD_BASE(106, 106, 6, 0x0F0, 0x10, 17, 1),
+};
+
+static const struct mtk_pin_field_calc mt8183_pin_drv_e0_range[] = {
+	PIN_FIELD_BASE(48, 48, 3, 0x0F0, 0x10, 21, 1),
+	PIN_FIELD_BASE(49, 49, 3, 0x0F0, 0x10, 16, 1),
+	PIN_FIELD_BASE(50, 50, 4, 0x0F0, 0x10, 13, 1),
+	PIN_FIELD_BASE(51, 51, 4, 0x0F0, 0x10, 8, 1),
+	PIN_FIELD_BASE(81, 81, 5, 0x0F0, 0x10, 13, 1),
+	PIN_FIELD_BASE(82, 82, 5, 0x0F0, 0x10, 10, 1),
+	PIN_FIELD_BASE(83, 83, 5, 0x0F0, 0x10, 20, 1),
+	PIN_FIELD_BASE(84, 84, 5, 0x0F0, 0x10, 23, 1),
+	PIN_FIELD_BASE(103, 103, 6, 0x0F0, 0x10, 25, 1),
+	PIN_FIELD_BASE(104, 104, 6, 0x0F0, 0x10, 15, 1),
+	PIN_FIELD_BASE(105, 105, 6, 0x0F0, 0x10, 28, 1),
+	PIN_FIELD_BASE(106, 106, 6, 0x0F0, 0x10, 18, 1),
+};
+
+static const struct mtk_pin_field_calc mt8183_pin_drv_e1_range[] = {
+	PIN_FIELD_BASE(48, 48, 3, 0x0F0, 0x10, 22, 1),
+	PIN_FIELD_BASE(49, 49, 3, 0x0F0, 0x10, 17, 1),
+	PIN_FIELD_BASE(50, 50, 4, 0x0F0, 0x10, 14, 1),
+	PIN_FIELD_BASE(51, 51, 4, 0x0F0, 0x10, 9, 1),
+	PIN_FIELD_BASE(81, 81, 5, 0x0F0, 0x10, 14, 1),
+	PIN_FIELD_BASE(82, 82, 5, 0x0F0, 0x10, 11, 1),
+	PIN_FIELD_BASE(83, 83, 5, 0x0F0, 0x10, 21, 1),
+	PIN_FIELD_BASE(84, 84, 5, 0x0F0, 0x10, 24, 1),
+	PIN_FIELD_BASE(103, 103, 6, 0x0F0, 0x10, 26, 1),
+	PIN_FIELD_BASE(104, 104, 6, 0x0F0, 0x10, 16, 1),
+	PIN_FIELD_BASE(105, 105, 6, 0x0F0, 0x10, 29, 1),
+	PIN_FIELD_BASE(106, 106, 6, 0x0F0, 0x10, 19, 1),
+};
+
 static const struct mtk_pin_reg_calc mt8183_reg_cals[PINCTRL_PIN_REG_MAX] = {
 	[PINCTRL_PIN_REG_MODE] = MTK_RANGE(mt8183_pin_mode_range),
 	[PINCTRL_PIN_REG_DIR] = MTK_RANGE(mt8183_pin_dir_range),
@@ -485,6 +530,9 @@ static const struct mtk_pin_reg_calc mt8183_reg_cals[PINCTRL_PIN_REG_MAX] = {
 	[PINCTRL_PIN_REG_PUPD] = MTK_RANGE(mt8183_pin_pupd_range),
 	[PINCTRL_PIN_REG_R0] = MTK_RANGE(mt8183_pin_r0_range),
 	[PINCTRL_PIN_REG_R1] = MTK_RANGE(mt8183_pin_r1_range),
+	[PINCTRL_PIN_REG_DRV_EN_DIS] = MTK_RANGE(mt8183_pin_drv_en_dis_range),
+	[PINCTRL_PIN_REG_DRV_E0] = MTK_RANGE(mt8183_pin_drv_e0_range),
+	[PINCTRL_PIN_REG_DRV_E1] = MTK_RANGE(mt8183_pin_drv_e1_range),
 };
 
 static const char * const mt8183_pinctrl_register_base_names[] = {
@@ -517,6 +565,8 @@ static const struct mtk_pin_soc mt8183_data = {
 	.drive_get = mtk_pinconf_drive_get_rev1,
 	.adv_pull_get = mtk_pinconf_adv_pull_get,
 	.adv_pull_set = mtk_pinconf_adv_pull_set,
+	.adv_drive_get = mtk_pinconf_adv_drive_get,
+	.adv_drive_set = mtk_pinconf_adv_drive_set,
 };
 
 static const struct of_device_id mt8183_pinctrl_of_match[] = {
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
index 4a9e0d4c2bbc..da024279ec59 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
@@ -668,3 +668,48 @@ int mtk_pinconf_adv_pull_get(struct mtk_pinctrl *hw,
 
 	return 0;
 }
+
+int mtk_pinconf_adv_drive_set(struct mtk_pinctrl *hw,
+			      const struct mtk_pin_desc *desc, bool enable,
+			      u32 arg)
+{
+	int err;
+
+	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DRV_E0, arg & 1);
+	if (err)
+		return 0;
+
+	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DRV_E1,
+			       !!(arg & 2));
+	if (err)
+		return 0;
+
+	arg = enable ? 1 : 0;
+
+	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DRV_EN_DIS, arg);
+
+	return err;
+}
+
+int mtk_pinconf_adv_drive_get(struct mtk_pinctrl *hw,
+			      const struct mtk_pin_desc *desc, u32 *val)
+{
+	u32 en, e0, e1;
+	int err;
+
+	err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DRV_EN_DIS, &en);
+	if (err)
+		return err;
+
+	err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DRV_E0, &e0);
+	if (err)
+		return err;
+
+	err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DRV_E1, &e1);
+	if (err)
+		return err;
+
+	*val = (e0 | e1 << 1 | en << 2) & 0x7;
+
+	return 0;
+}
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
index 6d24522739d9..795a3b10d54e 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
@@ -63,6 +63,9 @@ enum {
 	PINCTRL_PIN_REG_IES,
 	PINCTRL_PIN_REG_PULLEN,
 	PINCTRL_PIN_REG_PULLSEL,
+	PINCTRL_PIN_REG_DRV_EN_DIS,
+	PINCTRL_PIN_REG_DRV_E0,
+	PINCTRL_PIN_REG_DRV_E1,
 	PINCTRL_PIN_REG_MAX,
 };
 
@@ -224,6 +227,11 @@ struct mtk_pin_soc {
 	int (*adv_pull_get)(struct mtk_pinctrl *hw,
 			    const struct mtk_pin_desc *desc, bool pullup,
 			    u32 *val);
+	int (*adv_drive_set)(struct mtk_pinctrl *hw,
+			     const struct mtk_pin_desc *desc, bool enable,
+			     u32 arg);
+	int (*adv_drive_get)(struct mtk_pinctrl *hw,
+			     const struct mtk_pin_desc *desc, u32 *val);
 
 	/* Specific driver data */
 	void				*driver_data;
@@ -287,5 +295,10 @@ int mtk_pinconf_adv_pull_set(struct mtk_pinctrl *hw,
 int mtk_pinconf_adv_pull_get(struct mtk_pinctrl *hw,
 			     const struct mtk_pin_desc *desc, bool pullup,
 			     u32 *val);
+int mtk_pinconf_adv_drive_set(struct mtk_pinctrl *hw,
+			      const struct mtk_pin_desc *desc, bool enable,
+			     u32 arg);
+int mtk_pinconf_adv_drive_get(struct mtk_pinctrl *hw,
+			      const struct mtk_pin_desc *desc, u32 *val);
 
 #endif /* __PINCTRL_MTK_COMMON_V2_H */
diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index d2179028f134..ef4ccaa59e55 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -20,12 +20,16 @@
 #define MTK_PIN_CONFIG_RDSEL	(PIN_CONFIG_END + 2)
 #define MTK_PIN_CONFIG_PU_ADV	(PIN_CONFIG_END + 3)
 #define MTK_PIN_CONFIG_PD_ADV	(PIN_CONFIG_END + 4)
+#define MTK_PIN_CONFIG_DRV_EN_ADV	(PIN_CONFIG_END + 5)
+#define MTK_PIN_CONFIG_DRV_DIS_ADV	(PIN_CONFIG_END + 6)
 
 static const struct pinconf_generic_params mtk_custom_bindings[] = {
 	{"mediatek,tdsel",	MTK_PIN_CONFIG_TDSEL,		0},
 	{"mediatek,rdsel",	MTK_PIN_CONFIG_RDSEL,		0},
 	{"mediatek,pull-up-adv", MTK_PIN_CONFIG_PU_ADV,		1},
 	{"mediatek,pull-down-adv", MTK_PIN_CONFIG_PD_ADV,	1},
+	{"mediatek,drive-enable-adv", MTK_PIN_CONFIG_DRV_EN_ADV,	2},
+	{"mediatek,drive-disable-adv", MTK_PIN_CONFIG_DRV_DIS_ADV,	2},
 };
 
 #ifdef CONFIG_DEBUG_FS
@@ -34,6 +38,8 @@ static const struct pin_config_item mtk_conf_items[] = {
 	PCONFDUMP(MTK_PIN_CONFIG_RDSEL, "rdsel", NULL, true),
 	PCONFDUMP(MTK_PIN_CONFIG_PU_ADV, "pu-adv", NULL, true),
 	PCONFDUMP(MTK_PIN_CONFIG_PD_ADV, "pd-adv", NULL, true),
+	PCONFDUMP(MTK_PIN_CONFIG_DRV_EN_ADV, "drive-enable-adv", NULL, true),
+	PCONFDUMP(MTK_PIN_CONFIG_DRV_DIS_ADV, "drive-disable-adv", NULL, true),
 };
 #endif
 
@@ -311,6 +317,20 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			return -ENOTSUPP;
 		}
 		break;
+	case MTK_PIN_CONFIG_DRV_EN_ADV:
+	case MTK_PIN_CONFIG_DRV_DIS_ADV:
+		if (hw->soc->adv_drive_set) {
+			bool enable;
+
+			enable = param == MTK_PIN_CONFIG_DRV_EN_ADV;
+			err = hw->soc->adv_drive_set(hw, desc, enable,
+						    arg);
+			if (err)
+				return err;
+		} else {
+			return -ENOTSUPP;
+		}
+		break;
 	default:
 		err = -ENOTSUPP;
 	}
-- 
2.12.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
