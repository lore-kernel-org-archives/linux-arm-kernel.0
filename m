Return-Path: <SRS0=RmN+=PK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5C8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 02:13:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 386A92171F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 02:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Uv0vRSrI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 386A92171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=0MGoIk3plcRc+4C4wN+8CSNj3ksPUV6g9fXWTbzpmGM=; b=Uv0vRSrIF+3JPX
	m8IvRvfR+8UDgRZsar72WSzZ9GT0OwxEATCqjXQ6i8Tnh01uZdNpTmdXlhFIClPp12w7Ix2msr+TK
	csNiK0NAMyh2X8kDBouxSsp4ldW0iHWKQMDSyU7rUw0gK2Bvs9K6q6USnQcWJPuBX8K/7jyUNmd7w
	Rb6T+dcKMuroKYrjk8q2BPNQsQasWFvL4FX/t6+Kmv4VCADDGbTHTpyWb3wNHmVq0PA9l3Q4FAGNB
	nAs36/R2DBISz/EswY9Q7Msdcqa3I0eVF1fGh+6+1hKrw0UKMYmTpwkp1jqnEzrFaelKPAS0DTndN
	V6H6kWX3T4DO75GhvQrw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1geW1y-0001OS-Kn; Wed, 02 Jan 2019 02:13:14 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1geW1t-0001NL-Vh; Wed, 02 Jan 2019 02:13:11 +0000
X-UUID: bdad40e2ec374105972ebe7bb9c19437-20190102
X-UUID: bdad40e2ec374105972ebe7bb9c19437-20190102
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by
 mailgw01.mediatek.com (envelope-from <long.cheng@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1039876166; Wed, 02 Jan 2019 10:13:01 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 2 Jan 2019 10:13:00 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 2 Jan 2019 10:12:59 +0800
From: Long Cheng <long.cheng@mediatek.com>
To: Vinod Koul <vkoul@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Rob
 Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ryder Lee
 <ryder.lee@mediatek.com>, Sean Wang <sean.wang@kernel.org>, Nicolas Boichat
 <drinkcat@chromium.org>
Subject: [PATCH v9 0/2] add uart DMA function
Date: Wed, 2 Jan 2019 10:12:56 +0800
Message-ID: <1546395178-8880-1-git-send-email-long.cheng@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190101_181310_152831_FDD29BAF 
X-CRM114-Status: UNSURE (   6.85  )
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
Cc: Zhenbao Liu <zhenbao.liu@mediatek.com>, devicetree@vger.kernel.org,
 YT Shen <yt.shen@mediatek.com>, srv_heupstream@mediatek.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sean Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, Long Cheng <long.cheng@mediatek.com>,
 linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org,
 Jiri Slaby <jslaby@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Yingjoe Chen <yingjoe.chen@mediatek.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In Mediatek SOCs, the uart can support DMA function.
Base on DMA engine formwork, we add the DMA code to support uart. And put the code under drivers/dma.

This series contains document bindings, Kconfig to control the function enable or not,
device tree including interrupt and dma device node, the code of UART DMA

Changes compared to v8
-revise missing items
Changes compared to v7:
-modify apdma uart tx
Changes compared to v6:
-Correct spelling
Changes compared to v5:
-move 'requst irqs' to alloc channel
-remove tasklet.
Changes compared to v4:
-modify Kconfig depends on.
Changes compared to v3:
-fix CONFIG_PM, will cause build fail
Changes compared to v2:
-remove unimportant parameters
-instead of cookie, use APIs of virtual channel.
-use of_dma_xlate_by_chan_id.
Changes compared to v1:
-mian revised file, 8250_mtk_dma.c
--parameters renamed for standard
--remove atomic operation


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
