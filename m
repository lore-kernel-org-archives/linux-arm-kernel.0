Return-Path: <SRS0=qjmB=PN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F283C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:49:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27C07217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WdQ0Cl57"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C07217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soulik.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AsR4TUlBfXyD1TD2g3WDakVo6QMvzxyk2N/SprTFQho=; b=WdQ0Cl57S7uf3L
	DcyXCb0fDc5uAJAp4BLMdgpzHhaEXt9DmOEt0OiQMkGpx/HuoiYHa/spk7TSr5pcNoDNeO94gM3Nj
	e/0e/MKTgI5IvRtwoVRfcz+U4PpofcN5xa4uuAWJrY3Qo7+zjylIE2Y3AEV1qVeQ8gw6X7Erqoaqm
	TLC5BcOZB3qkTu2rOuVJduLZsuJmzjYtYKfaSFhRJSrVZwrpIWM9GmqB98KPkHD0/WOYAmSWp9KlN
	ts67ezP8GosOY0kt5V8A/pIsRDu7HKKXP2D+tkB1A0P3JINARoDwsA5bswUMZRki3Pr2pIHHRAZKS
	mLL6xmLHKsay+fqpI/2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfq4f-0006sz-Ut; Sat, 05 Jan 2019 17:49:29 +0000
Received: from kozue.soulik.info ([2001:19f0:7000:8404:5054:ff:fe75:428f])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfq4E-0006QL-ML; Sat, 05 Jan 2019 17:49:04 +0000
Received: from misaki.sumomo.pri (unknown
 [IPv6:2001:470:b30d:2:c604:15ff:0:a00])
 by kozue.soulik.info (Postfix) with ESMTPA id 80697101784;
 Sun,  6 Jan 2019 02:49:39 +0900 (JST)
From: Randy Li <ayaka@soulik.info>
To: linux-rockchip@lists.infradead.org
Subject: [PATCH 2/3] arm64: dts: rockchip: add power domain to iommu rk3399
Date: Sun,  6 Jan 2019 01:48:36 +0800
Message-Id: <20190105174837.19378-3-ayaka@soulik.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190105174837.19378-1-ayaka@soulik.info>
References: <20190105174837.19378-1-ayaka@soulik.info>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190105_094902_951111_2AA8E85B 
X-CRM114-Status: UNSURE (   7.61  )
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
Cc: ulf.hansson@linaro.org, zhangqing@rock-chips.com, heiko@sntech.de,
 geert+renesas@glider.be, sboyd@kernel.org, mturquette@baylibre.com,
 Randy Li <ayaka@soulik.info>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

IOMMU device won't work without power unless PMU
can't turn it off.

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 6cc1c9fa4ea6..b22b2e40422b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1263,6 +1263,7 @@
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
 		power-domains = <&power RK3399_PD_VCODEC>;
+		status = "disabled";
 	};
 
 	vdec_mmu: iommu@ff660480 {
@@ -1273,6 +1274,7 @@
 		clocks = <&cru ACLK_VDU>, <&cru HCLK_VDU>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
+		power-domains = <&power RK3399_PD_VDU>;
 		status = "disabled";
 	};
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
