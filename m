Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1BAC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 03:38:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9613320883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 03:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tXPl6F73"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9613320883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=3d2vwWZ014KIgFug+B+CInqZBlemte57A0eFmB1olGM=; b=tXPl6F73tSAhiO
	Pz6ku8INKKS2Ygu7k0am/9anAG1zsauEkOl22P1//EsaE6IiCsOuNdPnH+F63f8xTRmiCWoNh5+x3
	foZE14JvGM6NIeM6FY5FQkYytRwNvotnGrQIzIT7A7fVDE6QFDPiqNpg5TQZJgjsHNvXXJHngiMMv
	a7Aquw/7E7fUfByjJFw592FLQ+1FycDvaWhZBxtNpv8y4/ku80J3qe4fmhqDnYadv8FBoUeHXhXjq
	ABJLKU/MMgDq9g8FL5PKsrmYWw+B3odNYtAFXtG/tRmP/cbRgiP4UX+ZXv8JqOk8bKQTOrce4lw8N
	U1e7JQLbnvs8nIqRKEPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1getpj-00012l-SN; Thu, 03 Jan 2019 03:38:11 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1getpg-00012K-62; Thu, 03 Jan 2019 03:38:09 +0000
X-UUID: 93150fb1eb2d41caabc7b9b16fee4d8a-20190102
X-UUID: 93150fb1eb2d41caabc7b9b16fee4d8a-20190102
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw02.mediatek.com
 (envelope-from <chuanjia.liu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 529028950; Wed, 02 Jan 2019 19:38:00 -0800
Received: from mtkmbs08n2.mediatek.inc (172.21.101.56) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 2 Jan 2019 19:37:58 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 3 Jan 2019 11:37:56 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 3 Jan 2019 11:37:56 +0800
From: <chuanjia.liu@mediatek.com>
To: <sean.wang@kernel.org>, <linus.walleij@linaro.org>,
 <matthias.bgg@gmail.com>, <linux-mediatek@lists.infradead.org>,
 <linux-gpio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v5] pinctrl: mediatek: add EINT support to virtual GPIOs
Date: Thu, 3 Jan 2019 11:37:15 +0800
Message-ID: <1546486635-16829-1-git-send-email-chuanjia.liu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-TM-SNTS-SMTP: BCF6E7E982204055E7BCDB50B5020F824FCB9BA70D68E92B9F7A9DE898E55FFE2000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_193808_237373_1D69B659 
X-CRM114-Status: UNSURE (   9.59  )
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
Cc: youlin.pei@mediatek.com, zhiyong.tao@mediatek.com, eddie.huang@mediatek.com,
 hailong.fan@mediatek.com, "chuanjia.liu" <Chuanjia.Liu@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: "chuanjia.liu" <Chuanjia.Liu@mediatek.com>

Virtual gpio only used inside SOC and not being exported to outside SOC.
Some modules use virtual gpio as eint and doesn't need SMT.
So this patch add EINT support to virtual GPIOs.

Signed-off-by: chuanjia.liu <Chuanjia.Liu@mediatek.com>
---
change note:
v5: This patch is the same as v4,re-upload due to
      mail permissions issues	 
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
index 4a9e0d4c2bbc..b1c368455d30 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
@@ -290,7 +290,13 @@ static int mtk_xt_set_gpio_as_eint(void *data, unsigned long eint_n)
 		return err;
 
 	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT, MTK_ENABLE);
-	if (err)
+	/* SMT is supposed to be supported by every real GPIO and doesn't
+	 * support virtual GPIOs, so the extra condition err != -ENOTSUPP
+	 * is just for adding EINT support to these virtual GPIOs. It should
+	 * add an extra flag in the pin descriptor when more pins with
+	 * distinctive characteristic come out.
+	 */
+	if (err && err != -ENOTSUPP)
 		return err;
 
 	return 0;
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
