Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A0CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:28:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E563720700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TFKDsFd9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E563720700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=E51kZx0ZNji0mwElm0+U1L9iOVL41V2XrX8N1SsebFk=; b=TFKDsFd9PxeUvM
	dODFVTRSAy648B7sRfEtN+uUW4z0ZBHX1MuipLqInWIeECC611Ch7L4gwMDlV+FzwjaDmk/wfz90b
	DVXBIJxru/25YuXMKxKrr7WxIryMUAz6Qy9topccY+uuZSgzQpnprPZNoVIIMmtFdwhTSpkJyKj4e
	DiVzqe3cavZSur4BhngSCPV8XKqMFeK5DJgcmi7kmTtorbVl0N92TRejShDIwzFTWIzqcuGCw05G/
	On9iF7uNmchaj/CuorDzvQUDeLME3ZCDrmECAJe/LagF855MBJn6DwJT7UTmwyrOzjsAiTerM5I0F
	WbNgkX8OuWjgLDHp7RsQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx6CL-0004md-F1; Fri, 22 Feb 2019 08:28:45 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx6CH-0004jX-Bl
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 08:28:43 +0000
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1M8QFhF012441; Fri, 22 Feb 2019 09:28:30 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2qt9c594f1-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Fri, 22 Feb 2019 09:28:29 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 391C33F;
 Fri, 22 Feb 2019 08:28:26 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AB1A928AC;
 Fri, 22 Feb 2019 08:28:25 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 22 Feb
 2019 09:28:25 +0100
Received: from localhost (10.201.23.166) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 22 Feb 2019 09:28:24
 +0100
From: Christophe Roullier <christophe.roullier@st.com>
To: <robh@kernel.org>, <davem@davemloft.net>, <joabreu@synopsys.com>,
 <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
 <alexandre.torgue@st.com>, <peppe.cavallaro@st.com>
Subject: [PATCH V2 0/8] stmmac: add some fixes for stm32
Date: Fri, 22 Feb 2019 09:28:01 +0100
Message-ID: <1550824089-19961-1-git-send-email-christophe.roullier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.201.23.166]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-22_06:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_002841_701708_2D7992A5 
X-CRM114-Status: GOOD (  11.43  )
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
Cc: devicetree@vger.kernel.org, andrew@lunn.ch, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 christophe.roullier@st.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

For common stmmac:
	- Add support to set CSR Clock range selection in DT
For stm32mpu:
	- Glue codes to support magic packet
	- Glue codes to support all PHY config :
		PHY_MODE (MII,GMII, RMII, RGMII) and in normal,
		PHY wo crystal (25Mhz),
		PHY wo crystal (50Mhz), No 125Mhz from PHY config
For stm32mcu:
	- Add Ethernet support for stm32h7
	- Add syscfg clk support for stm32f4

Changes in V2:
  Apply remarks from andrew lunn
	- add all interfaces RGMII* 
	- reg value should be the same as ethernet-phy@X	

Christophe Roullier (8):
  net: ethernet: stmmac: manage Ethernet WoL for stm32mp157c.
  net: ethernet: stmmac: update to support all PHY config for
    stm32mp157c.
  dt-bindings: net: stmmac: add phys config properties
  net: ethernet: stmmac: add management of clk_csr property
  net: ethernet: stmmac: update to be compatible with MCU family
    (stm32f4, stm32h7)
  dt-bindings: net: stmmac: add syscfg clock property
  ARM: dts: stm32: Add Ethernet support on stm32h7 SOC and activate it
    for eval and disco boards
  ARM: dts: stm32: add syscfg clock support for Ethernet on STM32F429
    SoC

 .../devicetree/bindings/net/stm32-dwmac.txt        |  10 +-
 arch/arm/boot/dts/stm32f429.dtsi                   |   6 +-
 arch/arm/boot/dts/stm32h743-pinctrl.dtsi           |  15 ++
 arch/arm/boot/dts/stm32h743.dtsi                   |  19 +++
 arch/arm/boot/dts/stm32h743i-disco.dts             |  17 ++
 arch/arm/boot/dts/stm32h743i-eval.dts              |  17 ++
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c  | 182 +++++++++++++++++----
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |   3 +
 8 files changed, 233 insertions(+), 36 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
