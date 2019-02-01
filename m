Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E904DC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:10:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B03E520869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pjlWU9X1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o9ZxXDjD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B03E520869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AZGEVaBjXvuwsOMkJAvwMcEAwAWjMbP1pZGyWAUjFC8=; b=pjlWU9X1b8x2Ll
	9AEA/+PbQcEnora9Kz/ORyDA9SGNih/qG+x60U8jQFQyXFjhFeM4v93KYH/a7g7JDgeEyUsoJauhU
	xezApia/Dye6N7VsN9Jyv56XdzwjhKKJnx6dPFP2fwCvHeWCRnH0oolAD50EXMD1VU0DO/H+GkmyI
	5DOr/Nz84tpxb1nmYKzpsAcPZZPdeOi/rm9Dy6QZJGJSL0tC6v0Qdpdwj2tu+hy0KH411hErJYe+X
	NoHHlkxyBbO+5bHE7HXUrgXA0XBJxSqoHo71sIjzrvrow3DYlg8XLfizsnSa3JtFAcoUPUV/5qCUn
	M2ecvG/iYp16ZwBqsjeQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpUqT-0003xI-Td; Fri, 01 Feb 2019 09:10:45 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpUqR-0003x7-G9; Fri, 01 Feb 2019 09:10:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0OhjWRfPEesw+8X9DMvUH7NC1TaJLzVZB/hd4e17wdA=; b=o9ZxXDjDmmTjSbJNxJF3nF2gv
 vipkOnt7LSQuNZgJ0WvfXfmZk0xXRGJLzyzY8Ql2BZjnq138JjLfGIAY+HFRsm7Tx/FlsrNBj3zFc
 FkArh8NWl1L0y2dgd96aXo4BhY5yEpoZnT3hQZ/pci+sQFpoNYDU0fZtiqZVQ5x9pHUuvpdfqQL3S
 /WvQKVN3WnZBFZph6ZmD0iZniPcAYgtc7oR/213/1aDjLGcfI/tbIzSTFpWcRZdp9gf3hBsRjaCGe
 O3IEmcs0t115/QJwRsmk8UOL0vuyKqj8wVfi/e6M0eljN92lvfIyOW3oob3J1tO6LmhHjqMQB5dYF
 9JBArMy2Q==;
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpUGl-00064O-Si; Fri, 01 Feb 2019 08:33:52 +0000
X-UUID: 2539abe49ca9459296e4489184d3eca3-20190201
X-UUID: 2539abe49ca9459296e4489184d3eca3-20190201
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw01.mediatek.com
 (envelope-from <weiyi.lu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1746427689; Fri, 01 Feb 2019 00:30:31 -0800
Received: from mtkmbs03n2.mediatek.inc (172.21.101.182) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Feb 2019 00:30:29 -0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Feb 2019 16:30:26 +0800
Received: from mtkslt210.mediatek.inc (10.21.14.14) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Feb 2019 16:30:26 +0800
From: Weiyi Lu <weiyi.lu@mediatek.com>
To: Nicolas Boichat <drinkcat@chromium.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>, Rob Herring
 <robh@kernel.org>
Subject: [PATCH v4 11/12] soc: mediatek: Add MT8183 scpsys support
Date: Fri, 1 Feb 2019 16:30:15 +0800
Message-ID: <20190201083016.25856-13-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190201083016.25856-1-weiyi.lu@mediatek.com>
References: <20190201083016.25856-1-weiyi.lu@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: FCCA2CBE293709034A474DD21DE3AFFB238663AAB2C29AF8E826358676589C802000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_033352_104748_F1A5B1B8 
X-CRM114-Status: GOOD (  12.46  )
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
Cc: James Liao <jamesjj.liao@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
 srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Fan Chen <fan.chen@mediatek.com>,
 linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add scpsys driver for MT8183

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 drivers/soc/mediatek/mtk-scpsys.c | 226 ++++++++++++++++++++++++++++++
 1 file changed, 226 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index 53a16fa327cf..09795caf4547 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -20,6 +20,7 @@
 #include <dt-bindings/power/mt7622-power.h>
 #include <dt-bindings/power/mt7623a-power.h>
 #include <dt-bindings/power/mt8173-power.h>
+#include <dt-bindings/power/mt8183-power.h>
 
 #define MTK_POLL_DELAY_US   10
 #define MTK_POLL_TIMEOUT    USEC_PER_SEC
@@ -1142,6 +1143,217 @@ static const struct scp_subdomain scp_subdomain_mt8173[] = {
 	{MT8173_POWER_DOMAIN_MFG_2D, MT8173_POWER_DOMAIN_MFG},
 };
 
+/*
+ * MT8183 power domain support
+ */
+
+static const struct scp_domain_data scp_domain_data_mt8183[] = {
+	[MT8183_POWER_DOMAIN_AUDIO] = {
+		.name = "audio",
+		.sta_mask = PWR_STATUS_AUDIO,
+		.ctl_offs = 0x0314,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+		.basic_clk_name = {"audio", "audio1", "audio2"},
+	},
+	[MT8183_POWER_DOMAIN_CONN] = {
+		.name = "conn",
+		.sta_mask = PWR_STATUS_CONN,
+		.ctl_offs = 0x032c,
+		.sram_pdn_bits = 0,
+		.sram_pdn_ack_bits = 0,
+		.bp_table = {
+			BUS_PROT(IFR_TYPE, 0x2a0, 0x2a4, 0, 0x228,
+				BIT(13) | BIT(14), BIT(13) | BIT(14)),
+		},
+	},
+	[MT8183_POWER_DOMAIN_MFG_ASYNC] = {
+		.name = "mfg_async",
+		.sta_mask = PWR_STATUS_MFG_ASYNC,
+		.ctl_offs = 0x0334,
+		.sram_pdn_bits = 0,
+		.sram_pdn_ack_bits = 0,
+		.basic_clk_name = {"mfg"},
+	},
+	[MT8183_POWER_DOMAIN_MFG] = {
+		.name = "mfg",
+		.sta_mask = PWR_STATUS_MFG,
+		.ctl_offs = 0x0338,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+	},
+	[MT8183_POWER_DOMAIN_MFG_CORE0] = {
+		.name = "mfg_core0",
+		.sta_mask = BIT(7),
+		.ctl_offs = 0x034c,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+	},
+	[MT8183_POWER_DOMAIN_MFG_CORE1] = {
+		.name = "mfg_core1",
+		.sta_mask = BIT(20),
+		.ctl_offs = 0x0310,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+	},
+	[MT8183_POWER_DOMAIN_MFG_2D] = {
+		.name = "mfg_2d",
+		.sta_mask = PWR_STATUS_MFG_2D,
+		.ctl_offs = 0x0348,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_table = {
+			BUS_PROT(IFR_TYPE, 0x2a8, 0x2ac, 0, 0x258,
+				BIT(19) | BIT(20) | BIT(21),
+				BIT(19) | BIT(20) | BIT(21)),
+			BUS_PROT(IFR_TYPE, 0x2a0, 0x2a4, 0, 0x228,
+				BIT(21) | BIT(22), BIT(21) | BIT(22)),
+		},
+	},
+	[MT8183_POWER_DOMAIN_DISP] = {
+		.name = "disp",
+		.sta_mask = PWR_STATUS_DISP,
+		.ctl_offs = 0x030c,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.basic_clk_name = {"mm"},
+		.subsys_clk_prefix = "mm",
+		.bp_table = {
+			BUS_PROT(IFR_TYPE, 0x2a8, 0x2ac, 0, 0x258,
+				BIT(16) | BIT(17), BIT(16) | BIT(17)),
+			BUS_PROT(IFR_TYPE, 0x2a0, 0x2a4, 0, 0x228,
+				BIT(10) | BIT(11), BIT(10) | BIT(11)),
+			BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
+				GENMASK(7, 0), GENMASK(7, 0)),
+		},
+	},
+	[MT8183_POWER_DOMAIN_CAM] = {
+		.name = "cam",
+		.sta_mask = BIT(25),
+		.ctl_offs = 0x0344,
+		.sram_pdn_bits = GENMASK(9, 8),
+		.sram_pdn_ack_bits = GENMASK(13, 12),
+		.basic_clk_name = {"cam"},
+		.subsys_clk_prefix = "cam",
+		.bp_table = {
+			BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
+				BIT(4) | BIT(5) | BIT(9) | BIT(13),
+				BIT(4) | BIT(5) | BIT(9) | BIT(13)),
+			BUS_PROT(IFR_TYPE, 0x2a0, 0x2a4, 0, 0x228,
+				BIT(28), BIT(28)),
+			BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
+				BIT(11), 0),
+			BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
+				BIT(3) | BIT(4), BIT(3) | BIT(4)),
+		},
+	},
+	[MT8183_POWER_DOMAIN_ISP] = {
+		.name = "isp",
+		.sta_mask = PWR_STATUS_ISP,
+		.ctl_offs = 0x0308,
+		.sram_pdn_bits = GENMASK(9, 8),
+		.sram_pdn_ack_bits = GENMASK(13, 12),
+		.basic_clk_name = {"isp"},
+		.subsys_clk_prefix = "isp",
+		.bp_table = {
+			BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
+				BIT(3) | BIT(8), BIT(3) | BIT(8)),
+			BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
+				BIT(10), 0),
+			BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
+				BIT(2), BIT(2)),
+		},
+	},
+	[MT8183_POWER_DOMAIN_VDEC] = {
+		.name = "vdec",
+		.sta_mask = BIT(31),
+		.ctl_offs = 0x0300,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_table = {
+			BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
+				BIT(7), BIT(7)),
+		},
+	},
+	[MT8183_POWER_DOMAIN_VENC] = {
+		.name = "venc",
+		.sta_mask = PWR_STATUS_VENC,
+		.ctl_offs = 0x0304,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+		.bp_table = {
+			BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
+				BIT(1), BIT(1)),
+		},
+	},
+	[MT8183_POWER_DOMAIN_VPU_TOP] = {
+		.name = "vpu_top",
+		.sta_mask = BIT(26),
+		.ctl_offs = 0x0324,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.basic_clk_name = {"vpu", "vpu1"},
+		.subsys_clk_prefix = "vpu",
+		.bp_table = {
+			BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
+				GENMASK(9, 6) | BIT(12),
+				GENMASK(9, 6) | BIT(12)),
+			BUS_PROT(IFR_TYPE, 0x2a0, 0x2a4, 0, 0x228,
+				BIT(27), BIT(27)),
+			BUS_PROT(IFR_TYPE, 0x2d4, 0x2d8, 0, 0x2ec,
+				BIT(10) | BIT(11), BIT(10) | BIT(11)),
+			BUS_PROT(SMI_TYPE, 0x3c4, 0x3c8, 0, 0x3c0,
+				BIT(5) | BIT(6), BIT(5) | BIT(6)),
+		},
+	},
+	[MT8183_POWER_DOMAIN_VPU_CORE0] = {
+		.name = "vpu_core0",
+		.sta_mask = BIT(27),
+		.ctl_offs = 0x33c,
+		.sram_iso_ctrl = true,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(13, 12),
+		.basic_clk_name = {"vpu2"},
+		.bp_table = {
+			BUS_PROT(IFR_TYPE, 0x2c4, 0x2c8, 0, 0x2e4,
+				BIT(6), BIT(6)),
+			BUS_PROT(IFR_TYPE, 0x2c4, 0x2c8, 0, 0x2e4,
+				BIT(0) | BIT(2) | BIT(4),
+				BIT(0) | BIT(2) | BIT(4)),
+		},
+	},
+	[MT8183_POWER_DOMAIN_VPU_CORE1] = {
+		.name = "vpu_core1",
+		.sta_mask = BIT(28),
+		.ctl_offs = 0x0340,
+		.sram_iso_ctrl = true,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(13, 12),
+		.basic_clk_name = {"vpu3"},
+		.bp_table = {
+			BUS_PROT(IFR_TYPE, 0x2c4, 0x2c8, 0, 0x2e4,
+				BIT(7), BIT(7)),
+			BUS_PROT(IFR_TYPE, 0x2c4, 0x2c8, 0, 0x2e4,
+				BIT(1) | BIT(3) | BIT(5),
+				BIT(1) | BIT(3) | BIT(5)),
+		},
+	},
+};
+
+static const struct scp_subdomain scp_subdomain_mt8183[] = {
+	{MT8183_POWER_DOMAIN_MFG_ASYNC, MT8183_POWER_DOMAIN_MFG},
+	{MT8183_POWER_DOMAIN_MFG, MT8183_POWER_DOMAIN_MFG_2D},
+	{MT8183_POWER_DOMAIN_MFG, MT8183_POWER_DOMAIN_MFG_CORE0},
+	{MT8183_POWER_DOMAIN_MFG, MT8183_POWER_DOMAIN_MFG_CORE1},
+	{MT8183_POWER_DOMAIN_DISP, MT8183_POWER_DOMAIN_CAM},
+	{MT8183_POWER_DOMAIN_DISP, MT8183_POWER_DOMAIN_ISP},
+	{MT8183_POWER_DOMAIN_DISP, MT8183_POWER_DOMAIN_VDEC},
+	{MT8183_POWER_DOMAIN_DISP, MT8183_POWER_DOMAIN_VENC},
+	{MT8183_POWER_DOMAIN_DISP, MT8183_POWER_DOMAIN_VPU_TOP},
+	{MT8183_POWER_DOMAIN_VPU_TOP, MT8183_POWER_DOMAIN_VPU_CORE0},
+	{MT8183_POWER_DOMAIN_VPU_TOP, MT8183_POWER_DOMAIN_VPU_CORE1},
+};
+
 static const struct scp_soc_data mt2701_data = {
 	.domains = scp_domain_data_mt2701,
 	.num_domains = ARRAY_SIZE(scp_domain_data_mt2701),
@@ -1208,6 +1420,17 @@ static const struct scp_soc_data mt8173_data = {
 	.bus_prot_reg_update = true,
 };
 
+static const struct scp_soc_data mt8183_data = {
+	.domains = scp_domain_data_mt8183,
+	.num_domains = ARRAY_SIZE(scp_domain_data_mt8183),
+	.subdomains = scp_subdomain_mt8183,
+	.num_subdomains = ARRAY_SIZE(scp_subdomain_mt8183),
+	.regs = {
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184
+	}
+};
+
 /*
  * scpsys driver init
  */
@@ -1231,6 +1454,9 @@ static const struct of_device_id of_scpsys_match_tbl[] = {
 	}, {
 		.compatible = "mediatek,mt8173-scpsys",
 		.data = &mt8173_data,
+	}, {
+		.compatible = "mediatek,mt8183-scpsys",
+		.data = &mt8183_data,
 	}, {
 		/* sentinel */
 	}
-- 
2.18.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
