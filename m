Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA24C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:58:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53023205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 07:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jd9ovCpe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53023205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=fShHyHEGn7LgAUw7IKBbT8riExm51mcROwK7gyAmhD0=; b=Jd9ovCpedDnWlF88JEP72Zh5PA
	dqKgbSuGvijAjLnWEGgWnrhkqZkuvIRnkp+rFEqruqsxuyLRCU3obpU/hu/BBwtr8uA2BuB2MXNGI
	dmvqVdq3TlSTMRSF3KUJoCqEyPSkgicpZjUH9mkGNHH3Z80ghZFE6r+CQkvZzqdKyWckG92RTIG1m
	5sZVbZBJFj5E8mZv3DUI3qhLrhVvZv4A6smsfqxY6RQwlOXse/HkgPqIJPcDqWzgpbFoc8xs9bTnD
	xIBwQjCz7DO3yFDlpbaCIfLejDoBmHBKcUGOEtR7YzDIdVxyZya1kM4qplqYe8+BsJnW3yPnVtl03
	vtgzoqUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWGSG-0008K2-Kr; Mon, 10 Dec 2018 07:58:16 +0000
Received: from mail-pl1-f176.google.com ([209.85.214.176])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWGIV-0003s9-Im
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 07:48:19 +0000
Received: by mail-pl1-f176.google.com with SMTP id z23so4860688plo.0
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 09 Dec 2018 23:48:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8v4vTzeWbc4uxs0ldJmkPixXPctUZB78A1BBJ1O2A04=;
 b=e5fIk1+13CwK1HcsSvNC0kzaYUU4lju/0omlw+mAZhNpfyAAJ5QuxmIk8+SJGX5a8Q
 Fw7itYeX+d/7Gmb7NJ8DFQx52lP6tWL6UM6TKI5YSnB16+pbWgl7yd2vAcs3NY2spn69
 GAsLvcRMyNEGgemKk239dVGk9/h7/hFVez/4z3SgFArPf0kyPEEH3g/sPM/ijbt5fXgG
 wBmKpI4VVdG6eT7lsUncEcRqLt1fyXDR6lR/0l6itpLcm/QW/jT3Mp3ifa4lunjmLqvc
 I+scNO10ttbh9ITlL+75Wds7evWhu4AZq6Ze6VRobx3rlJlhi9gkM9RIF8t6S3HreJhr
 5iKw==
X-Gm-Message-State: AA+aEWbsxwfMmJpXHswiP9msKsxAYcpZS1wbZ4BKAsYPdfCqMR8WAlDY
 0xQEMeChuAwRyQpH/hF+S4UK6A==
X-Google-Smtp-Source: AFSGD/XKfRsV1fjRWYz3+O+gYTfXaRY5WB+JzuGClNY0BqzRzAQxYAL0kTb9YxfK04cAgph1+FX44Q==
X-Received: by 2002:a17:902:9047:: with SMTP id
 w7mr11329132plz.270.1544428080611; 
 Sun, 09 Dec 2018 23:48:00 -0800 (PST)
Received: from localhost.localdomain (61-216-91-114.HINET-IP.hinet.net.
 [61.216.91.114])
 by smtp.gmail.com with ESMTPSA id c13sm14363809pfo.121.2018.12.09.23.47.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 09 Dec 2018 23:47:59 -0800 (PST)
From: Shawn Guo <shawnguo@kernel.org>
To: arm@kernel.org
Subject: [GIT PULL 6/7] Freescale arm64 device tree update for 4.21
Date: Mon, 10 Dec 2018 15:46:37 +0800
Message-Id: <20181210074638.27873-6-shawnguo@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181210074638.27873-1-shawnguo@kernel.org>
References: <20181210074638.27873-1-shawnguo@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_234812_062625_FFD3CE3C 
X-CRM114-Status: GOOD (  15.25  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 linux-imx@nxp.com, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt64-4.21

for you to fetch changes up to 58f5fa68372505c8c6e57754a370f0e7e6004513:

  arm64: dts: ls1046a: add qdma device tree nodes (2018-12-08 10:28:39 +0800)

----------------------------------------------------------------
Freescale arm64 device tree update for 4.21:
 - Add device tree for LS1028A SoC and NXP FRWY & QDS boards support
   based on this SoC.
 - Add device tree for LX2160A SoC and NXP QDS & RDB boards support
   based on this SoC.
 - Add qdma devices for LS1043A and LS1046A SoC.
 - Disable PCIe device by default in SoC device tree and let board level
   device tree to enable as needed.
 - Drop compatible string "snps,dw-pcie" from LayerScape PCIe devices to
   avoid incorrect matching.
 - Move fsl-mc device as a child node of soc node, and add missing
   dma-ranges property for LS1088A SoC.
 - Update LayerScape SoCs' cooling maps to include all devices affected
   by individual trip points.

----------------------------------------------------------------
Bao Xiaowei (1):
      arm64: dts: fsl: Add the status property disable PCIe

Bhaskar Upadhaya (1):
      arm64: dts: Add support for NXP LS1028A SoC

Hou Zhiqiang (1):
      arm64: dts: layerscape: removed compatible string "snps,dw-pcie"

Ioana Ciocoi Radulescu (2):
      arm64: dts: ls1088a: Move fsl-mc node
      arm64: dts: ls1088a: Add missing dma-ranges property

Pankaj Bansal (1):
      arm64: dts: add LX2160AQDS board support

Peng Ma (2):
      arm64: dts: ls1043a: add qdma device tree nodes
      arm64: dts: ls1046a: add qdma device tree nodes

Pramod Kumar (1):
      arm64: dts: ls1012a: Add FRWY-LS1012A board support

Vabhav Sharma (2):
      arm64: dts: add QorIQ LX2160A SoC support
      arm64: dts: add LX2160ARDB board support

Viresh Kumar (1):
      arm64: dts: fsl: Add all CPUs in cooling maps

 arch/arm64/boot/dts/freescale/Makefile             |   5 +
 arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dts |  25 +
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     |   3 +-
 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts  |  93 +++
 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts  |  73 ++
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi     | 339 +++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |  37 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |  36 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi     | 169 ++---
 arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi     |   8 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     |  44 +-
 arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts  | 112 +++
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts  | 119 ++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     | 766 +++++++++++++++++++++
 14 files changed, 1703 insertions(+), 126 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
