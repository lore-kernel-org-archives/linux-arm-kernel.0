Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18308C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:13:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC2CE2087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cA8bYsne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC2CE2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=8j5f2tsYlZZJVXbIQyIfgSi5mRP87EZrkWLQxQGrfXA=; b=cA8bYsnetp2MLU
	iGLBViMJ3jJIJzSSxTYSsLdfs7F1FYWr8rtmrZu7K7FI45ThPBXd7NjmfEX1Dnqb6fU/Xf3wiOr+H
	1E798YUBECu27zMLi0Xu4HwmEDYlVhOIwFkHU4KB/CZBh72N3KNVMz8po3axE5U6P66+7qK5XaMS8
	b6xzO6FYdxpeRhq6JqcxjVMB+XDOcyKmnTqSYaSyc7TEbYAIWwaAnKMDlhezPAG8NeJYZ6KOPLEED
	ioT7znwyABCz8e1u6U+sD8wS/dxPIb3jMDK7Grw/dQSyDgyvfouBhpHUVdxswm+jzUPgSv05oxvg7
	2IUhc+5Or7VZ8Rc/2wOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyy5o-00076i-86; Wed, 27 Feb 2019 12:13:44 +0000
Received: from mx07-00178001.pphosted.com ([62.209.51.94])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyy50-00067j-9e
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 12:12:58 +0000
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1RC64sh028656; Wed, 27 Feb 2019 13:12:44 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com with ESMTP id 2qtvtx68gh-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Wed, 27 Feb 2019 13:12:44 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 78A6634;
 Wed, 27 Feb 2019 12:12:43 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2BDBE5266;
 Wed, 27 Feb 2019 12:12:43 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 27 Feb
 2019 13:12:43 +0100
Received: from localhost (10.201.20.122) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 27 Feb 2019 13:12:42
 +0100
From: Benjamin Gaignard <benjamin.gaignard@st.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <arnd@arndb.de>,
 <shawnguo@kernel.org>, <s.hauer@pengutronix.de>, <fabio.estevam@nxp.com>
Subject: [PATCH 0/7] Introduce bus domains controller framework
Date: Wed, 27 Feb 2019 13:12:25 +0100
Message-ID: <20190227121232.24873-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
X-Originating-IP: [10.201.20.122]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-27_07:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_041254_657231_5B36A8A9 
X-CRM114-Status: GOOD (  11.29  )
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
Cc: benjamin.gaignard@linaro.org, loic.pallardy@st.com,
 linux-kernel@vger.kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
 linux-arm-kernel@lists.infradead.org,
 Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Bus domains controllers allow to divided system on chip into multiple domains
that can be used to select by who hardware blocks could be accessed.
A domain could be a cluster of CPUs (or coprocessors), a range of addresses or
a group of hardware blocks.

Framework architecture is inspirated by pinctrl framework:
- a default configuration could be applied before bind the driver
- configurations could be apllied dynamically by drivers
- device node provides the bus domains configurations

An example of bus domains controller is STM32 ETZPC hardware block
which got 3 domains:
- secure: hardware blocks are only accessible by software running on trust
  zone.
- non-secure: hardware blocks are accessible by non-secure software (i.e.
  linux kernel).
- coprocessor: hardware blocks are only accessible by the corpocessor.
Up to 94 hardware blocks of the soc could be managed by ETZPC and 
assigned to one of the three domains.

At least two other hardware blocks can take benefits of this:
- ARM TZC-400: http://infocenter.arm.com/help/index.jsp?topic=/com.arm.d...
  which is able to manage up to 8 regions in address space.
- IMX Ressource Domain Controller (RDC): supports four domains and up to eight regions 

This version has been rebased on top of v5.0-rc8.

Benjamin

Benjamin Gaignard (7):
  devicetree: bindings: Document domains controller bindings
  domainsctrl: Introduce domains controller framework
  base: Add calls to domains controller
  devicetree: bindings: domainsctrl: Add STM32 ETZPC bindings
  bus: domainsctrl: Add driver for STM32 ETZPC controller
  ARM: dts: stm32: Add domainsctrl node for stm32mp157 SoC
  ARM: dts: stm32: enable domains controller node on stm32mp157c-ed1

 .../bindings/bus/domains/domainsctrl.txt           |  55 +++++
 .../bindings/bus/domains/st,stm32-etzpc.txt        |  14 ++
 arch/arm/boot/dts/stm32mp157c-ev1.dts              |   2 +
 arch/arm/boot/dts/stm32mp157c.dtsi                 |   7 +
 drivers/base/dd.c                                  |   9 +
 drivers/bus/Kconfig                                |   2 +
 drivers/bus/Makefile                               |   2 +
 drivers/bus/domains/Kconfig                        |  14 ++
 drivers/bus/domains/Makefile                       |   2 +
 drivers/bus/domains/domainsctrl.c                  | 234 +++++++++++++++++++++
 drivers/bus/domains/stm32-etzpc.c                  | 140 ++++++++++++
 include/dt-bindings/bus/domains/stm32-etzpc.h      |  25 +++
 include/linux/domainsctrl.h                        |  70 ++++++
 13 files changed, 576 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/domains/domainsctrl.txt
 create mode 100644 Documentation/devicetree/bindings/bus/domains/st,stm32-etzpc.txt
 create mode 100644 drivers/bus/domains/Kconfig
 create mode 100644 drivers/bus/domains/Makefile
 create mode 100644 drivers/bus/domains/domainsctrl.c
 create mode 100644 drivers/bus/domains/stm32-etzpc.c
 create mode 100644 include/dt-bindings/bus/domains/stm32-etzpc.h
 create mode 100644 include/linux/domainsctrl.h

-- 
2.15.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
