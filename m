Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814A9C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:13:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CA6E20881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eUFw+Swb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA6E20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=1fI37mSD7AyjJPeTbLy/eZAnnJyPw4sE2gGI+QQgIW0=; b=eUFw+Swb0VQ5YP
	kgGASUgGZqIdoaS+3S0C8IvLW+JLUsRliW73WHR9h41MX9+k70IhpZKBZwJr2WetuadMGpbFEZ04I
	icX+cNk7hRPT24k8DLpCh2TLYEqDAQ3xV5zFHxwbA+VGy2eVcwgoBe90dfms1gCRttZLIxUOoFSnL
	ouVHzQCPYx7P/vI4HVSkIhPJpPHHJACMRADrofdsXATTy8dQWfwOAkJveR1CQljgIf7aLYj1sohFD
	+/UGxqy8rclNSNxsILM3ziLtGsJASixc6Rofagq/8Ya24+0FHdHEHjU/JKMeDMDl83a+iFguJfbIn
	/zqniIZp/yhdtHsfX5/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gThUO-0007ai-Lz; Mon, 03 Dec 2018 06:13:52 +0000
Received: from mail-sh2.amlogic.com ([58.32.228.45])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gThUK-0007Yf-Cx; Mon, 03 Dec 2018 06:13:49 +0000
Received: from localhost.localdomain (10.28.8.22) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server id 15.0.1320.4; Mon, 3 Dec 2018
 14:13:49 +0800
From: Xingyu Chen <xingyu.chen@amlogic.com>
To: Marc Zyngier <marc.zyngier@arm.com>, Jason Cooper <jason@lakedaemon.net>, 
 Thomas Gleixner <tglx@linutronix.de>, Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 0/2] irqchip/meson-gpio: Add support for Meson-G12A SoC
Date: Mon, 3 Dec 2018 14:13:22 +0800
Message-ID: <20181203061324.36248-1-xingyu.chen@amlogic.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-Originating-IP: [10.28.8.22]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_221348_438473_E64B6B16 
X-CRM114-Status: UNSURE (   6.55  )
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
Cc: Rob Herring <robh@kernel.org>, Jianxin Pan <jianxin.pan@amlogic.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Carlo Caione <carlo@caione.org>,
 linux-amlogic@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>,
 Xingyu Chen <xingyu.chen@amlogic.com>, Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This series try to add GPIO interrupt controller support for Meson-G12A SoCs.
Although the total number of pins is the same as the Meson-AXG SoC, the gpio
banks and irq numbers are different. To avoid confusion on use, i think the
new compatible string is needed.

Xingyu Chen (2):
  dt-bindings: interrupt-controller: New binding for Meson-G12A SoC
  irqchip/meson-gpio: Add support for Meson-G12A SoC

 .../interrupt-controller/amlogic,meson-gpio-intc.txt         | 1 +
 drivers/irqchip/irq-meson-gpio.c                             | 5 +++++
 2 files changed, 6 insertions(+)

-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
