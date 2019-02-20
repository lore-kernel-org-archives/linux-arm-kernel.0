Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53A2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:26:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6BB62086A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ps3OQwlL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xCX6gG0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6BB62086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=P8MYj7AHCkhNQ4NkBRP6i7w4VZvcr9hIs+kr83hEdqw=; b=ps3OQwlLDtw9cj
	tQ0g//94DVmbN/FAJhNSt440CeDVHJBT2jP9kjqgjbpG76s0UQO37r0Dou0ci/dwqvCMG7k53Kt87
	3jNLEub70NmmuSZ5vR6GLKXsnCKpyBjtfPHEm1ElxsUckMhCNmHCST6iISuKSl4dDCSjAQdxSxkND
	koy+e8IvsquqmNRicJ8eQQty8oBhUzTbR0pHvrnxR6V1fOJhAlE4WoA1VDmzJQHPHb/k+kIgVh/zu
	cWoGmekMJ4IC9qxRIoJR0ygq4b7whK62lqPWFnNwJ6FaRNKNMmQvciy2M2RHv/BxyjPJ8uw5a5VVI
	cjHCdYlNKvnntgYVIH2w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwTlo-0000ax-Ah; Wed, 20 Feb 2019 15:26:48 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwTl9-00087A-4N
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 15:26:11 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1KFPwHd065757;
 Wed, 20 Feb 2019 09:25:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550676358;
 bh=yfgR1fzd7iWRZRBwGvYRuSanRPnPFahgoqcfsyD7zQ4=;
 h=From:To:CC:Subject:Date;
 b=xCX6gG0SeeIAIFMVK5w4TrAT84q5N/tFNEL4dkzpWTYPCuYkcDVaVRltSqN0VRP0J
 MPzYi/MXixielMstfSjSXhIMhQoHOWi/ujZfnpD3/RXRRv0Nx+hNY58IgsBWiJMJHG
 HExcYUP8iL138ss4sIemcEtaq+O5dllGZv4bUytE=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1KFPwjD085140
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 20 Feb 2019 09:25:58 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 20
 Feb 2019 09:25:58 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 20 Feb 2019 09:25:58 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1KFPv99022614;
 Wed, 20 Feb 2019 09:25:57 -0600
From: Grygorii Strashko <grygorii.strashko@ti.com>
To: "David S. Miller" <davem@davemloft.net>, Kishon Vijay Abraham I
 <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren
 <tony@atomide.com>
Subject: [PATCH 0/6] ARM: dts: ti: cpsw: switch to phy-gmii-sel phy driver
Date: Wed, 20 Feb 2019 17:25:13 +0200
Message-ID: <1550676319-6440-1-git-send-email-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_072607_629815_B47CAF5B 
X-CRM114-Status: GOOD (  12.85  )
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
Cc: devicetree@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>,
 netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Tony,

Hence prerequisite patches [1] have been merged already I'm sending final set
of DT patches to complete conversation of TI CPSW driver to use phy-gmii-sel
phy driver instead of cpsw-phy-sel. 

[1] https://lkml.org/lkml/2018/11/26/154

Grygorii Strashko (6):
  ARM: dts: dra7: switch to use phy-gmii-sel
  ARM: dts: dm814x: switch to use phy-gmii-sel
  ARM: dts: am4372: switch to use phy-gmii-sel
  ARM: dts: am335x: switch to use phy-gmii-sel
  dt-bindings: net: ti: deprecate cpsw-phy-sel bindings
  net: ethernet: ti: cpsw: deprecate cpsw-phy-sel driver

 .../devicetree/bindings/net/cpsw-phy-sel.txt    |  2 +-
 arch/arm/boot/dts/am335x-baltos-ir2110.dts      |  4 ----
 arch/arm/boot/dts/am335x-baltos-ir3220.dts      |  4 ----
 arch/arm/boot/dts/am335x-baltos-ir5221.dts      |  4 ----
 arch/arm/boot/dts/am335x-chiliboard.dts         |  4 ----
 arch/arm/boot/dts/am335x-icev2.dts              |  4 ----
 arch/arm/boot/dts/am335x-igep0033.dtsi          |  4 ----
 arch/arm/boot/dts/am335x-lxm.dts                |  4 ----
 .../boot/dts/am335x-moxa-uc-2100-common.dtsi    |  5 -----
 arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts  |  5 -----
 arch/arm/boot/dts/am335x-phycore-som.dtsi       |  4 ----
 arch/arm/boot/dts/am33xx-l4.dtsi                | 15 ++++++++-------
 arch/arm/boot/dts/am437x-l4.dtsi                | 17 +++++++++--------
 arch/arm/boot/dts/am43x-epos-evm.dts            |  5 +----
 arch/arm/boot/dts/dm814x.dtsi                   | 15 +++++++++------
 arch/arm/boot/dts/dra7-l4.dtsi                  | 15 ++++++++-------
 drivers/net/ethernet/ti/Kconfig                 |  6 +++---
 drivers/net/ethernet/ti/cpsw.h                  |  6 ++++++
 18 files changed, 45 insertions(+), 78 deletions(-)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
