Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47D7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 07:54:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2E292086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 07:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DWrpAWtg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E292086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=3otSGvF96Ai0vXZAc7D8EV7MANZLU5qT659g6oJFq7Q=; b=DWrpAWtgO+2Akm
	JF2ClH5Hrpea7ckPZ8UcpHnjAyH7aGV/5qHVaG913W48Tn0rqkveuxjYBoRvFe76wt2R+5zQ+YFH/
	H+S9m2rFv7uv6pOaRdNiNlaaoA/hQoDErh1SVtmXDAoTxER/QzvDqEj1qAAWsw/1059Sw9zR2Z+ki
	6KYN4aUvX4REvBtO38lp6Lu20D1/NP1e7Dxa7fyXUophfhiCY2PkO/44K3RpBM+wHXVbO2DmHjiFl
	Jer8d+Ya7e7zHCRiKOpda//4bwII/yt3kCVCBXeK9YGpOhWaKuI4VOKn5pCWOBcwGUOKaAMKPdWwq
	CtLBjK3jghkQq0YgKg7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjg1W-0005YY-Lp; Wed, 16 Jan 2019 07:54:06 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjg1T-0005Xd-7c; Wed, 16 Jan 2019 07:54:04 +0000
X-UUID: 49ffe6c47eea408c8d25cd46cae6c07d-20190115
X-UUID: 49ffe6c47eea408c8d25cd46cae6c07d-20190115
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw01.mediatek.com
 (envelope-from <jitao.shi@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1602074943; Tue, 15 Jan 2019 23:53:35 -0800
Received: from MTKMBS33DR.mediatek.inc (172.27.6.106) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 15 Jan 2019 23:53:34 -0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Wed, 16 Jan 2019 15:53:31 +0800
Received: from mszsdaap41.mediatek.inc (10.16.6.141) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 16 Jan 2019 15:53:30 +0800
From: Jitao Shi <jitao.shi@mediatek.com>
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, "Mark
 Rutland" <mark.rutland@arm.com>, Ian Campbell
 <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, David
 Airlie <airlied@linux.ie>, "Matthias Brugger" <matthias.bgg@gmail.com>
Subject: [PATCH] pwm: Add MediaTek MT8183 display PWM driver support
Date: Wed, 16 Jan 2019 15:52:52 +0800
Message-ID: <20190116075252.24124-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.12.5
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_235403_279484_D8D062D1 
X-CRM114-Status: UNSURE (   8.59  )
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
Cc: eddie.huang@mediatek.com, Jitao Shi <jitao.shi@mediatek.com>,
 Sascha Hauer <kernel@pengutronix.de>, srv_heupstream@mediatek.com,
 bibby.hsieh@mediatek.com, linux-mediatek@lists.infradead.org,
 Russell King <rmk+kernel@arm.linux.org.uk>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Inki Dae <inki.dae@samsung.com>,
 yingjoe.chen@mediatek.com, sj.huang@mediatek.com,
 Sean Paul <seanpaul@chromium.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Andy Yan <andy.yan@rock-chips.com>, ck.hu@mediatek.com,
 Vincent Palatin <vpalatin@chromium.org>, Thierry Reding <treding@nvidia.com>,
 Ajay Kumar <ajaykumar.rs@samsung.com>, linux-arm-kernel@lists.infradead.org,
 Rahul Sharma <rahul.sharma@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Use the mtk_pwm_data struction to define different registers
and add MT8183 specific register operations, such as MT8183
have commit register, needs to enable double buffer
before writing register, and needs to select commit mode
and use PWM_PERIOD/PWM_HIGH_WIDTH.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
---
 drivers/pwm/pwm-mtk-disp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
index 893940d45f0d..15803c71fe80 100644
--- a/drivers/pwm/pwm-mtk-disp.c
+++ b/drivers/pwm/pwm-mtk-disp.c
@@ -277,10 +277,21 @@ static const struct mtk_pwm_data mt8173_pwm_data = {
 	.commit_mask = 0x1,
 };
 
+static const struct mtk_pwm_data mt8183_pwm_data = {
+	.enable_mask = BIT(0),
+	.con0 = 0x18,
+	.con0_sel = 0x0,
+	.con1 = 0x1c,
+	.has_commit = false,
+	.bls_debug = 0x80,
+	.bls_debug_mask = 0x3,
+};
+
 static const struct of_device_id mtk_disp_pwm_of_match[] = {
 	{ .compatible = "mediatek,mt2701-disp-pwm", .data = &mt2701_pwm_data},
 	{ .compatible = "mediatek,mt6595-disp-pwm", .data = &mt8173_pwm_data},
 	{ .compatible = "mediatek,mt8173-disp-pwm", .data = &mt8173_pwm_data},
+	{ .compatible = "mediatek,mt8183-disp-pwm", .data = &mt8183_pwm_data},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mtk_disp_pwm_of_match);
-- 
2.12.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
