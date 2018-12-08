Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D426FC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 08:40:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A49BD2064D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 08:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PrK7VENa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A49BD2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=S6Vdg4jBhAW/FAGxfZ90UQGz+R38w+TexUn6RI5veA0=; b=PrK7VENabCvl5D
	mwN4cYatXvEMtwLVB2/oU/pSUfPjlqkpIGOK4ZKFI4RbJLMKdOCUs+vamladg2r3HB88vSYpaS/+8
	OYI37hRgnm6yega2jVXCs7Ijsamm6C5ofanw2Kx1UyYl/j63r0VlGMdhbD1J3VV/ChURlBfFxNFCd
	ZrHRvf+y443zuxZSgE8OcDJowP1Ia5Eqhg8/B+now8IahagcV9n1+Qs6Sjd1awfBpYhR3l25NqKKl
	tAeySFWgQiPVf2RkbsLlCIIdFxUvfMhpL8TbWuCDIMnUjnOCA3cdc8u3L43dEvBzwdzYWKUEwohQo
	29FRToF7G5FCyZG43ehg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVY9w-00025A-AC; Sat, 08 Dec 2018 08:40:24 +0000
Received: from [210.61.82.184] (helo=mailgw02.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVY9e-0000d9-RP; Sat, 08 Dec 2018 08:40:09 +0000
X-UUID: 845ce37150b74b96bbee11bea4a5bd08-20181208
X-UUID: 845ce37150b74b96bbee11bea4a5bd08-20181208
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1371006552; Sat, 08 Dec 2018 16:39:48 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 8 Dec 2018 16:39:46 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 8 Dec 2018 16:39:45 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 00/18] MT8183 IOMMU SUPPORT
Date: Sat, 8 Dec 2018 16:39:13 +0800
Message-ID: <1544258371-4600-1-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-TM-SNTS-SMTP: 5D9489F3D3DCE600E02FB4332D14276E305A8AC80387BD9CCEEA9C865713C6252000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_004007_156842_FF883488 
X-CRM114-Status: GOOD (  17.01  )
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
 yong.wu@mediatek.com, Arvind Yadav <arvind.yadav.cs@gmail.com>,
 yingjoe.chen@mediatek.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patchset mainly adds support for mt8183 IOMMU and SMI.

mt8183 has only one M4U like mt8173 and is also MTK IOMMU gen2 which
uses ARM Short-Descriptor translation table format.

The mt8183 M4U-SMI HW diagram is as below:

                          EMI
                           |
                          M4U
                           |
                       ----------
                       |        |
                   gals0-rx   gals1-rx
                       |        |
                       |        |
                   gals0-tx   gals1-tx
                       |        |
                      ------------
                       SMI Common
                      ------------
                           |
  +-----+-----+--------+-----+-----+-------+-------+
  |     |     |        |     |     |       |       |
  |     |  gals-rx  gals-rx  |   gals-rx gals-rx gals-rx
  |     |     |        |     |     |       |       |
  |     |     |        |     |     |       |       |
  |     |  gals-tx  gals-tx  |   gals-tx gals-tx gals-tx
  |     |     |        |     |     |       |       |
larb0 larb1  IPU0    IPU1  larb4  larb5  larb6    CCU
disp  vdec   img     cam    venc   img    cam

All the connections are HW fixed, SW can NOT adjust it.

Compared with mt8173, we add a GALS(Global Async Local Sync) module
between SMI-common and M4U, and additional GALS between larb2/3/5/6
and SMI-common. GALS can help synchronize for the modules in different
clock frequency, it can be seen as a "asynchronous fifo".

GALS can only help transfer the command/data while it doesn't have
the configuring register, thus it has the special "smi" clock and it
doesn't have the "apb" clock. From the diagram above, we add "gals0"
and "gals1" clocks for smi-common and add a "gals" clock for smi-larb.

From the diagram above, IPU0/IPU1(Image Processor Unit) and CCU(Camera
Control Unit) is connected with smi-common directly, we can take them
as "larb2", "larb3" and "larb7", and their register spaces are
different with the normal larb.

This is the general purpose of each patch in this patchset:
the patch 1..10 add the iommu/smi support for mt8183;
the patch 11/12/13 add mmu1 support;
the last patches contain some minor changes:
   -patch 14 fix a issue.
   -patch 15 improve the code flow(add shutdown).
   -patch 16 cleanup some smi codes(delete need_larbid).
   -patch 17 switch to SPDX license.
   -patch 18 Constify iommu_ops from Arvind.
this patchset don't contain the dtsi part since it need depend on the
ccf and power-domain nodes which has not been accepted.

Change notes:

v4: 1) Add 3 preparing patches. Seperate some minor meaningful code into
       a new patch according to Matthias's suggestion.
       memory: mtk-smi: Add gals support         
       iommu/mediatek: Add larb-id remapped support 
       iommu/mediatek: Add bclk can be supported optionally       
    2) rebase on "iommu/mediatek: Make it explicitly non-modular"
       which was applied.
       https://lore.kernel.org/patchwork/patch/1020125/
    3) add some comment about "mediatek,larb-id" in the commit message of
       the patch "mtk-smi: Get rid of need_larbid".
    4) Fix bus_sel value.

v3: https://lists.linuxfoundation.org/pipermail/iommu/2018-November/031121.html
    1) rebase on v4.20-rc1.
    2) In the dt-binding, add a minor string "mt7623" which also use gen1
       since Matthias added it in v4.20.
    3) About v7s:
       a) for paddr_to_pte, change the param from "arm_v7s_io_pgtable" to
          "arm_pgtable_cfg", according to Robin suggestion.
       b) Don't use CONFIG_PHYS_ADDR_T_64BIT.
       c) add a little comment(pgtable address still don't over 4GB) in the
          commit message of the patch "Extend MediaTek 4GB Mode".
    4) add "iommu/mediatek: Constify iommu_ops" into this patchset. this may
       be helpful for review and merge.
       https://lists.linuxfoundation.org/pipermail/iommu/2018-October/030637.html

v2: https://lists.linuxfoundation.org/pipermail/iommu/2018-September/030164.html
    1) Fix typo in the commit message of dt-binding.
    2) Change larb2/larb3 to the special larbs.
    3) Refactor the larb-id remapped array(larbid_remapped), then we
    don't need add the new function(mtk_iommu_get_larbid).
    4) Add a new patch for v7s two helpers(paddr_to_iopte and
    iopte_to_paddr).
    5) Change some comment for MTK 4GB mode.

v1: base on v4.19-rc1.
http://lists.infradead.org/pipermail/linux-mediatek/2018-September/014881.html

Arvind Yadav (1):
  iommu/mediatek: Constify iommu_ops

Yong Wu (17):
  dt-bindings: mediatek: Add binding for mt8183 IOMMU and SMI
  iommu/mediatek: Use a struct as the platform data
  memory: mtk-smi: Use a general config_port interface
  memory: mtk-smi: Use a struct for the platform data for smi-common
  iommu/io-pgtable-arm-v7s: Add paddr_to_iopte and iopte_to_paddr
    helpers
  iommu/io-pgtable-arm-v7s: Extend MediaTek 4GB Mode
  iommu/mediatek: Add bclk can be supported optionally
  iommu/mediatek: Add larb-id remapped support
  memory: mtk-smi: Add gals support
  iommu/mediatek: Add mt8183 IOMMU support
  iommu/mediatek: Add mmu1 support
  memory: mtk-smi: Invoke pm runtime_callback to enable clocks
  memory: mtk-smi: Add bus_sel for mt8183
  iommu/mediatek: Fix VLD_PA_RANGE register backup when suspend
  iommu/mediatek: Add shutdown callback
  memory: mtk-smi: Get rid of need_larbid
  iommu/mediatek: Switch to SPDX license identifier

 .../devicetree/bindings/iommu/mediatek,iommu.txt   |  15 +-
 .../memory-controllers/mediatek,smi-common.txt     |  11 +-
 .../memory-controllers/mediatek,smi-larb.txt       |   3 +
 drivers/iommu/io-pgtable-arm-v7s.c                 |  72 ++++--
 drivers/iommu/io-pgtable.h                         |   7 +-
 drivers/iommu/mtk_iommu.c                          | 141 +++++++----
 drivers/iommu/mtk_iommu.h                          |  26 +-
 drivers/iommu/mtk_iommu_v1.c                       |  14 +-
 drivers/memory/mtk-smi.c                           | 269 ++++++++++++++-------
 include/dt-bindings/memory/mt2701-larb-port.h      |  10 +-
 include/dt-bindings/memory/mt8173-larb-port.h      |  10 +-
 include/dt-bindings/memory/mt8183-larb-port.h      | 130 ++++++++++
 include/soc/mediatek/smi.h                         |  10 +-
 13 files changed, 501 insertions(+), 217 deletions(-)
 create mode 100644 include/dt-bindings/memory/mt8183-larb-port.h

-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
