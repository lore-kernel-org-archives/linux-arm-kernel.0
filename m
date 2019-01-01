Return-Path: <SRS0=AJAW=PJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27252C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 04:51:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2CD821783
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 04:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fh6E/7Su"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2CD821783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=j/1sAm6QCg8uauWWKGCwZrcf/kbc3lab/qgdmo2Cudc=; b=fh6E/7SuwcXx82
	x2K9m0Lp0UkpE/dxBwIgEhMqlWplLv0HFu1QeEj4DwJBoixQXYEfbjaFPxfVSh472RqNKPLCdWoIN
	au9Y2S3rtW5xN4W4atoJ3tD3ZFEJYWyXeqpVCYtqQ+8slx/XQ6uzpNlNYV/b333Knth8plCF1WzGG
	eoSOEVmx0YYC4oJ8PBtpceCFQRztvVMOZNEGX5vjRfJnGBMU4hhr1UBWwrpdaT+ciFTxUgNw1m+0u
	0npAJQ0nkJUZE792WH+rUZI5a6PxraPjSkWbcsPtEWM2Bj2TDy5f2GyLxK7l0C7jz4t6I4/sBMvxX
	7pwU7r8SRdCwODeZOm1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1geC1h-0001hm-Tu; Tue, 01 Jan 2019 04:51:37 +0000
Received: from [210.61.82.184] (helo=mailgw02.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1geC1d-0001hJ-E8; Tue, 01 Jan 2019 04:51:36 +0000
X-UUID: 2b92e5bd38144bac8313d87bac1e32d0-20190101
X-UUID: 2b92e5bd38144bac8313d87bac1e32d0-20190101
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by
 mailgw02.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1186191890; Tue, 01 Jan 2019 12:51:29 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 1 Jan 2019 12:51:27 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 1 Jan 2019 12:51:26 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob
 Herring <robh+dt@kernel.org>
Subject: [PATCH 00/13] Clean up "mediatek,larb" after adding device_link
Date: Tue, 1 Jan 2019 12:51:03 +0800
Message-ID: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-TM-SNTS-SMTP: 40C8168AB5B51643D5C91BE1842E5E56A0565B3483FA56B61046AC7EDDCA7E762000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_205133_728211_29D6DC5B 
X-CRM114-Status: GOOD (  14.17  )
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
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, arnd@arndb.de,
 srv_heupstream@mediatek.com, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 yong.wu@mediatek.com, yingjoe.chen@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

MediaTek IOMMU block diagram always like below:

        M4U
         |
    smi-common
         |
  -------------
  |         |  ...
  |         |
larb1     larb2
  |         |
vdec       venc

All the consumer connect with smi-larb, then connect with smi-common.

MediaTek IOMMU don't have its power-domain. When the consumer works,
it should enable the smi-larb's power which also need enable the smi-common's
power firstly.

Thus, Firstly, use the device link connect the consumer and the
smi-larbs. then add device link between the smi-larb and smi-common.

The ref_count of the device_link normally is over 1, when the consumer
device driver is removed, we should remove all the device_link, Hence,
I add the patch "driver core: xxx" at the beginning of this patchset.

After adding the device_link, then "mediatek,larb" property can be removed.
the iommu consumer don't need call the mtk_smi_larb_get/put to enable
the power and clock of smi-larb and smi-common.

This patchset depends on "MT8183 IOMMU SUPPORT"[1].

[1] https://lists.linuxfoundation.org/pipermail/iommu/2019-January/032387.html

Yong Wu (13):
  dt-binding: mediatek: Get rid of mediatek,larb for multimedia HW
  driver core: Remove the link if there is no driver with AUTO flag
  iommu/mediatek: Add probe_defer for smi-larb
  iommu/mediatek: Add device_link between the consumer and the larb
    devices
  memory: mtk-smi: Add device-link between smi-larb and smi-common
  media: mtk-jpeg: Get rid of mtk_smi_larb_get/put
  media: mtk-mdp: Get rid of mtk_smi_larb_get/put
  media: mtk-vcodec: Get rid of mtk_smi_larb_get/put
  drm/mediatek: Get rid of mtk_smi_larb_get/put
  memory: mtk-smi: Get rid of mtk_smi_larb_get/put
  iommu/mediatek: Use builtin_platform_driver
  arm: dts: mediatek: Get rid of mediatek,larb for MM nodes
  arm64: dts: mediatek: Get rid of mediatek,larb for MM nodes

 .../bindings/display/mediatek/mediatek,disp.txt    |  9 -----
 .../bindings/media/mediatek-jpeg-decoder.txt       |  4 ---
 .../devicetree/bindings/media/mediatek-mdp.txt     |  8 -----
 .../devicetree/bindings/media/mediatek-vcodec.txt  |  4 ---
 arch/arm/boot/dts/mt2701.dtsi                      |  1 -
 arch/arm/boot/dts/mt7623.dtsi                      |  1 -
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           | 15 --------
 drivers/base/core.c                                |  4 +--
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            | 11 ------
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c        | 26 --------------
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h        |  1 -
 drivers/iommu/mtk_iommu.c                          | 40 +++++++++-------------
 drivers/iommu/mtk_iommu_v1.c                       | 32 ++++++++---------
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c    | 22 ------------
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h    |  2 --
 drivers/media/platform/mtk-mdp/mtk_mdp_comp.c      | 38 --------------------
 drivers/media/platform/mtk-mdp/mtk_mdp_comp.h      |  2 --
 drivers/media/platform/mtk-mdp/mtk_mdp_core.c      |  1 -
 .../media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c  | 19 ----------
 drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h |  3 --
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c |  1 -
 .../media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c  | 38 --------------------
 drivers/memory/mtk-smi.c                           | 30 ++++------------
 include/soc/mediatek/smi.h                         | 20 -----------
 24 files changed, 40 insertions(+), 292 deletions(-)

-- 
1.9.1
 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
